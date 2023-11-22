Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6457F4372
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjKVKRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjKVKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:17:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12E7191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:16:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00a9c6f283so342129966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700648207; x=1701253007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLc9eoJnMu6ltPbT1jIbts/TAhvqm1awxCFreB1Q6k=;
        b=RrUmyEaArKkoME+7FqYCqgOk0STfM/URQQpPIlb5NUEarIdcO5CdfEHz3e4pvyxm4I
         +e7XSqeHwbC6tNvdq/1q5EWxS4x9m/fQOPLAPQ7zNz0TbAPfoSW9uNEIfLP2sRUnqs53
         cCIy7BdjwRMlfXEs8MMWGT2tDy35Gr6dK9Qt2oibFpUIVYZNdrbBAW2+oKdw1CFeU2LN
         bXU6SrgTT6X/OlCod8zBeRS/5ZpBWYSGYmUcu6FZlOLowXEoagu2puaL1crV7qaAf+5P
         RD67bmD7lvAwzf+d+yVcVk2AbUpAlh1tdNKdat15MT7CLOwv9+n3G7CoOTjp1tldfwLE
         h6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648207; x=1701253007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLc9eoJnMu6ltPbT1jIbts/TAhvqm1awxCFreB1Q6k=;
        b=MRTxZBQ3F1MDCXW3iKNP8PBERvo4dmPh2Jt71eCsJq5e81sCw8Ecoc6B1idhyCmV6t
         KDjytKPuMKmYHbJBuu5cA9ygscFElQMYXEBkHdoH0zNEbvvhf77go8OZtHi3I5+B14TP
         eLbbUP4Xb+bCLlemvhnXUgLNo072jI3TmCyU+ihDesp0jvZ1YLwJ88qVCmJ05keNcjg+
         +27Uljtye3flT3Q7TZmg6NmFqau4AU2KSFzgh2AkxI3VL0efAxCs/x0Gf9R9UkUTYjjV
         PEZ9RIqbbwkc8JBL+qbrIskXkoCyMcLMnQoAOGKEFYwG4a/QCs0lqseREgQAYAEfY1je
         YwZg==
X-Gm-Message-State: AOJu0Yx1PCwgG3IhFoRYkE0D9yNImnx9NxdjP7qHAVDLmDyghY1EOhJH
        eCC5iIPUdcaz8hTSix7ZghqJQc6HrtaZ0r/0xbI=
X-Google-Smtp-Source: AGHT+IH/nwieVeaKbZx03znmMuIeYwKqQartp3JyCE9X3wGV4XSH5V/OVoP2++RCu/gWdT9pwIyQQOxwFkTbOpIvhy0=
X-Received: by 2002:a17:907:9543:b0:a00:4d7e:4825 with SMTP id
 ex3-20020a170907954300b00a004d7e4825mr966199ejc.35.1700648206932; Wed, 22 Nov
 2023 02:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
 <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com> <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
 <TYCPR01MB109142FEC8F77CFFE3930456CD4B4A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
 <CAEnQRZD8zbgRzBrx+iHTbDqG5tOedNLyJByNNtSHTRtxFsgyGw@mail.gmail.com> <878r6qh2y1.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878r6qh2y1.wl-kuninori.morimoto.gx@renesas.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 22 Nov 2023 12:16:34 +0200
Message-ID: <CAEnQRZAVM6=2udYg0jY8dD_uVE8yGQgsoZ14K1MBiCP+dCqLNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:39=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Daniel
>
> > > But hmm... in your case, you need to setup 2ports, and use 2nd port
> > > is assumed approach.
> > > Why you don't setup full port ? Do you have some reason ??
> (snip)
> > Now, I want to write a DTS description where my DAI link uses
> > Component 0 (CPU) (with its DAI index 1) connected with Component 1
> > (codec) (with its DAI index 0).
>
> Thank you for indicating your DTS.
>
> So in imx8m_dai case, it has total 3 DAIs, and you want to use reg =3D 1.
> In such case, your DTS need to have like below, if my understanding was
> correct.
>
>         dsp: dsp@3b6e8000 {
>                 ports {
>                              port@0 { reg =3D <0>;         endpoint { /* =
not used */ };  };
>                         cpu: port@1 { reg =3D <1>; cpu_ep: endpoint { rem=
ote-endpoint =3D <xxx>; }; };
>                              port@2 { reg =3D <2>;         endpoint { /* =
not used */ };  };
>                 };
>         };
>

This works! Thanks. I didn't know that you can leave an endpoint unused :).

So please ignore my initial patch then.
