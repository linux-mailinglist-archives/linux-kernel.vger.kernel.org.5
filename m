Return-Path: <linux-kernel+bounces-94686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8708874387
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CF1F24F49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8F1C6B9;
	Wed,  6 Mar 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/P+eTMf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAF1C686;
	Wed,  6 Mar 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766679; cv=none; b=mbZely/bmyoFXispRtFFeaLl4rYXMeO03jOZH71vXIY8I2AKXo1fX+ue5ztmyIXGZJsrNgiV8bQU+OB0tWx2ypDVuNlgL0PIP09DCeQi+AQGpzXYiDQlY4Tpow+marHyE+8X84ujPTV/oCInk23oqyq8F1UH91qtlG8fblxMKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766679; c=relaxed/simple;
	bh=EBrriInW3JbtArIhXHglPAvOuHM/fEGrMu3uHu2Klgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZY+oTLAutHVQo+2zuXHv4YY19NDonCZCkuriG+1lIM4K0YmW4CU5fJGitv8HdzUeBubRAnCsGjiPLaxG6GuxotF89NdAoNT7qqlRJBPSxoDhopk/FQboIfiWO7UHsNrFeYM/KtnTt3uAulB7EOwYljmBuciQVlbs1z9SGc7pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/P+eTMf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412f692be21so2789455e9.2;
        Wed, 06 Mar 2024 15:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766676; x=1710371476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ed13jYHQ8Lp5ithwU/UjoL1/F5W01I7K/zlGRfPgDr8=;
        b=V/P+eTMfv1nELp+12dSu++7ka00Ht3HBcxQtBanqGFvx1Pblu/hsHaKHoPpYSUBzSZ
         stPIlkgidx01+6Ke4/djt0kg7IzmWY1oh4HFjtWA6qqTKHV8QQOGss1mFdDcTwtw5nmi
         07PT47nv3onGPHi/v7+Gt70fu84WBwTDXNyRR4SqmideQeIA1MfmpTpFp4WRWqG1NQ6q
         jhNP1eWOhOg8DoxBXCeaTLPdLO7iWJTuUvT+G8NUxOr8V98KSJ7pGEJZJncy6/e8KbYO
         uE9IYxgFtCtnAyD+xvvpNjR4h8dzNPtXqVf1DXiE/Je/T4L534MmWRGHd/Bb+U5ox7+T
         tIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766676; x=1710371476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ed13jYHQ8Lp5ithwU/UjoL1/F5W01I7K/zlGRfPgDr8=;
        b=VHKYsAUTyrl0pSy4K0Pwd1DriVmZGRwM4bli+mL8Fu6DFh7iEbqVQyxSrIc4G0HKnq
         K4aCifH3gLnwzsRkLxaeQdbIM2aRHLu//HJesR+yv1aY9pXIBJwi84DFNiDurst56L2u
         K8117ncgzaVp1FiUhJgynv9kXhmXfg3Z1MnTpukEMr4zI4ib7e9fp4VH6/ReilQVDAA9
         Dv5LfJJYx7zh2DUyoPU7UEYyPuosebbAUZwzfHGBljGYxpt4qQChpffhTdDWfEYO8j8L
         yh4cBZIrzRs5uDLAroNDdiYryzC15fzh/geLFM6MgAHhhypOIX+Qe++shogW1IJpbk12
         Crew==
X-Forwarded-Encrypted: i=1; AJvYcCW5YskdAz8rqlzYbBf2cvqjs4yA+aR5hy60B0eXTZg0H5ndclrVdNgzj5TnA5HlaDE2QIYlny+8dSnTmGDJlW4eQqvEi0tejGpqQmAv3NbG52DGTwhj6an5gYdGdEpb+6Jh8MMhJD/jqx39aZHXfGfiiNw/ZNA3d701wE97O99/HrIv234JTeC9vTgy
X-Gm-Message-State: AOJu0YwMCBl8HZhwkUcMK0EztiT8oFosGwrQNpBSFtDDG76xsng1p2fm
	sM5Ds1dXzrjohrf6yqkEN7mxLt6EiAGz3nZMhW8mrmQ126iE7zHV
X-Google-Smtp-Source: AGHT+IHTudt7kiYcNJSDPSJ98mAV2G/a5wBaZS03otEV7K9fUUgCt4uLpoJnm459eeVLI8D38BP8TQ==
X-Received: by 2002:a05:600c:cc5:b0:412:df1b:4875 with SMTP id fk5-20020a05600c0cc500b00412df1b4875mr8149679wmb.30.1709766675506;
        Wed, 06 Mar 2024 15:11:15 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0033d2ae84fafsm15328996wrx.52.2024.03.06.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:11:14 -0800 (PST)
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
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Wed,  6 Mar 2024 23:10:05 +0000
Message-Id: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series updates renesas,scif.yaml to validate the 'interrupts'
and 'interrupt-names' properties for every supported SoC.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'

 .../bindings/serial/renesas,scif.yaml         | 147 ++++++++++++------
 1 file changed, 100 insertions(+), 47 deletions(-)

-- 
2.34.1


