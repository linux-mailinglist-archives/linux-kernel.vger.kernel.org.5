Return-Path: <linux-kernel+bounces-24024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B282B58C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642D528A699
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D756B9D;
	Thu, 11 Jan 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4sm9qUr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35235675F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so5187490f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705003025; x=1705607825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZgZWlLOuuHga2qhsI0tLSH9tBejx4Id+Q/YPwkUBME=;
        b=c4sm9qUrYKH+8olL55EoTIDnWcB6hriLi8xL2Hz6DxiaqX0wkWftqPnW/2chuexifJ
         USVmoZ3CtJDlSqll7bHE2Feiw88hqlj4S6TS0qEIrSg0SRV2egW6SOAia0SnY9Lgh3KM
         pVTMzQyYOo5lKzjsIZmhxUF8YuimtyQt+Pj7otVI5fvTy2/xte1RBg15XcuX9JlOdy09
         BClwfWXmwjlW9LUWw6RANOZ4JCRbCVoCaOG7fHCf375QiNlnuIWplyRMPYqfPv9+wanG
         wuRnPj4Cn8rOUhnFk6CsItxPvizkmuX0xZ13ywq75eI/z6fF0lVBWt5dSBfNQHwrtP7f
         cRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003025; x=1705607825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZgZWlLOuuHga2qhsI0tLSH9tBejx4Id+Q/YPwkUBME=;
        b=J2YzD1753ecLwwaMgBBA87qWlKLdPXnpZIMuu6ddO/qQw94FP9blW6aXJA9IUtITGK
         b8oNNn1oiQN9blLEmGWlLZlEHU/Ig0lJ3RTG3qFLhOZADUKLTR6GLmb0Mj4SxBTZdPtr
         G9kCGVNLZEREfFLjjTdVMJuYy72wOvq5n2YfxGHovMjpbglyJ5NBjobu4R85fitkfLk6
         2ghawLes0TxKz/G7l17UhbnwuGQTspoiE51S5iYbTkkMlZSiHPhrE3hLQbNRMc5A+x1r
         byQfq+lkPPRdW4d9erncn2HM8nHQRHBysRQMMgqN1J9AbHMYmDX9jx4rR5HboEwbyso6
         4ASg==
X-Gm-Message-State: AOJu0Yw5qPj4ir5fZ7AhypTiWaOU43727f1F4fDaEk0rd9hqMsUhhUVK
	qE7eYSt+LU/WZt1Dc/7Uo3XqxM/Ulx4oSw==
X-Google-Smtp-Source: AGHT+IHbYFnxaZC2TUCLNG8JxqpcbQ6mJ0YZ5FZ0wSYJrvJECq4/mFEWuk77HvnMwC8MqDC1U+0KIw==
X-Received: by 2002:a5d:6104:0:b0:337:652a:434d with SMTP id v4-20020a5d6104000000b00337652a434dmr82635wrt.137.1705003025332;
        Thu, 11 Jan 2024 11:57:05 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm1955382wrn.63.2024.01.11.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:57:05 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jan 2024 19:57:03 +0000
Subject: [PATCH 2/5] media: qcom: camss: Add CAMSS_SC8280XP enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-2-b92a650121ba@linaro.org>
References: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
In-Reply-To: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

Adds a CAMSS SoC identifier for the SC8280XP.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index a0c2dcc779f0..ac15fe23a702 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -77,6 +77,7 @@ enum camss_version {
 	CAMSS_660,
 	CAMSS_845,
 	CAMSS_8250,
+	CAMSS_8280XP,
 };
 
 enum icc_count {

-- 
2.42.0


