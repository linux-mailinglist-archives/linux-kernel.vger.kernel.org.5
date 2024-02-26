Return-Path: <linux-kernel+bounces-81082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409C3866FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAEF2886D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62738605D9;
	Mon, 26 Feb 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihutsKax"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51351605BF;
	Mon, 26 Feb 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940618; cv=none; b=evLA/jgf05MjEhAKtzEf3k4FKv4qWacZvqZFL2meMO6lw6tpdmXmytTXjOFC/yaqQp1S+ru+FP/ZuSZYXDw/HmN6ED2m0Iqb4gprSPT4O0FlOQVzZFfi1rK1smIlQl7W2p7krvTSnt3EUrRFO9buy7LfE6tHDIIXGBCJhsiiX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940618; c=relaxed/simple;
	bh=Pve/bSIlmcARf4qUjbNWYScv11fgtbnnRqedP2X1KB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBk7R6ZKtUkMtuUmrIabEmzITYG82YQcHYte9Z/NFIo5daoqsJAg9fG9m78d+MOqIxGqnjVGcvkhU/76yYSsuBGQYtP9FOtyFYcMeXkRfYH0yE7A3zwcHzBm9D5S+vHem3QSmm0zSM36wLP8cXjJzX0bBsHCu8xCXRp8cncYM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihutsKax; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e480fe439aso1512361a34.0;
        Mon, 26 Feb 2024 01:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940616; x=1709545416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VNsylMFMmdhai5j9YeBwLJQVh2MvMY/FXe9gb0gujA=;
        b=ihutsKax5PX5JjG/qHabaTP14Datw4llWYd87Mh3ij/G+R7ygMO6nFYXrMK9TCQsj5
         u8xNGtHRYnggi1P9NHfr/sNujAhDXQ1sNxjeRBybWzq9DanzSk37H0/tUxSGc5fe5Ijj
         K2X63Qhducy29Yvm/ZPVsYtUfcWPBUPOfNWGJ20NXuAWrooVvC/DEF5xp3X7E1iy7mwb
         T4jzNkJHzI9KomGiwqgI1pCWUl67krH/QDJ76pYHH9jmydpNdxlwynaimKmnJ4nATZtl
         wgSQYvsHZFQg1D9Wm6igY1TWLc02GD0KhQfcJMvThoUhexqPssgwLoIkQ/ermhGo/+X3
         21YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940616; x=1709545416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VNsylMFMmdhai5j9YeBwLJQVh2MvMY/FXe9gb0gujA=;
        b=nv86EOay9nnruLjPvraaY6xrc4cbe7Yps5Qmaw4gu/Iud0x19MN4ZQDsvtNDFQs+A9
         6t6DEUq4QOLfVTClUCPOVEM/Ehw9hg/fxqb/+rF8PP/DDnBtTvhkeSbRd2IVkvvJZ+aX
         dBt9Ef8z9OHdShUdz1YPSYDKadFXQsdqYy8tT3+crWO0IbbpYKYZoCG0XzlKLSBFuwU4
         7kGIdjZnVhMRKYOsz1HcnUrosE36sfL3hO8j2rPp0tWXtSMhUBed+H/3fG9HptLvviru
         1DzNJqEROOsqva2YMGCCLmPJIpH0B7qCQ+u6fX/GUc9xpgy9J/RbLXpLzFElRvfsnzOt
         9sCA==
X-Forwarded-Encrypted: i=1; AJvYcCXinLduFbRgwavR20T8eADa03QY1nBFBtM8XADhSQOlYkBdscjUKN7aWzK47BUow/dWQ2OjaDuoKHcFDo0di90VV8c6FGK61RuGFRCfTmDmfvXkr/Hf2qMoRUKo/iEpiy6YJQErVZ/DSt4iSQsYO9KcYzX1HchSzNOrUNwWAl7Q+NQoodXwwSRuYpTXepuARc5E7GkICxoCvY9xEGhhPBFL9nO7tzmKkE8=
X-Gm-Message-State: AOJu0Yy8hqtq1pduCD4GTCk4BR5txyHzYdtoEXI7WTOgUCSE+xExV2kx
	05c447XmV+0CBniGZCWGgTRhOjby4U6p1Vi/FaXJnzFfpWzQjqy5
X-Google-Smtp-Source: AGHT+IEvtdQh+nOu/op95T7vu5tX8kKvdS9zJYMUhfDmlzVn9o/gBPLbQATjpRQLy/M0LsqNXjwpaw==
X-Received: by 2002:a05:6359:4127:b0:17b:55f0:3bba with SMTP id kh39-20020a056359412700b0017b55f03bbamr8962252rwc.5.1708940616142;
        Mon, 26 Feb 2024 01:43:36 -0800 (PST)
Received: from localhost.localdomain ([115.187.42.119])
        by smtp.gmail.com with ESMTPSA id y13-20020a62ce0d000000b006e4f1bdff29sm3799164pfg.1.2024.02.26.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:43:35 -0800 (PST)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: krzysztof.kozlowski+dt@linaro.org
Cc: raihan1999ahamed@gmail.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Lenovo P2
Date: Mon, 26 Feb 2024 15:11:03 +0530
Message-ID: <20240226094256.5736-1-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <a762f756-1a92-4d82-be38-098bacaf25dc@linaro.org>
References: <a762f756-1a92-4d82-be38-098bacaf25dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the MSM8953-based Lenovo P2

smartphone released in 2016

Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..6cc19c8d116d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -263,6 +263,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,kuntao
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido
-- 
2.43.2


