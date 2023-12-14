Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72579813A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573133AbjLNSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:52:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63710E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:52:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so8065979a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702579962; x=1703184762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1YI7E4Yx3iebHdrqbE0xCVHhBGWXCdGqSCBozZBsUE=;
        b=hWWLT2XeGignVzPb0iJpIbuoU0A/aX1twdmJnpT8hpOvjTYPE7t/n6nXrvkfwXeT7F
         u0h4L4VwTMcmQNKRZeBjdCa+l4gm+/dqF3Qxhsf4+3qoT5oD+Qi7ueu3iAdBf8WkUgc1
         P4Uf3nIZxNBB3f/rCzLfD2AgqEEEqlWQzNwmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579962; x=1703184762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1YI7E4Yx3iebHdrqbE0xCVHhBGWXCdGqSCBozZBsUE=;
        b=HmvvufjeHutVof7auB2W6vgh/oNKUiFKsjeW3SnXZY1Tz3hLKj6G3S0/QlDQYAFiWJ
         spN8vnVcOFFFMQX9kJOqdaGm2Nj9/OizG9MqDHSWa47qGaLpfXgK0AjNQANSB50yK/l+
         7BC/rVtdWdXqw4omLYYR1UYkQuSNGOeeSBQDiO0JSXex7/gPF+f4v2m2Uhnr4GxAfzoT
         1/qhvYr52Vqg77QaeBwKN3ege2Y4v/dTt3JaqQAIdibT4sWojHgDEH8/XYLozkgPmEIf
         tyifvKa7YuMNQWyIoUk+ItRzi+NIbrwXwX56IWdEmtq86dp43AYhkOF/ffmrwVcXIPv8
         EDeg==
X-Gm-Message-State: AOJu0Yyge+gq9f5PHuCNHmO7tg0mFCFyKnk9aUwMD7leXuFDTT/9bS2W
        AOrHW1A/3rwDcJ5+YZWxUpgticrCjxtTV72T/KSHdg==
X-Google-Smtp-Source: AGHT+IFcopPl/J2LJm2MTYkCC+0FgaNbvMLpCMHukrKF0Am984yotd0bOaD9XTh6E0Mo2sG3IBnbiw==
X-Received: by 2002:a50:d51d:0:b0:551:2dac:f77d with SMTP id u29-20020a50d51d000000b005512dacf77dmr4392827edi.35.1702579962152;
        Thu, 14 Dec 2023 10:52:42 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id q29-20020a056402249d00b005528265bc41sm579870eda.0.2023.12.14.10.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:52:41 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3363ebb277bso1512718f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:52:41 -0800 (PST)
X-Received: by 2002:a5d:5601:0:b0:333:2fd2:51fb with SMTP id
 l1-20020a5d5601000000b003332fd251fbmr4932153wrv.116.1702579961041; Thu, 14
 Dec 2023 10:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20231208234127.2251-1-yu-hao.lin@nxp.com> <ZXpjjmD5Se7axJju@google.com>
 <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com> <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 14 Dec 2023 10:52:29 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
Message-ID: <CA+ASDXOHQUnruWqsN0yTbKzVD8+7hcafLFhhv6jq7cdUzTY5ZA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 3:38=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Francesco Dolcini <francesco@dolcini.it>
> >
> > On Thu, Dec 14, 2023 at 02:22:57AM +0000, David Lin wrote:
> > > > From: Brian Norris <briannorris@chromium.org>
> > > > It probably wouldn't hurt to significantly write much of this
> > > > driver, but at a minimum, we could probably use a few checks like t=
his:
> > > >
> > > >         cmd_size +=3D sizeof(struct host_cmd_tlv_mac_addr);
> > > >         if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
> > > >                 return -1;
> > > >         // Only touch tlv *after* the bounds check.
> > > >
> > > > That doesn't need to block this patch, of course.
> > > >
> > > > Brian
> > > >
> > >
> > > I will modify the code for next patch.
> >
> > I would suggest not modify this in this patch, we should fix all the co=
de that
> > is subjected to this potential issue.
> >
> > I would personally do a follow-up patch just to add the check to avoid
> > overflowing the cmd buffer everywhere it is used.

Right, there's tons of code that could potentially be affected, and
this is definitely a separate patch. (Your feature only adds on to the
existing issue, so these are separate logical changes.)

> O.K. I will only change commit message. In fact, this TLV command is adde=
d as the first one command.

Well, it doesn't really matter than your TLV is "first" -- if there's
an overflow, there's an overflow. Maybe the 8 bytes you're adding here
are the necessary tipping point. I don't know without doing some kind
of informal mathematics/proof.

Brian
