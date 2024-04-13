Return-Path: <linux-kernel+bounces-143785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D068A3D76
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC4C1F218FE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552595028B;
	Sat, 13 Apr 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh8K2+nt"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121E4DA0E;
	Sat, 13 Apr 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022646; cv=none; b=Dk1RsHV0zreIai6fuU/SFgFQBxwGnaAyCET9D6xlDet6PHg7AKsn7Z0MVPwj3N3QeTST7fNOc9r2KgeZVPQA6iu+AS7LVvhiEmVZT5maJrgtkkOIng9T8Mf4ziXL62Qp673h82fIMKYiIDupejK/H+Qke+tBUJlruLXWyd/gWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022646; c=relaxed/simple;
	bh=XS/OsgA/rX06W+gcNKSPAvWRZjW5UTrTYVjxuYJXLvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALqU91hLjOtT2MY+QppuOFhizLJdhhtgZZ+jjrc502L22fXXy4IjROswAkkx5Q+FTLgE2LMPGwZAtnVZtTUOrmgEj18KHm04Cs1u4VBzWj9BaXlSP5CfwkwJtJRiSOu5MKq/qetzx87GqAbUqG8tCkkFnWih4q/GCx2VN9QrhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh8K2+nt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1323249a12.1;
        Sat, 13 Apr 2024 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022644; x=1713627444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX625iIBdt1za2l5qXZovB7IlyOsoBBOXctng8wWg/8=;
        b=lh8K2+ntxX1Q/8hVbL2s4TzET23V+cz20CuZAOuIp5LlVMXkHuAHEFjOlmJDKyjvUH
         eX9ON2SuG1Qk7eZo0sfZdxW6V7tcqYzk34iRl7snllCbp77TAWryRhz/q782FRtDnU84
         mRFslfuCqK8kOzVppVNJAXlclPO5SVBhKdiyRyNtYnmI32gppfD90cnk+iiZkZzDUK/c
         Us+OQQ7mQj1Z0j2gFaohnBi7IH6VYQBRfGRvEjHcO+/5T0kaYdHdf1rTvOBnz6ym+IAH
         /ZFKwLhq5hzrrECRdh60Anm57TGUM1xr1r4Ltd6JT5bWyw6X4SNmalK1u46+5ENdbp0X
         ekUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022644; x=1713627444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX625iIBdt1za2l5qXZovB7IlyOsoBBOXctng8wWg/8=;
        b=IeB20DwynFtnL7dafSkdyzNgPT5ngu5u95VnltrAnOlot9T2t5zUvr0fhc28ShmLg2
         8wVW88OlOSerYwLHGyX0kfLv0jsm3DobKIBmdur1rp+o3YBGSzEltGxThx3pw9hyqhqf
         9iCy2uyycGItJ/hsusHZYb+XHeDyc2zoUn/rRq4AbFimNonxQn+AAT/TPptZsmNY5Qbm
         gqTz1llyzCkCHGG9h+IJGQVrcp2FefShMb6rZMxc9BTCfATKnfIB6yIuAtvW7BYu9Ir0
         41BYOSG60yyXIVMkn+QSXeRWo8aO/yLimjgXR4oyrj4mpczY1UPqun/2wKNDF5URjGJu
         4Tow==
X-Forwarded-Encrypted: i=1; AJvYcCXBZdpNT0PjvAZnDETxhBh9Dr6+2fmj92QLgSezWlaQ/nH/YGAi3aRgf8tl184PMRdwjC7jjNxsUGPUuCnbQhgLSH8b3+KIQ2+pWnZQ
X-Gm-Message-State: AOJu0Ywz8u9icR4EbGH8/Qfflk2zeGWpKmh/jVlPUO0JlizZPymY8ngp
	a/AmYG+1S11KUI7N0URDEGmpzClikDMFoa3zvMFYbX2FU6btxQEVA2HIl38Pj04=
X-Google-Smtp-Source: AGHT+IGTBTCdgnTFod0G9V/qQQKZ+dCU3OqsO43l2hrUFqqgxqpxl1payWY1fhzFsBEQ35jk7QSyzQ==
X-Received: by 2002:a05:6a20:1059:b0:1a9:5bb1:ba27 with SMTP id gt25-20020a056a20105900b001a95bb1ba27mr5298784pzc.9.1713022644413;
        Sat, 13 Apr 2024 08:37:24 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ac24d00b002a706910b05sm2609606pjx.9.2024.04.13.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:37:24 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
Date: Sat, 13 Apr 2024 23:36:32 +0800
Message-Id: <20240413153633.801759-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413153633.801759-1-liujianfeng1994@gmail.com>
References: <20240413153633.801759-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for ArmSoM Sige7 board

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033ade..fd644e32c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: ArmSoM Sige7 board
+        items:
+          - const: armsom,sige7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
-- 
2.34.1


