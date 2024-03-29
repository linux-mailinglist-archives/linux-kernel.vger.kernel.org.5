Return-Path: <linux-kernel+bounces-124358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41E891631
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE7B1C23D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172645962;
	Fri, 29 Mar 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="eULRZUXM"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD92D622
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705230; cv=none; b=uAn2YXmT0DbmOUvOGEQj/pw+4HUgeVWcUHaK4WmO/NjXqEjn4F6wD7pj5bshU2rd6vLCxZrXHsGrOjDUA4WX2wIc/oWG8UNTgVmDeApG+GVJgaiDIETERDsDI9XBPL3g7+luyMZ5+6v5Zr6AOUxk0GsotzvjIvO00ukqRSq5W7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705230; c=relaxed/simple;
	bh=IlTVpUHVnbFvNddzhPvo8GZp772CDt/oDefqMRPIkU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrk4ICm8IWOsjtg4XpbBir5fHpub7tIsNc/2ZAS9E81nVzIjcMXJKGpQOhPCH03iU8Xf/0MGXu10KBNnzW59GljnPu3BX6YyEU1UqYC//B5JeK9vX98ee3Sf2cyJDGjjqut7nQGCqRezywk8AkBo0muVDtX/gjVj+E/yD8PvIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=eULRZUXM; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id pglCrcLYkPM1hq8ijrD9AO; Fri, 29 Mar 2024 09:40:22 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id q8igr0U7IYakKq8ihr3wQm; Fri, 29 Mar 2024 09:40:20 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=66068c84
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8
 a=CkiI2OoxxAuuNGj3sd8A:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kULNzBIMUoeRMVOdp6S7pdnsbj6mCT91q7TkSpxtW7A=; b=eULRZUXMIiGeI5Ei5c3ID1tga0
	JNMrbsAGbwKaegMaZQCvwmDytzpJ1DomZq5QU/WMFbAzqVop2rSHr06kVigqgv3b270TuK8F0Zjhf
	Dhxcp67b4qt3rUqACq71Gt4gkeBO4Hz/JH1L6HSnU0+quXXQ5NuCFtDxhaG6GX6RA6OxcCJ7ryCQm
	Va7yEmRjy889FMWcNImUjFyYbRmmJMo7ZjBo3n/vi05a6RzTn3coOUL737UaL9K8jilL9OK5ndL33
	HsB4DSagFlSpSs3+b+NsSM7MHsKlO6j6q+TwkS528pdx1l+cR6zbwDANqFP7P+H5/TnXiQB45ZDe4
	TlW2Mg8w==;
Received: from [122.165.245.213] (port=58934 helo=[192.168.1.4])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1rq8ib-004Dis-2W;
	Fri, 29 Mar 2024 15:10:13 +0530
Message-ID: <454e1850-87e3-44ac-aa90-03d628a97f1a@linumiz.com>
Date: Fri, 29 Mar 2024 15:10:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull: add seeed studio NPi dev board
To: Shawn Guo <shawnguo2@yeah.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Parthiban <parthiban@linumiz.com>
References: <20240229082337.3090778-1-parthiban@linumiz.com>
 <20240229082337.3090778-2-parthiban@linumiz.com> <ZgY82LADJS9FuvY6@dragon>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <ZgY82LADJS9FuvY6@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rq8ib-004Dis-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.4]) [122.165.245.213]:58934
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 2
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPADPYP4FFbS+ToD1ONqIHaLCB68NQTsiRPGHHnE/yhqNnZPLrZ4NwbLjLYEOtz6dNegOQmbQb6U0OJp47XA7UWd98XhaGB/WtYbDZXMOEYsgekml5Bf
 P0qYAX/pTpZeAE4mjUyRDNGmAt0qAHVWUKllwQjUjqfIcgNHhEB9v72XYjxjRMK1IPNNpTZ6vvk+fzBHvQdT6Nd7TYIWWqi6Coc=

Dear Shawn,

On 3/29/24 09:30, Shawn Guo wrote:
> On Thu, Feb 29, 2024 at 01:53:37PM +0530, Parthiban Nallathambi wrote:
>> Add support for Seed Stuidos NPi i.MX6ULL SoM equipped with
>> 512MB RAM and 8GB eMMC or 512MB NAND flash. Development
>> board comes with either eMMC or NAND based SoM with peripheral
>> interfaces like 2 x ethernet, 2 x USB, LCD, CSI and more.
>>
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>>  .../imx/imx6ull-seeed-npi-dev-board-emmc.dts  |  19 +
>>  .../imx/imx6ull-seeed-npi-dev-board-nand.dts  |  19 +
>>  .../nxp/imx/imx6ull-seeed-npi-dev-board.dtsi  | 424 ++++++++++++++++++
>>  .../boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi   | 155 +++++++
>>  5 files changed, 619 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts
>>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts
>>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
>>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
> 
> Could you elaborate a bit the point of splitting imx6ull-seeed-npi.dtsi
> and imx6ull-seeed-npi-dev-board.dtsi?  Why cannot they be a single file?
imx6ull-seeed-npi.dtsi is for the npi SoM and -dev-board is for the board which uses the SoM.

Thanks,
Parthiban N


> 
> Shawn
> 

