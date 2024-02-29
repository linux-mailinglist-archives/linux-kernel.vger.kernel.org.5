Return-Path: <linux-kernel+bounces-87235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44D86D17C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB81B213F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186577E564;
	Thu, 29 Feb 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp457hfZ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA757A12F;
	Thu, 29 Feb 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230108; cv=none; b=D3ogkgx/a8E23eFPMDiLSA+GQ46vjZETHAaPlqHG9ULPfX/Vk5XNsq2q1n97tEiEBNmh40kaNb4jXPFQXltXPz5bb4c4DIH4t5olJB64cPBjHZYl+soCEZdcWX6qWFS0lbABd4uhmfMX0apxcU6nVFfq0v9quos1JRNhJL8FMkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230108; c=relaxed/simple;
	bh=OPoEGaTaF/oEMgvPl1c1lMp/+Hytcqt2GkXEA6uM3NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9xiZNihdyu11eviE2Z4vKPisz5c9e02G2W7VF6H73GHc9+KMiNn7S3HvLGIHW3ojdilWGQgc3698ysRwPUr4htMdI3QlnT4I/HAToTrGnaEKqJEP9cY5mq5+eLkMXYlMJvGVn8ShFe8eIp0vRJk4djWVFqBZeRVRVUwn3Z/jKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp457hfZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so12632041fa.1;
        Thu, 29 Feb 2024 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230105; x=1709834905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/Xm60hjVFDoBBFKWZ90/O5g1Yww87R9nHLMoER0+64=;
        b=Tp457hfZeZ562LQzXFLd7dXoDw4VezZCGv7uJXQZhwsfCUzZRwUocrhIaoou/i5208
         Nld2EH73VsaLiJEg7FALvYLAVpk6KjQiLv7/WIHvGsilqp+/mV7VarC7LjLIh/ySvSeN
         28vXayVigAJqeVHd5UU5s/otKDcNkw/3gV64LQOrgMKElYDtJZ0ZNRZCtdPeNHh1PqbO
         D2HMTF+A3shHXko9jr76D9xNJdGew7D2dfoQNMT0JtZpjIIyxLLXa752CxFSwghTsi8G
         KGWXd98GmhBYkwBSOcrSeVyp1/NRw5wp+KyIKr78kOi9PCyGvXJrc8qQFfownL4/aD9H
         cx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230105; x=1709834905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/Xm60hjVFDoBBFKWZ90/O5g1Yww87R9nHLMoER0+64=;
        b=fKcjczpL3Lhlke0SEVlj6uAGB/w/nLzTIZnL9R8nFAFynZA8Yc5Ys5AhvdmTrU3nu9
         sAJE8rlww3pjBiWoY6ssaYel4N0cn5AT+dwZZ/S2rh0uRYfe4ZqLLXzZDMpI9aPquhx2
         6UkM4B8A9H6rAWrv8vTMm62RgO/wThMsO5cFl7qv1znMYyQuaCOJfKi7sTunS/YzkBYR
         J8ZHl2KYH8nGAor5cFdJIKDP53CkfMvaalHSxcuDc9CE3eqdIIfbhQ6phIPni1cBrSKz
         h8Zlmb4B1x3RJJVTAJIQVZxX5k1ImmIk+j6X9D1muJpk4qzWQDpun+4eS+82hEIomUWn
         A00g==
X-Forwarded-Encrypted: i=1; AJvYcCVOXvp5MQISgPrOM72wa1S2mLefoTPr9txznwz5poWE81AWORmzNiY5cyFxI72pU4+g9FPfddkquSFmfiMyL+7l5hOCakuYFDAbL1m0O3evSM8mLyA1zkFijGtVmLqOgKbzOvocQK40
X-Gm-Message-State: AOJu0Yw4brR4HVqCgge59MxxQlDSlU1etwxLck/tPrnacok64BvDw5ke
	wRzjYr9HkVTM+G5pAt5BtX9/3p9M3BR/42h3iDniamGzhW1oJMTV
X-Google-Smtp-Source: AGHT+IFXOk4FStuddUutRB0VHMsxas5rzJT3Lfn10l9nYhijtAtGE9Hc8v24D3UrCHWBoYx78T+X+Q==
X-Received: by 2002:a2e:850e:0:b0:2d3:1be:2565 with SMTP id j14-20020a2e850e000000b002d301be2565mr2075456lji.6.1709230104824;
        Thu, 29 Feb 2024 10:08:24 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:24 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:48 +0100
Subject: [PATCH 3/7] clk: qcom: gcc-ipq8074: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-3-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: 9607f6224b39 ("clk: qcom: ipq8074: add PCIE, USB and SDCC clocks")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index b7faf12a511a1..7bc679871f324 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -644,6 +644,7 @@ static struct clk_rcg2 pcie0_axi_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_sleep_clk[] = {
@@ -795,6 +796,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_gpll6_gpll0_div2[] = {

-- 
2.44.0


