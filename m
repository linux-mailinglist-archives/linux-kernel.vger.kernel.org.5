Return-Path: <linux-kernel+bounces-85433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD586B5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092721F27AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08115CD5D;
	Wed, 28 Feb 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK1D2lJ7"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28003FBB2;
	Wed, 28 Feb 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141100; cv=none; b=mVNYYJS3UMuZvca6IQvkJk1c4p44nsPW/8ZzEbLRWzSLiiHdTQ90jJc4AugiUGAlMupiPLGbhrCnsKsJ3Dl0zV/VvA4clefFE/6RUJEUY8bOFSL+AkLvFEyUJ2+rkYAR/PxaoqhpunwfjNHeEFRbqRbUJyLuHD8J8pEyu8I7ND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141100; c=relaxed/simple;
	bh=ibbZtSAB3p6iITdVB1SXa0cy+XZ4vhhCy3WP18PyyD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7gzYO3+uFJwEkTRZ35mBTB/F7QzDeHBIZx/AC4EQ68NTsB93e2C7RRhXKF+TGSHC4duVgo/StOwymOJ1OT0sHgXvdpi4yZ9MLHENlIO2sfgqEn4vThIzXyEqeld7ViQPUl6N+fz7gPpNZZuKy2M7LhTydkKNYQKpvToIs2VAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK1D2lJ7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso27494a12.2;
        Wed, 28 Feb 2024 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141097; x=1709745897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggUWzI97AER97VCO5bK1ghUrgDw3VtB950on0vUkKY4=;
        b=MK1D2lJ7BIkx9icBccLLDChbA7H1+8PayXlzXLK9b6z7z5RlI5vSMVBIQigF0Je6Ia
         jrFTLN6Pwm5pPJPHyG3kB57C7S+eTPwpp2TJPWMrvFdE3sMAoUS4vCxBCJmS5QfN15Zd
         1LzVYHU3teMPTatGrPV9qu4qHqYb+rDpPgZptlGN6spDkN1TsTt1n81+sQaU+ueTD/aO
         GPFlAyfT0qgThRBqQvowiAV71XEDT2AlxkztFXpiU8k+5MOrOz4G37V1T9mnEsMBuFMl
         FktxM5UW5OhlZfm3nQX78mDO1EVlTptexQn+5gx6hzlsX/m2DZDgpH0g0rzVgjdfC8BG
         4qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141097; x=1709745897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggUWzI97AER97VCO5bK1ghUrgDw3VtB950on0vUkKY4=;
        b=WD1tQ3bLE5OxR3B/lvy5qRMc5fxKCFSE2TTBRk5/80F0JMHFoMrUFUiezLI/VgXXv3
         tT4N5MQj6mp+hKqvP0osxTIUEIxhLC1pnTuPVQcdPdDje0h/EyDbpLaXsP9qMqR/4JD8
         AXA2xv2jc/dEJzbn2rQbu8GCVrmswTARMORdXzpI5cvVt0yAc+2O+fmHYagFd1CRekiM
         5EJxdS57fm1YmVtmrrmmhos81HU+cyM4Kmrhs7kgl0KEp+9RXKuzE7MlfU90D9AdqErE
         622vyaPE3d3L1Ldky3eJIF4Qwcvw0NJsnMmf6DDXRSdnPZiZU5V82CgnbPbvRdsnP3Hg
         rFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVz+JSeFv8BGerlPToBUbD42Nbk7eo9IYqnECr+dSP6TYrxP33u5Oq+9Drgp93XWizBjohOq7a+hwS6lp7RhWT0bGUQLcENGCQudQYdoN0c3X75edfskIRY5yHLew8Lfqq2LElU/1GhIs+7AU6fQsaOcqv3evthSdfX1fBLw0ke+TylpA==
X-Gm-Message-State: AOJu0YwsckSgFdrV8hOekII4Bq2hJx9ZOC/XSMxgQ/ryalDSDVZ7leqI
	da4CTqYNq0lr2niHnjs1LjeP1F1CPt3puNxkDq9gkoSftchxexQs
X-Google-Smtp-Source: AGHT+IHRtV+73O8/64MXV5GC0Imj4BFKa58Y2BDfVVmT6K5FnbrF6s0WW1PyaDtDiMh8WcLBxqZWzg==
X-Received: by 2002:a17:906:454:b0:a3d:994a:791d with SMTP id e20-20020a170906045400b00a3d994a791dmr193000eja.59.1709141096969;
        Wed, 28 Feb 2024 09:24:56 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm926910ejc.103.2024.02.28.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:24:55 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: qcom: qca808x: fill in possible_interfaces
Date: Wed, 28 Feb 2024 18:24:08 +0100
Message-ID: <20240228172452.2456842-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QCA808x does not currently fill in the possible_interfaces.

This leads to Phylink not being aware that it supports 2500Base-X as well
so in cases where it is connected to a DSA switch like MV88E6393 it will
limit that port to phy-mode set in the DTS.

That means that if SGMII is used you are limited to 1G only while if
2500Base-X was set you are limited to 2.5G only.

Populating the possible_interfaces fixes this.

Changes in v2:
* Get rid of the if/else by Russels suggestion in the helper

Robert Marko (2):
  net: phy: qcom: qca808x: add helper for checking for 1G only model
  net: phy: qcom: qca808x: fill in possible_interfaces

 drivers/net/phy/qcom/qca808x.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

-- 
2.44.0


