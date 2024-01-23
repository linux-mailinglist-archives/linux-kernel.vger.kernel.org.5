Return-Path: <linux-kernel+bounces-35141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C2838CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95828C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A65D913;
	Tue, 23 Jan 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYVlCkWN"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEF5D73C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007719; cv=none; b=sy1snnIxLDUj99ajAbUgjZMY1gKj2niT29dsMnQwv/UmudtjDEXr/Flx5QeauXuxLXCRubgvrnlzr/8VfV3DHHVebu2UTd6oeDhUUEmoaZS/0JthbXSsnmhfb/QADFEFB2ZTv29ifalA2lXpxgggeVPZdEvFpgGIAUSZ8p3HTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007719; c=relaxed/simple;
	bh=tx4kyU5130JQklcMT0u/f9UNERWWdQSXmZjEXww6BvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rALChQEO+wi3q1XG/5AV5YXFemheR+7WTz901aNkMKbabgEc42qRZe0O0igPKvFCoDRYqxc5McUzrqjlEXex1CVee45AMOHBphJjQMwm5YeRtsccBHYnvx0GsAAqxPAIcvB6TIGgZzPF/TAEorJI+eNLVve1NoYbBiYEluJah5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zYVlCkWN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so3230633a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007716; x=1706612516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoXONBUAbVlHo3DHcqRibgt90d5J3XAE3xf2yCRQRgw=;
        b=zYVlCkWNPYawKN7IoI8VgT1rzKhfOD09jmmhyQPDv9r4rWoVekQzWG8Uepqahf6Oq/
         DPPgLUw9y47nsjlAADIehrI/gvWjpbD/lOWYKbv57wKm6FzSJUVbnMDZLmOKWhBdU2uD
         dxyOxFMdEH9jDbAErkbG4KQMwkKk7mUzCRAkZJglxK9mwPUqfmGGWCiY3la9fU2HWdSP
         V084E8OMBnEhi3NZcELS3yqdYA1M6MqCRCEd6FQMrLnEXJMBNock2x6ktjTvL3ZC5ODt
         ck6PVq0ww7h3QFviQmSaa8h+gPT30RjxlC6Mg4GOdQFFqr2Hoq8Nk8ER/4H+tzNKQDCI
         e2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007716; x=1706612516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoXONBUAbVlHo3DHcqRibgt90d5J3XAE3xf2yCRQRgw=;
        b=BIbGsz98uQu/ukWzooHCRLzvkTJsjCfP8btoN5VVaEO+bsqkeDEHBrmyXXA+eqelv7
         qX7SFi4irpPQMuMSyd/9NkEwvyf9uwJAvV5+Fq8CIx/4uIaoF1KFORNjyTiyHU630f8I
         Lrr4mDC7Q+T85DszSOVBC1LUT8d2uU1Ot14tsAjoOIYDu8aYdSNkqAu2iRILUNcKiquQ
         1S6MDX5F5fmcUlV+2AwewV/j+EqdBYmtNF7Aar2nFWsrV56xXO0nVTiwBNPEaHMkS+BP
         /EAO7NnzSzg/GIF6h9Wucg/NpPMwp9BQnwkFhvVuoqe0i68V1FTh1uD5T/0hsqDJX4EU
         n/Rg==
X-Gm-Message-State: AOJu0YxkI/MTpJ2X3bpRLB8lrmVzq0gt3S8xcBV+gdtd/xYRvT/kYlIG
	K0yhVsCPImDLCef5GZjlYtqjqgqsZzShSKEbsfXjojqv1YEf/tyhVyQBAd7jF9s=
X-Google-Smtp-Source: AGHT+IEfNsk9L0g4s8vJfsvbAiDMdVUeTODmP1Xq5n/ArwSkMIfm+DJiXWeNiKAXlwf6dlyMlVT4LA==
X-Received: by 2002:aa7:d957:0:b0:55a:2f50:53f3 with SMTP id l23-20020aa7d957000000b0055a2f5053f3mr856010eds.38.1706007716196;
        Tue, 23 Jan 2024 03:01:56 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:01:55 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 23 Jan 2024 13:01:17 +0200
Subject: [PATCH v4 03/11] arm64: dts: qcom: x1e80100: Add QMP AOSS node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-3-072dc2f5c153@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=uhruz9tzEahNH2F+362SSx/RVU2PIo0lL6mu3SYOWPA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5yToeDIe65tkiekRwtNNDg9NvyXARy78Tt9B
 MX4UJ45ziiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+ckwAKCRAbX0TJAJUV
 VtDSD/44xZDfbuKEB4OsZ1TuVrZQKx4E9T5MuSJ5hti61vAcN3uScdvhdvtIylm6N+wigqirf7I
 c8IKg3O27M1khiTz1DRxv2aanSJb8NNM5h6nBlJEzO4ibo9fP7fPw1umaj5hrv6/BlZuN3b4k51
 70V/IjWS7J5Uu0Uk18uL2lfHP2RVB2aNmJeUu9mygtQ/qzMAoNGo4AVGOk6jVuV41PJd/ymzD/o
 lL5gMEu1jxnxFbaDx4QFiVnjMrnjUm0TAT972/n8eKrEOkqmV2gW+7xHDwZy8rO0e59f7nOZXDz
 8z5kbuhqltQcEndxO6RF33QPLNhi4axH0pNER8jG4Ngkout0U2pIEvkvRx1VZNUqi2KNkXXNKrp
 td+tOzjZDEGS0CTa96IcNeQEojaxN2Ke64/lbHAas8qG09g0jxTS/lEZ5YG0OKogyOhRKaYob8I
 NQfKH/FwKCCLJBmL4z/IsU9MfR9jFRxsxohEfzgJUgmq93jCokE1YNf0WQirqfIn9JjPDQqLaNS
 nj6gF5k11tf8Do0YQBIbceK+VO0u6ju9uuVex/aWgVK9swh8XHj2bxXZA7ARVV2PumKEpa26L0R
 bohvWRJTMNZmps4KZTVtufjmdx3nP+BiUt40BN008MxQCZs3VZJ67mDsKnxOVB0s22Syfjz+LeJ
 0Oemeqfm9m6YJgQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

Add a node for the QMP AOSS.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 1210351b6538..3790d99eb298 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2663,6 +2663,18 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,x1e80100-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c300000 0 0x400>;
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,x1e80100-tlmm";
 			reg = <0 0x0f100000 0 0xf00000>;

-- 
2.34.1


