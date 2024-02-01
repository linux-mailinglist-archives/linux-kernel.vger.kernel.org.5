Return-Path: <linux-kernel+bounces-48482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81170845CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67E61C2C1EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317915DBBD;
	Thu,  1 Feb 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="km7I2nCu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FE779FB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803996; cv=none; b=IB3JDFnsybIx7jQjm0kxOFyTyvzfeSrJjQs2YqVkLf/MeMSeT4BWik2J21pH7PPCs4krhl5q3DUErUuRa7KrDiAI/FFcU5BrBNWwvVTvaitMOS4mhsTBN6ZdFcwBshpaV/3tqLtvept3HIyRouxnvld7jXmMghY4NkZbJdpOli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803996; c=relaxed/simple;
	bh=UZHeu3wlMZdyRHsJoehsE8dE84CK6TDC5MVsRRlOzos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uo3/rpMUMccextp1mHndEZUOh4UgMnSAe47XqMDFiyx67NkEdzK7btMs4drJTMnyab0G1J4wz0uzkBava0FztXcfgiQIeOzM09fO4cvbkHmcujnIMPh+IM0kKXEOtQj3phMiXckPN4FuxzAEP9cRMpNDIo+Q7Dw8ZAoW3qkwDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=km7I2nCu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a366ad7ad45so140445866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706803993; x=1707408793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2CcvzpjBI3QWMIjK+OFITJ/1PGm3RNV8zUlxy0Pq24=;
        b=km7I2nCubVcrX37uvU52zmjhwqvgHErHXp6T8M2ZhSv8Wdoq2WOnkZvVuUHSv+ivsx
         7tErsTMTbh8Fn6/CMCJx1Q+Usj9OD6/CjnyBflnavVk9zvMYgBOg9ACBNv10J+x6tb7K
         PhfdWmsPTmZsBdv3UHwg1H0euag31itGpcY/hbxXg2srq0e/3+ozhLvBUfrZYI1X50fG
         4Blcu5RUVzUg0v2920yR/QxCROehivLEn/CzmF6Hu52Z7Rd178q5L3ZYdr3e1rGAToQJ
         moK2IN2cAiPUURi3+wg42h/XqspX+l7qA0pRGEXuNiEBAyDV1fepW5posQGfHbgvoQ2t
         a2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803993; x=1707408793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2CcvzpjBI3QWMIjK+OFITJ/1PGm3RNV8zUlxy0Pq24=;
        b=ETEybs/7AKfNHLCqfgO0rykAgqE3AwcYIwxVSLHjHfN+6H9+vvtB+nx41Yc3zcWrzr
         KPLtrb2Tafx1AKxLgAVzyEPGKhVab5MxbuhMXdHGdD2I8BiqOf9azgS41jWhY78dDBbr
         GzzSttqEItqiP9BuMFZ/QA5uTwG82mN8F3GJziSV5ZnIMXCWC41T6DTjd4s6hPgMfRkz
         O1elYzuHnA7miHPc47QlTRhKMESrEptG3sEigNhx90GJN2yk9v3MTfN235LiDuLKVsb4
         5zCajvOHcM6yidnUHkRaQmdZMVUy/dk1ivMvAjT/4jglD6X+XWnVIvB572zytwyT6vh+
         kzSg==
X-Gm-Message-State: AOJu0YweAmSIviPAgp2DCg1g71eYoZycgXdjdb/6Xlu8MvzzVfH4FSTu
	TIsExyQMA9G+/tD3w9xAbDiYYt7soVpEfTRkQ5LGDJhmZF+OmInfAVPhdZaJGRk=
X-Google-Smtp-Source: AGHT+IG7Y1q0fq7jSMpAZANXYH2o9mznYnyrztLx6txWcfih/S7H4Fhq9AeCp55I8KWmnfd1myPDnA==
X-Received: by 2002:a17:906:48ca:b0:a35:1f1a:ca50 with SMTP id d10-20020a17090648ca00b00a351f1aca50mr3787804ejt.11.1706803993381;
        Thu, 01 Feb 2024 08:13:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZSro7qetSG+lqknKtlWTDplGprqys1VfSzOI1wicV5NIlyB4stC53Dxdm7Ziy3jdsvW83QVQwKoMj0Di9ZP8JSp8REqYALv0DKqyp/TaXvtI9wf5aP0oozdh9pXk18KCLSuzoUxKVwXMymfVDKLn1bnsnSsW4yuX8qk84GCIrNbwY/gEZG6tJZvg2aGvkXdMA43+H6RG+wfHsXjlQwClVu+0DgcWVmSXIMsAmLsDnWz+WmBJDlBieDp0dNXlZDCHHJXJLLsTAGDHqF9gBIJPFDuAdPS4JTIEg4ShgUXQXOHoW5E4krMBEmClpxZlFLVfLhTdR8EUd4bJz+OOYjSGwsrjMOdAN2JXrY2ZdVUapSkXf6IEP7Xs2QI75JpKX4ARtg7X5So1c0wbbE63ES7DKACppcwcicRq2S7btNsjSbnHFrJzqaVW/crHhtfGsOd2rJjYRL0CACKfxnzBy5FGKR20Y2OzBowM8OWvceCzxsIqZC3VbZOfmP75KGww//NAUKkPhH9qmEyKPr7DcFYhNC+bjxWyRds7JCCzzDOTrtD3qn3bn+TnZX6g68cd/r/1sJZYqzJ3rAq7lL1VAPVLmjYolU3UokChkXM2JrkA6/s9HCZl2ihDqBxubcUgD9SRIY0ztn1HtuNoqKkyruY/xzU2mA/ZbaP+D5lU+XNXkdEkSCG0W+k1gAaolE2n9fwkSF+8yUakN
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a3600d7c2fbsm3449288ejc.176.2024.02.01.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:13:12 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/7] dt-bindings: samsung: exynos-sysreg: gs101-peric1 requires a clock
Date: Thu,  1 Feb 2024 16:11:40 +0000
Message-ID: <20240201161258.1013664-5-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240201161258.1013664-1-andre.draszik@linaro.org>
References: <20240201161258.1013664-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise it won't be accessible.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---
v3: collect Reviewed-by: tags
v2: collect Reviewed-by: tags
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 33d837ae4f45..c0c6ce8fc786 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -73,6 +73,7 @@ allOf:
           contains:
             enum:
               - google,gs101-peric0-sysreg
+              - google,gs101-peric1-sysreg
               - samsung,exynos850-cmgp-sysreg
               - samsung,exynos850-peri-sysreg
               - samsung,exynos850-sysreg
-- 
2.43.0.594.gd9cf4e227d-goog


