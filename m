Return-Path: <linux-kernel+bounces-46264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8B843D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6853A1F2C9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A86D1A4;
	Wed, 31 Jan 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz1ek1/T"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE569D2E;
	Wed, 31 Jan 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698334; cv=none; b=oeo/O5o5KyuNxoD5vw/7Er/p57fWg9I5ocBZtq0uyWjkG9EbgJ3GZ366lAlzfP2M9S3YCPhFQ11axE9ddfnL/7J+WJrY7ap4tzUw8OudXolz/2qFWRNiA4bM0KnbFCJ3agqb5CTPSYCDMRLf0RKnx+ycdeGn4vRd3Er634QnoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698334; c=relaxed/simple;
	bh=DTr5Wk4PCj42NKTiJpVQSWqGcjbL2I2O7xvegUsab2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s450CEtt7O9DuDeRzOB6+AxfGjga00JabWnejQt1MAfzoWK3FVpCEv0CAttp1EbcTGDbRZUr68bmr2Td4dnd4L/1I5hiEJl1o32muLXif8lfDnQxqcvTFHr28gOuiM2ysetoPip6BcEg/gggaOpZwooeQCUe2Wn291vkS5DPADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz1ek1/T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1408058a12.1;
        Wed, 31 Jan 2024 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706698331; x=1707303131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdW4Gd3ArFQpDEqxCJbMxPMn8UQ7Pb2sdPxKXDUejLY=;
        b=Bz1ek1/T5LbShZEpdw/0CbOxJYNmuIan3Hm4szPpYUcBFn6VKiHongjHCgZ/iA139x
         gucFLzjVx1VDzZeS2MY2clfLH7HtSvDkW5/VkGMEJbcMnp1kzstGnuTYC3V7AeLHKzit
         TC5HuBlEbsYYMuH7kctSDOKqIabZP5GjMOyIycWDl/liA+xa/kOIioOMa3rKu6VMG6z7
         kkJKdqJSMuBHBM/HvhS6pJSxp1pTg1+1NGkx2jEb8KmTKtvG0lC38AQeT3lJ4TbhOgAr
         FlA7NnxbgF4ImoMAGO7rNeAkG4HrjLkb3jo+pxuB8AytcLyzb1Oe8xuvm1SHZg47WSxb
         g4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698331; x=1707303131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdW4Gd3ArFQpDEqxCJbMxPMn8UQ7Pb2sdPxKXDUejLY=;
        b=Mzl4wHBH3VfhqVEEmAsFO1RKF0MLlg+KO+JoI6hgHpd3YQHZh/3/LLdxTh77nOGiSS
         Vva5Rfm99d50Mb/cU+2NziS6aWfI0YLV8e6xTuEw8qaoSzDm8MJBa8h4R9XEkY8tWM0M
         lKBTZM5yCCuq4p01GNP/It6JluEQ5Owgp63UinD5LGmCEjgRckQc6lY9jX95zIbzpCv3
         8mc4h9OFN8AY89ExNJryBTgS7V8RrwQz0ncYmDskKqXRMback5xfm2ZBcR734+QwAL7L
         mLoIOiZqNLpjHnSQ7/HebMiRtFfJEpYDBk6z/I5CxdYib61vNL25TtUh/+ylx1/7y+Wo
         EluQ==
X-Gm-Message-State: AOJu0Yz47fizqkqshIMVPmCe+6yQ7mhIyi7HsCgsP7cbvZwjSuinuH+A
	Q4a1MZVAoxC+SkOJyYaVnLQTF9iPdnLhd3aB60G+AY+7XYRye4KkX4hHrGR/Y+mUbw==
X-Google-Smtp-Source: AGHT+IEih9ZrkXKkqIF/sVq/rSL+nvqrfNkOX06nA8/cbt/AB8BNuUqbHdeD8RVWe4uLJG6CldtntA==
X-Received: by 2002:a05:6402:1507:b0:55e:ea14:7912 with SMTP id f7-20020a056402150700b0055eea147912mr1277655edw.0.1706698330872;
        Wed, 31 Jan 2024 02:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXV8YPRy06XCmvJjxL8LKeTlDnd90YLYKieep6bJHFsCoAbq1wXCxJUFQPXvhlNwkVI80ycc7CODeqXO2oSJY8N71qRT0OEqA+dG2bsHM7143Yau8HvJ3wKZJd96tk8dJ01GWM/kOL5CG7miY7y7fm72FNcg1CR1/AUWPkIyfoi7CS8TWhJSAGUFUC6/8GwYqJAbQPCYvufJnqN8cQCeT7TIduvtvkIw1LMD6iF/zbanE2gXG7WywFc2Di8NmBhHH5B+n7bgWbDEWuLeK45kDVEXM16Ms3fwe4MoF7lipFtJMvayFMKWJmlFdkBhyny3xB+TErrJKONDamRI4ItY5AJ4OlcbOOOZIHCVcCHrX3Ej3h4hSPjPvzQVe7a3DEMzb3BYQ==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm4753966edz.27.2024.01.31.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:52:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics, Inc. prefix
Date: Wed, 31 Jan 2024 12:51:50 +0200
Message-Id: <20240131105153.8070-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131105153.8070-1-clamor95@gmail.com>
References: <20240131105153.8070-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing LG Electronics, Inc. prefix used by some older devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..b94ac977acb5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -767,6 +767,8 @@ patternProperties:
     description: LG Corporation
   "^lgphilips,.*":
     description: LG Display
+  "^lge,.*":
+    description: LG Electronics, Inc.
   "^libretech,.*":
     description: Shenzhen Libre Technology Co., Ltd
   "^licheepi,.*":
-- 
2.40.1


