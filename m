Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE07779D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjHLFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHLFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:25:01 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359572728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:24:59 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so2399076241.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691817898; x=1692422698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GjZKC5SHsYiAeOcd5mJRedb6ykn9pBtFKS9Yw2TUug=;
        b=BvdXfvwtiJKxa68UesAP77Up2l835Q950AhSnhAykPiWeflzwhKLkWvcQvB1r9Lqb4
         xyoDsBJHlPrymD5oAlF0F3ITZkf/B+yO3p+nIKgQyxuHmpvggI+TOPFZpnrdCV4UcbeX
         YimA9+zTxsr/yXPJ4EBs1WbUB6aDYnh+HdHTth0OmvhWKx2dok8u1qPn4BNPDraTFyud
         MLmC96sd1Bli5QKxoeToM5moAUHyEgw01sjyKKwP//0PtzqZYU24KJX4DY39/Df1voZE
         xN/lqjtW45ewqpzKvW4DcT1qGPnBXbjwxFBwJ+3ajQKtXN/rh/z8t8fOXLdzrHQ5//lA
         fuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691817898; x=1692422698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GjZKC5SHsYiAeOcd5mJRedb6ykn9pBtFKS9Yw2TUug=;
        b=NEOCb4flv7tQGl9NKg1uD0jCpIjIeaPaSSNNCKL0VR6bHywFhWvAg+N2OKCYIz1eJp
         wEKLWaSIVUW5Ne6axrZlHlf9n2AR+d45/K5KDzSdzWTDi6RNzOgageQA7Vay+hnqZS7v
         VG41TAJ2ZM3BX+OVmRqQKBd3rH1ShyrnOWVG4tEBNXIz70ap8QaafuqREDyfriTLgmG9
         B0jFQDX9wSJfMNSKRo51f1mjP5pKVlNcTijHBXV3ZZuFaJNe8LHikU83Rz9c5TiKKEdS
         PpFi8AM5S9fBW2/ANwrfskyTO2LY0H2Py7h65MB0U2kQafDgwxZUo6UkRyZnd+aKwdbI
         mWcQ==
X-Gm-Message-State: AOJu0Yy4SxSo69KHYbBS8UPk1dNNYeWMBcthNVdTYChXs22dLiS0CZiM
        yeDHf/ujcMEUDm4jf/PzpqkKIkVHcAebMFSp59lnWzP/UkMEng==
X-Google-Smtp-Source: AGHT+IG+k9HcvkWMsYHXM3SHXpJyc3oKo1AL1JpRAWqvDc47qihs9uRV+CZFkDl87nYq2tsyK1xzNONe6husm6IevfY=
X-Received: by 2002:a67:fd65:0:b0:445:4a0c:3afb with SMTP id
 h5-20020a67fd65000000b004454a0c3afbmr5081309vsa.8.1691817898204; Fri, 11 Aug
 2023 22:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230807122233.28563-1-yangyicong@huawei.com> <ZNL9s92HjLy+MZTw@localhost>
 <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
 <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com> <ZNOCgX8yniu+IuUG@localhost>
 <f6edb51e-ae79-5eaa-f337-fb4971aec575@huawei.com>
In-Reply-To: <f6edb51e-ae79-5eaa-f337-fb4971aec575@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 12 Aug 2023 13:24:45 +0800
Message-ID: <CAGsJ_4wivZ186D9JgyL-46zRuBDboST+c-ODx0FEbXdy5Tt3NA@mail.gmail.com>
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto loading
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Liang Li <liliang6@email.cn>, yangyicong@hisilicon.com,
        will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 6:14=E2=80=AFPM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> On 2023/8/9 20:11, Liang Li wrote:
