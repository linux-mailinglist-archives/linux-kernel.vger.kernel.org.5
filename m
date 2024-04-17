Return-Path: <linux-kernel+bounces-148064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60AF8A7D31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38D21C2142A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF07641E;
	Wed, 17 Apr 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="wIrzrm4m"
Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20446CDA1;
	Wed, 17 Apr 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339349; cv=none; b=ncJ3hakYj9iRu4sARzKBJNCkpYqHHrWO4gWUEHNwc8r9g9EihE3vc3j19XG1Ogkq4whrLxZtvPLGoP+0ZEl2xbAJHU/wE0ErdHfY02sB6OwTU28q7Q5c6P2pjWA9dR1i9USOaPYV6ua7xgYsK82qlw1wgmt5/6ihF7J9eQPb6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339349; c=relaxed/simple;
	bh=SHKa031b3gssZAFMARLpJsBsZfy5fESYEginTqV3/ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUbzvntNZfs42zgLJPCbeL2usVifZqgd57dd4H6S0J+EnK9AULfOgYc+ChShJaJJvYDEpjSln/Be9h3ymEkt+Sl3g23eQzeL37ajN2zOJV14aKhalxfy4pFq3nq+LvMKJPQaRKmK3zExmuH43zOWQxjJmpi7VKNbqvbLyfw5rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=wIrzrm4m; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4VKCPM4hLSzkQNK4;
	Wed, 17 Apr 2024 09:35:35 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4VKCPL5WpFznTp8;
	Wed, 17 Apr 2024 09:35:34 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: github.com@herrie.org
Cc: andersson@kernel.org,
	benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzk+dt@kernel.org,
	linus.walleij@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom,pmic-mpp: add support for PM8901
Date: Wed, 17 Apr 2024 09:35:32 +0200
Message-Id: <20240417073532.3718510-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415141743.1983350-1-github.com@herrie.org>
References: <20240415141743.1983350-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713339335; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=j8qU9SmIWp5C34F+ofmR8Pu30Ccwt3X51g+H9Nuh7A4=;
 b=wIrzrm4mNADi9YB2TD+qH1W7ziWbHLnOqlQR9vF0PP3MAzyI2dNn0TbUv5vxEJy9+5rDj2
 3hoVuPchMzGc05T3ICXZd2ukwu7dL3GIbRVEELaa1+fjBQ40XU/+EAamoA7xwzTrSNJqdo
 /kTtIHjF3KfU2VxG+3u3Vd4W9sIrxYqcwokVHRLDg9ldzkDF9V8/O/UT993jNxI+wBXwyd
 GKDqvGMvDd4ZKFt/H33zA+NKyOzSfiuChkQkr7QkNhsxXObaHKsOC5K0hnoS2cPuv71Fw1
 YgogaVYuG0d0cn5rQf2iCRAuov1aBeT1HhLISY5gy3CvtSlFkuPWuudOv7eirg==
X-Report-Abuse-To: abuse@transip.nl

The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboard
and HP TouchPad. It works the same as all others, so just add the
compatible string for this variant.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index fe717d8d4798..43146709e204 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,pm8038-mpp
               - qcom,pm8058-mpp
               - qcom,pm8821-mpp
+              - qcom,pm8901-mpp
               - qcom,pm8917-mpp
               - qcom,pm8921-mpp
           - const: qcom,ssbi-mpp

