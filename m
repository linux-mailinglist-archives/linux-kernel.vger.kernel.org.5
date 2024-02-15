Return-Path: <linux-kernel+bounces-66736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1C8560DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD652858B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B112FF77;
	Thu, 15 Feb 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Ggu6prDg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0vnoD0W"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AE12A158;
	Thu, 15 Feb 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995079; cv=none; b=KNJbW03dPEfECW3LrGAxYouiEZ1chvxXEdCZ64EuCjfhBBat5LO6Y5lMzjyFMLtsxXoJD8JdYuQ+5VWPly1o2Tl3zi6RPuGC51xdK6Eq2ebzhlfbEzWWZZvL36vQSCXBp5eA7IBi8PN900oCKZaR4wIOuaJtSIXO9/ShMHNtQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995079; c=relaxed/simple;
	bh=LVxLZxKG9gE9dvsfBodYcWtQoBsqB02CeeYr1NhVDp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJsVe8Afr7YBqgZZA0KSn57Br2uHZBrwOsBZn9ic/WKhdfKvnY9Nu3Z+9qaA1B4f5175gpKGCKkNOWIok8NHlxW7Ph/3hxR0c7PfWor9saGgapmllBF6SqIpNihVdzzvsMvugAOkuH2Zf6npihLccv00YRBoJXQcz9uBSAS/8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=Ggu6prDg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0vnoD0W; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F28011400F7;
	Thu, 15 Feb 2024 06:04:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 06:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1707995076; x=1708081476; bh=orAhrN5tQs
	DXbvphAeqrgPill/y0dP9Y2EbQICt1uWo=; b=Ggu6prDg4x0ShAuxim68z5iUbD
	cr4CaiuOpZcs1TjNWdQHpznuKCoH3WT1VwkM3ef4goac+Fi1dr+rPACf8Bz+zugS
	VG+xT4FABA2HCfCCUZMi/LUev2ovqEhXXCBU3YmF8V9gnazo7FR7mQhsREqvWRWn
	dEm/1cQJxdq689LfOmMjPa6gExg3bBJYM+bE7K07iNKkwps9oagDOaJSwCbd9Hrl
	W4yusGNHg6XnIV3+Ad8MK9qEx1lLWlT0Ekuxj+huLmw0VLJsIYBc0m/1/KUgYigK
	O5KGD/m9kNIh7BXZ2nVh/G6SY8fUskqWzbzEHuso7M0PXoxUxIZufHEXY7zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707995076; x=1708081476; bh=orAhrN5tQsDXbvphAeqrgPill/y0
	dP9Y2EbQICt1uWo=; b=b0vnoD0WgyQMyv5jfXcEwD3TNBmS3HyTjeYoIzSd62FX
	bhgALGKTGr2qU22gfztZE5Z434L635Sr8PqNoRtxPQo2ut2WcReVRoUCmJEZVyEI
	Wq4S8SStCCE11VIfh70LxdEsagBp7lMlTK+MMXfN81nSory+LR2vl8epxG1Sd/YG
	ar5Cc2JpAq49ZhNN97VXYBq4WlwCvD/M7JAuONXFrrEk4imWIDLr1+m2osBWsUwH
	yHhrs0lL2JjA1raNEoiIM87F/mw4f6G1EpnrD9ka9DfHWYSin0K0K3FIiEFBlXTv
	nwqkPhivCnpu8DwnOM8c4umqnrtiZZjUFDGVlDVOVw==
X-ME-Sender: <xms:wu_NZXr-8RH-TLFNnrHYIF-Hw6QShUOmLJz63JnBZGdx26lCXlL9GQ>
    <xme:wu_NZRoSGbvCd0AjQw5eJrvEOAfxS1PzjbeJddRR6cKlDwqeWDTKhUXboMakmrQxM
    iG5Bb4ZKw>
X-ME-Received: <xmr:wu_NZUNpSGM2o7zhuGJNCIDRKScx4H_3EdN1hmjplPfOgcdj4Atdtg6cHWFG5E2bUyaz65p7mnk9VxKTjCM927wiNAPqS3NQ1rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfnuhhn
    nhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnhepud
    fhtdevueejjeejffeivefgtddugeefffevudfgteetheduveetheetgfeiiedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfhgvrg
    hthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:w-_NZa5vDr0NOxTJ61bEs2mVMddU34KSH1BDyPyhiOy_yjtyzq_iow>
    <xmx:w-_NZW6lJ4xNKTSLd5q9sJkmQwHDK6GPzIr41Zhx3oizPvmiCFKW9g>
    <xmx:w-_NZSjg0LHwppK0-sBYcc0nqo9FVFFrWocQw85Cs0TqJ6xURltJIA>
    <xmx:xO_NZfHXdhUHCCE2UE0H9_Q4Gp1W_PaKvzhDoFYYY-aEXp9RqX4ivw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:04:31 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Thu, 15 Feb 2024 22:04:27 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dts fixes for Sonoff iHost
Date: Thu, 15 Feb 2024 22:04:23 +1100
Message-Id: <20240215110425.934740-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of tweaks to the dts for Sonoff iHost.

Add aliases for sdio and sdmmc to ensure consistent ordering of devices
on boot.

Tweak sdio properties to improve detection of the rtl8723ds sdio wifi module.


Tim Lunn (2):
  ARM: dts: rockchip: mmc aliases for Sonoff iHost
  ARM: dts: rockchip: Wifi improvements for Sonoff iHost

 arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.40.1


