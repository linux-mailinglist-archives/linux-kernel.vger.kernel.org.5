Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8C778918
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHKInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHKIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:42:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A122D61
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:42:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76595a7b111so131510485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743377; x=1692348177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIQ8i+p6xQBSmS50RICthOqhzAEen6knjOOfWucKUo0=;
        b=PK2zaxI86OBdWOplcWQrdJT4YBkklK4oNO/VuSXS+lFXm2dwqf8Q7OdES2R21uodd+
         0mCDb1oAAKsxTgVPgOBKkHD1F53bAbvC9WnARW1I19fYqJkyKN0klZ2sLVZxvfBaU4NY
         er8x8pQbPVsIO6v3EaEZd1ymermEzo2GkGbh7WP6l0AYIKt0zYvxOCmYa6cU6jmA1/8T
         fQDaD32WIvVu9c4sRfzO4A3pDQQOFj/KoIr9rWzNicQLRy/xnh+j80eqPMojvd0uBYGn
         NCybKbeUg3PHE1GRbdjMq08+94K5vFTVPhwfwMINI1KcDneOKQP+9KfP6gcBozfZ7Nic
         p69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743377; x=1692348177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIQ8i+p6xQBSmS50RICthOqhzAEen6knjOOfWucKUo0=;
        b=KlthvbSVJftRQHX9Uj5slH1RxQo6QsXhKID5dwZs0WkVhO9XcVXatGRhPlT2w/NFp6
         xI33S5gALki5tY8HRODvQ2wvIfSqt62kDcrUoEwskfAvzek/9poblmOFBNGx4Sb9LYtk
         ZSKIYBFDx8JiHzvGJ8uoAgeegOid7I/pB8jiyShp3pU/kZK94+RTKzi8fBE2OebXLpL3
         VCU7plt06xDke51/F0tgjjNqzp/XglB3yg2HeIdj0QZwetDICHiTNf5UNBVD5ubxDqat
         tVpBWjnp1X8za30ZY6nEr6r/Vvl/wJLkptqeXyEk6BANdZjy8WshAe/JBTuNhc/SDcC/
         ouSw==
X-Gm-Message-State: AOJu0YwwaYQA7hXd/wjabK0aP0roDSgY0g3ltQY2+nmwb3JD45TmfVeb
        D5gk/oMVpZuHZz+Cv5cyjzwiA9dVIG8jCiZpEzMvRA==
X-Google-Smtp-Source: AGHT+IFrx/4nZm7LJ0PluTRh1rL9k5kfKdhaOHdnTImTV8OsOurdhQMQ8BuJbfOtM9H1PspnCHrz1rnGbv/vJJYac1I=
X-Received: by 2002:a05:620a:4101:b0:76c:ad46:2670 with SMTP id
 j1-20020a05620a410100b0076cad462670mr1610010qko.45.1691743377029; Fri, 11 Aug
 2023 01:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230809052952.323-1-wenchao.chen@unisoc.com> <CAPDyKFoykxdP70t2pjeiX0pkKuUCZ2AeFM4yT4-wfVijxB7OHw@mail.gmail.com>
 <CA+Da2qx52QVk5Hz2PdY78qHRmspkDkXbWCWbUOGXCt2nbjNW0Q@mail.gmail.com>
In-Reply-To: <CA+Da2qx52QVk5Hz2PdY78qHRmspkDkXbWCWbUOGXCt2nbjNW0Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 10:42:20 +0200
Message-ID: <CAPDyKFoHwg3MvyNTTTnZLhsEA0Zhj6ZU+fZkhf8rGeoTsnTDJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 09:23, Wenchao Chen <wenchao.chen666@gmail.com> wrot=
e:
>
> On Wed, Aug 9, 2023 at 6:09=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 9 Aug 2023 at 07:30, Wenchao Chen <wenchao.chen@unisoc.com> wro=
te:
> > >
> > > Added .prepare_hs_tuning and .execute_hs_tuning host
> > > callbacks to support host-specific tuning for SD high
> > > speed mode.
> >
> > This certainly needs to be clarified more. Especially why it's needed
> > for the sdhci-sprd variant.
> >
>
> First of all, Unisoc's IC provides cmd delay and read delay to ensure
> that the host can
> get the correct data. However, according to SD Spec, there is no need
> to do tuning in
> high speed mode, but with the development of chip processes, it is
> more and more difficult
> to find a suitable delay to cover all the chips.
> Therefore, we need SD high speed mode online tuning.

Thanks for sharing this information - and please add some of this in
the commit message next time.

[...]

> > > +static int mmc_send_tuning_data(struct mmc_card *card)
> > > +{
> > > +       u8 status[64];
> >
> > We use kmalloc-ed data for data transfers.
> >
>
> Why is it better to use kmalloc-ed data?

If you use DMA for example. From the core point of view, all data
should be kmalloc-ed, if it's a data transfer and possibility that
that DMA is used. Hence, it seems reasonable to conform to this
behaviour when using this helper function from the core.

[...]

Kind regards
Uffe
