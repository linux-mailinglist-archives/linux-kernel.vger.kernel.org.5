Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCB7DED57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjKBHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjKBHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:31:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5612C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:31:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc0e78ec92so4474405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698910268; x=1699515068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpFooBRbxkfZ/wSEwus+JSRKBHYugcnutfyQXd2DWRE=;
        b=vRhNbX5TSmR7o8qiS6ew1j0iucB1YukWnlHkuCaNhsrTymCd/qQIl6HqkYBOMUAshI
         mEB96vVjPGG4vTZBIleCZBCRd0zI0pid/60bPBzUC6qu61DY0sCa3/9trhwxZmA+0nQW
         YCyuqWc/umFp+P05V9yXpOpFPv6IDvXc8enw5pxKCa4PTidHQlJCPngMWHK90N+JxNPT
         /sLxPTnvvRiOn8+1eFw6b95z1NrpKmBJGV3NenT2WwhK9O/ZUmr+eqi5Zo7i2j/8QSZC
         y+KALF39Knc31SwtxQOrC++2yfAGnfon897olzXPMcEIcbCz2CxfmOBp52Pc2Un5HNti
         cCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910268; x=1699515068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpFooBRbxkfZ/wSEwus+JSRKBHYugcnutfyQXd2DWRE=;
        b=WjhbEwetyE2jZpU5Ew6/jpq6AHiqmwD4geLVmaOe61UsqAtgi1IxCFQn0/3WV5H2Pe
         hhIm9XaQc/2Q4JGfF2tyPAN7kiq82bv6wMr0B84vxiuMLsd4bgTEfN/QEa6kWf7T47zJ
         q0mL0QnFYxunlVIbZkSWGHpMzb9a5szjPYe8bKHh/qY8pae9CfN+lzGdNoIqMcPqDbNU
         pL9oDlm5XCwY1p9FIQdJWbwhvU8JDTv1K81KYs8YiWWTtvddg/A48rvJQku9zlYyZbVb
         3Tj+/Gro+wOM1/9vn7PfQOefyfabSOFHqHHYvOCUTDQ1sHl1WGUIUZL3ltJ+AyIsuaPB
         gFDw==
X-Gm-Message-State: AOJu0Yz07bnngnhKKAHxnCZFKO14SODGqrlsgWoVmhi+FIZL9C5gj97e
        aZLqhC4zYvOv0T/KOrpGUBORNQ==
X-Google-Smtp-Source: AGHT+IGJ7JedVw97MOpWD4ZhfL26eo5oIAM+zKC21uMnhqZgmQCKp0xz49ir2/MgMHq5Yl1ge5oqhg==
X-Received: by 2002:a17:903:245:b0:1ca:e05a:93a2 with SMTP id j5-20020a170903024500b001cae05a93a2mr17857451plh.32.1698910267843;
        Thu, 02 Nov 2023 00:31:07 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b03a1a3151sm2424104plj.70.2023.11.02.00.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:31:07 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/2] tee: optee: Fixes for supplicant dependent enumeration
Date:   Thu,  2 Nov 2023 13:00:54 +0530
Message-Id: <20231102073056.174480-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024

Fix this by adding an attribute for supplicant dependent devices so that
the user-space service can detect and detach supplicant devices before
closing the supplicant:

$ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
      then echo $(basename "$dev") > $dev/driver/unbind; fi done

While at it use the global system workqueue for OP-TEE bus scanning work
rather than our own custom one.

Changes in v4:
- Changing the device name would be an ABI break, rather switch to
  additional device attribute: "need_supplicant" to distinguish for ABI
  compatibility.
- Dropped tested-by for patch #1, I would encourage folks to retest
  this.

Changes in v3:

- Split patch into 2 separate ones, one for supplicant fix and other for
  the workqueue.

Changes in v2:

- Use device names to separate out tee-supplicant dependent devices via
  this patch.
- Since user-space service is aware about tee-supplicant lifespan, so
  allow the user-space service to unbind tee-supplicant dependent
  devices before killing the supplicant. Following command has to be
  added to the tee-supplicant service file.

  $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" == *"optee-ta-supp-"* ]]; \
        then echo $(basename "$dev") > $dev/driver/unbind; fi done

Sumit Garg (2):
  tee: optee: Fix supplicant based device enumeration
  tee: optee: Remove redundant custom workqueue

 .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
 drivers/tee/optee/core.c                        | 13 ++-----------
 drivers/tee/optee/device.c                      | 17 +++++++++++++++--
 drivers/tee/optee/optee_private.h               |  2 --
 4 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.34.1

