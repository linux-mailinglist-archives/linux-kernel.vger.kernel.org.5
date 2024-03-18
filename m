Return-Path: <linux-kernel+bounces-106437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D715587EEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB78B20522
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763435576B;
	Mon, 18 Mar 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqGwnGwT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96055777;
	Mon, 18 Mar 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782554; cv=none; b=t6yGpOM7g0h9/H7n2o7+QIRdatYjMCUi8ycXhed2Ek/zUF2tQ7Bzl6RJblEaXSXgCSttZ6enFhR6ucqJw3pFSl7PG5LWv/mFLANV9AGpSfYPxVyG6yu3KB2d0h1dVdAyYriZUk9SFytlbM1OoEXCvj6K+j5+qJ2z9MML1oud5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782554; c=relaxed/simple;
	bh=bqogYihsT2MUMkgJT/9f7+odx5Q5POVudeXLuCfRTCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOLtk39GvNZqgHoWKos13ChpO7wd4WcMrpr25mcl1S+TR/XYEX0h5dW2BwB9anvGb8NaHsnG6lemypiuPfZK4sfzc8ylQY8bwSmILYlIVdzJcdzkTMPo9Dc0PFe7swqtKIOFDXpW55yNRMbIjE+p/dO3UFQsnumonyctdiHq6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqGwnGwT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so2516251f8f.1;
        Mon, 18 Mar 2024 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782551; x=1711387351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBFejtHMX0UPJ3eW4z9/yufOKHm5p6BhqExLw0G3pDY=;
        b=nqGwnGwT0dMWClmYSRMxaAh0MoMrRk3VFtn5fSwBJ+YSd1CCIQSfCuF/4tVeQyuGdp
         ONir6PwAr3ekFzYHwC6AB028mi47cdG9BWe8tUeBdsO0vtaS3asr1O7aGWWuTZ/jlphh
         j8gFMM/kNvL4hXFeePzGUN541SoXSyc7CLvz+rtlDaAacUqFjrnCScrKUHG7qTNkmVQS
         lBkGCFBd5DFP1vJjAPd851uZzyhMj7eNsRySxt1x9GAfxtmFBRhDJsWktwZx5pxXhvnf
         ewf7Un3HIAXWqJWPZ3hIj125apEjs8CAJkWaW+arI7SLABTlNdBv6QvWoOoHHxNOE0IG
         2ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782551; x=1711387351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBFejtHMX0UPJ3eW4z9/yufOKHm5p6BhqExLw0G3pDY=;
        b=vEBnZpJSlKennafZXUlH3r9KagvbcuG9LDeptW2D5gYZZjMuytTIFtluahv8pMpKVI
         LU9V132miHQpAvFNrifdX3GkXlzMsMlHdweW36cSXY9qzznoGnbtj/iRGlVl1enhr4LO
         d4nq+eDNQvMm5HzxT3/m+7AKg7jCojwvTq6k7HS/9JgjPR6csXAEf2rdjxIXFFI3QrBp
         kNIys/zMonMOieeMEojvVH6Fy0fThzpBsLiwT9yPseNuCWVmgkYUvTIKmHvQiubZYWP5
         6D76YG9FL8Y3oPGPKMmGRSuU3FY9wBXHH7AqtVMqpHJWv0n4UZrsMZGrHp5K/j0npx6a
         Up9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoqk0BvEt6Q9DNEqPEHUBwjkQudz4M1XsoOwcejTvknCPVosVOvBH8cvRLW0gk79Oj9ySZxNmSSQzeQO4yNjYnWLMBjysnOq0D8ZHiqbsSa+68Yxw+FWOPDeS1Zg8LTrmBsSaJmh6KNtoSo4UxMQVo8K/rkfN/0aqBUkUraCRxNb8Yd23Z86u0fBKu
X-Gm-Message-State: AOJu0YxDYO7S++5OpKAO2gYtC8ypWFeFVpmJbr/wPdMDvX/VIAUUpTHs
	uxK1FYjqMsUcS7AkCis58tu/taT7vw4TvSlQY0zaeoASNznnAzdD
X-Google-Smtp-Source: AGHT+IEa3GE8ywRJSL+LQikpBiv5zAhF8ifisyDLX5kfpe/JdCvQyW7dEjvtdPbCQ30aB2It0RJ3IA==
X-Received: by 2002:adf:e00c:0:b0:33f:8e6d:ab6f with SMTP id s12-20020adfe00c000000b0033f8e6dab6fmr37473wrh.62.1710782551189;
        Mon, 18 Mar 2024 10:22:31 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0034180898569sm1140769wrb.72.2024.03.18.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:22:30 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Add SCIF support for Renesas RZ/V2H(P) SoC
Date: Mon, 18 Mar 2024 17:20:58 +0000
Message-Id: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series updates DT binding doc and scif driver to add support
for the Renesas RZ/V2H(P) SoC. RZ/V2H(P) SoC supports one channel SCIF
interface.

v2->v3
- Included DT validation patches
- Added a new compat string for RZ/V2H(P) SoC
- Added driver changes for RZ/V2H(P) SoC
- Listed interrupts and interrupt-names for every SoC in if check

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'
  dt-bindings: serial: renesas,scif: Document R9A09G057 support
  serial: sh-sci: Add support for RZ/V2H(P) SoC

 .../bindings/serial/renesas,scif.yaml         | 158 ++++++++++++------
 drivers/tty/serial/sh-sci.c                   |   7 +-
 2 files changed, 117 insertions(+), 48 deletions(-)

-- 
2.34.1


