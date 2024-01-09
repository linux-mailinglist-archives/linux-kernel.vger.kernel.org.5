Return-Path: <linux-kernel+bounces-20703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB228283C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D22B22818
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB1364AB;
	Tue,  9 Jan 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6NQlFlw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9C364A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d420aaa2abso14790095ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704795285; x=1705400085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYcz+lLy7jxQiN/nMDH+1tTyWaKqSRKEE7oqXtsGGtM=;
        b=J6NQlFlwAuoBx20Hu40o6Uxomq5reGhxLwYW4BmC+j5Gs/VNYfR7ueMdR08eYXHCyd
         kH+t7L7tuZSxkWwAG+XmpwpYQbYtFEPyvjEhizZARNSq29Icy2c+KUXUR1FMV7Uq8uS4
         DWEeJa67a4DpN0o9B6YOD4XwooCtaaWpzxv8jLwNn/47o6skIZB9gKY8B5Gb00f8YzQ7
         XA1YlqI1W3FwRC8344OdeKq9HBGaxPObw0ziIfe2nxhjI8HR71W8ZtHSSnGp9tmziRXL
         d8GR9t/YBcRinUocM7kBRZNsOQasdZrG9xt4V5e8YJkffmN7yDKiNLL7j3vd/0UP8sP1
         ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795285; x=1705400085;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYcz+lLy7jxQiN/nMDH+1tTyWaKqSRKEE7oqXtsGGtM=;
        b=vMIEzWQpZ90DxB1uCjb+jyBhVI1g09aZMs+jJf1ZdUOBvx2ER7frziQcSlphEyV5nG
         GA+qHIeaMvxqlZDVCy3ck1hRD0V+iBsp2fjgJ0Z1xUaVtt2kucyflMMKcqZjJbdICiiA
         JvBCGnsytznC0yFul0J8tHsxSjozk3CgR45uMdgBslbVlg1/RyrtRmntMZmXGn3Ik4xL
         Z4qvR6tTCZigtzje0lBtqKaD4tq27o61ujviZPABIezoft4DGVsXWta0gvqrlkFyXwQU
         hVqQNBh3jk8j9GGjjpa7HtJpEOSXAeww08XH4ETtRE9rCvGxlA24BNyk+M7Jmu+30FVJ
         440g==
X-Gm-Message-State: AOJu0YxxGG69CXUgL3n9n8UEKqNbnJk98m7bVmjuLi10pe0EmTG94FFF
	4iyO4BaUY+KWyBShB883YHHeLQfl5yzSiSq1OAApS4YWKA==
X-Google-Smtp-Source: AGHT+IEN6vSrQgf2nJ60+D4f1GqwnDums4anxoIH3Ok/QP6okou9cs21IINCrtyBoivetFA6vG8d1A==
X-Received: by 2002:a17:903:280c:b0:1d4:672f:1f45 with SMTP id kp12-20020a170903280c00b001d4672f1f45mr2218725plb.102.1704795285234;
        Tue, 09 Jan 2024 02:14:45 -0800 (PST)
Received: from [127.0.1.1] ([117.213.102.45])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001d40ca98b9esm1423663plb.65.2024.01.09.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 02:14:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 09 Jan 2024 15:44:31 +0530
Subject: [PATCH] mailmap: Update entry for Manivannan Sadhasivam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-update-mailmap-v1-1-bf7a39f15fb7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIYcnWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNL3dKClMSSVN3cxMyc3MQC3TRLC3MLCyNjIJ2sBNRUUJSallkBNjA
 6trYWAGuBEUZgAAAA
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=3dSN5qGmRVk/NptTYj/p2KLlrbSvmuAZHHD0VvGKIGE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlnRySlhnHNGwZ/DCa1iZnYuWxxHx9jDJ4JRuLD
 7gN9TLbpxCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZZ0ckgAKCRBVnxHm/pHO
 9R2TB/9Axtq2td4W5SgIG3PtNJsIzb4Kcy0AbxnZI28b8c+A8xqp6pf7HMfaLqiWhxzGpGJNB/F
 npSVcj5Ea0cdrBuH1kbNDI1BgrIftp2IIJl4+szkpk65GlWkfQnGJCRZ4i14aj465uQW8eYqqKi
 yjR8cRQfqj7pj2nn3LYmJn4winh7c8ZCTISlBy/C4C7h9ns7/R0W2ySa3Zlx80CC2V6MoLJ/lOt
 1h6NrWEqBG7EjUAUdW/UXezldzCUPPLAQ/Sm6IFYFKlVY7Obfr4J+y1c76EkxIZo7u37KHzZ/0l
 XDR6SznUnWNDynTL6/v32oeqvAExF5pDozmxZ60bOjXg6P6w
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Remove the map for Linaro id as it is still in use and I want to use it for
submitting patches. Otherwise, git uses kernel.org as the author id for
patches created using Linaro id.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9a9069235f0d..00c4c1431d25 100644
--- a/.mailmap
+++ b/.mailmap
@@ -363,7 +363,6 @@ Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
 Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
 Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
-Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
 Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240109-update-mailmap-f9878823f98c

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


