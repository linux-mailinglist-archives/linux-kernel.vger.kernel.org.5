Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E977B564
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbjHNJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjHNJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB6113
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:24:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so62587281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692005094; x=1692609894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JFxxFR5TymLQm+aito+FZJyIWGIRfXx3TVA3PFJ72C0=;
        b=x3GkhbXJC7WiYbklRuBlGb7WiDGlcrWkMpbKimBKGnsS7UOm4sFHGPD/nvR8QfAoFL
         VuOyl+JmQGxrn46EEoXzzDAM0UFO7waKyDAiu18vvJ3hqxDKMn9xzumiOPxiSAG5BcMH
         +UGfnaXC+D3PCcL7HT1uYHqWvI1BsSpL8iL6jg7+TcIIseQpnKW3066fJco8/ToqrGuS
         Im1ZEpgtynpE2iBYKnXtjYumLf9aPSzC65NrvNcygtn69i5Cr39oc0tAGIPcFihUdVgh
         YKl8GIZdGg/Z/iiM9FuXjdG5z9HUtGtd+HxniAbaznklMkxFETAtFTn1y3kfeQMTFReS
         rn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005094; x=1692609894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFxxFR5TymLQm+aito+FZJyIWGIRfXx3TVA3PFJ72C0=;
        b=HuakJOo82fPlo97Ni3mGq+UH4lFWnEve8dq8OBJWNYFzzqS5Ap8dZ9xlJE2ozJyTQa
         sr8eImaCETGKmlK2OkMyX2jOLn0PtrESBV0T2xMGMGuX5j0dYJmEsGblijZS+CbCptLi
         wA+d4+wa5F0eWbp4f6CRrzAdToOOmkKDFM+yF4K92hGsacngzhp1n5Mk/UZWayhXVdwq
         NR1FSuTxqZzKBs+vv6j61xGunj6ARd0Ib1vzH+QyA5WZHgRXHzzGdGwWPDogwKyFVsN2
         tTa6kTU55t/JMJ/bT5ZuMeRv6q2KHZLjSC9/wDOh57nSCZ6blPnxLxEIQtXiicqFTYKW
         /kuQ==
X-Gm-Message-State: AOJu0Yx7kJ0hgdveRr0NPMq17JdS/Czp0SiNCDbGRnT/HJDno/RCiHe2
        jS3XXbqySDszYS+PofuUXJ1uQ3BjENi2Ngp0G+hXUESprrji4Zxm7IvYxw==
X-Google-Smtp-Source: AGHT+IHr9v01ZWZyUzD3vM7qKaug00t39MvClWRGrqq8j1TOOtduPuhlRnV6sBoewQyB2kjTvjp9cBGJoVyO8OvaHOw=
X-Received: by 2002:a05:651c:212:b0:2b5:7f93:b3b0 with SMTP id
 y18-20020a05651c021200b002b57f93b3b0mr6151058ljn.17.1692005094466; Mon, 14
 Aug 2023 02:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230807025343.1939-1-masahisa.kojima@linaro.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 14 Aug 2023 12:24:18 +0300
Message-ID: <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> This series introduces the tee based EFI Runtime Variable Service.
>
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
>
> Changelog:
> v7 -> v8
> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> - fix typos
> - refactor error handling, direct return if applicable
> - use devm_add_action_or_reset() for closing of tee context/session
> - remove obvious comment

Any chance you can run this and see if it solves your issues?

Thanks
/Ilias
>
> v6 -> v7
> Patch #1-#4 are not updated.
> Patch #5 is added into this series, original patch is here:
> https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas@linaro.org/
>
> There are two issues in the v6 series and v7 series addresses those.
>
> 1) efivar ops is not restored when the tee-supplicant daemon terminates.
>  -> As the following patch says, user must remove the device before
>     terminating tee-supplicant daemon.
>     https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
>
> 2) cause panic when someone remounts the efivarfs as RW even if
> SetVariable is not supported
>  -> The fifth patch addresses this issue.
>    "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
>     not supported"
>
> v5 -> v6
> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>   automatically update super block flag when the efivarops support
>   SetVariable runtime service, so that user does not need to manually
>   remount the efivarfs as RW.
>
> v4 -> v5
> - rebase to efi-next based on v6.4-rc1
> - set generic_ops.query_variable_info, it works as expected as follows.
> $ df -h /sys/firmware/efi/efivars/
> Filesystem      Size  Used Avail Use% Mounted on
> efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
>
> v3 -> v4:
> - replace the reference from EDK2 to PI Specification
> - remove EDK2 source code reference comments
> - prepare nonblocking variant of set_variable, it just returns
>   EFI_UNSUPPORTED
> - remove redundant buffer size check
> - argument name change in mm_communicate
> - function interface changes in setup_mm_hdr to remove (void **) cast
>
> v2 -> v3:
> - add CONFIG_EFI dependency to TEE_STMM_EFI
> - add missing return code check for tee_client_invoke_func()
> - directly call efivars_register/unregister from tee_stmm_efi.c
>
> rfc v1 -> v2:
> - split patch into three patches, one for drivers/tee,
>   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> - context/session management into probe() and remove() same as other tee
> client driver
> - StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
> - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
>   this file does not contain op-tee specific code, abstracted by tee layer and
>   StMM variable driver will work on other tee implementation.
> - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> - implement query_variable_store() but currently not used
> - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
>   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> error message
>
>
>
> Ilias Apalodimas (1):
>   efivarfs: force RO when remounting if SetVariable is not supported
>
> Masahisa Kojima (4):
>   efi: expose efivar generic ops register function
>   efi: Add EFI_ACCESS_DENIED status code
>   efi: Add tee-based EFI variable driver
>   efivarfs: automatically update super block flag
>
>  drivers/firmware/efi/Kconfig                 |  15 +
>  drivers/firmware/efi/Makefile                |   1 +
>  drivers/firmware/efi/efi.c                   |  18 +
>  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 612 +++++++++++++++++++
>  drivers/firmware/efi/vars.c                  |   8 +
>  fs/efivarfs/super.c                          |  45 ++
>  include/linux/efi.h                          |  12 +
>  8 files changed, 947 insertions(+)
>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
>
>
> base-commit: f6e6e95ce16205025b7b8680a66c30a0c4ec2270
> --
> 2.30.2
>
