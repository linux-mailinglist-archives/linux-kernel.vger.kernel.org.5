Return-Path: <linux-kernel+bounces-32100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF0835674
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD65A28157C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F437710;
	Sun, 21 Jan 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="LzhU+z6h"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E02381C1;
	Sun, 21 Jan 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851681; cv=pass; b=qUl9TrDYx4EOtJisdOX9FpEZ9B5VDiq+34xNZ2m++3uSfBtLMe2xZUQwKmxDa6V4irX/dnn+G7B5WPFbp98mrBhl9tRmUMt41LhQ7MWHf6Y3PTqtO+pMC2wXzQjjiWmcaXJs5cVb3cicc30+2As8m/HVFa20qMBx6M5VOSlJ+fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851681; c=relaxed/simple;
	bh=sVvxCHlSK/+sfe9ob5O+VzxcoO0+Nlcp8+Z1Z8K2LVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrIYbliuG7qiEGh0ZEBOT0fJQX3PrbblGPVgH8HjLG4gsmNdXoYj62DjTIhi/HVl84ZRY6gj91BwCugh1jhpJGzCj2EojCjsbtFAaq1cxGHBplsC/HI2kQ4V8BMfMx0lZGCzquN/0cqUT+Jg/KAR2dPeHoXm5Opjsuud8HE3lMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=LzhU+z6h; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705851675; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lKrnC5iz4EjAUlM1dG3yvv2jsrRh5fafKoN6K4ecgRjhwpT97gmhZmNuOP9cqGNGEJtv0G89idRnCXqWmU38St4+2taGqt2tZd5T4/Q3EBn7qbHOYS/VJSzdx1JZi6VciSX99lb86xhI5X+xejdXrmR8ZKgvpL+zSicez7qSkBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705851675; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jusAEr/6CP3YgIm/JYi1U4Od66lMyl2Vie0zS9sHYaQ=; 
	b=HpS3aMZQlClyi61Ql53IQLKLFAhhlcATY4A9o1rR+tNmkimEpK6aNYPEpDoioJZ3I4Yq7/Oa8+eUQxrc8MEhQubYL5a/wgahIgWbvaNl64QNJzPD+IdsvrYemrLAhYJlBTZzW3D+Sge4KZyWZFz3QphwfY3djglKPEiCoUgjvKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705851675;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jusAEr/6CP3YgIm/JYi1U4Od66lMyl2Vie0zS9sHYaQ=;
	b=LzhU+z6hUtMtIdC8scxrbPMsLdOVlyBrAy7UlA8Qh04yb5f1aBgLn3i3QC1MlVWe
	lY2QP3caz8JRmrb/SkkEAGYTFqKNNMDUdah38zxAfgKvJj/YPXzhn8yQgkOlDyZiEXm
	yqg6IuJzLv8kDXon7uUDDEojOANmx5sst6q8QMpo=
Received: from tb.lan (182.118.232.129 [182.118.232.129]) by mx.zohomail.com
	with SMTPS id 170585167418551.57866219546406; Sun, 21 Jan 2024 07:41:14 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 3/4] dt-bindings: arm: qcom: add Samsung Galaxy S5 China (kltechn)
Date: Sun, 21 Jan 2024 23:39:58 +0800
Message-ID: <20240121154010.168440-4-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121154010.168440-1-i@rong.moe>
References: <20240121154010.168440-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Document Samsung Galaxy S5 China (kltechn) based on msm8974pro.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..2bd29a2399ad 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -223,6 +223,7 @@ properties:
               - fairphone,fp2
               - oneplus,bacon
               - samsung,klte
+              - samsung,kltechn
               - sony,xperia-castor
           - const: qcom,msm8974pro
           - const: qcom,msm8974
-- 
2.43.0


