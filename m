Return-Path: <linux-kernel+bounces-118941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A588C1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB421C2A1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A7175A;
	Tue, 26 Mar 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuStPuwi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9AE6F09C;
	Tue, 26 Mar 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455043; cv=none; b=SD6L4otj/goUNtJZOYHvQSQxD0x0+CIhuVPYZXvGS7pdzJhXSLS/lmQV8D+TUv9q05Ka4aipUnGK0DZF7lQBMC3xkQ9LqJMDIJU17lW8FQLXMdWqY3s+MzdIWbLpyK8BDiSmGwEdrTg/F+gigZsWz8CzurPgE+6J399hnkX0gvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455043; c=relaxed/simple;
	bh=nwPCm0qUSDLp5e7wKBD2bY0U4BMhrIhCB6VSF+O8VTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hz0JLVmsNvAhsy4yRFjnnGkBv3Te79BdhSkTT1CSmTBCCmW7aqCmve9ABrchjWqkf951QQBVCcNcLOY3cdBqROs55nZNVHQ6q0FjUmWnS2rCRG29Ks82KC+I2Nfu3xLIq43ZipiJb4a1uKBx38ss4wBxL7A+Tza1UXwVI5kE2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuStPuwi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512e39226efso3854914e87.0;
        Tue, 26 Mar 2024 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711455040; x=1712059840; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wj9zqu4KqtByKrkCsmOVqlAEXw1tgTMlx6WI9IWeGMs=;
        b=UuStPuwiL2uMFwypHEMbq4ZovjBU5ksU/FPdYiKHL7F8QlsCRwbcsOYB0Tdwrfn8df
         0G0LqmxwPtSynzEyagv6d4tdTsA2YtFPzIGMlIx5VPEvbajnBAGXj8Epfk8cHsl0RqqG
         PS3eYKYwmpR1R2T+I0LZGXiA9YjzX1shYPaYUKcTJT0mWrGIzQwMSBQiwv+bK/D18sbk
         qTM0zOvdBrctSh0HqMNOblTvwyFwhv1clnQymrVokQVcn1OPs2IFQ+JCn0CFomRjNRI8
         IEPGjyxsr4URwC1sDKtiEk4qfKNeI5YKpYjPkbTFXL2ifzuzZ4vz+VjMBx5qIbDg1Sbq
         hIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455040; x=1712059840;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj9zqu4KqtByKrkCsmOVqlAEXw1tgTMlx6WI9IWeGMs=;
        b=kpd5W0+pGWoH564fTSt+Yt2ZUpvPG3qXbhU26E5qe8X2596DtgYK95EbxcUz+wFot/
         ZS160LXt1OCxyVXckD7SOlxsGAKutkaOUIy7rqdzUlJWRRkY4BrEPD84dut4446ryYMr
         sAq77BcyPFFeSbYnwedOyVFz2QBxRrBK6hVvqNglnbNzDlWAFqn4ysHBbe2vyK0gG56t
         nYPQjksf90t2LRuef9wNZuZTij4JGaZvdcT3P1AENS2wkknN7tAmD19AZ1sb98K6VNXC
         qYKR94y7ClimnrxAiMDBkF2RdgELGkE2J8pr1vpjrC42u2vl+i/+TWq1jEucKl1KDzNj
         2TPg==
X-Forwarded-Encrypted: i=1; AJvYcCVk04NP4/PdUw8Y+OpChBBZylW9NDNPIb+l3yRcxFyQilvupSuHDzQzQuTIHujt5RJ3zVbu25XJDKUxtwwr22Gh+zFzs9liBAobqciPpHEBy4YDX4KpppuD34skpcXnMPFI3e5PKgmLSgXEFLSndUxSXxnP8KZzoXm2CurisVOC9cHfh9mR
X-Gm-Message-State: AOJu0YwDB+DmyW7quqJsFjldu94mskTWRVT1uJYq5qqEGXpJh5Zb3rWv
	hvhhbLIBogFjcr55olqVHhhTPEMTW3A4DxteP92t979ypcSn+Q+M
X-Google-Smtp-Source: AGHT+IEqp2FBx6KNEcGF8PYZrt2yiFFeJzXd2DNuncZjxKokYgr1OSN8xMlxufbd5lMAzaLBL0opVQ==
X-Received: by 2002:a05:6512:3da3:b0:515:bb56:51aa with SMTP id k35-20020a0565123da300b00515bb5651aamr500824lfv.15.1711455039791;
        Tue, 26 Mar 2024 05:10:39 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id u21-20020aa7db95000000b005689a4b250fsm4054356edt.48.2024.03.26.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:10:39 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:10:37 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)
Message-ID: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1711454680.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the Motorola Moto G (2013), which is a smartphone based
on the Qualcomm MSM8226 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - collect Krzysztof's A-b

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..d2910982ae86 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
               - microsoft,dempsey
               - microsoft,makepeace
               - microsoft,moneypenny
+              - motorola,falcon
               - samsung,s3ve3g
           - const: qcom,msm8226
 
-- 
2.34.1


