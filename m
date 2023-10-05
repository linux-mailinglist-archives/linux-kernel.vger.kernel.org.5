Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE37BAEFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjJEWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjJEWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:52:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506EDE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:52:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865f1447a2so2213273276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696546356; x=1697151156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Oz7VGuhkfxzsvalUB4WGErH8Z4TrWqr8F51Ij8/laM=;
        b=tHdMIZ5tS8RGbySNTGbtVgs1Zm3RXGpldh3ytPh+vSsFme5ZjHyfogfTbuu0W864Z8
         HnEjq/qv5BKK/9eoLfX2INT7dGyE4Z1cQstNXT60D90gxRqI7CwxBFsJeaFh26Wuo5Av
         GPN2UsVCZLG9kIPnmCwkl01UBTunFKUIMGQv1zAerck0cbLNNjAh2TwscdyZdTD/2EvI
         1yChzX//yb2G+VD2PQZyPNtFbxlAWRV99mHxrPNK/axfMOS+8Vod7EGE3dOLzUAHjq8Y
         rM0De59R8wNUZoP90ueE64m9whQ5o7ZrksPfsVzTZMS+C9Bd/HjKxwljx/LCzJmmGvHN
         Wmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696546356; x=1697151156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Oz7VGuhkfxzsvalUB4WGErH8Z4TrWqr8F51Ij8/laM=;
        b=d882cP3tPXfTgirzRYnLfoQG70bcCzPGdm+8NXHWyOWnqJdffL4OzFoSKZuHebWRqK
         u6LdjW1Z4rkfpNA+KiWiC15Le7heSUOfte8TX1mH6k2DgFqrTaNBkW7UWT2Hz+5y25qD
         6/H1qfYhDP2PbOCg1+bSibuGUxWs0/BDE2+bT31Vg/wb4gaA3ZZ+kz6EIszvDGqpiqCo
         HiQ6+I5OLIv4JGYHo0PH449st4sri0fHTEbCQouqoXDDDaL4E4AQqq32pDoxa9uoelmE
         S3ZISHmuKCd6PdYVX3e0BtvOLFBWvSsKmWCSQs459uDEkZVjc1iOseRg/TYOOEcZ3fkZ
         hUWg==
X-Gm-Message-State: AOJu0Yyr3lgq/WH1CyD0wqZ3PIl8pwFVthLuSlaB9TuS9I8R8YEhsH9U
        L9SlVNaTEHPtIh6inUg2YI5oQCS9GThrWbuDhQ==
X-Google-Smtp-Source: AGHT+IGDgPSWXZdhmhN7MdmN3bf5jRSxRNUgL0WJ8V/nI7kavwxEdlz4wYNdYbzKHL6kN1emrnS5q9Xxm9oJ1JljtA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:68ce:0:b0:d86:56bc:e289 with SMTP
 id d197-20020a2568ce000000b00d8656bce289mr102971ybc.4.1696546356067; Thu, 05
 Oct 2023 15:52:36 -0700 (PDT)
Date:   Thu, 05 Oct 2023 22:52:34 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADI+H2UC/x2NywrCMBAAf6Xs2YU0Nb5+RUTqZmsXNKmbNCil/
 270NnOZWSCxCic4NQsoF0kSQ5V20wCNfbgziq8O1tiuNcZhyhpo+qBXKawJA2fkPLL+gPoi8xM f8prFS8RImWO4+homRsLO7Y92t70NB+OgLiblQd7//fmyrl/ZrJ0VjgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696546354; l=2673;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fHSGB3GybAy+lcwImCPC6umWTJnnaa6Fe/COzeftew4=; b=2ACCQqBmGkLvXioby9De9Mcm2kl8X/AKHpYXgLlmc18u5LikoehfZYt35LQvAVFalOi3YAlDi
 +/o6ilE3nP7AZKwVkQdZGhrazudQ3OAHN7r1l377kiu1UNfXo7neP/x
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
Subject: [PATCH] cavium/liquidio: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `app_name` to be NUL-terminated:
	dev_info(&oct->pci_dev->dev,
		 "Running %s (%llu Hz)\n",
		 app_name, CVM_CAST64(cs->corefreq));
... and it seems NUL-padding is not required, let's opt for strscpy().

For `oct->boardinfo.name/serial_number` let's opt for strscpy() as well
since it is expected to be NUL-terminated and does not require
NUL-padding as `oct` is zero-initialized in octeon_device.c +707:
|       buf = vzalloc(size);
|       if (!buf)
|       	return NULL;
|
|       oct = (struct octeon_device *)buf;

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/octeon_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 364f4f912dc2..6b6cb73482d7 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -1217,10 +1217,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
 		goto core_drv_init_err;
 	}
 
-	strncpy(app_name,
+	strscpy(app_name,
 		get_oct_app_string(
 		(u32)recv_pkt->rh.r_core_drv_init.app_mode),
-		sizeof(app_name) - 1);
+		sizeof(app_name));
 	oct->app_mode = (u32)recv_pkt->rh.r_core_drv_init.app_mode;
 	if (recv_pkt->rh.r_core_drv_init.app_mode == CVM_DRV_NIC_APP) {
 		oct->fw_info.max_nic_ports =
@@ -1257,9 +1257,10 @@ int octeon_core_drv_init(struct octeon_recv_info *recv_info, void *buf)
 	memcpy(cs, get_rbd(
 	       recv_pkt->buffer_ptr[0]) + OCT_DROQ_INFO_SIZE, sizeof(*cs));
 
-	strncpy(oct->boardinfo.name, cs->boardname, OCT_BOARD_NAME);
-	strncpy(oct->boardinfo.serial_number, cs->board_serial_number,
-		OCT_SERIAL_LEN);
+	strscpy(oct->boardinfo.name, cs->boardname,
+		    sizeof(oct->boardinfo.name));
+	strscpy(oct->boardinfo.serial_number, cs->board_serial_number,
+		    sizeof(oct->boardinfo.serial_number));
 
 	octeon_swap_8B_data((u64 *)cs, (sizeof(*cs) >> 3));
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-3579264bf805

Best regards,
--
Justin Stitt <justinstitt@google.com>

