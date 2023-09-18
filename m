Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93F7A513C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjIRRrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIRRr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:47:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195EFD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:47:23 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81a4b96a86so3574244276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695059242; x=1695664042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jacBNNhmnoa4Ag6t2eGllJTMGaWz698hP3YqxfydkyQ=;
        b=wCugR8c+r5h/3scPPwVyopeDvMuFZLRXWRX0qpIn1ff+n8xPRQdwVHego5dw0715x/
         ylmpVxUqs+y58E6epJNj+RTj2MXnM3nMMrw1KFt/pMZiVRe1l/f18dRFcXIbV39GHYuV
         6OQoEH+1jlgGt7m200ZSm6+kEOCgWd50D6YHSEujnTdLhT6vQckpEWPJgbeOXAR4eUOI
         /vH1COKVsECIkeuvOUbn0zg9ejKc9O5NtOMWoKrNpzFxyTSWi3yFU2FNQa4Cpg8w9GhU
         a5RX9DC5kIThKMynPaJ3imeJQl6Ba9fKTRp6bxrPuQ1zrxhcVeY+B5JilB3r5Q576DuX
         Yg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059242; x=1695664042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jacBNNhmnoa4Ag6t2eGllJTMGaWz698hP3YqxfydkyQ=;
        b=HQ3NHXNslETt4+qwQCIRaeDvzGN/WYB0d4DcjtDvWr5liiqegUXQZs0Qql9WiPXpAB
         IWCEx4PBnz7F3+Vo9k4m/ui8Iz5ccw335OKpVp/mMovTIqjv3tsXp6jyvck9RoP5a6f5
         CZsNcszf4TPD6gCQklGpnMeE2ksSxYMrg+lduJkJ9zhnx8YhO9iqBI0VxMPXAtuqoQPl
         +3Q6r4gp8LkYgjoCL3MHJax7mf4hwXhIA75pkcuCqrLvWZxwCt/kAHjqG0ajmvpm/zKt
         FgKzAJOpZKeg70sMwqZkzVUezMFgpOzgrZlQgHzYG2wHM3jwfIqiCNhLJA61nAzkEhOg
         RU/g==
X-Gm-Message-State: AOJu0YzYwyYE+z3nVScsQx8GKnAWGE4akM51JCMcjBWUApkId65wUkV4
        hkobyZBdyTOZwTYXH5pTk1KWit7uwxHCHnRM3C/I8w==
X-Google-Smtp-Source: AGHT+IHvGYI7M1DS+eOS2wkF6sbDnAPbUKSQ9jKcvcwOVAvS5cajZgrPKVsEOgAa/KNKI+4KPpXnxCOITEpioXonPG0=
X-Received: by 2002:a25:b298:0:b0:d78:2383:4427 with SMTP id
 k24-20020a25b298000000b00d7823834427mr9184475ybj.9.1695059242242; Mon, 18 Sep
 2023 10:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172818.761-1-shiju.jose@huawei.com> <CACw3F50Edbk7uemvS-ZCNABKSz=3VMaRdPjzoYp9XE-hkOUKBg@mail.gmail.com>
 <e8a20cf946354312b865c1d69a18a81c@huawei.com>
In-Reply-To: <e8a20cf946354312b865c1d69a18a81c@huawei.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Mon, 18 Sep 2023 10:47:08 -0700
Message-ID: <CACw3F51eSVKybNWKvf_YULfQPhuQWZRDKvP23oOJo=HeNBgGCA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI RAS2
 and configure scrubbers
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 3:20=E2=80=AFAM Shiju Jose <shiju.jose@huawei.com> =
wrote:
>
> [+cc linux-edac@vger.kernel.org]
>
> Hello,
>
> >-----Original Message-----
> >From: Jiaqi Yan <jiaqiyan@google.com>
> >Sent: 17 September 2023 22:14
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
> >kernel@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> >naoya.horiguchi@nec.com; tony.luck@intel.com; james.morse@arm.com;
> >dave.hansen@linux.intel.com; david@redhat.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >rientjes@google.com; duenwen@google.com; Vilas.Sridharan@amd.com;
> >mike.malvestuto@intel.com; gthelen@google.com; Linuxarm
> ><linuxarm@huawei.com>; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
> >Zengtao (B) <prime.zeng@hisilicon.com>
> >Subject: Re: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI =
RAS2
> >and configure scrubbers
> >
> >On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
> >>
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> This series add,
> >> 1. support for ACPI RASF(RAS feature table) PCC interfaces to
> >> communicate with the HW patrol scrubber in the platform, as per ACPI
> >> 5.1 & upwards revision. Section 5.2.20.
> >>
> >> 2. support for ACPI RAS2(RAS2 feature table), as per ACPI 6.5 &
> >> upwards revision. Section 5.2.21.
> >>
> >> 3. scrub driver supports configuring parameters of the memory
> >> scrubbers in the system. This driver has been implemented based on the
> >> hwmon subsystem.
> >>
> >> The features have tested with RASF and RAS2 emulation in the QEMU.
> >
> >I am very curious how the test is done. Does the hw patrol scrubber on h=
ost
> >actually been driven by the driver to scrub memory DIMMs (doesn't seem s=
o to
> >me, but do correct me)? Or it is like to a VM scrubbing is simulated and=
 no real
