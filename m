Return-Path: <linux-kernel+bounces-29012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145058306DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262BC1C24536
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926F1F5F3;
	Wed, 17 Jan 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BRaVVMb8"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDC1EB37
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497513; cv=none; b=ZugxZagycs/ORpSsYcfhXxJps1KmAE7kjOwXSf8vjsmd/v6gYGBiXAGo5rkh1ahl+3kiQzgHJLoaWPFOeVqncfk4hOxeitLaLnB9Rs2zjghoCtQaNcE18kRqkdwCt7P0xOpeGdxoIo+RtJGgEv1Xk9ssMDnSu9mcix11DsPy1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497513; c=relaxed/simple;
	bh=VRbUn2kwlJHScFcg9cybX+heoKEbz8MvlzYOFtqqSbw=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=FaXTvQV5pJGx8HHIiHqR9gaAvwV1fGiiRmwbYMkenLQzk+ikbE5RiNmMhNxbSeCarA7XN+El0Dx8BeWETp2NlrpIFIIKzsfEmj6OENmdG2vWgGXfRSuqyYlQGTAKM8VpQB5sBEc54JZCT5hJucrvejTq862oO38XLUoOc3DflHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BRaVVMb8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=P+ka5e/ApWfpXi
	TpFT175X3zjIXXrZ2y+vntVR5PtKg=; b=BRaVVMb88P6BozbG10zXOnYXgs7ZG1
	t9JXR8o3RvijMTF79nghqWMyXJQTqBwAsWUh1wZujaxvjn3J8W3HFk9hJuCAK99F
	BJlzjqZpPBZTr7nwo0/FGtC9wmvm7fpDqSoIWm2kV4rCUO5WH/UvfQRpEOUlOWBw
	hwRI7mrIA5wCfp3icHkW3tDu8vpfPnu01M5dGtHArJCnp54hMvTGoEqCmP+wxvhw
	U3xXU8TTmhpLNZ9bsbze61QyUV2iI9gKp5hvbtcpdrMWOVn6T94N9hNT/6kto4Bm
	/+dY+0NIOcUNfNRIr81bZtEN5tE7w+/gr105akDoo5KB8DIh4Ox8SBng==
Received: (qmail 2754576 invoked from network); 17 Jan 2024 14:18:20 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 14:18:20 +0100
X-UD-Smtp-Session: l3s3148p1@bymoFCQPzKpehhtJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/2] arm64: dts: renesas: ulcb-kf: add GNSS support
Date: Wed, 17 Jan 2024 14:18:05 +0100
Message-Id: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been a while. But now the driver changes for GNSS are upstream,
so we can add support to the KingFisher board. First clean up the 3.3V
regulators as suggested by Geert, then add the node. Further comments in
the individual patches.


Wolfram Sang (2):
  arm64: dts: renesas: ulcb-kf: drop duplicate 3.3v regulators
  arm64: dts: renesas: ulcb-kf: add node for GNSS

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 42 ++++++++----------------
 1 file changed, 14 insertions(+), 28 deletions(-)

-- 
2.39.2


