Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6FA80FB97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377613AbjLLXvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377516AbjLLXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:51:10 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323DB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:51:16 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49618e09f16so1549967e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702425075; x=1703029875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=CacnCAzwSbudmwwYJOMgYdksuVWzV/PGJjKuKG4M3a615cLK/lglaxwE9zk5hFFLo5
         +CqOmBQkgfnp+8zkSWZPaEYV2GPASHFAN0D/DVDYAcvWKYf6BsFnTuqXOIo5xD1gxawY
         JHRdJIBcuHHuqOuh2uRLB5L1jEmpvSNMxTbVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425075; x=1703029875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=NhLL8Q2W4wjt+/WRiGp4hWdTGY6UXZGQAtvF/fh6Z4W6kLiohydvLcsmkJVGE/TooI
         jHcgIA48jxgvynP6uiclPPljx62PtEp4Npc6w0wTP8/YTTrZsWHu0Er2pUEujylpZCEu
         nYgFwVGltE9E66goNh6wa4EjPbuYjVAp/C5i/FKeQ237h1y8nbOH2yZxebd/32tVPwDp
         URUrnj59o/hSHprxOKmqzFw3GuKexi3x/vQycZUdqUcWDGX4L3ESxyNDCQDXuY5+l7Gz
         2EvGHrAqLVIDVU1VBB6lFTXcYE+4NL/7HSZteKTOL+6HSbJkLyIsMa1kaB5oW61fjPBT
         x0pg==
X-Gm-Message-State: AOJu0Yx8WyUpd/9hGbJHqWirKoymUm/j7efsPAFPO6KqonsO4kuhO1Ee
        bV98jpO4KonHwMFAGH/ld+WyQSP7wWfZTh0r65+QLw==
X-Google-Smtp-Source: AGHT+IHgzY6TxuyoNkpl2aQeyRJYTpGY2b/Uli21Z+t7hU04lfjLJQ/88/mR7DldxbjQ1RCBksHpytK1u9KPLiGxHEI=
X-Received: by 2002:a05:6122:31a:b0:4b2:a7a9:b2a with SMTP id
 c26-20020a056122031a00b004b2a7a90b2amr5285959vko.11.1702425075124; Tue, 12
 Dec 2023 15:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
 <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
In-Reply-To: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 12 Dec 2023 15:51:04 -0800
Message-ID: <CAPUE2ut0gbSyzUQ+m=760kXeOqKoi+9OwaExXTSgg8S=bWhUvg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, Dec 11, 2023 at 4:46=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> >
> > We need to free it in other places too, like if the count doesn't match=
.
> > It may be easier to extract this section and just have 4 string
> > literals.
> >
> >         switch (reg_def->reg) {
> >         case SX9324_REG_AFE_PH0:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph0-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH1:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph1-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH2:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph2-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH3:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph3-pin");
> >                 break;
> >
>
> I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
> appreciate feedback.
>
> [1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-s=
x9324-c-v3-1-b8ae12fc8a5d@google.com/
>
> Thanks
> Justin
