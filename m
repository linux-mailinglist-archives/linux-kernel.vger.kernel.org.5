Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3887ACAAF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjIXQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:07:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA258F1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 09:07:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so601273466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695571643; x=1696176443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeckoQ9VJ6OdE5PMGKcILi8nW1PsNTWbedGCSVfgmYk=;
        b=pM6RtUZ4Xtu65BKrhuaRLnqteAc8odjhJPgScTI6jG3b5rHRIMk1x/ldvs/TAL+q9K
         XtYxIyFwMhVLLwIMB7bVti5sEacz2JtKOSgIlMzgkU7OWcuJOtiQbpMyGNRpIoENv5rW
         ScE8zK/sgAmo1/ijQtC4qUvrOHdZExq+JwrX/xIVBE0bV22hALrP7zc+VvTwFgANDaBA
         S+MTaWHUBZ2Mo6bwEqdVytt6PRfnhOsPmOH0jnTH7/LooVuCKr/9FIYYVQpoh6sdAdLJ
         5ZHN2jZCVwI6c0Ec2pD1ykA18jxxe7RfUXXK/8tr4+W5mwT6P7/q2Q1dujZhr1itfY8g
         vMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571643; x=1696176443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeckoQ9VJ6OdE5PMGKcILi8nW1PsNTWbedGCSVfgmYk=;
        b=oVVqt6R3K6lZGIFhqE6vQZQjvEGT1QTrABb1y/Y1lU03l7jta46a1xze0uCZIBSeKS
         TunRdtk/gsC4q3fnASCrlRygwmAzWUM9gKwPqw9W0gHxnGdk/1bRzizxYDdZ1yfQuJrA
         9cJiirmMxvoSHSKJdmxAJXdnSK4Pm3relwUyECmwy4MlEyzGTHA8gXJihLLGIPT9o4KA
         LJAsjlFM9iGJkf6vBWv5uhSLQJIxac86a48cxALfK9/UcXtS/+DSJZjUg1x2Tk4tafLE
         ewuJstG0l+lH6Y7kVI5qR+imFDMTVa8xvQjd7iueEHVxlDelc2OpJi5biaQ+QJy+mSN8
         ueHg==
X-Gm-Message-State: AOJu0YwGP43UkTh+Wh3Q+8D6MOOc5CXjLZCcBX6FYT0NMUSWSdn6ehnP
        kvHR0geMBhHmSVRqZBRl/8M8
X-Google-Smtp-Source: AGHT+IFmNgTmvkhfEL7chsuYFChrrcCOV2LP9TnppN/EiOE3IfsIoXn1NDoQMebULuwONv1/WW8lxQ==
X-Received: by 2002:a17:907:6d29:b0:9a5:b1cd:bdf2 with SMTP id sa41-20020a1709076d2900b009a5b1cdbdf2mr4006180ejc.51.1695571643552;
        Sun, 24 Sep 2023 09:07:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:8240:1578:d967:4cf:6d0e:a066])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b00999bb1e01dfsm5155345ejj.52.2023.09.24.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 09:07:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom: Add interconnect bandwidth for PCIe Gen4
Date:   Sun, 24 Sep 2023 18:07:13 +0200
Message-Id: <20230924160713.217086-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe Gen4 supports the interconnect bandwidth of 1969 MBps. So let's add
the bandwidth support in the driver. Otherwise, the default bandwidth of
985 MBps will be used.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 297442c969b6..6853123f92c1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1384,11 +1384,14 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	case 2:
 		bw = MBps_to_icc(500);
 		break;
+	case 3:
+		bw = MBps_to_icc(985);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		fallthrough;
-	case 3:
-		bw = MBps_to_icc(985);
+	case 4:
+		bw = MBps_to_icc(1969);
 		break;
 	}
 
-- 
2.25.1

