Return-Path: <linux-kernel+bounces-111094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E286C8867D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825D6B22D26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333921CA94;
	Fri, 22 Mar 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jO1LHyxe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44F17597
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094513; cv=none; b=Mgv+V2QTOioYcEKZ36RxvjIRAP2lwDL0u2kjsNmJpDqdNczP4o014deDHBbUZEMZbfvciBX3ZYlWlxeH4pYB6BqXVaqfnNiGBhDtj16qaRFFNseLxTUajmlP6S6OHyEUGb3snM7923VWKBdkp1JO7acdLDuIqEB7vEdtfgppEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094513; c=relaxed/simple;
	bh=ZBM5V09fKIuDTzLzV/0cG79mmGRRchouq0MxxhGGVXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3P/GwWmNvRd+5aIIogvwBFzbAcXZNmK2Cp8mTVYyjmXpVUOAPasbzPB1/ejpRljqBDdBAzBX2+Xrzp28aiJ8nZ2920LCBZL3ko0vdiX9Ql069JyyIbfPvv6ykAf+C9Xkt+u5OP7n5RThf39WdZgLV8kcmpvTjHBrtPT92FWpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jO1LHyxe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so2312446a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711094510; x=1711699310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvLE1MVPgDc0vjg2RXtuyO+IXL0HADH5M9xYPYlMtPM=;
        b=jO1LHyxeBbLsB+xQF0yhB+lG9vvRSiDifTk1cfI8nyG8yEWCUYvKpoNB1arVg3NVZG
         OmGTdVmDjcLfhZ+ZWVeu9qUoRtB28ECWV+hTprvsmoZ1wHA7XGIrM+4Eh0EhnPj21Hbe
         sRu6WIi0Rt3Ep8RCSlK9STxPWjQnG1zqzfUMyBC2xStrmgeL7FdOA10yU1xz3Y2HBQEQ
         69Oui27BgfLR6/G7RzrqjmmBUsEp3YDa3zQfFw40MJGNMUytpmbBcOTOAczJJ1KtWzRm
         fMZ4baFGMgqr4fuQsAKmsceatepVuqLcvTURw7W4b/jiWOAOD9EARcK5SB2+KEF0MPEZ
         KUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094510; x=1711699310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvLE1MVPgDc0vjg2RXtuyO+IXL0HADH5M9xYPYlMtPM=;
        b=Hezb9+hXqeQX5yw7i9emqxzVysDNY97BP20JFz33hdg9nPVVLZtpbtbo1b8QpfAQIm
         LGp4SZlGIgJrWfU0ekq2LdOxCsSJ7wUIwSBpJKGdHef0con+iP8B8T2wTp7ZwHLJtpmb
         sZc/NcK0kHhQ1LVU+V+QIeAOEOcyxanK6berFDeOGFtqCbCkYvyyureV92IW/1NBiymv
         nNY6GM7jNK7jpMt+xMaS9GJLtQ/aAqbkRNqWSDJAuthDlhCS5DuvRYelh0o1jrqoXRhz
         O8+lsul64iQHpSqrjEglEqYGGltWfJ2D9Nkv+t4/eXbQLvQJU9P6Dkkr7mDjXBJ1kDv5
         Aotg==
X-Forwarded-Encrypted: i=1; AJvYcCUldkqtoJUc/l1dkjE7CV2j17Yc4sPVtJsyk0Y91xagsabvn57FT/H9HEJw6S3uuN6EG3Fk3nwUEJorhQ2RIHr8YzypDVhQELfEVlgg
X-Gm-Message-State: AOJu0YzzBmluqFc6Q0B8hNLV2mI+z12H9pomZa37RqLLm2j3hhfIgGqU
	ff6xhlW65iyuvmRq6lCJ4WjJybZ8S1bc2l63myoJAkmoICA1pxwimH+oEuTH5l4=
X-Google-Smtp-Source: AGHT+IGbA7Ib8iNtMMdw2HGCUucqhXUuLYARbm0CTeKU/FpNbScbeM2XX2q5s73AS0o+fhZUPA/Xag==
X-Received: by 2002:a50:8e5d:0:b0:566:1952:694c with SMTP id 29-20020a508e5d000000b005661952694cmr971634edx.20.1711094509844;
        Fri, 22 Mar 2024 01:01:49 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id p29-20020a056402501d00b00568c613570dsm739889eda.79.2024.03.22.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:01:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 22 Mar 2024 09:01:33 +0100
Subject: [PATCH 2/5] dt-bindings: usb: qcom,pmic-typec: Add support for the
 PM7250B PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-fp4-tcpm-v1-2-c5644099d57b@fairphone.com>
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
In-Reply-To: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

The PM6150 PMIC has the same Type-C register block as the PM8150B.
Define corresponding compatible string, having the qcom,pm8150b-vbus-reg
as a fallback.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
index d9694570c419..0cdc60b76fbd 100644
--- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,pm6150-typec
+              - qcom,pm7250b-typec
           - const: qcom,pm8150b-typec
       - items:
           - enum:

-- 
2.44.0


