Return-Path: <linux-kernel+bounces-125162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E889215C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B61C2889C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314B12F362;
	Fri, 29 Mar 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCE0b62S"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC272904
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728831; cv=none; b=ayu/FzzJ3Y6mIrXIeCcKGblWMK8fQckXCr1NotRpzrQtpOPpVwh6VQy4gjpDnGZvQuD8xMmmaMFU7DTlfA6JwBOKewGwhkuN19Q+a4JuWDmiFQ2duJvhH7Zlp7OFpNQBxZjeLENjZWjJkOXOTXRhRvJV2bKTdKOJ1O8UPj84nQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728831; c=relaxed/simple;
	bh=z/dwvRYoLCyrENtd52zE1j0oJSexq/EB596omvcXjTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqOYzYHBCofXHraKihn+EnwzQE0giiaIa7LEK3O49sxUXZlP1HbXni73MPex45nlaZ23FJ1bRTCo/WSj8IJ10jV4riEQ+3pgjjcjDatzI1eIUpO7t0bJGaJ4npR528qQESdyTDjb7muug2ar7Cb9g+HOXf2Qs1vW84x6gbV8+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCE0b62S; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so31576831fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711728828; x=1712333628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8IvZgLFPwbU0i2ZY4hTepKsdCGAPwe5FM2U52H7EOQ=;
        b=kCE0b62SUT8mwWKB8k/5JqGOSs84MTnH2ytdPzY1WUOOHA5rWmRiYRjCs8i79gugpb
         S9rMS+RlKvhBwW5GZASMVlrjyAronRkQncnSJYxOSE+CLE3YMDk5VI0B6e+lETlyZ1rm
         AP950AThyP4bEY5KcsTQF+FBxPqz6rdFasUL9JgXLQj1BlvLo4XFuF6UgqmFxnpZNZmu
         IAQ8jF7E6VQRt6Ub/RML1cZWHYsMUoMqK0L2i1xNRlIc8RWj3ewpZ3qOFgEu5knTqmW+
         yBu52TfU20+tAMMrKWaOQStdQSFaeQC4dBlUYKk7Wod3Ui+FB7nqINmIBvF1FRDDuU6l
         KdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728828; x=1712333628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8IvZgLFPwbU0i2ZY4hTepKsdCGAPwe5FM2U52H7EOQ=;
        b=vA0IpHSXDc7k+YL2szt2ntIaRQpJ7D6av15c8Fpm/OYmi8EvZq5IjQKuvAUFTRdLh/
         WDYj5QYMKwdWcKH9ghp99vTt+RH8utqougx6js3aQMyDbpWdUfK3CypzS3Tb/pvGqWf9
         dqPt5RoAM/bROwGtf3SAwUrs981FVUjSFZvJ+EcKWzsjecbCoOCqgeU688ZstxQltzGn
         1vmbpTB+eA8mNHo4HgOTS1CtFkXY9lciMwlfGdr2VBxFm9UaHRSZSC19XAFnCCo7mySC
         RfJR8qvZEjEFjfYOZJzvx/9uDtMyeMuifJWp/SXKTIGENkGq9e5j804v2INZ1qL8zlH+
         zC5w==
X-Gm-Message-State: AOJu0Yyeutt7CbBexB4NFc7DXRN90rVZm8ldfytkJDfK+06j9jhk/7+c
	Qw50Cw1CjmYoiz6jUtnq2j1qSIryLkrRsG1UGL4O2f/PXTJuT9jCmQLMrT0MEXD36HK5vvT2r+I
	o
X-Google-Smtp-Source: AGHT+IHli1kpbsUY2DisjZ6yCGvx6TTlOnOKE6J/IggOBtIwM7f/6HEfSDUR5zSJ0SU8Fy8vZ/86cw==
X-Received: by 2002:a2e:9b96:0:b0:2d4:7a3:67a7 with SMTP id z22-20020a2e9b96000000b002d407a367a7mr1673985lji.22.1711728827773;
        Fri, 29 Mar 2024 09:13:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b004155568fa99sm214878wmo.36.2024.03.29.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:13:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 17:13:36 +0100
Subject: [PATCH 2/3] nvmem: layouts: onie-tlv: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-nvmem-v1-2-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=z/dwvRYoLCyrENtd52zE1j0oJSexq/EB596omvcXjTY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBui118YOed4bZ4H/VJRg6TLj4R4ovL/V/JOj6
 csgMKbdvmCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgbotQAKCRDBN2bmhouD
 12IID/90Rqq2Cg33QNUyjR83bOD/gpuMId1+BEniJ6gRtdu5Bn6eRiVB+CpdnKJhRYEghBGZSiw
 7T+Q8RaC9fiLfd5GB4KxCxx6qPMzzkT4wFkoAWHWw4KW3p3rcBde57VFCjHi5dbcwXfsn5X7pcQ
 5mXDMTx4Jh4mjaGs07+vkr69c/BfT0OACoV6TdegqZqBWdvfmKYZQubLSgN/kIoGCRv8tuQPDKC
 i0xCFroMCX8ndFDrDz6IC3DZhsfUEdqmTOfwW2JkeaH8KSnc3VqpI1zhVWo5oNLyrdqiCHH5bJF
 AxpMDHCrxDN5Ms+eQi/Xvtlfi2mCd7XXkk5VNkA1o4Fhjlf64DR5Fa83nr/8ffJVm4uQg/ZFM7f
 /MTo+QV6E4bNJ3Jk4FgDmJkKIDBjaI2poPN1IOafrxNbEkI/Po9GXuqgJ3spLo9AE1D8IY75UoL
 v+XiJZN3wNJFpXNatJpK3mBuaqg4m4cnQXY8RjwaxJbrmUMm/0Ie14sdzYdGF/b3tX6C0t9BhWb
 5VzvD8dkjKMqvjm7xvUwAUN6yGI4O+km96+JmWKXjGEBckVRxPWYjh36MQ+HpgDgRi7RpKA+hFF
 qRZzRSR6xtJ9iWp/YP8/HlZ9TQiZdPmgg8Cul7dYk00sIl3FygzwwcHO4gAC4TftjEMBRPR+yH3
 LM+YeSCa4jw74Cg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in nvmem_layout_driver_register() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/nvmem/layouts/onie-tlv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 9d2ad5f2dc10..0967a32319a2 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -247,7 +247,6 @@ MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
 
 static struct nvmem_layout_driver onie_tlv_layout = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "onie-tlv-layout",
 		.of_match_table = onie_tlv_of_match_table,
 	},

-- 
2.34.1


