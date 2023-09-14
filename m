Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5087A02A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjINL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbjINL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:28:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466431FD5;
        Thu, 14 Sep 2023 04:28:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso5416335e9.1;
        Thu, 14 Sep 2023 04:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694690899; x=1695295699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C84N4KpIlfLhULr5hc4AJixueUMKVFzThA0tY3ldPeI=;
        b=Z8wk4XZFPTKNMtHRF9MEnC9DcvgmQZNd4jxKilm4/K82HnIKUrQjf+xPYFzZGVpBwf
         +AXQZ5Vq5WRi/QHPLFnDlCtM2wAsTDQdzj400R+wKh4ofX/dTPwKQrdXV3ZP643xkjPU
         QaILr3rLYpjE0HZi+exUFhEGwGWvVmKkv9BDelEdhx1jKLLUXIKSRPqFL1k8r+e7Ffq1
         lg3yaUXp07oHDoDeY8WbC1LM9aDQoCUoiKkynnL8U3BCRxJKINGkm6OS8j6MUNkO/ma4
         ji4yUdfS8aidHiHhSUPnlEBXoDq1RSVUJ7E+A5ChZHUbl7DrhPtvtNv9+CkBxa256Rpv
         FFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690899; x=1695295699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C84N4KpIlfLhULr5hc4AJixueUMKVFzThA0tY3ldPeI=;
        b=L2vlXgrmH1iwMFBa+JzcojNCS/I3IRAxI3LK8FhK69zTviihwp4geyDi7Cpbrg6HR7
         pFQ2ntTP25FO0Y5H0oHc7JfzBFrvFOMvEWzTxrk/fCAeDgEQp3ngseREvujVhTaWNpTs
         pT6/fAZgRkiGqshEmqgH2snIsV+VahrR6WdPTG5StMHWHf1fsquN5iyfCKfkRYDAbJV5
         yKTjzh5bJKEJyQsDcvTu+W+i94mvYH8+9JHlrJaoLFFhoDglI8AoAbAyHEUWay+Vx3Yn
         /jLp/1s4kXG2knSrUsBKDzeuIZ84y6tXKQ4y+l13paw4k6YBapBii4pWx4Ihn1uZ0GvK
         eFMw==
X-Gm-Message-State: AOJu0YzQAJZPsjstovbr8cHG7fjeu3n9HgDAAXiVRlMX9gAVu/UbuFG+
        hFBjoJm0xXOq9K2+O/iZQPgSDIF0Fn6JRw==
X-Google-Smtp-Source: AGHT+IELJuTUdJIWSQ45iy2wGCtfTswWTAWydjDtGP+/E0KFWu7+R7gYsQAjHOzxx+ZQlRvEhMEfFg==
X-Received: by 2002:a1c:7402:0:b0:402:feff:90d5 with SMTP id p2-20020a1c7402000000b00402feff90d5mr4446473wmc.5.1694690899199;
        Thu, 14 Sep 2023 04:28:19 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id l36-20020a05600c1d2400b003fef5402d2dsm4786764wms.8.2023.09.14.04.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:28:18 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: [RFC PATCH 2/2] docs: Update kernel-parameters.txt for signature verification enhancement
Date:   Thu, 14 Sep 2023 11:27:39 +0000
Message-Id: <20230914112739.112729-3-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914112739.112729-1-alessandro.carminati@gmail.com>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kernel-parameters.txt to reflect new deferred signature
verification.
Enhances boot speed by allowing unsigned modules in initrd after
bootloader check.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0c38a8af95ce..beec86f0dd05 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3410,6 +3410,15 @@
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
+	module_sig_check_wait=
+			This parameter enables delayed activation of module
+			signature checks, deferring the process until userspace
+			triggers it. Once activated, this setting becomes
+			permanent and cannot be reversed. This feature proves
+			valuable for incorporating unsigned modules within
+			initrd, especially after bootloader verification.
+			By employing this option, boot times can be quicker.
+
 	module_blacklist=  [KNL] Do not load a comma-separated list of
 			modules.  Useful for debugging problem modules.
 
-- 
2.34.1

