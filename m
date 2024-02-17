Return-Path: <linux-kernel+bounces-70082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93E8592E1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271EC284616
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2747F7D4;
	Sat, 17 Feb 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2k+wvx4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CA1E880
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204410; cv=none; b=hYW6+JgkZV/uUj4abaN8QL2PcCebDJ1/AnNrK9aY1WJghQ0FChddVoZwsmqQ4ag4lm1kcqx7tX5Emwcy4lKoHDdGJU5NYFIkHmVK81t7/TII7krNbu2V6Cdu3lmjurLLZcmtZr22Ma+yK7RLpJpHIQBngEG1wGHyAKzvlqLNkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204410; c=relaxed/simple;
	bh=fgLVkE2GXqizLVWyGzhJrb1Y0u81C/+bGZCwGZyhqjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=onF7BKT4agOC1Ml6aghCLJ28gSrexRv4WDMKDUVj2HmDScl5gaAxqwGW6WEPgnxJeW3hfiMEpi1salRCBdYSE4t3Pf3HJoX86Ta0KPhmv/vHJGUaNz04V75XyYLJ/qQNFULNpmcEUq2uOD3hvTjTJG0igt9GiKPcfsinyD8dkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2k+wvx4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d090c83d45so41384921fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204407; x=1708809207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5KrHvRvX5NmJw1iIyLeL4nKWoIo2Stg2o/a0niAbAg=;
        b=f2k+wvx4xY0TwEw//fK87x5gsM6M7iHkscY+52WN/RS+epTrTyXqHcBwXSM1+AyDhM
         sP5et2NbzNadLjd8zn6J7tgxt3qjIoWUK9c28YYAWGLwgNPch24vz0taGsGnHhr7jS5X
         4FUTzSaMa54D4N+kniPNwQAyEGn95aHZxLzC393PQiglyIk7+AlrtM5ohWIIzS1PJ4Im
         lqCvsvR1zwi5gKgBHdvLxLz/Hc+kD7phsgj19P2luIEf1SIIF0KAWuW/zt097TVYEtwW
         WPCAW6mbELyhlEsRi3cTCw9W/eC3/9xyaXFiKxylR6UfB6FFhyCxYJDZysBLD9wmjOe9
         9Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204407; x=1708809207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5KrHvRvX5NmJw1iIyLeL4nKWoIo2Stg2o/a0niAbAg=;
        b=QDSBxOglN4Y14BsRcbXLDwuix8toxn1Bo+aXLSF+g88u1zVtr+i7JPr3f378AfTHs1
         rLGXdMkDUhoWnULy0pOdupfxpDkWoA7yqM/FC+SZCq5gU4GUqrt7Q4GWeDEPsIbJy5C8
         HuFp1ApFR1cw+kvg+feCoTwyib17m5LcP4P8qw6AyDzLDahnC66FuX8z5sf8MNSqv857
         pr8dqNgC0pOIboVE3hjRLhF9nJuMd8Mvq0elct3mKDRcLCx1sM5ryq0O6YjPhDyXQ98T
         40aLIzYUnaMbYKBMbnKfWstxvNmhOxA8zuh1IieV98poiHoCE3h6P7ZX65jaOLmSBFZT
         jjxA==
X-Forwarded-Encrypted: i=1; AJvYcCUOf4UXiLO3KO111IE2QGE46GsUot/htSQhaShqbJeXoCIMTwjgVG7nHLfKQCwv9AH1wAb5nRl/oKRMYXRoXX5+IDDbEw9p/BrUNC4v
X-Gm-Message-State: AOJu0YzrkW3e9OExXrwAh/dtbn9q0KsGc4vAGTzXeO93QKu3iOdF5qmG
	iuuOqD9kTYhiFMh2b0Ok27rZaVa0WzWdSg2AqaVzti7lnngbMTwR
X-Google-Smtp-Source: AGHT+IGQW9t/Ign8tuIdpWBDnnpeicJVQEPwtk4gbl2C1sFXpO2TkTRg31490oUWRseCPX4oZ40PGA==
X-Received: by 2002:a2e:2c19:0:b0:2d0:ce72:570b with SMTP id s25-20020a2e2c19000000b002d0ce72570bmr5227109ljs.48.1708204406518;
        Sat, 17 Feb 2024 13:13:26 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:26 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 0/8] Staging: vc04_services: bcm2835-camera: Fix code style checks
Date: Sat, 17 Feb 2024 22:12:38 +0100
Message-Id: <20240217211246.28882-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resubmit these patches to fix multiple code style checks for better readability, consistency, and to address errors indicated by Gregs patch bot

Moritz C. Weber (8):
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix blank line style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check

 .../bcm2835-camera/bcm2835-camera.c           | 61 +++++++++----------
 1 file changed, 28 insertions(+), 33 deletions(-)

-- 
2.30.2


