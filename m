Return-Path: <linux-kernel+bounces-149726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C08A950E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B1DB21B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07301586C0;
	Thu, 18 Apr 2024 08:33:10 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AEB1E489;
	Thu, 18 Apr 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429190; cv=none; b=V/zjkH1PIhorfA3wtz2n5zM1uvjGHBW7V3yzXGsbGGrMZJoMMkH5DsHv85kn2+Da8X8akaGHmOzIYvDA/CBIiXPAkdfZrZ8K3iqHJwguGMIf8D7/VQsneXBJ3JJqpm+T4JoUmU8el7aGWrp7T37A9cyeIVVroZEnMmiF2t+/Wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429190; c=relaxed/simple;
	bh=q+i8pVmlIrlg2uXNb2LPqfkCOiu8Po9mLE63rqzPPp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+YAEJXUluW5mWUJOfRVOv9LBTgwFdCbOdTy5XqZ1OBWj6x4CkVogWReLjiQgcstOzF/JharOnu2b0rlX0+yeq+GV7ysD4jGM9P13u4WKMKB6yKZFll0Tode2+uQkMHYNbieI72dHGIaW9mEwbGZgpdtWZ2E0+vtTacfgYsMyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpsz8t1713429112t1pczxp
X-QQ-Originating-IP: V8JKS7yvHdhP0iKN6L3sa6gtMib2nnjrQRhERCSiCuQ=
Received: from [192.168.159.131] ( [106.150.157.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 16:31:49 +0800 (CST)
X-QQ-SSF: 01100000000000C0G000000A0000000
X-QQ-FEAT: ALw5QuVtm4XcJgw+J5V+e1OHlRlWVPQRtBJdXNg7y9MPl3lldtrMstt74caul
	bMSHUekZJddAOgMTKK/6SQcoFWyyk1Zuxo/0Xn/AM+AAIilub6RJsYj/EABugMx+km3y2Cq
	JqOCfiBKVWcHYvJZxKqQn6qXk5AG1Q4v1kUxMmk1C6m0HFrrfaMqYku0kdonl3SECJ5ddTC
	WU5AYb9lC/ggfFvSJs+a3XgwyZHL471CgrKosjXXP+jS3mDUkBnG/lGaN/FxLBjZZ4GJ0O6
	myDqQjaPMLgMK+YCKE8JUsb07fLVIWrXHi+hmfQ70YDrh7VrsfrADPkgFEc+N5qkaTM/vHb
	yHt+CZ6pLuPQbx0zsDnwpugnjssCZg/Cww57kCq5WVjFeZoK34txDMmVd+i8bYASJ6xMqXr
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16492290732445670536
Message-ID: <5C3644E82F788C47+c823a9ad-5dcd-4f20-b589-057c7d31eb22@radxa.com>
Date: Thu, 18 Apr 2024 17:31:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se, conor+dt@kernel.org,
 devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
 <a144c052fcc2460a615a754a64a8f739@manjaro.org>
 <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
 <9e915ef29a2b49ce56446ec9d474eb64@manjaro.org>
 <ebf7b5f5ff4cd3c8cbee36f35df6ef5d@manjaro.org>
 <730e21fc4c74bf42b8a5e54473270899@manjaro.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <730e21fc4c74bf42b8a5e54473270899@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0

Hi,

On 4/18/24 16:18, Dragan Simic wrote:
> Actually, a couple of board dts(i) files, listed below, need to
> be renamed to add dashes into their names.  That, together with
> the other naming cleanups I've already prepared, would make the
> naming cleanup of the Radxa boards complete.
> 
> - arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
>    (-> arch/arm/boot/dts/rockchip/rk3288-rock-2-som.dtsi)
> - arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
>    (-> arch/arm/boot/dts/rockchip/rk3288-rock-2-square.dts)

uh... they are prehistoric relics... there was no strict rule...
(FYI, there is rk3188-radxarock.dts too)

I don't feel a strong need for them...

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

