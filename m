Return-Path: <linux-kernel+bounces-24027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AD82B595
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE5C1F24246
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459857888;
	Thu, 11 Jan 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/wkqdio"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566C5731C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3376555b756so3345149f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705003028; x=1705607828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vt4idOJ4AVt0o+9v3yIJItOs/gt0F0b2lVJhV4P/Taw=;
        b=f/wkqdiodNpRYVeKemyBnc3CgxRiGBYfiJ2i/To9OCgKk9MfUHwmsyzt4/RPTjVNml
         MoNOpBBRGXWEmVhw9zfzxFYi0i8k3NxJuAHZdMwv8DHexejCycwiD51I3VfokiaJU1vp
         zVzvBNGQLXZie/invwnrHFeW6FMzZG22DCC58PS0M8R2z3GUCaXD51fnavLRlAoj11UU
         TK9pRPTfRnoJXuh92q6z9SoAZZFp49B9NzhnHBIgrjGGBAlKG5UiFBMcT4cs/66QCCpY
         pK2dZlnvENkIEnufEQfpt/ZqoyxIXRxDBTVU6AAoBJU7UlAHrP651no5I4x4+8uvEWy2
         Q/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003028; x=1705607828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt4idOJ4AVt0o+9v3yIJItOs/gt0F0b2lVJhV4P/Taw=;
        b=H7Chh9hdEXw5aPCRDNxeelueiSY3q51w5CAKZ3mEGJKUomikcWmD68nfCrUxKUHMdH
         tz65skGRqnEuy6lmSxMqkGj8RUPVsL1ypcWm+IlujClAH9woEoRO2dPvmaITVnJcKg4o
         Ug1wff9KTRgOP2Jne30tTr6N0kY6M6lvZ53ZaxVTrd3WrtKGkLL0nzH3pAdbmkh2JHCB
         vcYlKS3iTy6XT9L3pOPav+4AXoMvoKn4E0GTKJsgRmo+HnGDrVuQj/qHhXP5+fyxyFs8
         1ao5Kp2WcNSnTrKEZ6I7qCKb36K+m3j8fZhpIopXFoGidLc1SsPDDskm8l3ryadzGf0i
         gNxA==
X-Gm-Message-State: AOJu0YweUV/gl6eh3tZED+SVNrRQogwQl9p4CWjvCqGo33xSetV2Kidg
	y8Rrb8Bs91p/wnDnvVA8Yoo611ItB/Z3Iw==
X-Google-Smtp-Source: AGHT+IE90qP2pgskdFf+tC+ZCbc+pS9HmA+agxQymv0g25TJ6DADTofWu1tMSPhKtAsxJEQylqul4w==
X-Received: by 2002:a5d:4603:0:b0:336:7281:cc78 with SMTP id t3-20020a5d4603000000b003367281cc78mr218405wrq.50.1705003028504;
        Thu, 11 Jan 2024 11:57:08 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm1955382wrn.63.2024.01.11.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:57:08 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jan 2024 19:57:06 +0000
Subject: [PATCH 5/5] media: qcom: camss: vfe-17x: Rename camss-vfe-170 to
 camss-vfe-17x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-5-b92a650121ba@linaro.org>
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

vfe-170 and vfe-175 can be supported in the same file with some minimal
indirection to differentiate between the silicon versions.

sdm845 uses vfe-170, sc8280xp uses vfe-175-200. Lets rename the file to
capture its wider scope than vfe-170 only.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/Makefile                             | 2 +-
 drivers/media/platform/qcom/camss/{camss-vfe-170.c => camss-vfe-17x.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 4e2222358973..0d4389ab312d 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -14,7 +14,7 @@ qcom-camss-objs += \
 		camss-vfe-4-1.o \
 		camss-vfe-4-7.o \
 		camss-vfe-4-8.o \
-		camss-vfe-170.o \
+		camss-vfe-17x.o \
 		camss-vfe-480.o \
 		camss-vfe-gen1.o \
 		camss-vfe.o \
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
similarity index 100%
rename from drivers/media/platform/qcom/camss/camss-vfe-170.c
rename to drivers/media/platform/qcom/camss/camss-vfe-17x.c

-- 
2.42.0


