Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0467B79D260
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjILNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjILNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF01FEB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52c9be5e6f0so6806183a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525531; x=1695130331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxtccacpBwGixpSIy230e0q5PgRxGFascOoiViGLP3k=;
        b=qAJM56IwJ4yiKwdjx6+cf4c3RGogvlLXWHdXGE1PgUUovkc0nCuV4I4aw0eWOzzjtO
         L5/DKUrsX7YsIr4vbwipNwsuMrSDZUHttczUieo/gRfVmfPMv4ZM2UE/FMDQZ1ysQmI0
         me8oQRZGukNzU4F7eDILek9Y0cdqS8IP/f9DGeS3iWPZxJNLd2GIhHh5FqJwgKESJX5j
         XIN4/KIgMZhSwq5avsrhSKnEYnW9X78oCKCpw5z61EhRxYsZ6nXJJVf0RZkumYvEIAld
         fvmNYWHiJyNVND+EXM9rujXY8dhtLUDzxD6I1zVksO+a3iYswoKeuK2a4S+83W91ddll
         q0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525531; x=1695130331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxtccacpBwGixpSIy230e0q5PgRxGFascOoiViGLP3k=;
        b=TmUTzm6nv7w2dZqZFc6S+Yyg6i/HQu2N9+OQURw+0Tw0lkpqgmtwUfzqIvSmI+i2Gn
         W8UmrPmHwwUaRupA1Kzv3TdIe2vy2DUOXXgBHuy9VOrdwUHozoL++rmGODm5nhDZeTNq
         XtbHy6/tWLf2iULhwhzHf1j8wNuANEQYqVimNpb/kBVJPMwoH9u5MkWnmK//G1unF4N0
         s6PFJr6sb66ru87YBbGrUy2bpzJd/Y7x/HTNH8jydzSDglMGgFcHUYnPYByk3bkcQ/UV
         3RrVCiUwH4Pee14ulk4OtcS3Ne84RY3KxenR5mPieLyUwYMn0iUXaVs/4jqJidW5it4Q
         q6Vw==
X-Gm-Message-State: AOJu0YwuvkH9ed+MH4+tpnA8d9IR/syTacNdWAyq0b7LuVNthSvZcAzR
        pllpDGDoxJJfvtwRA6uS2NPnPw==
X-Google-Smtp-Source: AGHT+IGDdLlH6QMNo0LesrvW7tqQ3UhLo5jMkBHR5ISm+pmrwc0Td7mwqYE6zY6eveDY64WIEHBQDg==
X-Received: by 2002:aa7:d508:0:b0:51e:ed6:df38 with SMTP id y8-20020aa7d508000000b0051e0ed6df38mr10476262edq.13.1694525531150;
        Tue, 12 Sep 2023 06:32:11 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:49 +0200
Subject: [PATCH v2 11/14] arm64: dts: qcom: msm8998: Remove AGGRE2 clock
 from SLPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-11-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=889;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APDJWKGv0OM8xkXbz6kn7MnEY9F1MTCZxMvBScddrP8=;
 b=fm7ExDvbRT0Sd/IS/guUrW0VKUsM5an7PF7RCJbaYOVZf0humdCmaqSivS8PZcBVQ8jHJJVQP
 gaA9Ee5eVxDCUutCLYzu7eMoDF6RCNm3MutO/ynMxiuRHlPqxZGgrxS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f180047cacb0..5667ffa83ce5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1618,9 +1618,8 @@ remoteproc_slpi: remoteproc@5800000 {
 
 			px-supply = <&vreg_lvs2a_1p8>;
 
-			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "xo", "aggre2";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
 
 			memory-region = <&slpi_mem>;
 

-- 
2.42.0

