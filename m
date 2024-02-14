Return-Path: <linux-kernel+bounces-65812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73AA855226
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1630D1C2A93B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6412FB1D;
	Wed, 14 Feb 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MjznPnCi"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2512F5A6;
	Wed, 14 Feb 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935453; cv=none; b=sFCUsgTVMgJf6sqg6hpwNcjV//QbLjdJodaxWwnoE0FRNNki9VgSYCKxlG85cEv6pbyHEBEtn2hA9qnA8YvZSDCjEGKM7cCKIGJLB5HuI4gkCjo267g8dS4A0hxv2rdWTptcUhbhIcW8ygYretYrv+FY4xJyv1lL7MtkHOph2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935453; c=relaxed/simple;
	bh=5uP8HuasPE9jjTg8TVWNXGQF/Kh7MKjGojWz/AXkG2Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BmgAfO8OVm5OZC+xU83+hEb+e1EaDe2NSKA04Fsi3cvhuiXpU9NuhmAFULEL0qD2gf3gy4OXGn9U/JQjJq+fG6+kphzF93zVGEclc2huOKkmxbtUtMPuFde7IbsqG+43qTKtDKeMuULcWRTDJetzTHLkQDeplFqsWiC54K3J7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MjznPnCi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707935446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBm/TVAwluVa6W1ppxE/9VD5uiTG5c6NeW89/JYMXY0=;
	b=MjznPnCifzzDeID5hxhRe5HjMuAMYMBfod6hcJaXXeGnbCBQyqGdy0V0yM5MkMuUPJDXae
	3yUbZBZOvwjzNhN/gF1r+MvKtUjvueXDXbHJ5jHp5wwOtmmDpfYBwvQ8Gs/0bGPMmWkrxv
	byOOaaLyeYv/t6OzGbL6LfQ5CA+k3/va0d6nWFzbyJabyL2UExOVXZUX87a4DXlHioSbgd
	TInaD9VFAlYhn45qzK8+OzoDskmLudnUYBGxgx2wQcqUitJrd1ec4kW3WojXdOBfOT+wDM
	W5GkNZyizat53+yxu2OMvm1L3pdUY2U3RLZwjPk4g6Fd2aZtdPV3GASLaHwhsg==
Date: Wed, 14 Feb 2024 19:30:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Tim Lunn <tim@feathertop.org>, linux-rockchip@lists.infradead.org, Andy
 Yan <andyshrk@163.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>, Cristian
 Ciocaltea <cristian.ciocaltea@collabora.com>, David Heidelberg
 <david@ixit.cz>, Heiko Stuebner <heiko@sntech.de>, Jagan Teki
 <jagan@edgeble.ai>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>, Tianling Shen
 <cnsztl@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
In-Reply-To: <20240214-moocher-womanless-21201b67b76d@spud>
References: <20240214040731.3069111-1-tim@feathertop.org>
 <c03220db663279c9e83bab81f3d829e7@manjaro.org>
 <e952d127-b12d-4b5a-838b-807a876db707@feathertop.org>
 <20240214-moocher-womanless-21201b67b76d@spud>
Message-ID: <d9a17e535f8e414f91fe06b2b71849f9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Conor,

On 2024-02-14 19:12, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 03:27:08PM +1100, Tim Lunn wrote:
>> On 2/14/24 15:14, Dragan Simic wrote:
>> > On 2024-02-14 05:07, Tim Lunn wrote:
>> > > A couple of rockchip boards incorrectly list their vendor as Rockchip
>> > > when they are in fact not manufactured by Rockchip.
>> > >
>> > > Fix the vendor strings to correctly list the manufacturer
>> >
>> > Just checking, have you verified that the old, incorrect "compatible"
>> > strings from the board dts files aren't used anywhere in the kernel code,
>> > such as in some drivers?
>> >
>> Yes I checked that, there are no remaining references to the 
>> old/incorrect
>> compatible strings in kernel code
> 
> What about other code? Like a BSD or a bootloader? If nothing is using
> them
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I just quickly checked U-Boot and it's fine.

> Fixes tags I think wouldn't go amiss, but I'm not expecting a resend
> with them.

