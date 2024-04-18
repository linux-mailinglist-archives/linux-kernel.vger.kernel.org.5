Return-Path: <linux-kernel+bounces-149730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B518A951F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7AE281F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4371586F5;
	Thu, 18 Apr 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cbWfah37"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7411E498;
	Thu, 18 Apr 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429408; cv=none; b=odDBsLKmxGMUxvi3jQKWiOeZfncb9NrhCQu8ikqDtS15+uPuczwM6/8xhgBHNA1PdW/UdTACZBOkLQoo+A9coDBH+d0x8scUjumtT6N0BP41SLQpKCu9IC0TuhpwGHeiJYcNXIgpLZMdNStQhg9Sfyfn8hy50NkQJAhVywrm0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429408; c=relaxed/simple;
	bh=yFvxY7AzwVnnSQ8ucWawolwzbibsY7q8XL7KxsGJHqs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=luneJOwv8O3Jbw32OqNX1fPuZnirV/o8YowAqwgV0apKZYhOYoeXEcrUtXZuhSpKeABuCDlMlaUUekprpgf6g8ym4hVLqaE7U5x7yqhzF2fp9Kax5jSWky67fiBJUssAKlUIeSo5xDFbvFOxWwRmIXbYpANxuVY032OG71uIzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cbWfah37; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713429404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0/pcL8zpK5I18i+eBbw+Iwo3gVo9gl9K+bm6kJi3/g=;
	b=cbWfah37TC39SvM3VxL7ZEQaqL3EWiESpIWQhAVKmh/L52QKdeb/qRUbnu+PRm5U+vV9PC
	TBjciVZ5OPKuKJ0hfwdknCBl/w2lMQqSxDp8KZ8xduKwD6lsVq2z8O6PDk4f/TacoVrUSg
	GKfroAhQKweVa//nKaOTQ+xEP0VmzeCNc4koquXyNLD79GeVWjGKxardACQnOEbeKNZzhn
	lUu4E3ubbqUbuWdL5o01gh7tcxj7toNIadZ4CdfeFZUtLw27NjW0ieUju5dk0x0xIm2v+U
	8TDL6oryiQZ3aQsbNjdwsrGQuwffAqYJ8GLWHxXwKeLm8+K5ZEmWRm0RN2Cavw==
Date: Thu, 18 Apr 2024 10:36:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se, conor+dt@kernel.org,
 devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK3 Model C
In-Reply-To: <5C3644E82F788C47+c823a9ad-5dcd-4f20-b589-057c7d31eb22@radxa.com>
References: <d7de2213-8dd2-42ec-9a30-a569ac71be3e@kwiboo.se>
 <20240417133016.62753-1-amadeus@jmu.edu.cn>
 <a144c052fcc2460a615a754a64a8f739@manjaro.org>
 <B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com>
 <9e915ef29a2b49ce56446ec9d474eb64@manjaro.org>
 <ebf7b5f5ff4cd3c8cbee36f35df6ef5d@manjaro.org>
 <730e21fc4c74bf42b8a5e54473270899@manjaro.org>
 <5C3644E82F788C47+c823a9ad-5dcd-4f20-b589-057c7d31eb22@radxa.com>
Message-ID: <4d171d1365965c72a19fb23040be026a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-18 10:31, FUKAUMI Naoki wrote:
> On 4/18/24 16:18, Dragan Simic wrote:
>> Actually, a couple of board dts(i) files, listed below, need to
>> be renamed to add dashes into their names.  That, together with
>> the other naming cleanups I've already prepared, would make the
>> naming cleanup of the Radxa boards complete.
>> 
>> - arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi
>>    (-> arch/arm/boot/dts/rockchip/rk3288-rock-2-som.dtsi)
>> - arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts
>>    (-> arch/arm/boot/dts/rockchip/rk3288-rock-2-square.dts)
> 
> uh... they are prehistoric relics... there was no strict rule...
> (FYI, there is rk3188-radxarock.dts too)
> 
> I don't feel a strong need for them...

In that case, it's perhaps better not to do any file renaming,
which will also keep us on the extra safe side.  The U-Boot patch
I already submitted won't hurt anyway. :)

