Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41B77D87C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbjHPCe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbjHPCeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:34:13 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5B213E;
        Tue, 15 Aug 2023 19:34:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63fbfca1302so25226516d6.2;
        Tue, 15 Aug 2023 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692153247; x=1692758047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l92r5yJgCD353zfCO+2Sdu2ov8hNkLMxduEgueS9Sn8=;
        b=MWHoj+jz0QmtXPEDOPergPwBKIXoca8e2OTDoX7TL4aD65if/FwL9KoFIY6qtfIz7Y
         y6CV8Qx+ZaKhE5grCIIwcu9RFsOBYBaCwGD4D7bl3nGbda0PLemYxIpsg842I3qirRHQ
         qUTRWTxWxA9Y9yhU5QuHDyOLPOLJBA5I34pj06Iez5gwtugv9wyeHtt/GY5xa5qR1r6+
         YZ4/gu6Be/n4U4BIOmB9l87wr569sSGouOgk8w2Ex58mPAvwWR0fBv70GZHk8nNsWUuT
         p7gUN6t0e6AwnsJy4t4JbghHH7E/DgzH3MdKWTBnbEJ7MLWk0LzmfQGpYsYa+YAs7HgG
         RbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692153247; x=1692758047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l92r5yJgCD353zfCO+2Sdu2ov8hNkLMxduEgueS9Sn8=;
        b=D+bMD/FaXvWp2HeZIUwlfpEiEzuG08qUULBDgMp3Z26d8bPhp93KkEWphCbiQP51Ub
         v9ecTeuYsTHY9scvfici/P5q4vdFQirYm+wDNdXcYB0Jnh2gUeAnAbtLtkKHYhjcnDzy
         a5GcJwwXBeDF61cZPW4PRj0ZFCyXza9cTG/nzW6qnN2LKiStRhir38WgBdYAu0HQblTu
         ZYn0U+y0V7v6BprsBeiLBNOS02E47vRJgqPr042pT14YcoMv1qACfitltN3W4cONz8du
         d2Jlj7NnVKBb2zNzz4sG6j7ez+qN6tuwF24UyjIX23ho5oKuNj5TKHI9X0KTfnsJHSmF
         GPng==
X-Gm-Message-State: AOJu0YxXWz0ARQZ4cDon3IqIqaefVrKchne05XA1+WGsCKQ9VnIQ2IEq
        6lwn+yVXvbZZ8p0n6bu191jXZLgTBpy838JhL0jeRttDikM=
X-Google-Smtp-Source: AGHT+IFqr4HhsHIkl2ldrZuJim4yj0IoTyIwerIwBxAduMdph7ExvdUeLJm5CVFX5AsB6DrsBwax4F2uoq3oYw4JtwU=
X-Received: by 2002:a0c:8e8c:0:b0:63d:362d:e666 with SMTP id
 x12-20020a0c8e8c000000b0063d362de666mr472138qvb.15.1692153247335; Tue, 15 Aug
 2023 19:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
 <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com> <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
 <a241ac07-c9d5-ba76-44da-267006713365@intel.com> <CA+Da2qxf0o4C-yQZ4EirSRZCGs7a+BZLdxpmXeVM1zsMxG9rmQ@mail.gmail.com>
 <b3c90331-f1c3-bdb7-5fca-cbf6441bedf6@intel.com>
In-Reply-To: <b3c90331-f1c3-bdb7-5fca-cbf6441bedf6@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Wed, 16 Aug 2023 10:33:56 +0800
Message-ID: <CA+Da2qx0ByjudURai6yBkX3xEtb1LWSsBuxv53GKFQ25qwK+7w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 7:19=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 15/08/23 13:55, Wenchao Chen wrote:
> > On Tue, Aug 15, 2023 at 6:37=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 15/08/23 13:29, Wenchao Chen wrote:
> >>> On Tue, Aug 15, 2023 at 2:21=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> >>>>
> >>>> On 15/08/23 04:40, Wenchao Chen wrote:
> >>>>> Change in v2:
> >>>>> - add mmc_sd_switch() and mmc_send_status() to the header file
> >>>>> - split up core changes from host driver changes
> >>>>> - Use pr_debug instead of dev_info and dev_dbg
> >>>>> - Optimize the best sampled value algorithm
> >>>>
> >>>> What about hooking ->set_ios() as Ulf suggested?
> >>>>
> >>>
> >>> I've tried that, but it's not a good way to do it.
> >>> We found that sdhci_runtime_resume_host() calls ->set_ios, but we
> >>> don't want to do that.
> >>
> >> Given that sdhci_sprd_runtime_resume() calls sdhci_runtime_resume_host=
(),
> >> it should be possible to determine when to tune, right?
> >>
> >
> > You mean like this? For example:
> > static int sdhci_sprd_runtime_resume(struct device *dev)
> > {
> > ...
> > sprd_host->need_hs_tuning =3D false;
> > sdhci_runtime_resume_host(host, 1);
> > sprd_host->need_hs_tuning =3D true;
>
> Yes
>

This works, but we found a problem: if sd hs tuning fails, ->set_ios
is of type void with no return value.

> > ...
> > }
> >
> >>> We just need SD HS mode tuning at mmc_sd_init_card().
> >>>
> >>>>>
> >>>>> Wenchao Chen (2):
> >>>>>   mmc: core: Add host specific tuning support for SD HS mode
> >>>>>   mmc: sdhci-sprd: Add SD HS mode online tuning
> >>>>>
> >>>>>  drivers/mmc/core/sd.c         |  12 +++
> >>>>>  drivers/mmc/core/sd_ops.c     |   1 +
> >>>>>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++=
++++
> >>>>>  include/linux/mmc/host.h      |   8 ++
> >>>>>  4 files changed, 173 insertions(+)
> >>>>>
> >>>>
> >>
>
