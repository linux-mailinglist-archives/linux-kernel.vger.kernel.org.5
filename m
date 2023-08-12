Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AA779D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHLFcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjHLFcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:32:13 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DD2728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:32:12 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78caeb69125so814756241.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691818332; x=1692423132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g74E1AgyKwKQKO3lIxF5su/pLHJrzXvBsq/PnlgTqE=;
        b=iVF2avGNeMIPDddPG3LbISwhLFedJi7u4mRRWoyYs9zf+cCXpWiz8jUpgo1np2TSnE
         VyD0+fD8Z1u9Nhla72r+Wb8GetWHg+XTkPqJIVNo+fzDH2QWa+i57ULayuUsCkgtruB+
         +7jfIq1fYbXw07/T7NnZRFrKZvFL6wU1oaOAN/Zf9XMgu16ZnJCyEMlwGGjmVkdq0Zwk
         PARJo4+0+U1goTtHFmDDJAIU9JNo4VebpW+5apQgWePc+wkoLDDbYjOEbyD+mQv1qeh5
         wT2fz6LbBftvNpDWTvyJV5NRyGdPjZn1fNo04Q8JV7dBkasT0w5xv4eqZJoJdViCMVww
         Xh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691818332; x=1692423132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2g74E1AgyKwKQKO3lIxF5su/pLHJrzXvBsq/PnlgTqE=;
        b=ToWZwsmK6lJTKpABMtbqzVt3XhpHO3I3l0aSKkD1UQpTZHAVBdf94kxQH9PI1HpIaf
         TTFQ/ooj3ITTw5s0NdQKnKjiuAuqNhIpGLGvy13Wm+EC9SwcwwOhXM0U3yx5aQeJRHT+
         PkSfTIk53R6JdnGj7ioEwLOZZcE8Lov6wnnLdq0CvrPWeRuZxAJC52ZbOXqaIQn2Ankp
         pZ53NfA6iH6868XsubqEFdRlsazBNUmsttBbbC4fitIsGmh118Pk6TXMdBphW3KH5Yk4
         MNcx21H3v84eQd5qRfrLTaVBLRcKacqDQxHE4oguxceNc4W5OLKJvlbLTEL0xJZaHQOr
         bJyA==
X-Gm-Message-State: AOJu0YzDN4+4BJlFnUlJyakjoj2dlfss7do6erAQM605Y/3nkHzQPSIA
        WFpxW1qNqQ9bxJTRPAyvIzQoXJOUxupWh4uFoMo=
X-Google-Smtp-Source: AGHT+IHrIUb4tsaDVV3nI9BSWgtzBF45GMS+yJt33V1stlAIA6T5l5Plo55UvO2r0ZWk1nkl3ANkdj6KBxAnBH4PVrg=
X-Received: by 2002:a05:6102:50e:b0:447:55b0:bcf6 with SMTP id
 l14-20020a056102050e00b0044755b0bcf6mr3254812vsa.29.1691818332000; Fri, 11
 Aug 2023 22:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230807122233.28563-1-yangyicong@huawei.com> <ZNL9s92HjLy+MZTw@localhost>
 <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
 <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com> <ZNOCgX8yniu+IuUG@localhost>
 <f6edb51e-ae79-5eaa-f337-fb4971aec575@huawei.com> <CAGsJ_4wivZ186D9JgyL-46zRuBDboST+c-ODx0FEbXdy5Tt3NA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wivZ186D9JgyL-46zRuBDboST+c-ODx0FEbXdy5Tt3NA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 12 Aug 2023 13:31:59 +0800
Message-ID: <CAGsJ_4wxJvmsa3iVcgqeQEx5Ur3vq1aupE=FJKxOc-fCxy57SQ@mail.gmail.com>
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

On Sat, Aug 12, 2023 at 1:24=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Aug 11, 2023 at 6:14=E2=80=AFPM Yicong Yang <yangyicong@huawei.co=
m> wrote:
> >
> > On 2023/8/9 20:11, Liang Li wrote:
> > > Hi Yicong,
> > >
> > > Thanks for your reply,
> > >
> > > On 2023-08-09 14:31, Yicong Yang <yangyicong@huawei.com> wrote:
> > >> Hi Barry, Liang,
> > >>
> > >> On 2023/8/9 13:47, Barry Song wrote:
> > >>> On Wed, Aug 9, 2023 at 1:01=E2=80=AFPM Liang Li <liliang6@email.cn>=
 wrote:
