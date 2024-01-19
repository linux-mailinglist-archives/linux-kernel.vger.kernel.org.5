Return-Path: <linux-kernel+bounces-31432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DB832E47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7291C20F54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C955E7C;
	Fri, 19 Jan 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="hx3KVGfZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD555E5D;
	Fri, 19 Jan 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685974; cv=none; b=QlN7KX6iuAJ2MA4J5Sr9EW+R4dsMsBvVef1i/XOFd4bfIqyMo00A+LTfUa1CN72DCs5HufJ79cKPqFuTeeUgkldzLi/d8KipIZpVIp3t38tHdaIU82ZcKjQyiZzcDL6+1vV96v0UIoyl+3o0YlwKx8+A1H0ml+ZeyzBxp9OEpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685974; c=relaxed/simple;
	bh=UUvE4MgwQfEdxGu3tH7PSVyIoWC3rveCc2i3+sxHqRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGZYrdmi5z8ba2yXEtDHMnm+OYic3BtQ68FN4FIoGfNvBNEYBcR6j6isJNKu3qlLQX7uyj86pAdwErisAIHXc+Hx/MxRL/ik4C1jVUCUTAe6ukVP1EOdGU5s5KM9mM/qFntOsZHDQd2uh5WIezltRbLvTTeGDCtEVCDEhlz/l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=hx3KVGfZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705685957; x=1706290757; i=erick.archer@gmx.com;
	bh=UUvE4MgwQfEdxGu3tH7PSVyIoWC3rveCc2i3+sxHqRU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=hx3KVGfZY1MqGYHNWrRtaEmqNpGAJb2lJWyzF52ijpcCtmtyFEyTgl++/OBjXH4k
	 46TfWCupG0/p+LEl+x1L0Rh4XJEV+85cl24dcjYLSvrPfO30b73DKVdf17Io3yKGg
	 GDS/3v2hbRfU03W1Ssate3nBTj45kgehVXm2i/kM50GX0TblU5c8OQBznZOdFQZ99
	 OoLyBTZ9qj/gsbiHLs0rf+R2qba8Qb35cazxbGchv6dqIaN4O+itLv6m8FkKDGNxQ
	 UzdxADolXP+hrUb8ZwihsSVXaw47+OZb65rSrLZVp1mMioAgrSrpBh4CkHFG2vCRU
	 6qhaIOcHzzI2a6ZcGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MWzk3-1rcBMy17tJ-00XHib; Fri, 19 Jan 2024 18:39:17 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Use kcalloc() instead of kzalloc()
Date: Fri, 19 Jan 2024 18:39:00 +0100
Message-Id: <20240119173900.11035-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wxZhQM2riaMzXVUch/UHOHGALDeJM8Or7IL3LT5X0g14z3UhlKs
 NG9HarUz8N15YVnVmVm1EghoZc+X1snm00Av9Lr6ru83GxZxOEh+rlO9hF9+qZVjrpTB74h
 JHOW7RkMB+0zrtOjVThHD+XM6FmbpvtH78WJh9i84pLIYCza1i8OCeG4hU5i5W82RjywC2g
 PFiFCzHOZffx5Rqj8e3sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zdYhetBxIF8=;RhAHn+3ji1UPG7DZxHdTUJDXCzh
 YyXaHAnALTH8GU2RufWgaYtiiRGRZC4Ijkw667x/1IHWa79O5GiqDUigl49atNvzw1boyMl9H
 X/rWzZ49LASvMMW+58A3b25b+BSrGDziuxYLKzcASXGs3dWdLimmXfJqYzlsbCamVMpgzGpjh
 aI3/MDOm9WDHfHJxsdkb3MqxISYQUifeg3Xn6Hyvav9Tw/Z+52rCUFgFtP1VQLHwfFdV3Q8Oh
 44iNsz/wYgnmWZK3gB1mNwd9e2Thicey00wQZydBc21SS12cDDQBlYRDJpH8cToNQEO2hbAcD
 dwJCHjG5/hGLDnXALn1MDDQGFzlw9jnJ1v5n/VyT4qFmhFUfXufx5DNWFzi0yuqtCJ9MoSTDz
 XX0R2owi+zZgLBpmArohGiRx2ia+GbDFk42kwpQ1mu6tb04NXV2yPKupzEyjEDKjT9qhDfsTL
 tOgV9yxL9yLD1TVFg49BD6RR4AM40/BkK78vgR7DdC/egqMnpFMjXTwGV9YWTUSIuP3QRmIpr
 sJGwKsZXDAZeLYbVYNa/djUF8BzRZp42MTEN4MIrAd34WdVkff/nhsFplQafK+gtuunTOoEM3
 cpG64sBcuY9MzqePR0J9OMqjAV99tUW7LBIl7y7gpXnBO5XrEVpqnv046Al3V+ATikBMjLsqc
 /MM3rYG39vkeZk07cfD7iFltZHNuuicixXTXCge4yw0znd5IMk4/JXTgZ1gtalu70TyBIGYsj
 TW1LDhYaGfEGs1m7tgtAODnIASX1rDAqVwTdUPaZpdzLiOFofZxfRqee21dK8jEcX0NViJ4Dw
 Ep37Go6hB+cZt2xeQSZib07jMGI2TMIaM20//VW3dhhbH+7qc897zMyUoXLQtZnSAL3+7GBcK
 WHFxaNBroRuabyEBKVhHQduD76OhvnodlwrHNGYiZMGM352rDLRowoPwryhc7Ns49JcMO7L6w
 AJRa0J00dsBla/3OhpAJNyxnKc0=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
count * size in the kzalloc() function.

Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not change the
former (unlike the latter).

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/s=
taging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ff763c10064..65a450fcdce7 100644
=2D-- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1259,8 +1259,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		goto check_need_indicate_scan_done;
 	}

-	ssid =3D kzalloc(RTW_SSID_SCAN_AMOUNT * sizeof(struct ndis_802_11_ssid),
-		       GFP_KERNEL);
+	ssid =3D kcalloc(RTW_SSID_SCAN_AMOUNT, sizeof(*ssid), GFP_KERNEL);
 	if (!ssid) {
 		ret =3D -ENOMEM;
 		goto check_need_indicate_scan_done;
=2D-
2.25.1


