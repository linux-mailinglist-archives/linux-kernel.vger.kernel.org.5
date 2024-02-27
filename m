Return-Path: <linux-kernel+bounces-82559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5D86865E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429321C26056
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D051C5A;
	Tue, 27 Feb 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8EYuyRL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429104EB58;
	Tue, 27 Feb 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998466; cv=none; b=Eryqk00qUjdbPnbkNh1ptxsKYJEGK9EbFZrQVsFOGfU0h4ezLz9dE5qceP/NVarOGAF0vh13Fy/nbbCSq5f8Z21Yh3WwjL2vsrXPrB5mEBT+QYWg820xaWq0rYk8CX1QDC6dDNouScvrBi6U5rfkgUQ+BCP+o5C4pB7E+dtwFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998466; c=relaxed/simple;
	bh=tqRWl3+FrZKqukKyRngOznLXU4pJFPxd+qsvBne/hwg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcRujgzU14vnZcGEAVr3NzyMSrUWby9rrfRZU8rYIo9bmY0b1Wb1c7lIES9oxpM0wgn2gP659yUhkRaKPU+wl0SFc5TikMLjIL7ZLO2wZNRmIEiWPKXhWA3sASBSqMj1tiQNhL3TU6D5BYwBDJ3Yqqn7glNhJGkRPwjDp1QtlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8EYuyRL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e54451edc6so513189b3a.1;
        Mon, 26 Feb 2024 17:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998464; x=1709603264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeUVH1enZnNU18wYfElV/S7pL59t5rpG29uXETSjnD8=;
        b=I8EYuyRLmh1kRCq9qMveNOpgz9BOwyeSFM1/4NrpGOiYagbDw2njyjZUEjh73376ys
         xiwNL6m80aN40bgXEQyQjKysTiAG7mVK5+IGL4i5Gp/CMy5LomNzhgmEegCZWf4Jj2Mq
         ksE66gqLKJE7xbcW/xG8re9kfFIBBQcM60KAjD3lc+AHnCfTzYmgvKAGGRD4i/QCv00P
         X9MHvhnmkQQ/36oHvNOxhr/StlnN3dETAzcAoNo92uo1n6YFr603309krISNKWe2S759
         NEeMef2J8VPtRBjduc0ySU0VR1ImFIQykhm7EMxFOWWdFb6UUsIXN55XFsL3XQNVoPgF
         +UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998464; x=1709603264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeUVH1enZnNU18wYfElV/S7pL59t5rpG29uXETSjnD8=;
        b=BXidZsdjFXDICt58Njg3EiUifHycd/x2NkY04G0LR0xla6Xy288iLST+6UVlv8jIvH
         MXT2KCjx/abB9sOwNcc2BXIq+Ku/nF1+L1uhmRdYOdfskUtN+7HxP4CfemKUNp1VG8Es
         GMNrD1LodynzLfzYkqnU14NJs/D153BMNxbCvGH+1XEu46vzfb+Au7jKXZJVm1FQwF8e
         65LzYdN+V7oX4xjdtB0D0Dk6e024N00iDpyMxrXGTOkd6C7nYdBiwl8mSzqu2PWhgt47
         XwrecVSqqW/AaAW+jJ63SO+t0HI9HdaLC8e7vzAPs3gHpTFwd4YvzDp7DZfEx7ez8cdA
         OiBw==
X-Forwarded-Encrypted: i=1; AJvYcCWrXbXE5HGmzxkLojzWSSjAnoj354h43AgyhxsFwn3dLlbUt8e6YlRpt/uSMfjeRnYOkLtyAb4RjknKsL9q5mCKBZIlDy5nyq36EUIfZtrS3Fyz0W8vP6q/dAlRgHHSA8Lskg//49jUfQ==
X-Gm-Message-State: AOJu0Ywdwbkq+aXtun0bFKHpG7cF1VNAPywaDauzxUNqaMGTloBQ4+ev
	ojaUUsvp02Q7PRrWI6KLJ9ZH1wruqkoQOoBrO+cwfBJi1//k6JtN3cLjjq67
X-Google-Smtp-Source: AGHT+IF/Ku+RIpOrUIY/aJ7uNPcDkGlC4OFk6afz/ulTHSCfoWsoNZFTnnp/YaBtuRHdqfJv6tNwOA==
X-Received: by 2002:a05:6a20:c916:b0:1a1:b38:be61 with SMTP id gx22-20020a056a20c91600b001a10b38be61mr881754pzb.51.1708998464656;
        Mon, 26 Feb 2024 17:47:44 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:44 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] ARM: dts: aspeed: Harma: Revise max31790 address
Date: Tue, 27 Feb 2024 09:47:16 +0800
Message-Id: <20240227014719.3037588-8-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise max31790 address from 0x30 to 0x5e

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5c3fa8bbaced..7e98af5836cf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -192,9 +192,9 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@30{
+	max31790@5e{
 		compatible = "max31790";
-		reg = <0x30>;
+		reg = <0x5e>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -212,9 +212,9 @@ temperature-sensor@4b {
 &i2c2 {
 	status = "okay";
 
-	max31790@30{
+	max31790@5e{
 		compatible = "max31790";
-		reg = <0x30>;
+		reg = <0x5e>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.25.1


