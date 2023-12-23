Return-Path: <linux-kernel+bounces-10342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459781D31F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC48E28453D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450B8C1A;
	Sat, 23 Dec 2023 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUXUNN8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDC8BE5;
	Sat, 23 Dec 2023 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1844961a12.3;
        Sat, 23 Dec 2023 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703320325; x=1703925125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltOi6r7fK9bfySPLwaQJXbTwu4MoVyIkyF1mw73/wow=;
        b=CAUXUNN8NmuJnW+wf6KU7U9pLSg+3YIZ8JelM1djcILXGRyYopvYJsH2Wexwu3RVWR
         s5e2/DFlCP2NY4Qfrk6OMuixzKbnnEHhTtRUd1hiu3QN3O8sI9kXg3TQh6MyzPVZbayv
         PNWyJUn4JADpGuGzFdiOTYe9thigxz1PxK6zSdM1aaIHj5sfhl2d8TLzgZHXJKsA6duq
         vLpu/hWgHBVPb+H0APtQlAhwlf0yYEprRsnpSGmNNYWi54hah8+bfgj1Um803Klc9Vk+
         dPhNkQ1+YwUOE8B5oEyB1WAeE9RDmXc087jyCeStx1oAzt+ZXjUMMDU7PLYrocYaKL+9
         RxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703320325; x=1703925125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltOi6r7fK9bfySPLwaQJXbTwu4MoVyIkyF1mw73/wow=;
        b=d2Ni7frsOxMJfkntoa6ZYk3MwyDyM6HCyLIjlN1q8rReERqPdHT1ubXgTxAHSC6U7H
         RHZyR49NLeicZbxNUJL+/0fWitGSW8kSZ9i8gRvPlCHVPGntQivPHyixT34y8+RoFTYU
         qjk8k2jkkxNNymfO8blzSf2NaLQHCh3KDgo+5Rgh2YwH/QmbPrGO7n/b3mmw44R2MnoU
         LW8dp+FK2uRfYx/pxoQWGvhDlT3QrP9zRkwQFABTpxmJ5dWpcdC3XNFe5bdJAJh7xJIR
         Jgd/jJsDsHIQC5EZanPDlrepog4iz/f6cToSyG+mzaOtuH1FLV7PY+rmsv0fP+rzO1Nr
         cZPw==
X-Gm-Message-State: AOJu0YwY2Te6YU5+b4rmROdWCCJnxLWGSDjpbwgx4EFw9OB300jwS5PO
	1heqKMGYXcGFHFs2m2BvEn4=
X-Google-Smtp-Source: AGHT+IF9s6B9AwwFBmikLvuFCZBc0WaXkD1epFSbGhnrvs9lMnWisGnxqwIEE/DC5z5Sax9vGjvWhg==
X-Received: by 2002:a17:903:41c9:b0:1d0:6ffd:9e06 with SMTP id u9-20020a17090341c900b001d06ffd9e06mr2270306ple.88.1703320325330;
        Sat, 23 Dec 2023 00:32:05 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm4558658plq.279.2023.12.23.00.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 00:32:05 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media/atomisp/pci/isp/kernels/hdr: Fix spelling mistakes in ia_css_hdr_types.h
Date: Sat, 23 Dec 2023 14:16:57 +0545
Message-Id: <20231223083157.84090-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in ia_css_hdr_types.h below:

'''
./isp/kernels/hdr/ia_css_hdr_types.h:60: paramterers ==> parameters
./isp/kernels/hdr/ia_css_hdr_types.h:62: Currenly ==> Currently
'''
This patch fixes these spelling mistakes.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h b/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
index 175c301ee96a..ecc98686f5cf 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h
@@ -57,9 +57,9 @@ struct ia_css_hdr_exclusion_params {
 };
 
 /**
- * \brief HDR public paramterers.
+ * \brief HDR public parameters.
  * \details Struct with all parameters for HDR that can be seet from
- * the CSS API. Currenly, only test parameters are defined.
+ * the CSS API. Currently, only test parameters are defined.
  */
 struct ia_css_hdr_config {
 	struct ia_css_hdr_irradiance_params irradiance; /** HDR irradiance parameters */
-- 
2.39.2 (Apple Git-143)


