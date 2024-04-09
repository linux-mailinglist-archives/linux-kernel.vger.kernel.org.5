Return-Path: <linux-kernel+bounces-136822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B348789D8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C191C21F84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019912D1FE;
	Tue,  9 Apr 2024 12:00:34 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2212AADF;
	Tue,  9 Apr 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664033; cv=none; b=C0qbKNmdbIa6o7710Qq26k0Mohk+guHPZZqKcYUFysCts5NGJOGwlNGbuuXxciN9YVkWmuEUVsSDXASGKiMmnaSExjQ3SWZnwCNTe3HAHt/RLP5oosMTASRONDKAzv5tUe6jOqiD06Bvhe9UhcYATXXHhKSBRaw1WnZXfS9Oh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664033; c=relaxed/simple;
	bh=u6xesq7i29A5sx5UWXkwxPRhMjfvLiXda27tkq37/ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDFy/SoqyqeMjUEvzKcHZDapcJcIGDqj5J6FxS7IBCmBfiVIUsvY/RmSuayuMO9NQ2YwmOoJH1TKkQHC56bSSWpTrdV5C4xNNY0I5XeZB74OsnjtfllUPdAbVXiktgEDlVRyxPtf91gZG+PZnFX7GIG+3MjjPUZU2cMADl74fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:8f70:2795:b738:b1bf:b2bc])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0ED4D7E014B;
	Tue,  9 Apr 2024 20:00:09 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [v2 0/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Tue,  9 Apr 2024 20:00:02 +0800
Message-Id: <20240409120003.309358-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0JNVk9MSk9IGR5LTExJQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZFhoPEhUdFF
	lBWU9LSFVKSENMSEpVSktLVUtZBg++
X-HM-Tid: 0a8ec2bada4303a2kunm0ed4d7e014b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Dgw4CjMSCRkILhoRTB4w
	VgFPCh1VSlVKTEpJTU1PS0tCTEJKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZCAFZQUpJSUo3Bg++

Changes in v2:
  Add missing cells count.
  Increase spi max frequency to 104MHz.