> > Hi Yicong,
> >
> > Thanks for your reply,
> >
> > On 2023-08-09 14:31, Yicong Yang <yangyicong@huawei.com> wrote:
> >> Hi Barry, Liang,
> >>
> >> On 2023/8/9 13:47, Barry Song wrote:
> >>> On Wed, Aug 9, 2023 at 1:01=E2=80=AFPM Liang Li <liliang6@email.cn> w=
rote:
> >>>>
> >>>> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
> >>>>> From: Yicong Yang <yangyicong@hisilicon.com>
> >>>>>
> >>>>> On ACPI based system the device is probed by the name directly. If =
the
> >>>>> driver is configured as module it can only be loaded manually. Add =
the
> >>>>> platform id table as well as the module alias then the driver will =
be
> >>>>> loaded automatically by the udev or others once the device added.
> >>>>>
> >>>>
> >>>> Please consider revise the long log to clearly express the purpose o=
f the
> >>>> changes in this patch:
> >>>>
> >>>> - What's the exact issue the patch is addressing
> >>>> - Why the changes in this patch can fix the issue or make something =
working
> >>>> - Consider impact of the changes introduced by this patch
> >>>>
> >>>> These info may help reviewers and maintainers .. and yourself on cod=
e merge.
> >>>
> >>> years ago, i found a good doc regarding this,
> >>> https://wiki.archlinux.org/title/Modalias
> >>>
> >>> guess it is because /lib/modules/$(uname -r)/modules.alias fails to c=
ontain smmu
> >>> driver without the MODULE_DEVICE_TABLE, isn't it, yicong=EF=BC=9F
> >>
> >> Yes I think it's the reason. I didn't find summary in kernel docs for =
the modalias
> >> as well as the uevent mechanism. Arch wiki has a well illustration for=
 the modalias
> >> and suse[1] describes how this is used by the udev for module auto loa=
ding.
> >>
> >> For my case I'm using a ACPI based arm64 server and after booting the =
arm_smmuv3_pmu.ko
> >> is not auto loaded by the udevd since we aren't providing this informa=
tion. In order
> >> to support this we need to provide this MODULE_DEVICE_TABLE() when the=
 smmu pmu added
> >> as a platform device, then the userspace udev can know which module to=
 load after the
> >> device is added.
> >>
> >
> > Then what's the purpose of the added '.id_table =3D ...' line in the pr=
evious
> > patch ?
> > <We lost the patch context in this thread.>
> >
> > Based on above clarification, the updated DEVICE_TABLE would update mod=
alias
> > as expected, right ?
>
> ok, it's lack of illustration in the commit. If we're going to use MODULE=
_DEVICE_TABLE we need
> a platform id table. So I add it and I found it weired if we have a id ta=
ble but not use it for
> probing, so I also initialize .id_table.
>
> I found there's also an another way to implement this by used MODULE_ALIA=
S(), and no need to add
> an id table. Maybe this way is less controversial.

right, how is your driver matching with your device?

acpi_driver_match_device()  or strcmp(pdev->name, drv->name) =3D=3D 0 ?

static int platform_match(struct device *dev, struct device_driver *drv)
{
        struct platform_device *pdev =3D to_platform_device(dev);
        struct platform_driver *pdrv =3D to_platform_driver(drv);

        /* When driver_override is set, only bind to the matching driver */
        if (pdev->driver_override)
                return !strcmp(pdev->driver_override, drv->name);

        /* Attempt an OF style match first */
        if (of_driver_match_device(dev, drv))
                return 1;

        /* Then try ACPI style match */
        if (acpi_driver_match_device(dev, drv))
                return 1;

        /* Then try to match against the id table */
        if (pdrv->id_table)
                return platform_match_id(pdrv->id_table, pdev) !=3D NULL;

        /* fall-back to driver name match */
        return (strcmp(pdev->name, drv->name) =3D=3D 0);
}

In both cases, it seems we don't need id_table. id_table can support
two or above device names, so that one driver can support
multiple device IDs usually with different specific device data.

>
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.=
c
> index 25a269d431e4..4c32b6dbfe76 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -984,6 +984,7 @@ static void __exit arm_smmu_pmu_exit(void)
>
>  module_exit(arm_smmu_pmu_exit);
>
> +MODULE_ALIAS("platform:arm-smmu-v3-pmcg");
>  MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Exten=
sion");
>  MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
>  MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>")=
;
>

Thanks
Barry
