Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C70771879
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHGCx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGCx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:53:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E51BA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:53:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-56487a5401bso2230283a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691376836; x=1691981636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YD/XTnbhuU2XMDO3k4F6oaZErM6LxFvKeeJ+ERoc/lE=;
        b=dGkfaUwSC2Ua4CSTX3pLjDV+iZqJQg4mb/kAwJ2arxUhufuNnSz5xCt2ojZUkOwFx0
         3c9peJ8E22aOT4OEH/pG8Fx7ST+IkqaWZGtFacicGqMWoY/6i5uek9Emlbn7I7IQr6pE
         bnGMhntYzn0ocszZqfWe1bBQb0dgKYUKWF5Yx7CVN40s/IF+n9kBByMWW10q4GVNhKim
         zTVUbU4XVjVfhHO8osf+AmxCqCx/dGgCR0iGTd3T4LRGpY6YcgV3MP7KghUkJw9YdhWE
         ELIFZe1VOQvAwyZYGToiUh2xcM4jDUAUcoInqX6E70nvo+cUXcM29q0vysPDgKDo75nH
         G50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376836; x=1691981636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YD/XTnbhuU2XMDO3k4F6oaZErM6LxFvKeeJ+ERoc/lE=;
        b=SNewNB6wwNpdMvFkyM9DZuLa4vsS2Ip/aK//wB5GolWPdwo17GIcD/TMTTWoHsXkeL
         08IArfGNmd/2pbNi4ap5xr+T4vU0z+Rwdj3iDcPwT6C8J97rdOB/gvQDEcUODbp45BP/
         0+s14xyDj5k33bQXypUe+2EWIA/SmeJsYey3HFs8H68fmB+LoKtLcut8qHkuM5ZiOSxU
         wUxjbx/RcdnPXrJe7N3I/T82tMfCCZN76ndYinByd8/+8NeKWFV318gWvNf+yOSGFBTC
         /FlwqW2l25QR05P+Oc7QtxrrNGMPVm8apsns+kVQvfn8KmFUOEMpr01ur5SIKhDUrGVj
         bxAg==
X-Gm-Message-State: AOJu0Yz7kzspCD8+Y/jXzsfShiSMFG9qiQX4tDpE+V/i7i2aGS5+COuP
        qc2OHcZXuKkdEsIPiRQY8bmcOw==
X-Google-Smtp-Source: AGHT+IHyqBG+Gw3XLWZbb38o7nuYQzkjog2AkUzyLMZglhhtEgKTLA5gllajSjujUxeelyCbUSSEyA==
X-Received: by 2002:a05:6a21:6d93:b0:13a:8082:5324 with SMTP id wl19-20020a056a216d9300b0013a80825324mr8826987pzb.44.1691376835845;
        Sun, 06 Aug 2023 19:53:55 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id t22-20020a62ea16000000b00666912d8a52sm4959743pfh.197.2023.08.06.19.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:53:51 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date:   Mon,  7 Aug 2023 11:53:37 +0900
Message-Id: <20230807025343.1939-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the tee based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
v7 -> v8
Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
- fix typos
- refactor error handling, direct return if applicable
- use devm_add_action_or_reset() for closing of tee context/session
- remove obvious comment

v6 -> v7
Patch #1-#4 are not updated.
Patch #5 is added into this series, original patch is here:
https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas@linaro.org/

There are two issues in the v6 series and v7 series addresses those.

1) efivar ops is not restored when the tee-supplicant daemon terminates.
 -> As the following patch says, user must remove the device before
    terminating tee-supplicant daemon.
    https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/

2) cause panic when someone remounts the efivarfs as RW even if
SetVariable is not supported
 -> The fifth patch addresses this issue.
   "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
    not supported"

v5 -> v6
- new patch #4 is added in this series, #1-#3 patches are unchanged.
  automatically update super block flag when the efivarops support
  SetVariable runtime service, so that user does not need to manually
  remount the efivarfs as RW.

v4 -> v5
- rebase to efi-next based on v6.4-rc1
- set generic_ops.query_variable_info, it works as expected as follows.
$ df -h /sys/firmware/efi/efivars/
Filesystem      Size  Used Avail Use% Mounted on
efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars

v3 -> v4:
- replace the reference from EDK2 to PI Specification
- remove EDK2 source code reference comments
- prepare nonblocking variant of set_variable, it just returns
  EFI_UNSUPPORTED
- remove redundant buffer size check
- argument name change in mm_communicate
- function interface changes in setup_mm_hdr to remove (void **) cast

v2 -> v3:
- add CONFIG_EFI dependency to TEE_STMM_EFI
- add missing return code check for tee_client_invoke_func()
- directly call efivars_register/unregister from tee_stmm_efi.c

rfc v1 -> v2:
- split patch into three patches, one for drivers/tee,
  one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
- context/session management into probe() and remove() same as other tee
client driver
- StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
- use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
  this file does not contain op-tee specific code, abstracted by tee layer and
  StMM variable driver will work on other tee implementation.
- PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
- implement query_variable_store() but currently not used
- no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
  Other tee client drivers use 0 instead of using TEEC_SUCCESS
- remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
error message



Ilias Apalodimas (1):
  efivarfs: force RO when remounting if SetVariable is not supported

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 612 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 fs/efivarfs/super.c                          |  45 ++
 include/linux/efi.h                          |  12 +
 8 files changed, 947 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: f6e6e95ce16205025b7b8680a66c30a0c4ec2270
-- 
2.30.2

