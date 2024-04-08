Return-Path: <linux-kernel+bounces-135635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D489C8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07961F24E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806F143871;
	Mon,  8 Apr 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANq1pbei"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFF1428EF;
	Mon,  8 Apr 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591602; cv=none; b=OcSiS8FGGaImt4zd7869L/evuoWPt1iQQSILwcSaxl37xiZcSyydhfEWppvpPBSi1rQEXEFtfbjUJC1G24DahZa3xqUH6EKjxVZyAoatJmj6ntRbHFX5lbFxCbN2icg6/X4+Mus5Gr7eb/KX0p5eXuPeTznUlsj7Z6TYqFNaWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591602; c=relaxed/simple;
	bh=UiEej7wlBRi/pLQoBrweryeFGNwfjKuxoShA6lE5rgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KntcXQx7PHCFZxTLhAj/f0nZ9H8HjeCyzhHG7f5q4LARS/5jT+TF+bPaxupXSpdv4NOGei4wmLwFH8BDry9/3DHq7YvERVZQ+LImJ0QgpofK6gRFCRvnFR+bTcYmCxht0YiTn+uNkqrCXBDAHj3qeNjyynEQkc0bQxNMnv0l2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANq1pbei; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44665605f3so526721166b.2;
        Mon, 08 Apr 2024 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591599; x=1713196399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rI91zKEHaZphCjid+rr3ztF+AksAKCVPYsgJBuGJSE=;
        b=ANq1pbei/8XsreUqESimfE4VazWYLMx48EBVin4z7x/pzO+v4WC0D48UbWj2SWdBYA
         uCAoGyU1u+jKVlFL2mWRUzwQSQra18rvaYJveMa0BM1pdH3XcqUZmF3RzmbCmhx/CBzh
         2xzN2R7V+nqqVN0OY5RBJRVeuq8H9SF47NMCmtCPjDUh4FrYsBc2+nsxDqsvDumQGdBg
         E1iSL3uczHfuSNvRk5KmfbFPLTA7IMGQbpw/Hf9pTikDVHf1xRrvUnyS7c/7ajxlTJGb
         nK+ZlPKTOro2bWqfUdX5k05wA/CqVPFY+ciOO3C/lHpAhzvNUsE+fPCAl+ky4aU/Bghi
         2SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591599; x=1713196399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rI91zKEHaZphCjid+rr3ztF+AksAKCVPYsgJBuGJSE=;
        b=u5H0hl53iJAZpRC0vSwo2IzLiypT5eekDbDtN4cMEEWSq1j8fh6XipwJTu/eHYdi+B
         NAPXYMQkHZYMpfMLewGpq2nsb1QEBsNk+S92cf9AdI/0PUXi1kCkEQYnXIMFccggWYrt
         WLUtXEp+SYBSXRW3u7UcBP5AepJ/CpPfevgWtdubUzQCtiRZ+gLoK/eT4ICUWMWQKIR4
         Jxpyvcsei6+GLdEN+4w4wgowZ+AtRvcpMuK9U0cCr19wqb8plai2u7VEsWT2O7B98CGU
         ah2Rq+Cx0MRqavVkHAeY7FKut5Pn9HuTbP44pPw3h/KQC5id+h8R5zJFzQ+ny9XrfzpE
         7a+w==
X-Forwarded-Encrypted: i=1; AJvYcCWwK6vsVoUibDK5UsYlWsGCN78xbW9FE8vOpLpFF3H5f+nmwrqFsfC1fCIM6g4j64hSj417dvQNbbSVNnQ8n08DI551BDN67H65TVNo8xO0oSqsPsOM+vPfsJlsD/1/WuX6YSrBXG2UAA==
X-Gm-Message-State: AOJu0YyVJbOBNqsg3DxWeoqkbzhYGZeAtcQzrfUzX4E4yWNyq4P8ghZ9
	jlCwE9DfM3WdS1rlmGQZxGSPT4OjKD0vwYi4dIGhqTMmDA8PDNKR
X-Google-Smtp-Source: AGHT+IHimdaFx4mr+fd5liP9CQQHQfUAme+YF2mKZ7a1UnXQ6iSPME0h09ObN08oeUq6W9IgNv/UPA==
X-Received: by 2002:a17:906:cd03:b0:a47:4a32:604 with SMTP id oz3-20020a170906cd0300b00a474a320604mr5925265ejb.26.1712591599181;
        Mon, 08 Apr 2024 08:53:19 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:18 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:05 +0200
Subject: [PATCH 5/9] dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=2126;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=UiEej7wlBRi/pLQoBrweryeFGNwfjKuxoShA6lE5rgI=;
 b=EpHnh+7FpXHoZNz9WVmqztAU819VB3IfAfjePtPHE33EfG9pOWc64lH5c4iJGsPPAkiXfkCFM
 67eNi1/nowwB6ktD5i9GayFdEXGoC8VcQqXJvBH2aLTYW752caeJ2Ze
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The RTCs documented in this binding require a compatible, a reg
and a single interrupt, which make them suitable for a direct
conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------------------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |  6 ++++++
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
deleted file mode 100644
index 2e956b3dc276..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-ASPEED BMC RTC
-==============
-
-Required properties:
- - compatible: should be one of the following
-   * aspeed,ast2400-rtc for the ast2400
-   * aspeed,ast2500-rtc for the ast2500
-   * aspeed,ast2600-rtc for the ast2600
-
- - reg: physical base address of the controller and length of memory mapped
-   region
-
- - interrupts: The interrupt number
-
-Example:
-
-   rtc@1e781000 {
-           compatible = "aspeed,ast2400-rtc";
-           reg = <0x1e781000 0x18>;
-           interrupts = <22>;
-           status = "disabled";
-   };
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 710b096fe6f7..0f773167d32a 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -24,6 +24,12 @@ properties:
       - abracon,abb5zes3
       # AB-RTCMC-32.768kHz-EOZ9: Real Time Clock/Calendar Module with I2C Interface
       - abracon,abeoz9
+      # ASPEED BMC ast2400 Real-time Clock
+      - aspeed,ast2400-rtc
+      # ASPEED BMC ast2500 Real-time Clock
+      - aspeed,ast2500-rtc
+      # ASPEED BMC ast2600 Real-time Clock
+      - aspeed,ast2600-rtc
       # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
       - dallas,ds1374
       # Dallas DS1672 Real-time Clock

-- 
2.40.1


