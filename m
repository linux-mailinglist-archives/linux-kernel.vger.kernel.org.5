Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D97BADA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjJEVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:33:23 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D06E9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:33:20 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57b739e5637so1762320eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696541600; x=1697146400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DBeGsTEWaeHMVhG88NcKDZwFuePbfbjL4RyYq3i7W/U=;
        b=w7WfL1/G6/y1GScimOJYHT+87Q8GMHJNBFsijTmekIyEQMcgZEcTh815QBNPe8vhUD
         J83dm8TvK7umU+fVBL7mDSyWfYlZX3OVkCvu4a58MXdRkFIqi1lT4IBq3rbbS3LZHg+4
         /9Ya1TbRfR5EFgoDapnJDipaTzGaAXv474aJj71A9jt4qC9kOvD2v4LbVGjkKY2PuPIF
         bSQKwZK/0FrFQs+5Tyids8wKoaVVe8lGJY52MpD8/qcp5TGX4sydFZxaUMBEfH1Mab3G
         QQEkNkrZFWymaSuqfShJc2qjAUF4S+ZeJn7bFvEQfQAawSTa6ENKyH+j6pMd1LEcsPvL
         EVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541600; x=1697146400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBeGsTEWaeHMVhG88NcKDZwFuePbfbjL4RyYq3i7W/U=;
        b=oTPUVOB17hUMh2+znSlVw6zETzsn6OcW4nOxtA5Fbq4iIXtOBa+i8vCqNTDq617zvt
         UP0uS0mfS1bpHhpYWHnECulSi8hYDZIXKuBvdsWcgZSCBCxDUf9gO99TBfjdwphNo96b
         bcFZIvimrrUW8wX+ys8cvOB+tfTBFdxHMPOvOfF92nEyyfKT4Rnt3y9bdxThoQApv4u0
         TM8OigTlBeMI97Vg5LfPoa6dR3Gmm/ipc8cOWSdFvUr87FFKdbXAy42B5HRwe94kOl8z
         qbydmUiLk/B5VPEocykD+p8iJILLXM+x66JZiynD3faOCLiZQ5Qomc+DLth8McS6jm0c
         u4WA==
X-Gm-Message-State: AOJu0YybqPH9gR+XHVE+7UOgkPEUvX8I6pxrebnyXjKjcVW3RucFGm0Q
        j+ED1QODB7uyZz+V7VQ/mZJMOH60EDeha9gTjA==
X-Google-Smtp-Source: AGHT+IERmtuCbXgTxMb6GCIs82t5NHgtdhXCBck4p3yQOXrj8TSuyBNg0Kjon0YrX+XoIVuXYQ74AU/tz2JVombgFA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:4f42:0:b0:57b:3840:4c85 with SMTP
 id c63-20020a4a4f42000000b0057b38404c85mr2335028oob.1.1696541600124; Thu, 05
 Oct 2023 14:33:20 -0700 (PDT)
Date:   Thu, 05 Oct 2023 21:33:19 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ4rH2UC/x2NQQrCMBAAv1L27EKSoqhfEZGabOxCTepuGpTSv
 xu9zTCHWUFJmBTO3QpClZVzamJ3HfhxSA9CDs3BGddbY/aoRZKfPxiEK4liooJURpIf+KHy8sS JXwsHzg3yrcWS84Qe74dT77yJRxMttMEsFPn9n1+u2/YFMCiAn4wAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696541598; l=2730;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PKPsb45o8cJUMR1NbV9bY/ZXdX56wnhP8PdDKS7CtXE=; b=V1BHnD4OOJXpH/xgsaKnRxTqiT9ViCdlfEibIwEOSbm+ZYxyvmHL5E4Z4Ng26ZmlHpUNgDba/
 +ghPh0uvDd3Cp21R6QwP2QMeWaE/vV57KKgtRZYIt+iUrL/D/xjBytE
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
Subject: [PATCH] liquidio: replace deprecated strncpy/strcpy with strscpy
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not required as drvinfo is memset to 0:
|	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 9d56181a301f..d3e07b6ed5e1 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -442,10 +442,11 @@ lio_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 	oct = lio->oct_dev;
 
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
-	strcpy(drvinfo->driver, "liquidio");
-	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
-		ETHTOOL_FWVERS_LEN);
-	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
+	strscpy(drvinfo->driver, "liquidio", sizeof(drvinfo->driver));
+	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
+		sizeof(drvinfo->fw_version));
+	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
+		sizeof(drvinfo->bus_info));
 }
 
 static void
@@ -458,10 +459,11 @@ lio_get_vf_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 	oct = lio->oct_dev;
 
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
-	strcpy(drvinfo->driver, "liquidio_vf");
-	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
-		ETHTOOL_FWVERS_LEN);
-	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
+	strscpy(drvinfo->driver, "liquidio_vf", sizeof(drvinfo->driver));
+	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
+		sizeof(drvinfo->fw_version));
+	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
+		sizeof(drvinfo->bus_info));
 }
 
 static int

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-b6932c0f80f1

Best regards,
--
Justin Stitt <justinstitt@google.com>

