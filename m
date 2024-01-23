Return-Path: <linux-kernel+bounces-35380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFE838FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35383B27343
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBAF604AC;
	Tue, 23 Jan 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj2IQQTB"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641E5FB8B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016084; cv=none; b=JcyK5k8T+SSeu1Id2IlfB+uvT5ANEyc1aHH3unfLPJ6tHp4AsAjaNPKRS1rIIfnkCGAJ/+J4+h6uDDQnqQFe8oI30TgXjPRIL1XXfMkjvbXgiipT0WbUYpYxGB5qwyQi524W1EeiO6a1JLYIhWVO9DU8gUkH81R5GQKiXPVIUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016084; c=relaxed/simple;
	bh=MpVLG/UwodDdLmGV0SZN0/WbrDrYke7nzmLvuxJBZzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKKtLPSQtPyfpuP8p+jbLUoJK/jy+7UMdFgy3aqF0rukVUy5aHLGaYVvxnVr4n3rf6+5c7DyhDRD+p66vHS5IUFtLVXBxsHiNu+0Lj4sF4gZH8my5QEE54TQWjVGKHsLhaVgQmR/d0vjBJSYtPShas3WXenMOJsxCRYMmwM3Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mj2IQQTB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so42394905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706016081; x=1706620881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO3A3wF59S5J5YdoyqZ6H7kiWHm6DG64im4Af+tC8FM=;
        b=Mj2IQQTBJ9Osigk14jnSGsNiajm32YQ4R4m/yYKv4VprF7V9z9/0OV0X/WdA1xc45R
         7ldx1LdW5/NAp+NVhv4MPqWAz864DJh2IzVrOFW25n6B86W8jtaACRjITNxt8WpUVGvu
         K5ermjvbu007BtaYszfPWSIyIjvsJaiVs3tcuSeusZE0Glt2Iinouwn74CnPUbc2nES9
         BVJYcIq/FoUdFnvEMbwHIr4DK3xIP8pY/I0Fut7cSWMV2lOp0IKqp+unHamFbZn8wiPY
         hhqQ2szobJjILh586wgnyGGRvxAy6GwZEAXj9I0Y01O2HDNQZim9xnMbKR1slKtcOxHO
         TXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016081; x=1706620881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO3A3wF59S5J5YdoyqZ6H7kiWHm6DG64im4Af+tC8FM=;
        b=Gz+irLJcg4bkIGTCE+/rwZz9DSAL3/uxkVi2rYypK6W4263O7BNtofeONyWZhFDuXc
         hHo2Hsdc/Q92W6f/5Wo/2LrShPS+cC64IGTykzp2JONqElwZHVKrrKEv0G0L8SLL0XYa
         WfK0dCy1OB9LAwRrm1aZzMYUXDPGrAzYut1S8k6x1eW6dtz6q1Zi5TrTNoYwoRRltY93
         Cy7w4SIY9rlpbA9tQS/NXbYtwRF+7meJqU1zsqwNPVlDWlP/DSbVk8IAtroi2bND4PuT
         hXEckw3HyIScWnebLK3N1+MJ6VDe/yYdi5dEEyB5GQk+QCNvQCjuvW/P6ZNZkrQ7egzd
         RY3g==
X-Gm-Message-State: AOJu0YwvjJWeadED1LTIphD7e+Y5Rh8QPSO2BbgWBfl4dX6lCnyBpA6g
	DTIN24rvQ8BGOE3JxdWSy5K6rHWmHmZwEnL7kXY527/SpoXYXN57kGvFPXmAtDw=
X-Google-Smtp-Source: AGHT+IE1bvYl3RyRK6to8EcXBQTa0QhdvJ+5CcJXeETbCTgQwdMPCwNiBvPkrtALvvU1boq8TRjmLA==
X-Received: by 2002:a05:600c:4694:b0:40e:736f:4d4c with SMTP id p20-20020a05600c469400b0040e736f4d4cmr636880wmo.34.1706016080900;
        Tue, 23 Jan 2024 05:21:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id hn33-20020a05600ca3a100b0040e621feca9sm39982445wmb.17.2024.01.23.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:21:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jan 2024 14:21:16 +0100
Subject: [PATCH v3 2/2] arm64: defconfig: enable WCD939x USBSS driver as
 module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-topic-sm8650-upstream-altmode-v3-2-300a5ac80e1e@linaro.org>
References: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
In-Reply-To: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=686;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MpVLG/UwodDdLmGV0SZN0/WbrDrYke7nzmLvuxJBZzg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr71NbV4VBhFeFzKwpKWChVyPCUPG3WJo7SjUjgy4
 sRbkFzOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa+9TQAKCRB33NvayMhJ0YDEEA
 CMBLna5nPJSn/Hd/1/HDQu6/DvWJYTXtO4ZZi3KlJfDQ3VyPnmo65syklQu7GRBkgjzf+X6VIG/xIb
 0OsfPJatKyrEadHXY4q6xjSpquIVpjBeY5XRdJmJGHefJTexO2d1kzT2w42xqc7Xon1SXEPM7rgpOW
 IimkDRrxkUV3Mss0yHwzHNut2WTucGfL+eRMGEEk/7Hf/M6NRUfg2CtzfEmpCZpwplC2V78642GX5Y
 70T4dvUmW4gwS22Vdq4XNORAbnG7PcCU7CRyzL5al0T50+Hj8dfLu5WOeGJvkVsaZl7coe4KeqooZ9
 /x1USq/HrAXn18m1bsJX6iT9VN3NV7qReX15aMMYS9j73OfSOqYW15yQU2KyrNd6VLmvq6sj9271Vn
 UFX8STLEN9V+eLtoqzXeSKXchWSlb+mPdlQtvciTO6ANSgXFgleWSCz53UJnQ2FlPT0i5hBiQZ3A4S
 rzAZbTfgvvsO4jDhYJJbzrEESYCIRr+GrQeyEOSd104YCes0pmdQM3uhcrXYTBtTAVljGcam9VIPM8
 I/4lzdppNnfPa1Tw6+iziSx1/pSMQA/iOVRWHCB+xqEUK0F+hW9H3kB1qX5B/oRxtyCUuOptTcMMR8
 aI52WWHikVM+Gabphj4rTb8PiURoFXBSaKubPw3wFiMYssfyqR+assQTHN7w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the Qualcomm WCD939x USBSS Type-C mux as module as
is now used on the SM8650 QRD platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..5c8777fb5a29 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1079,6 +1079,7 @@ CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_MUX_FSA4480=m
 CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_TYPEC_MUX_NB7VPQ904M=m
+CONFIG_TYPEC_MUX_WCD939X_USBSS=m
 CONFIG_TYPEC_DP_ALTMODE=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32

-- 
2.34.1


