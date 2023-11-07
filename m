Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE47E3AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKGLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjKGLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:02:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F0B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:02:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7004229e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699354945; x=1699959745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0anm7ddVMrR6+VdyylWCA9JmbbtcqiR4CvxRpAtSqU=;
        b=ewRlXGBeQP4Gx9dXaL7v8cx+GXGqnsoWXg0Jn1CXHG2TyOspqagVUEHvnaDcFnf1M6
         YIcsEwELdH6O1BwCHF7PgtgO1Wvxn3++Tvq6BoX55e3sXcfiRPb0fgGv1hxTV0lXMKjp
         in5ozuYTFzlOz33qlai8r0Luoc3eZr39zFI9B9ICSEMzy0DMdlswFC4GIVi9lLDoxEED
         63RB26amswf1RfO/r2+Stixf/6xv9dMuRVOQEWurOzTJq8pcGlbTpA+wr8Vf4uKsiwGe
         7taufWFrjvgePYxHpqohXF2f2L+4+vgCY3jDTo90I9vzp905I0yyNsI+tbeD+/0LmFPC
         cjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354945; x=1699959745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0anm7ddVMrR6+VdyylWCA9JmbbtcqiR4CvxRpAtSqU=;
        b=t09+7ax7N0psoQ8B7Ls/NSFXlMLjrpeSNVb+1UXCmhaTCLdjRBEhHmUi0OEoXUlT6r
         udz3f9oXMhF9cqN9xeyb9482+ynj8UeOW+CQNzKA4e28hMqWcL+KhGf/UpL5FmRCC0xK
         jXy0/QavJ6x77CxTeoXthWIPQkTYLXB0XdaTarktLoc2CGGpXfDSlahHRrl9WEJ4GjRV
         1PewFVXhyAw7wyzZBubUj8sftJd9YmSLk07307AhIrcJvQO17wMSLRViFB3U/2XP+Cvo
         wjQg6QJoRxarcvBP7LRUKGtbO2lMA3RG8dzObNO5dOFRtC4aqXOpzY1ywDy7PhK2Tskx
         sMNQ==
X-Gm-Message-State: AOJu0YwVv++Q3tgnMi5eSjkiFUKcc6ChVKq/RunJyFX//n1C6WFX3aER
        kaLxJ3mTcc05uZaHGt4pfn4HqejowbvNJY+WSneWZQ==
X-Google-Smtp-Source: AGHT+IF9mMjePxVnT2UWthnbRjqVoUWNpE4h4aQeAHsFAxK8YtqMNeLy01N3FPGF34fov+gfhqcBec3cXyXvtp+CxiA=
X-Received: by 2002:a05:6512:695:b0:509:297d:b7a2 with SMTP id
 t21-20020a056512069500b00509297db7a2mr21252888lfe.65.1699354945283; Tue, 07
 Nov 2023 03:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 7 Nov 2023 13:01:49 +0200
Message-ID: <CAC_iWjLmv52BQ_k8UrFAaMUTkg6f2uGhsb=SzUnkiSkS16JYRg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kojima-san

patch #5 wasn't applying correctly. I guess this is based on efi-next?

On Tue, 7 Nov 2023 at 07:41, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> This series introduces the tee-based EFI Runtime Variable Service.
>
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
>
> This driver depends on the tee-supplicant. When the tee-supplicant
> stops, this driver needs to be unbound from user-space script or tool,
> relevant patch is posted[1].
>
> [1] https://lore.kernel.org/all/20231102073056.174480-2-sumit.garg@linaro.org/

I managed to test with Sumit's patch on top. Unbinding the device
works nicely and mounts the efivarfs as RO.

Reading and writing authenticated and non authenticated variables
works as well.  The only 'problem' I found was this sequence

efi-updatevar -f PK.auth PK
efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
efi-updatevar -f PK.auth PK

For some reason this leaves an empty 'PK' in the database.  But that
PK only appears in Linux not in the firmware and if you reboot, it's
gone.  I am pretty sure this isn't related to this patchset

Doing
efi-updatevar -f PK.auth PK
efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
efi-updatevar -f PK.auth PK

works fine.

For the series
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Changelog:
> v9 -> v10
> - patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
>   is removed
>
> v8 -> v9
> - patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
>   is newly added
> - remove !EFI_VARS_PSTORE Kconfig dependency, we have added a non-blocking
>   set_variable and it just returns EFI_UNSUPPORTED.
> - remove obvious comments
>
> v7 -> v8
> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> - fix typos
> - refactor error handling, direct return if applicable
> - use devm_add_action_or_reset() for closing of tee context/session
> - remove obvious comment
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
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 616 +++++++++++++++++++
>  drivers/firmware/efi/vars.c                  |   8 +
>  fs/efivarfs/super.c                          |  45 ++
>  include/linux/efi.h                          |  12 +
>  8 files changed, 951 insertions(+)
>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
>
>
> base-commit: 5329aa5101f73c451bcd48deaf3f296685849d9c
> --
> 2.39.2
>