> > >>>>
> > >>>> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
> > >>>>> From: Yicong Yang <yangyicong@hisilicon.com>
> > >>>>>
> > >>>>> On ACPI based system the device is probed by the name directly. I=
f the
> > >>>>> driver is configured as module it can only be loaded manually. Ad=
d the
> > >>>>> platform id table as well as the module alias then the driver wil=
l be
> > >>>>> loaded automatically by the udev or others once the device added.
> > >>>>>
> > >>>>
> > >>>> Please consider revise the long log to clearly express the purpose=
 of the
> > >>>> changes in this patch:
> > >>>>
> > >>>> - What's the exact issue the patch is addressing
> > >>>> - Why the changes in this patch can fix the issue or make somethin=
g working
> > >>>> - Consider impact of the changes introduced by this patch
> > >>>>
> > >>>> These info may help reviewers and maintainers .. and yourself on c=
ode merge.
> > >>>
> > >>> years ago, i found a good doc regarding this,
> > >>> https://wiki.archlinux.org/title/Modalias
> > >>>
> > >>> guess it is because /lib/modules/$(uname -r)/modules.alias fails to=
 contain smmu
> > >>> driver without the MODULE_DEVICE_TABLE, isn't it, yicong=EF=BC=9F
> > >>
> > >> Yes I think it's the reason. I didn't find summary in kernel docs fo=
r the modalias
> > >> as well as the uevent mechanism. Arch wiki has a well illustration f=
or the modalias
> > >> and suse[1] describes how this is used by the udev for module auto l=
oading.
> > >>
> > >> For my case I'm using a ACPI based arm64 server and after booting th=
e arm_smmuv3_pmu.ko
> > >> is not auto loaded by the udevd since we aren't providing this infor=
mation. In order
> > >> to support this we need to provide this MODULE_DEVICE_TABLE() when t=
he smmu pmu added
> > >> as a platform device, then the userspace udev can know which module =
to load after the
> > >> device is added.
> > >>
> > >
> > > Then what's the purpose of the added '.id_table =3D ...' line in the =
previous
> > > patch ?
> > > <We lost the patch context in this thread.>
> > >
> > > Based on above clarification, the updated DEVICE_TABLE would update m=
odalias
> > > as expected, right ?
> >
> > ok, it's lack of illustration in the commit. If we're going to use MODU=
LE_DEVICE_TABLE we need
> > a platform id table. So I add it and I found it weired if we have a id =
table but not use it for
> > probing, so I also initialize .id_table.
> >
> > I found there's also an another way to implement this by used MODULE_AL=
IAS(), and no need to add
> > an id table. Maybe this way is less controversial.
>
> right, how is your driver matching with your device?
>
> acpi_driver_match_device()  or strcmp(pdev->name, drv->name) =3D=3D 0 ?

btw, those drivers supporting acpi probe usually have a acpi table

#if IS_ENABLED(CONFIG_ACPI)
static const struct acpi_device_id hidma_acpi_ids[] =3D {
{"QCOM8061"},
{"QCOM8062", HIDMA_MSI_CAP},
{"QCOM8063", (HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP)},
{},
};
MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
#endif

>
> static int platform_match(struct device *dev, struct device_driver *drv)
> {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct platform_driver *pdrv =3D to_platform_driver(drv);
>
>         /* When driver_override is set, only bind to the matching driver =
*/
>         if (pdev->driver_override)
>                 return !strcmp(pdev->driver_override, drv->name);
>
>         /* Attempt an OF style match first */
>         if (of_driver_match_device(dev, drv))
>                 return 1;
>
>         /* Then try ACPI style match */
>         if (acpi_driver_match_device(dev, drv))
>                 return 1;
>
>         /* Then try to match against the id table */
>         if (pdrv->id_table)
>                 return platform_match_id(pdrv->id_table, pdev) !=3D NULL;
>
>         /* fall-back to driver name match */
>         return (strcmp(pdev->name, drv->name) =3D=3D 0);
> }
>
> In both cases, it seems we don't need id_table. id_table can support
> two or above device names, so that one driver can support
> multiple device IDs usually with different specific device data.
>
> >
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pm=
u.c
> > index 25a269d431e4..4c32b6dbfe76 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -984,6 +984,7 @@ static void __exit arm_smmu_pmu_exit(void)
> >
> >  module_exit(arm_smmu_pmu_exit);
> >
> > +MODULE_ALIAS("platform:arm-smmu-v3-pmcg");
> >  MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Ext=
ension");
> >  MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
> >  MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>=
");
> >
>
> Thanks
> Barry
