Return-Path: <linux-kernel+bounces-71644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65A85A848
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BD5B23B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E013D0CB;
	Mon, 19 Feb 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9dH+UhW"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102D3B1B2;
	Mon, 19 Feb 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358996; cv=none; b=jirlHKPcJy6GhAcUnc/Fc021Qu2je12DMsiE5Z3pBuYpTTiQCcNGkxNpz7TZ8DDJaIF8lK2U3c14UIv4J4Nfs074bsnyDkQQ6kHBL0WLuRgA9wz3BhbuCV1hXOTke88HpdyrfA2yy7v3LNeWNLd8hg3Z51dixPOt057PJwQVAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358996; c=relaxed/simple;
	bh=LnFYp2F5S9qzqglmLAYrhKmDTTk5nrJduQ5ic7z0Z3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUO5CHTmXrspTXYRHE7F+DJYaqdGWfS75gYCEa4d3Hijnuqr42kSvVkEWyWmVoNK8HhRXIuZoWH/o4ZbqeUb0HH8I1ywhAwoqpV2vQQSerMJtakNreEEa/YcVL3udvMA9h1Asia3p1P97kyysvQgIqPWHlpuILXxSaxyeOaH35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9dH+UhW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d208be133bso43547201fa.2;
        Mon, 19 Feb 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358993; x=1708963793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h1gyFepUXpminNkUQmVqPlZQwS+g2zBZirXjStpZCk=;
        b=b9dH+UhW88G28HbD5AYzeg9Fmm7Sa2aSg9vcA8id3ZTayMErHv+obHtnZXWh05gKj+
         scw1WTktK+jL2Kkr+Bju8oXYKFtttNoQU3iiG6J9K2BrAhSwdzSFb0qNuRF+i1IE4Feq
         H5CAyuwr132MDJpMPtfU5wxWgiyvMfqu8pwsGOWVfToiyW2/FG2BI/762vzdxKK/8iCN
         nZCAnBlE9RAfnJR8w7aQ1CLiLjHSBANpCWYWwL9ttWoaWyZL9xZixDCgiPJ+BpBCVYc+
         F1BLDcrwcuHioSTSac+ePENi6DITCtLROXEMUjsE+1hl3A9rweOXiReXhC5i6OFp75ys
         dH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358993; x=1708963793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h1gyFepUXpminNkUQmVqPlZQwS+g2zBZirXjStpZCk=;
        b=j43ZpvjE0LqjLV08BULd97t9XA2tSHtK0cjI74VzEIRVEcPSwTV/UrBK0K7Mj/uJ/6
         FgpCBvVKtnaG+k7/p4x0xbgc2YpO2wMuHFDCFJxbaSDrEPuz0AhhmBygvPSL0pEK0ADd
         5bfkkhGISeq5oAuPpgDhLObDTfwroVKIIppXP5T2hvrXWggo5dsvtJMG6I60KafhQiiW
         HNkTotlxLytldI3cpc0i3GZ41Fr0vQJOgMJlqIRIGWU4cTZrtvI826B3wyZ3NPd7lIhP
         Ov+42E6ccunwB6woIjWIeXFRjR1hpUqd1+S+vXXz2+cxOB9ywpkpU0JfgeNVpsdEkY3Y
         bMow==
X-Forwarded-Encrypted: i=1; AJvYcCVXyuB6tHggD2Gyz8IHD8DcWwh9uC2tame8vEaX3mVXnHHALKSSmpxJHES55YuQpzAhTc1bNImCzbg1o5n4qurMt8zaoi+NUyagWVbV4j9TYHVIybQ8MrhMZAfL+hnIUX9JnFLpiy//ULndpNUNhW0Jqfh8GyBoLWHWI77eMORhX501Zrdnb+yMfps9
X-Gm-Message-State: AOJu0YwxOPSdM5C4KfzC1q/ck1UwVTfoXOJlwRxGgaO+BrPz2/5Kfuhh
	vBgAayKx1KqZi4H5yoP7ySkXwnB0FweqS0bok4QXUzA8Vxm9kOIA
X-Google-Smtp-Source: AGHT+IHXJ5jdds4R66iOr1SPOl+gYdrMt7Xb0LSwije1srKFZ11JFY5D4isRYUHLrSTGw8YTOqfmOg==
X-Received: by 2002:a05:651c:b12:b0:2d2:3978:a14 with SMTP id b18-20020a05651c0b1200b002d239780a14mr2846870ljr.34.1708358992385;
        Mon, 19 Feb 2024 08:09:52 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11592670wmi.34.2024.02.19.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:09:51 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] dt-bindings: soc: renesas: Document Renesas RZ/V2H{P} SoC variants
Date: Mon, 19 Feb 2024 16:09:09 +0000
Message-Id: <20240219160912.1206647-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document Renesas RZ/V2H{P} (R9A09G057) SoC variants.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index c1ce4da2dc32..109fbc8d48db 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -513,6 +513,14 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/V2H{P} (R9A09G057)
+        items:
+          - enum:
+              - renesas,r9a09g057h41 # RZ/V2H
+              - renesas,r9a09g057h42 # RZ/V2H with Mali-G31 support
+              - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 support
+          - const: renesas,r9a09g057
+
 additionalProperties: true
 
 ...
-- 
2.34.1


