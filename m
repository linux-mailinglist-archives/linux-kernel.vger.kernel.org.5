Return-Path: <linux-kernel+bounces-82660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86618687E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5127DB22B93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1834D5A2;
	Tue, 27 Feb 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nibPEp29"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A553339BF;
	Tue, 27 Feb 2024 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005560; cv=none; b=g/uWWZ065ggOxE0dcNsiy/xaZwDmvtP8icO7ayLqt8akc45INnxNCk0DphGZUBDUHgmHTQgxh7cZ6yJdQu5mcjaSpNpnjKHg9U0skPLXjgHxga5JZ/pzg61lDxFbJvHyur+WdVHSsqGHFI3dNlCAPzpf0kWcPcwaLWmuPMRUOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005560; c=relaxed/simple;
	bh=PKqroATuQmkXfdeKNmcaZSx60NSv+Ro2hJXFdpkmcSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKEgvneKe6zlNZlZzKxHj9C3FT/RzFcAzIOUEAioKM8h/mXpuyYKU/u42qGxG8/grV+A2gZJeB+WkaQXzjnQVcRCW00s3wd1H1djDKKm7eRXDQ2aNQyYysXvH1upiJMybIq2fBl2C4/uurXahI+AMRfTplQxuTA3tAeMNMqSmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nibPEp29; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36517375cc6so9649725ab.1;
        Mon, 26 Feb 2024 19:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005558; x=1709610358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucD/+p4K6+j2ZE6i/N6HFdJPDZilTnGBi4Fcog1oUsI=;
        b=nibPEp29q5L6NSZn1CxCs+UB13moAr9MOVYZtaC60PJyveelBh65Di3RskCeWz5Fl4
         d7yMKhY0cEXRmv85XOBDiQ/b3zS6E1YXZZU426u7rf57q3kWYFWzosHIcrmoKtUx8Qt+
         RKI6Li/w6VlskxrCyDyvDLrY81ZH133pLudUwgJtSPRaBRVi/XEZTmwh3LmA6P9nqrKW
         2FGmQ8c/edxCc+FJqBfaW1SuiGfpzAAmCWAa5cFUWAB0zojhDtMyJ7A/qdSEbItstsGT
         dQlBGayScuop5gMlyfLTEAL/vipklMi5LzJRJZ8YqFL7u3XwdBxXdH+KPz5AClcNCtj0
         TJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005558; x=1709610358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucD/+p4K6+j2ZE6i/N6HFdJPDZilTnGBi4Fcog1oUsI=;
        b=oTQDhJsI3U2opDPsUpw4gwDTgEvu/1gguS0c9vcWotSMVeUs2M+0CUNz60Q16sMOjF
         4Uf5AT+pbaYQYJA+WWgXn08siQZ/zkNnSbgabZcp+ph53GxzaHKRNXPo6x6Mg9xHzn2m
         vpKy0SFVt/puiCKob0A2akcIP5QNQvPLcH5AJc2vjEWXIQV55Qc5sCsx4SwMoPHyZMjy
         C5o5yg1rrB0VUaCDsPdeQnkjiA45aIYBF3fBM1LaT7wZ7YjVtc1vDIqv5Pt2NO4+1WGa
         mJyp6FhpeeGjJKbOg98wf4g1zu2w9f9Nt8ZvohRCyGYOnIM1NkzQfpac3Ljpno6nEmc0
         1uUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLnijTruHKv8uW+2eaxDmj8pCvwyhDcIS9Pu0g9V2hRj3onnqbuG+nj8/AXUSe9VPITp6GB/T4lwqhyc8hqjLZn31oIFD87wY1W68bi+8FA+Tv7IFTBG5dAtJVRVv7PZO+zwjwkyMmgbrfFU1cO7zz3jYfriMv/1B7FaTyqNkIJrqLvyRvut8jgZJr
X-Gm-Message-State: AOJu0Yy/mLfSq+JgzerEtCS+Tipl7wzrVLEYoQUKb9WwK/b46ehtby7/
	RUZBJ1xPaWBPtx0wqZpMR5ThXuraj0f93AWRzuMzxpFSapgMEj/c
X-Google-Smtp-Source: AGHT+IEEX+eGY8wwb+gRh5Rwva/dPaMluotD4yi0XNwRuMV8qyLsDXz+GtY5HhmQ4McOBOW+ph9nRg==
X-Received: by 2002:a92:c8c4:0:b0:365:16cd:66 with SMTP id c4-20020a92c8c4000000b0036516cd0066mr9677139ilq.31.1709005558600;
        Mon, 26 Feb 2024 19:45:58 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:45:58 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: gpu: powervr-rogue: Add PowerVR support for some Renesas GPUs
Date: Mon, 26 Feb 2024 21:45:31 -0600
Message-ID: <20240227034539.193573-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227034539.193573-1-aford173@gmail.com>
References: <20240227034539.193573-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the binding to add support for various Renesas SoC's with PowerVR
Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so update
the table to indicate such like what was done for the ti,am62-gpu.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 256e252f8087..7c75104df09f 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -14,6 +14,11 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r8a774a1-gpu
+          - renesas,r8a774e1-gpu
+          - renesas,r8a77951-gpu
+          - renesas,r8a77960-gpu
+          - renesas,r8a77961-gpu
           - ti,am62-gpu
       - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
 
@@ -51,7 +56,13 @@ allOf:
       properties:
         compatible:
           contains:
-            const: ti,am62-gpu
+            enum:
+              - ti,am62-gpu
+              - renesas,r8a774a1-gpu
+              - renesas,r8a774e1-gpu
+              - renesas,r8a77951-gpu
+              - renesas,r8a77960-gpu
+              - renesas,r8a77961-gpu
     then:
       properties:
         clocks:
-- 
2.43.0


