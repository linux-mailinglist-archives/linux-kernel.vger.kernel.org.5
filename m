Return-Path: <linux-kernel+bounces-61866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79496851792
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F11FB25052
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895013C6A6;
	Mon, 12 Feb 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TB9CSVOt"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DF3BB34
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750335; cv=none; b=d4Z8lsTaIUFB/hn2lB/rsYB7KgTLv6jE6na/g50pQSPmaUHYunyW54tGDYszrcWFMLbkyR54s23vbMl2WvowNhl45UKe7Pc8HlH+8i1Zxm5DElSZxkjp7TAhYifHWZjLbomcWBRplveGyEYM4MpnuPO6aGLVZBacn5o3KycBiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750335; c=relaxed/simple;
	bh=KgUowYfgtXl28hHu8o53H1gGOukBG50qgWooL1gLRCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=in9y+xqjGFfj4ggu9JXESDY+SPebttfXnmwKRkjEvNa5+gFY2WLOTZ/zxQLZCW8uxV7dB3nTMlL7MrvyAARnJHMwg3T7uKoiFAafflYROWtReGfpT8SjeuKDLinz2BwTh86I9VcdOkZEO/tD+K4rXa7FASf9JBVSIQyqbF7r0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TB9CSVOt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1855247f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707750332; x=1708355132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyTLWvwJXO7xoVt7rika7/6Jet6raOmjXeaXTzvReEM=;
        b=TB9CSVOteC2cMG0gOP50vkZ9rvmG6IQszJ2R8MvIsL+64nVVJNy8siWyuX++uqX4Cp
         4M4w3wQ5cdRgSfENQ2gSpIH5AgYqbAACWm/HyTKin2PDynH3yLUQKRnhdRA/gSs8zevo
         ZPC1B81vsMPsNiuvuDa5vyn/IlboWQKc9UgtbWLq+NNiz8Vs8QUrEUIag2KpWLTO0Tx6
         wf4WAYhjpehQpVcykNle3myLlVzM5tobuezuAn8NG8NX/6GMG8bLwSw/0Dz1cvQSsk/+
         ntSgK4cRj6nu14OJHIRpDRC3+42le5K/Y1E0kwmDI0K9RPJgt8jmvxkeHpl0tmohyAfN
         hx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750332; x=1708355132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyTLWvwJXO7xoVt7rika7/6Jet6raOmjXeaXTzvReEM=;
        b=TLkB3bUD/5qmZDRCQHMPjRABicjmzbP5bBghU3ypFKKc9M27lpMXNlVZDpK+Hj9yNc
         GMxQdSGFNsV0oVcUfffNaiweGwSwH5jr8teIxl8XO6ap6XwfNz5bX8UrdV4GhzQ6lTvK
         fMyn2RiMQyQhsHhwdl9ozt2cSZ3TC8N5YLWZOmVBbjrhT+AmSkfCQ806K4wfrtMWHy1B
         /m0UULIjVviK4Z4Cis6JXKQH/h1F756A59o0QcJuLTKR0IUAgFbaNZYX/zSX6R95ZcoP
         8JjRNl/GFgRvK/xZYtRidbNNzGpmhNBFrGc4MAVdiAy9yfU5BHGQ08CRNwnoUhDEaqAA
         rjrA==
X-Forwarded-Encrypted: i=1; AJvYcCU5bAum19V3Iprl0BDPLv5tFlILnkA1hLOzD3F9EmIXKoXrP2tU0KNZIDYi+sjs8Tk73jd7/oUP/dpwT/geTDb5/94PfgKTWJTVA3TV
X-Gm-Message-State: AOJu0YwVA+5w/WMtAgM4RJ6mRebhavBVVpB4fNoXssm+mqKhUHx4Q5Ea
	3x5cEXVFpDwLr3aLisxCEY5GYpuwUBBNidyT2/sJ5+NTPBYYX1oWAp3D1ZS2/1c=
X-Google-Smtp-Source: AGHT+IEHFhKnUidcc8ozQBza9HuX78VlrI3zB8EwUymtQo8q+7mZGqafUpbXddKfPALQC810Sp32mw==
X-Received: by 2002:a5d:6daa:0:b0:33b:582e:1e4e with SMTP id u10-20020a5d6daa000000b0033b582e1e4emr6259901wrs.6.1707750332526;
        Mon, 12 Feb 2024 07:05:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFXqShNNvztQDBXSpM8OOw/PBnzVmD8Yv1Kz/rd2nVlpk3UjRQrEKiLCd1ONeLZ0xpPw8+acwyELh5o62P19lzguRMuQD4Y1tczTwFDHKss0GLB3SHAGwPu6m1W+gh5e2w7AgpfS8neTPJSrQnw0zKbe6okpx35a30VbCL/A==
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bu13-20020a056000078d00b0033b6d5a1244sm6964223wrb.12.2024.02.12.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:05:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] docs: dt: writing-schema: document expectations on example DTS
Date: Mon, 12 Feb 2024 16:05:24 +0100
Message-Id: <20240212150524.81819-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>
References: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree binding maintainers expect the example DTS in a binding to
show the usage of only this one particular binding, without unrelated
device nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/writing-schema.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index a35859f3be00..7e71cdd1d6de 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -92,8 +92,10 @@ additionalProperties / unevaluatedProperties
       'unevaluatedProperties: false'.  Typically bus or common-part schemas.
 
 examples
-  Optional. A list of one or more DTS hunks implementing the
-  binding. Note: YAML doesn't allow leading tabs, so spaces must be used instead.
+  Optional. A list of one or more DTS hunks implementing this binding only.
+  Example should not contain unrelated device nodes, e.g. consumer nodes in a
+  provider binding, other nodes referenced by phandle.
+  Note: YAML doesn't allow leading tabs, so spaces must be used instead.
 
 Unless noted otherwise, all properties are required.
 
-- 
2.34.1


