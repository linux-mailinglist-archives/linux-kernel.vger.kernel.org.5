Return-Path: <linux-kernel+bounces-136208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F0489D125
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2380285E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4F55E45;
	Tue,  9 Apr 2024 03:36:07 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86E2572;
	Tue,  9 Apr 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633766; cv=none; b=V/jwDGA47MJCqMuogQ2Rfw45xLgly9gw3I/Qfuh1lR4ATimKRB2TUElV0ee5o3kSAiOMKJ3KVcMs7aIxwSAUijcPaVecQrTQpLgaDPJniCzHNSGGOIppkoLTt11hM7wdfsnddEg6lxdv13ng6Y0s3PQpZehov5dRByNq7Bz69eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633766; c=relaxed/simple;
	bh=kpXcVusQB3TZwqAjX49PyCnBLbhQ4biBz2tJMGSOtto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZDWTquI6IAe9tw2n0oXsypf9+lkRQwn5nxWE49uIpnJoZyO5mFqTcQW6nRWQ+w9tCl1Nebw2w5V9ecAmngtyyn28ZQqnjKVF5UHzQS3lEHR5kBZ9hpvBhnrfn/W1qeXATbOmaehDdhe2hMgg6Uivro1URIaWtgRGCk9BIHJWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:8f70:2795:b738:b1bf:b2bc])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 304D97E0129;
	Tue,  9 Apr 2024 11:28:09 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Tue,  9 Apr 2024 11:28:05 +0800
Message-Id: <20240409032805.19682-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fb57172e-2517-498c-9412-76f62929d24a@kwiboo.se>
References: <fb57172e-2517-498c-9412-76f62929d24a@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUMaVh9JQxhJQ0wZHUhKTlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZFhoPEhUdFF
	lBWU9LSFVKSktDSEhVSktLVUtZBg++
X-HM-Tid: 0a8ec0e61adb03a2kunm304d97e0129
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46UTo6PzMISiEJPBQUTSNP
	Kw4KCTFVSlVKTEpJTUhISUNCQ0NLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBQx1MS0FJTEJOQRlMSENBGUoZHUEZSRkYWVdZCAFZQUpOSEM3Bg++

> I think the on-board spi nor flash support 104/108/133 mhz
> so 50 mhz is wrong in any case.

Thanks, I tested 104MHz on linux and it works fine. As for
133 MHz, only MX25U12835FZNI-08G supports it. And I didn't
find it support 108MHz in the datasheet of MX25U12835F.

Thanks,
Chukun

