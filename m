Return-Path: <linux-kernel+bounces-89272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E586EDA3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E381F230F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A038C0B;
	Sat,  2 Mar 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fu/l1l89"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A75660
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340744; cv=none; b=duK0bI54aQyTAI9ds3EeeffAG4LCCeSG54KCErKuZYoT1WLeXlEkaHCtI44l+Z1y3JeGpo74CCkuUa3kSnLW8QY7cCoQrpzQnQckqKztTyarHqt0a69EJUCcIrbZi+Bdofnr49ytPTqXcAyRp5dzj1IjDHrNz9fjDHHhA+3C3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340744; c=relaxed/simple;
	bh=5KcsPf2NXDTosjt6TxYIEZuVyoCBWIEzwcJCEsZMh14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UroRhq/Yg2xpZ81++gYBz/MY96UbOaK/oWTE6XDSnlVOgveXTYjYg8QHEZO/MnXogSUbb+8fZgB/4Lo52VcI3Ux/Zj/8JgIsk3G5Ti6rRcBzn76u2fvleXCGXaStk0lNICkw4MW1CapavZ9lHM3ZjlVGfnHcCQWfjgimqeuByDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fu/l1l89; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d568fbf62so1341905f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709340741; x=1709945541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epHJKobVDJjhahUPHFVdoDFlUlvBfNFMXFrew87gMLQ=;
        b=Fu/l1l89CnZlijJnxS0I4KyLWrlvc48EU0pgiB+X13fV3KBCnIiHe+68bx6qCFD7gx
         wUZj7GG7YO7pyTulu9Rh5ScpdcugSkvIRn8RriRs/2WkM0dVJcNVGJEZ6HeGPKvEabyW
         hQHuZCXIZMawyDQWuJ46GA7PkejCKCRZv22JdtyICgWtWWmMChSYsDfS4J2KybM8BZlw
         bvh6tHqbDZMyoHV2VLVyzLDqROGK3U2j9q/C41gJZCAV0lkVcMNKwduGK5wWaEWkV67C
         0QwDlhAx2hW0pCV6uwFOOw7SvSmCYLotEffu00K6cfRBsMOvgJUiPZMfz3GU9+sJjWF7
         X3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709340741; x=1709945541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epHJKobVDJjhahUPHFVdoDFlUlvBfNFMXFrew87gMLQ=;
        b=SeqsKQwVtmor2ybvTPmve4ozNfGpvL/C7VtHwTKjF9KajUnpAg9e45xNzrJFYVyeCP
         Zn8UfHJYlTDAr93+pJaqgTXsaQTMzY9BMftj7edIodq9699fupJWuPqFa+tvzNVSK/Yn
         l5aXQ24g7SOFOUrIbgEnZTwUqDEV8zhmSUbrV908xb1R9PitGGMkfBFiYLoCfmneMRED
         5FEcfnzwigZiZrBG6IGP4DrnFt6CR/zqnaMQlwXRuPxgeumVsEVOaNhmT++rGikG48RE
         9BOVqa28uYTyb1m28hK9cCjFZPGp/fiO79mtBBWR+i/pl8mfKaaQFYPKlqfOk8RTYp8H
         PkSg==
X-Forwarded-Encrypted: i=1; AJvYcCUp6MaO2+WtuQjkr8RddKxTRR5DgAsTeIcQl8SUmTVjuBxzeUr4DPWaXui8v8KzfyIINMu7IinXNCT2QLs28bRLJx2ktF2RJiHuTvqm
X-Gm-Message-State: AOJu0YyVCWzRV/xz8NvZ+RHd0RwIOdH3F+km7Z8x1X8KQYSLwSYufhjh
	JozEAupNj8mRkQ9OUBdpiun79JyuCF1LkiNGYg0HB0JGirqhBwRx/XI+VVTNi3g=
X-Google-Smtp-Source: AGHT+IEZB89IozKw4cjqKVIKyH5c1bwWK8g37ziiO6UL1ZXHdGBpR5lru1AtvgB13K9uvzoUE1Co6g==
X-Received: by 2002:adf:db50:0:b0:33d:afbc:6c85 with SMTP id f16-20020adfdb50000000b0033dafbc6c85mr2953106wrj.8.1709340741649;
        Fri, 01 Mar 2024 16:52:21 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id f15-20020adffccf000000b0033dedd63382sm5865501wrs.101.2024.03.01.16.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:52:20 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 02 Mar 2024 00:52:15 +0000
Subject: [PATCH 2/2] clk: qcom: camcc-x1e80100: Fix missing DT_IFACE enum
 in x1e80100 camcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-2-25f348a5982b@linaro.org>
References: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
In-Reply-To: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14-dev

The desired DT pattern for clock indexing is the following:

clocks = <&gcc GCC_CAMERA_AHB_CLK>,
         <&bi_tcxo_div2>,
         <&bi_tcxo_ao_div2>,
         <&sleep_clk>;

In order to facilitate that indexing structure we need to have DT_IFACE
enum defined.

Fixes: 76126a5129b5 ("clk: qcom: Add camcc clock driver for x1e80100")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/camcc-x1e80100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
index f7f3d92c263d..46bb225906bf 100644
--- a/drivers/clk/qcom/camcc-x1e80100.c
+++ b/drivers/clk/qcom/camcc-x1e80100.c
@@ -21,6 +21,7 @@
 #include "reset.h"
 
 enum {
+	DT_IFACE,
 	DT_BI_TCXO,
 	DT_BI_TCXO_AO,
 	DT_SLEEP_CLK,

-- 
2.43.0


