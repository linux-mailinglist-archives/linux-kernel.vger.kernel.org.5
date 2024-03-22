Return-Path: <linux-kernel+bounces-111642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995E886EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA361C22453
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455054BFC;
	Fri, 22 Mar 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwjdgMmA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8250255;
	Fri, 22 Mar 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118708; cv=none; b=lRo03ezc/1IEapFOIrUqOfxn/oSc1FcIHcwBNTDi3MDwFN4zeG2V5evxFLMhEQYaJaIpiHXuR9APweoxkZscX2A0pq1ts3yqshifBdVqikETX49mwAxQ2NFG2myQm8KvXV9iY9N4KlU2SpS7Up/iuS6JGX3x3YC46Qag44D3nsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118708; c=relaxed/simple;
	bh=pk0bhuxbVWLKZLYkS//DIr1PzZ7X1d8HhGL4EDlpJgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiWwXqQvLyKAWozKdGz8YHdVnwy9JBVLayWHhuJk1mgZZSjQv2RjhzTvbsNJwDQvm2NZ3CoKI6b8JqxF+AVP9HMVZ+ffFTqy0PVKGYW4WTZvko++Nb0gt39sZeS1tA2UKZ276Q1MibfTbrcRP4uAWTn7DQl8Va9dDI096uzkVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwjdgMmA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4147e135f4dso3325485e9.2;
        Fri, 22 Mar 2024 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118705; x=1711723505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4uAQ4C9kulwxZznVlWW/8ebBG259lLBKIIu3Q2bFtY=;
        b=AwjdgMmADANnmvf+1nxf4Ht8giXSyyV+g5+H+XX8zlTz4ISbxVQzotJOxnZZjYWSVY
         QGOnoUMZjbbfEUvul9gGC7i9RLSvEW4vWR3RgqekY9CNVdpmdS0iwFJWznMptOaj3s5S
         UMIvH6NnEOmzPIcmxFe7nD4qa1HvUa0sQYmORES9GX2QySVBWxaYI3+J/VTyhu8qHYns
         udCS608+LQBm2yU2UnMpDBgWsn9vSujJL0dTqPZRRwxDs9Wmg3GiekBdDv/LgPDiZT5A
         IvAgQRLQNWwAtXAZWmvPEeYtKCB8rmS3Np3i0/FxZn7vNo+BhGHNiIVdtHl8PwkHOWwC
         aJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118705; x=1711723505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4uAQ4C9kulwxZznVlWW/8ebBG259lLBKIIu3Q2bFtY=;
        b=T5xdbGrfV5rQeGNxpGw5i4rKmB+pTYwMhb6lOnJpmtyKa1IycnD36OIBfBpj20TVla
         eJiaonUla8lpb/jUOYY+53ZSm/5Y5nZMVttAaHHeLkdgNqB5yFgsuPbpcBpSkcYX/buu
         XdB6fJ8Sjlnvr0+tZLUuQr0VotmhLPza/XvDKfo7COUbkD+6PndBK5VitWo5L+iY2SZI
         5m7LJPkry8bymRYCOCmYPPccaaWQqnuJE1GDgN3Gk1uTsMrYN95p7/7NhsgeNFDIf1v+
         vm/F1z+i1+gufmKgVy/wS87fdK9mlSvsK15UmJ77wf1PlH5G6nDyI2An2UWuWelonA42
         jUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVcFwbXkMxfm3iyhSgiBWZUfAA4Xs2agF7ipvf+4fgLa4ZEfWtwKdYzH5sklM4NOeX8SE+tFn3ebBFIPAJVGca5ilBYNJb3Ka/4BsJk05EyFhPyEpIj8NQlOgl4wFaHRKOnaaKHnFe9vzFWAKL0coAK1GMHd8PlOOPmhrxR54KSXMPlv+zDm5Dvi9pb
X-Gm-Message-State: AOJu0YwMP2eKiBQN4Kk/q0Q3BiGqjzybhgaGKXvwsQtUVt73DpT6Ut0Z
	MgE7oM50EVpJOzf/Qtt30gbX60BMF2DKL7uEtCpvNDa+l+xxWzec
X-Google-Smtp-Source: AGHT+IGsrDk14rRDiD9xfpqQ3L+sJLzhHcEk40nAr7Q2VFynMk7I/HH3yiJpFgIkH85Gg0jC02iVOg==
X-Received: by 2002:a05:600c:1395:b0:414:7ddd:b92e with SMTP id u21-20020a05600c139500b004147dddb92emr887641wmf.39.1711118705493;
        Fri, 22 Mar 2024 07:45:05 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:04 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/5] dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as required
Date: Fri, 22 Mar 2024 14:43:53 +0000
Message-Id: <20240322144355.878930-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

As all the SoCs having multiple interrupts have 'interrupt-names' property
in their respective DTSIs, make 'interrupt-names' property as required
so that we can validate them using dtbs_check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4
- New patch

Note, we need patch [0] to be applied or else we might see
dtbs_check warning.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240318174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index eb2aa5e75e02..c13b31c28049 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -179,6 +179,9 @@ allOf:
           maxItems: 1
 
         interrupt-names: false
+    else:
+      required:
+        - interrupt-names
 
   - if:
       properties:
-- 
2.34.1