> >op to DIMMs?
> Intent here is hardware scrubber on host as far as we are concerned.

Sorry maybe my question was not clear, so let me try again.

Does the driver being tested on a machine and directly or indirectly
control (start/stop) hardware patrol scrubber to scrub physical
memory? what are the CPU chip, memory controller, and DIMM chips?

> Could be used for VM too perhaps. We did it with QEMU emulation for now
>  to get the flexibility of configuration. However there will be other scr=
ub controls
> over time, such as DDR5 ECS.
> https://media-www.micron.com/-/media/client/global/documents/products/whi=
te-paper/ddr5_new_features_white_paper.pdf?rev=3Db98f4977d9334b4aa5d0d211a9=
2bf14a
>
> Also found there is very simple support for scrub control in edac, and an=
 alternative path
> would be to look at extending that to sufficient complexity to support re=
gion based scanning.
> https://elixir.bootlin.com/linux/latest/source/include/linux/edac.h#L512
>
> >
> >>
> >> Previous references to the memory scub and RASF topics.
> >> https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.c
> >> om/
> >> https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0
> >>
> >038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLO
> >OK.COM/
> >>
> >> A Somasundaram (2):
> >>   ACPI:RASF: Add extract RASF table to register RASF platform devices
> >>   ACPI:RASF: Add common library for RASF and RAS2 PCC interfaces
> >>
> >> Shiju Jose (7):
> >>   memory: scrub: Add scrub driver supports configuring memory scrubber=
s
> >>     in the system
> >>   memory: scrub: sysfs: Add Documentation entries for set of scrub
> >>     attributes
> >>   Documentation/scrub-configure.rst: Add documentation for scrub drive=
r
> >>   memory: RASF: Add memory RASF driver
> >>   ACPICA: ACPI 6.5: Add support for RAS2 table
> >>   ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
> >>   memory: RAS2: Add memory RAS2 driver
> >>
> >>  .../ABI/testing/sysfs-class-scrub-configure   |  82 ++++
> >>  Documentation/scrub-configure.rst             |  55 +++
> >>  drivers/acpi/Kconfig                          |  15 +
> >>  drivers/acpi/Makefile                         |   1 +
> >>  drivers/acpi/ras2_acpi.c                      |  97 ++++
> >>  drivers/acpi/rasf_acpi.c                      |  71 +++
> >>  drivers/acpi/rasf_acpi_common.c               | 272 +++++++++++
> >>  drivers/memory/Kconfig                        |  15 +
> >>  drivers/memory/Makefile                       |   3 +
> >>  drivers/memory/ras2.c                         | 334 +++++++++++++
> >>  drivers/memory/rasf.c                         | 335 +++++++++++++
> >>  drivers/memory/rasf_common.c                  | 251 ++++++++++
> >>  drivers/memory/scrub/Kconfig                  |  11 +
> >>  drivers/memory/scrub/Makefile                 |   6 +
> >>  drivers/memory/scrub/memory-scrub.c           | 452 +++++++++++++++++=
+
> >>  include/acpi/actbl2.h                         |  55 +++
> >>  include/acpi/rasf_acpi.h                      |  59 +++
> >>  include/memory/memory-scrub.h                 |  85 ++++
> >>  include/memory/rasf.h                         |  82 ++++
> >>  19 files changed, 2281 insertions(+)
> >>  create mode 100644
> >> Documentation/ABI/testing/sysfs-class-scrub-configure
> >>  create mode 100644 Documentation/scrub-configure.rst  create mode
> >> 100755 drivers/acpi/ras2_acpi.c  create mode 100755
> >> drivers/acpi/rasf_acpi.c  create mode 100755
> >> drivers/acpi/rasf_acpi_common.c  create mode 100644
> >> drivers/memory/ras2.c  create mode 100644 drivers/memory/rasf.c
> >> create mode 100644 drivers/memory/rasf_common.c  create mode 100644
> >> drivers/memory/scrub/Kconfig  create mode 100644
> >> drivers/memory/scrub/Makefile  create mode 100755
> >> drivers/memory/scrub/memory-scrub.c
> >>  create mode 100755 include/acpi/rasf_acpi.h  create mode 100755
> >> include/memory/memory-scrub.h  create mode 100755
> >> include/memory/rasf.h
> >>
> >> --
> >> 2.34.1
> >>
>
> Thanks,
> Shiju
