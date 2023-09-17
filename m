Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD87A3DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjIQVOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjIQVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:14:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219012A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:14:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7b91422da8so3643547276.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694985260; x=1695590060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE9zhEHg7Ff1TIIzy8crm7OARMfmzExyLqxHdSZc9JU=;
        b=F+7HQI2hYDV4Uocc9TJgAWRbogODOqjZrPwJ0+O0RovAEZ3xleVkmaFiaU4FHPshzs
         M/WZMA0vCIB1518QE6iH2ohZMq5Hv4c176DVv/VI2kEnLH3X5zdIW/k18Y+/S6If0nCP
         Lsi3P1ErEfPFzqiUpAfP9FxUumbeFwARDltI0rbb/412rwwTRijt3Uy0N3kJnwWAoS8w
         Bc7uLm3yQXH16Tjrvpj9g6HAMi+LIBgD6Ms7DRhhwlWFB7b+HazJsvHAdejj997HyhLN
         9UyS76lbgm3F4PZt+mUmPGvzUWZ6250Mg+Uc+0PxAfsIbLwt/L51JHsmXT7DYuX100ys
         20Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694985260; x=1695590060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE9zhEHg7Ff1TIIzy8crm7OARMfmzExyLqxHdSZc9JU=;
        b=JPaJYHuuRluiw+4xwvog5R/9R8PKaeSE6sdVmqbO87Ds2avmGq5VHABu3lBg6+6Xel
         FCcflsTCz3tD3zQZm3J+8LuEP0clBAQuuzyqo2MvU9mVAruw7aSjcZV09827BlQouIyM
         1UOUY6uZw8CTqzdl4K3ELWLHabmQrSZO2MM6PQyaopWyceuB4qnpyywCHDgtxmf19Dsg
         v3ON5ezSlPKsduAo2MsvIvbrrMw3flwlnzBHHur4tEufUbcEm3gm16a7lBvVae3zLzcM
         wbwj5xFdgGttoP1qGqmKw65vOELWHTDWjveez3hSUV9z8pXzNtvMu0T5LFZ7/4TvYG67
         tuTw==
X-Gm-Message-State: AOJu0Ywtm8/hxO2iuth7letgneTf9mWVVW3cA38rWzguIEh3TR14YJPF
        rS3G+gMDgnqKZC5+wr+R+gjgxDo76nS2cn93gnXoyw==
X-Google-Smtp-Source: AGHT+IEYEGBmaguetuVmqnK/hfRS4pvSVNkwBOqKRbYYNfEh9KrK07Nkvg60EdrkayQBd3d8ORZ8YJ+Y3ccSnxRGE/Y=
X-Received: by 2002:a25:dc8a:0:b0:d0e:b5c8:6359 with SMTP id
 y132-20020a25dc8a000000b00d0eb5c86359mr6726072ybe.55.1694985260079; Sun, 17
 Sep 2023 14:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172818.761-1-shiju.jose@huawei.com>
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Sun, 17 Sep 2023 14:14:06 -0700
Message-ID: <CACw3F50Edbk7uemvS-ZCNABKSz=3VMaRdPjzoYp9XE-hkOUKBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI RAS2
 and configure scrubbers
To:     shiju.jose@huawei.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        naoya.horiguchi@nec.com, tony.luck@intel.com, james.morse@arm.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, rientjes@google.com,
        duenwen@google.com, Vilas.Sridharan@amd.com,
        mike.malvestuto@intel.com, gthelen@google.com, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> This series add,
> 1. support for ACPI RASF(RAS feature table) PCC interfaces
> to communicate with the HW patrol scrubber in the platform,
> as per ACPI 5.1 & upwards revision. Section 5.2.20.
>
> 2. support for ACPI RAS2(RAS2 feature table), as per
> ACPI 6.5 & upwards revision. Section 5.2.21.
>
> 3. scrub driver supports configuring parameters of the memory
> scrubbers in the system. This driver has been implemented
> based on the hwmon subsystem.
>
> The features have tested with RASF and RAS2 emulation in the QEMU.

I am very curious how the test is done. Does the hw patrol scrubber on
host actually been driven by the driver to scrub memory DIMMs (doesn't
seem so to me, but do correct me)? Or it is like to a VM scrubbing is
simulated and no real op to DIMMs?

>
> Previous references to the memory scub and RASF topics.
> https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038=
718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
>
> A Somasundaram (2):
>   ACPI:RASF: Add extract RASF table to register RASF platform devices
>   ACPI:RASF: Add common library for RASF and RAS2 PCC interfaces
>
> Shiju Jose (7):
>   memory: scrub: Add scrub driver supports configuring memory scrubbers
>     in the system
>   memory: scrub: sysfs: Add Documentation entries for set of scrub
>     attributes
>   Documentation/scrub-configure.rst: Add documentation for scrub driver
>   memory: RASF: Add memory RASF driver
>   ACPICA: ACPI 6.5: Add support for RAS2 table
>   ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
>   memory: RAS2: Add memory RAS2 driver
>
>  .../ABI/testing/sysfs-class-scrub-configure   |  82 ++++
>  Documentation/scrub-configure.rst             |  55 +++
>  drivers/acpi/Kconfig                          |  15 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/ras2_acpi.c                      |  97 ++++
>  drivers/acpi/rasf_acpi.c                      |  71 +++
>  drivers/acpi/rasf_acpi_common.c               | 272 +++++++++++
>  drivers/memory/Kconfig                        |  15 +
>  drivers/memory/Makefile                       |   3 +
>  drivers/memory/ras2.c                         | 334 +++++++++++++
>  drivers/memory/rasf.c                         | 335 +++++++++++++
>  drivers/memory/rasf_common.c                  | 251 ++++++++++
>  drivers/memory/scrub/Kconfig                  |  11 +
>  drivers/memory/scrub/Makefile                 |   6 +
>  drivers/memory/scrub/memory-scrub.c           | 452 ++++++++++++++++++
>  include/acpi/actbl2.h                         |  55 +++
>  include/acpi/rasf_acpi.h                      |  59 +++
>  include/memory/memory-scrub.h                 |  85 ++++
>  include/memory/rasf.h                         |  82 ++++
>  19 files changed, 2281 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>  create mode 100644 Documentation/scrub-configure.rst
>  create mode 100755 drivers/acpi/ras2_acpi.c
>  create mode 100755 drivers/acpi/rasf_acpi.c
>  create mode 100755 drivers/acpi/rasf_acpi_common.c
>  create mode 100644 drivers/memory/ras2.c
>  create mode 100644 drivers/memory/rasf.c
>  create mode 100644 drivers/memory/rasf_common.c
>  create mode 100644 drivers/memory/scrub/Kconfig
>  create mode 100644 drivers/memory/scrub/Makefile
>  create mode 100755 drivers/memory/scrub/memory-scrub.c
>  create mode 100755 include/acpi/rasf_acpi.h
>  create mode 100755 include/memory/memory-scrub.h
>  create mode 100755 include/memory/rasf.h
>
> --
> 2.34.1
>
