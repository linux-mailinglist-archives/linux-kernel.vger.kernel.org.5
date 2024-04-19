Return-Path: <linux-kernel+bounces-151325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC38AACF0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72845281AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D07EEF3;
	Fri, 19 Apr 2024 10:37:15 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D23537FC;
	Fri, 19 Apr 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523035; cv=none; b=ljn0BOBWEFQyeaCA/dZ7vt2uNBkv78wos9q3AIhkhDr/3eJ1n12Cb6YZ48cJ0xymt1C2cl9RW53ltLDIkkqiwvgxJSXWTmGXCPuIi0DkM62gdVkhoNvcLrK95Z/dCHQArtyGWLuBzeNSBxe+Z1EFbzJt33dYJn1BWXMZ4X0UqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523035; c=relaxed/simple;
	bh=uUzlRYYg0wBzoCsmrKnn7rE6m+C4E5F+sA4ybRUnFss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Blj80O2/E7vpPGtAXzS5btITuUZD0VkVUfRGMapcuVRBrbWozOWbfx50ZrgLfphC/82CBH0t3OBIDtOFgv0iTfv9yPQ35iMyTjNw2m/hIYDvtpu+0Z1gEnCGj4+9lJNga5ZMTgy2x9Sx156yTbNC16g3/tvbwbNnnCmehdx7k9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4860:bdbf:c4be:ec53:8f46])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 46CC27E0105;
	Fri, 19 Apr 2024 18:30:27 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/1] arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
Date: Fri, 19 Apr 2024 18:30:17 +0800
Message-Id: <20240419103019.992586-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUwdVh8fHU4fSB8aTRkfTlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0NNS0EZHxkdQRhPGR5BHhhOSEFDHU9NWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8ef5e853cb03a2kunm46cc27e0105
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6Mww5OjMRFU9IC0osPw43
	QgIKCU1VSlVKTEpITklJTUlMQkpPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0NNS0EZHxkdQRhPGR5BHhhOSEFDHU9NWVdZCAFZQUpJT0M3Bg++

Changes in v2:
  Collected Reviewed-by.
  Remove changes to compatible.

-- 
2.25.1


