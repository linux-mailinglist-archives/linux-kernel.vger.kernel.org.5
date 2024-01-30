Return-Path: <linux-kernel+bounces-43770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559C8418B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8816C1C23BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68736AE4;
	Tue, 30 Jan 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLi2+pDT"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCC364AD;
	Tue, 30 Jan 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579460; cv=none; b=bmyWg3uopPacCpN08Sk2IFJmoiT8qu7kbsEt2QK7W2js7fdMVJ2qIvzy79Y6HKWsNMHKbclw/gp9PM9m5PPa2UsCgNMpFmyMJiWVLQ4kYqq5UnuYc8PEdwpo1nVzrk3B9Xlb76c/sfRXWAnFP8P2VJccksbYkjXeA7UWaJFrh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579460; c=relaxed/simple;
	bh=2DTJRKZZGjYCcXa3T36ACsw67WzQbjbiVOF8FynEqdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLh9+K7c1ySCAm+vZ9j+hodIrdMChylFS79ASCUmzeL5KxRZs+AcY+nX72pWGC3+nJN+ri2XGOwfVLWFCgvGV0dEfWe/0yVyfakm0HJHxJy9aciojcKtzIKJcHruZixpA7pJYznEh4uzHdkYjYDeDZ7wI84NVE2g1zfyyBT7UXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLi2+pDT; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb9b28acb4so2454152b6e.2;
        Mon, 29 Jan 2024 17:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579458; x=1707184258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+xiQxZglnWq+tBqbd5E5R9p1VheyL290G3NA4mMGp4=;
        b=jLi2+pDTihOUWrgQa9P5yyB1vdOTlDyV9VXrmWKz6vjGp/lo01zJQHObmpDB4boz1H
         B21ALWIgXTfFdO65s+Y+SDVLRfsz/En6qb1/bW7k3HaRsFlrqoE+lImFLMX00uIZziVo
         GYWwS9zWgmThRqbCuP8dgzsLjdVhw81B0s2Spmj2Liek0lj1+XdP4Enl7XAL2rI4gWkU
         cdb5wlusw6eD55ZVEkxB05vclZw3lrCBDvOCLONjr59S9YAZUOMGaqF9vpAxXeohWyeZ
         Ro9Bjl2fdTJd722p9cY5FvKP0StIDfUGb5fIU17xRo8GgRfPagub+mtPC9n3sbuBEX5Z
         sOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579458; x=1707184258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+xiQxZglnWq+tBqbd5E5R9p1VheyL290G3NA4mMGp4=;
        b=MeybnuCKQWVs0ROSOkFBn/HWqkxe7YWvW/CsIZLaITAMYwvzCJ48cdj7xUjV901bcA
         0QLefHotqKPfmMU2Ds7fqG8/FDcxuRFlpfkv0nciOadKVaOnvTo3QA/OspDUqEFZGCJj
         cIe378l817Ysj6cjoofXLiiyGTDVELSvtHpgr6EnhLTeSrlYQKYixOITaZ24J42niWvG
         sP+orfob+eaPEHiCcWGieGupcmevjvkzOCSIJYpxraYmAMML++9KriRGgRLg2nqbxVar
         6Vs+szETxFbvf7e4+gQ+FsOWqbqJDrDrrd31jfMiF95b9YZABegX/VtJnRqlWRw6UwJT
         Ut8w==
X-Gm-Message-State: AOJu0YzB5uLavu3aQcmDBuhp/eqAsj3kPZzJPl3IFqXqT3fIsaLouUBU
	HOUuDPVlYFiJg0oeU9PImcfWK+DRJR9NqWHFTwhrnU1nJ/aVwSGe
X-Google-Smtp-Source: AGHT+IEVngsUvnKfoP7Yv/9NQbRGtKkZWpQCRP18wKnnkXaseqw/Yc9oW8LGCQ23D3g9qIEVcgYDbw==
X-Received: by 2002:a05:6808:1b21:b0:3be:9565:d4e4 with SMTP id bx33-20020a0568081b2100b003be9565d4e4mr235702oib.24.1706579458391;
        Mon, 29 Jan 2024 17:50:58 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id cz13-20020a056808404d00b003bdb8b1f964sm1652754oib.21.2024.01.29.17.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:50:58 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 4/4] riscv: dts: add resets property for uart node
Date: Tue, 30 Jan 2024 09:50:51 +0800
Message-Id: <807f75e433a0f900da40ebb6a448349c98580072.1706577450.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add resets property for uart0 for completeness, although it is
deasserted by default.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index eeb341e16bfd..81fda312f988 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -343,6 +343,7 @@ uart0: serial@7040000000 {
 			clock-frequency = <500000000>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
 	};
-- 
2.25.1


