Return-Path: <linux-kernel+bounces-99434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978F87883F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2313B2345A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631355732B;
	Mon, 11 Mar 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFGkXz33"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764D3C6A6;
	Mon, 11 Mar 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182731; cv=none; b=qBqllfNOT19nx3BgpIZJGWTNY6lkCyRO6iCysdimuVN/pECNl9pIv4/UBXAAKBHAXt5K3u8r7ow2/8GwuUgN3aGZFz1WAasccO+a2jd+V94ZxClnqDo7sxhoyFspiOXO4poFqiYgjvx/2dkx8eZUrD673V4QeeB9me1RVeh6HDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182731; c=relaxed/simple;
	bh=qXlbhvjc7gvgg2eHgkj+ypNfZbJZupOIRygjv8P1Xm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ap40FeqwhQMAHeDmIYF5i7tD9DYIvh2xVXnRPBrGijH8ts7uA4UaMJ+7i4t+C7P6WWw+hDL4N2VnzIdMz6j3B/GkDZh0mbvC5KUmm11OqgmT7OhjO7gs+eGCNLv2DL+55AgXWFN2t8Snvu2n0QEymvPYCGTLnk9YpXaSY+NnHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFGkXz33; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e82c720f8so3549646f8f.3;
        Mon, 11 Mar 2024 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182728; x=1710787528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PseLU3EgM+ls5BiEnnXK9PX3aABYOZpy+sktZvbfHpE=;
        b=QFGkXz33k3bwMECHB/xvpZCwQVtadoCXqyFs/tmlZi6cjWu6HJkoRnt+Xi29eQ++iS
         XDPtnBkg77yvbCCcM3ET3yaXAIn4h+eLAGk3GIHu8Mzv0blIEmt0C0aXJePxaTNO2M5E
         Wu30BQSKCkWvDXSMFXUmGYXs83mFEF/AQlpPbMiZyviQPM+VVih/1auyre88Z9Q8ggBN
         qNzE1QXFkuQ200uRbhG343DmzIL6cfx32Lh4mqvvqByLLJyyVdpMku8x2K7hW7konNdj
         TEhVQgo4aQGAkdPHpRWx05qZXnxl8tQ2XS160P8LmZMheJEpyGBS0BlwIyfNyArSmfps
         cZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182728; x=1710787528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PseLU3EgM+ls5BiEnnXK9PX3aABYOZpy+sktZvbfHpE=;
        b=pMaMH42naZP737hizAL7NqLHWFtK2ICUinn/G08wixbRy68nbWzCtMqT1UxJIxObEd
         PyH4UAcG7HAGOr/aIIwKMVRzv88SPOsHz0ocGjaJz3jHwvSjKixkp0dbL956qXMVljV7
         q2qVLMJjo6qPwVdG5hdKyac4Cr5IedOk1/5io8KRQQp9wUtz0PH8VbkSXyT7dYFlbneL
         NEoQxVt1iHlOdq3+Cs0KqujCwa2URQHYPVTeECt/Ve375E8REOoFIFdMmyrtMiH6H+m5
         hDUYWGL/SPMdjpej+CE86Sq2uNINR765tvcA7ywsvDc8XCYhyjp9WtFpBS2OwGYwZZnH
         k85Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfV7mwuHIQETbxvozbOsgt3XCTlb0Umd6CkUdJInNUbKAssl+6lJbD29FY1Wk7fwKd+p1ICRFvUMUQTY7uTgUqh6iizotSbVQ53YnRnfvVYj9KO2NhFW4+uV8YVDPGbBAulKAxKsyX
X-Gm-Message-State: AOJu0YzvEF1l2kx6lv6M0NzaQy6ZsX/asVVuwZ/LVteWI8hZyrCCYdN4
	wft/OlcBK0Z2SsFkzFfXloa9XOVnDiSYW/+KYM5ksEIRRpbm4dIs
X-Google-Smtp-Source: AGHT+IFPxC7107Q8bCZG5/uyqYypiGUbreG5pzm1tajs9Cq29E3KHmuATMsI+JPAr/cP8sHLfJJU8w==
X-Received: by 2002:a5d:4006:0:b0:33e:75e4:d40e with SMTP id n6-20020a5d4006000000b0033e75e4d40emr4483792wrp.12.1710182728241;
        Mon, 11 Mar 2024 11:45:28 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id a11-20020adff7cb000000b0033b48190e5esm7012080wrq.67.2024.03.11.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:27 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 11 Mar 2024 19:45:19 +0100
Subject: [PATCH 1/2] clk: qcom: clk-alpha-pll: remove invalid Stromer
 register offset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-alpha-pll-stromer-cleanup-v1-1-f7c0c5607cca@gmail.com>
References: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
In-Reply-To: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The offset of the CONFIG_CTL_U register defined for the Stromer
PLL is wrong. It is not aligned on a 4 bytes boundary which might
causes errors in regmap operations.

Maybe the intention behind of using the 0xff value was to indicate
that the register is not implemented in the PLL, but this is not
verified anywhere in the code. Moreover, this value is not used
even in other register offset arrays despite that those PLLs also
have unimplemented registers.

Additionally, on the Stromer PLLs the current code only touches
the CONFIG_CTL_U register if the result of pll_has_64bit_config()
is true which condition is not affected by the change.

Due to the reasons above, simply remove the CONFIG_CTL_U entry
from the Stromer specific array.

Fixes: e47a4f55f240 ("clk: qcom: clk-alpha-pll: Add support for Stromer PLLs")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 05898d2a8b22c..58ae732959803 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -212,7 +212,6 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_USER_CTL] = 0x18,
 		[PLL_OFF_USER_CTL_U] = 0x1c,
 		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_CONFIG_CTL_U] = 0xff,
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 		[PLL_OFF_STATUS] = 0x28,

-- 
2.44.0


