Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990887F3020
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKUODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjKUODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:03:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4FAD75
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:02:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so268440966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575376; x=1701180176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Okt0Vk7fLF6tTfkiXuwS51yIO92AetNhg7I/Fs4g5s=;
        b=bqWhZQHfHe12SXrRqVzXKxIzVipiZ21opyedT/T2C4fAHlybcIBxOFqqMdIajqKe2V
         K9MbCxW/PDigccmXYYh+LHsrbkUdUgLTGxExIK0AneSQGwsyYpdTXQVf56CXQTbf2Vh4
         iY4mGCQhL/Lm8uQGPOu4p8ne1c+MACY67SQw5XpksJqHyJEb0i6xcsQ81xDp4/UkmsDx
         mDGo4fMbt+0VHzZvmCa9/F9L2XL3SKGe9ger4g9JwnNCC1D9DEQZEQotDGWmsXcNnLAt
         5RGkudVftEdDrMkvnw4Ob87gOl7t3cTfLaig1EvaAoHEL1EJz9QFgExGIyd6vM36trID
         7tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575376; x=1701180176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Okt0Vk7fLF6tTfkiXuwS51yIO92AetNhg7I/Fs4g5s=;
        b=VVfePVhE/XxkUD/tvOOdTG10Ee+C8bVH0ijF2T2zuyhzX51jRotjIVzruJ+StajQ/a
         gpjW6mvQYNH7MGvZ6i9lJ68qy3eq90kLzBwA0AYrKXziaRrUGqUP+p0EPLhDc9huDaN9
         LPhl0ReGO90Xgkey0BOqSpZhgm6tKnrdhymiJKTy9LcaLZIeW6HbnWqIRs0kwHEMTD81
         Mflg0nq/HkWD0KV/pmbhNuCx2n1zZpKxtbx4E7nPQvmasJ6hHCsA6a9hrPZVoHC60bU8
         HQss/B89mcoEgVPaAnE34cIJylio/W983GudaY8K9oj+GcvFFtZ97naPHICEr8WgPT+N
         9w3A==
X-Gm-Message-State: AOJu0YypJXMqSCFBA5eK6isAaQdU3b5sJ8gD7xAqiOXDKciQ80bFBxJF
        bbfPpW6tHkGmskZ+HKJNHe3+FWQV6qZpOY5CkAY=
X-Google-Smtp-Source: AGHT+IEzLuupufRrOkNgN2ws6o5MMFZCEg2Qwce2Gcw9cxG7jatiU0cWqzY9M+OaDjl4qFC7NDP8LqLiVwpcn/S+8L0=
X-Received: by 2002:a17:907:5095:b0:a00:8706:c82e with SMTP id
 fv21-20020a170907509500b00a008706c82emr3109200ejc.18.1700575375887; Tue, 21
 Nov 2023 06:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
 <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com> <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
 <TYCPR01MB109142FEC8F77CFFE3930456CD4B4A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB109142FEC8F77CFFE3930456CD4B4A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 21 Nov 2023 16:02:43 +0200
Message-ID: <CAEnQRZD8zbgRzBrx+iHTbDqG5tOedNLyJByNNtSHTRtxFsgyGw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 1:04=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Daniel, Mark
>
> > > > -     args.args_count =3D (of_graph_get_endpoint_count(node) > 1);
> > > > +     args.args_count =3D (of_graph_get_endpoint_count(node) >=3D 1=
);
> > >
> > > If my understanding was correct, for example you want to use 2nd DAI
> > > but your DT has only 1 port (thus, it is using reg property) ?
> >
> > Yes.
>
> But hmm... in your case, you need to setup 2ports, and use 2nd port
> is assumed approach.
> Why you don't setup full port ? Do you have some reason ??

I'm not sure I understand what is a full port setup. But let me
describe my scenario so that we have a common ground.

I want to use audio-graph-card2 machine driver to setup Sound Open
Firrmware cards.

Here we start with a normal link with the following components:

Component 0 (DAI) : 3b6e8000.dsp (See sound/soc/sof/core.c: 280)
                                  -> for imx8m this has 3 statically
defined DAIs
See sound/soc/sof/imx/imx8m.c:

static struct snd_soc_dai_driver imx8m_dai[] =3D {
{     // DAI with index 0
=C2=BB       .name =3D "sai1",
},
{      // DAI with index 1
=C2=BB       .name =3D "sai3",
},
{ /   // DAI with index 2
=C2=BB       .name =3D "micfil",
},
};

Component 1 (Codec): wm8960-hifi
                                    -> with 1 DAI

static struct snd_soc_dai_driver wm8960_dai =3D {
=C2=BB       .name =3D "wm8960-hifi",
};

Now, I want to write a DTS description where my DAI link uses
Component 0 (CPU) (with its DAI index 1) connected with Component 1
(codec) (with its DAI index 0).

So, for this I use the following dts snippet:

sof-sound-wm8960 {
=C2=BB       =C2=BB       compatible =3D "audio-graph-card2";
=C2=BB       =C2=BB       links =3D <&cpu>;
}

dsp: dsp@3b6e8000 {
    cpu: port@1 {
=C2=BB       =C2=BB       reg =3D <1>;
=C2=BB       =C2=BB       cpu_ep: endpoint { remote-endpoint =3D <&codec_ep=
>; };
=C2=BB       };
}

wm8960 {

=C2=BB       port {
=C2=BB       =C2=BB       codec_ep: endpoint { remote-endpoint =3D <&cpu_ep=
>; };
=C2=BB       };
}

So, property reg =3D <1> refferes to DAI with index 1 associated with
component DSP.
