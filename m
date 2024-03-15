Return-Path: <linux-kernel+bounces-104833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D40C87D450
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6831C22399
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077250A7E;
	Fri, 15 Mar 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RKeEk8Q9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAF51005;
	Fri, 15 Mar 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529465; cv=none; b=FMqWsnQJOKSgGR0AJkKbms4PXFfYfAZJp00K5gPDZ1paiGdMTBzROadUZ82zsCt3ina/AiyCQ/WYZKY4fyegxPrzNlXep5zQgmzP7KmtvGUthAzA/AaoCLnVhH+8aJuqtZmqiPQHap3G0ymHlgKdmlEaGPAQ04tmcieXEW17Zbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529465; c=relaxed/simple;
	bh=H2G1mNojwriAzl/RkRYzjyygSjD5gvvRSE4O9fzPGLg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sRTCgQUrL3Zp/7GB/W+A1+/1bY5Sixgx/JmYAJgr24aBzkSN2p8dJ+/uozWPNDwGBg++dNZmP9huTNSUmLhDdvHJzd3jgvUw+yg/GjBnL+de9u5mDrZXcOPw6FUBLoy0mioYGi3AheDPVDCnlmeWK6ZZff/u086uWFv9GVWrpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RKeEk8Q9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710529453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QeVTt7EEVUu2Ft0Iu4mZyhzwsN4UDGTEp8s8bgI6eg=;
	b=RKeEk8Q9e0N+4Vg6+DMe4lGtWMuHetNupWAEWrPFY4DT39ESUMcJnG06KeHUCIo9aiz+Vv
	Lbj7zoZg067upCQsuWGf8gfD9I2AADS090Gk6sgH9yWXcDcgokA6wstStnP8uCpLtKBkWj
	/tdC8PIx5ZXsCANqxL9G35MaDuLvhxdIQG9POLYUG17c5ORxXDHN6MPCPLEhljm7FdjZhD
	Ud9EiXHqF+aTlKPVnis72eqiVsBVh4LPPdhpRcVQcaLaSOsuks8Hz0C6SjJzkL4YpcXGFQ
	eIoPRufPoXUe7g0RNZccV1G+RHniso19OSYthlQ9ITUac4Smh0mQPCKUd90RsQ==
Date: Fri, 15 Mar 2024 20:04:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lorenz Brun
 <lorenz@brun.one>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add &gmac2phy in rk3328-rock64
In-Reply-To: <PN3PR01MB10135290B74FD411720E431989A282@PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM>
References: <20240315084018.2200581-1-himanshu.bhavani@siliconsignals.io>
 <96a53f8560b3563328eaf7b9d6f63d87@manjaro.org>
 <PN3PR01MB10135290B74FD411720E431989A282@PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <0f674cf37d01e1a6651068b0402e766c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-15 16:02, Himanshu Bhavani wrote:
>> Unfortunately, this isn't an acceptable change to the Rock64 dts file.
>> Yes, there's the second built-in Ethernet interface in the RK3328 SoC,
>> but the Rock64 layout doesn't expose it as a separate physical network
>> interface, i.e. it isn't available as a port.
> 
> I was wondering if the Rock64 lacks a port.
> According to this link: https://pine64.org/devices/rock64/,
> it seems that there is a physical network interface available on the 
> sbc.

As I already described in my previous response, there's another Ethernet
interface in the RK3328 SoC, which the Rock64 is based on, but there's 
no
second Ethernet port on the actual printed circuit board.  That's simply
how the Rock64 was designed and manufactured.

>> Such a change would be fine to be applied to the dts by hand, by 
>> someone
>> who actually adds a second physical network port to their Rock64.

