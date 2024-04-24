Return-Path: <linux-kernel+bounces-156387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876528B0241
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36111C226DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB88158A3C;
	Wed, 24 Apr 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="o4xwe88O"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3C1581F2;
	Wed, 24 Apr 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940670; cv=none; b=foiBs1ss3fZAq03S4AQeBWOh8VO+15wfUox9iVEtHgX4LAILsgFkDspZ4Hwt4p/23Z4gQvvYgO3bYxwgztCbH2Nx1S5gHM3yW8cEc5/+3gWFNC2QogoGwJ1YwcVOq34hhps60LglwjdWTgA1an8QEB+0a4fXcAUpToqQ4Dau3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940670; c=relaxed/simple;
	bh=JpRmySToucWzmNU3GW0RewtThBM4eo0oW5oq/VEQNzY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nJm4XUZrA2nGC2/X7gD1uONoHEE7ewyThp+VbgTSzXMrlUDLjRTNaXzozl2UCjtvxfIBz4AbYR5d3O+4rhSzhA+s49oLfL9BlmLwD/JFrlZz9VaBmopyFXbIgpV9ljeCW4wmTSmASlRrADImLTF0Pe/DhwelY/uhvuvwAOUmlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=o4xwe88O; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713940659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHwmy+JfTUfK+F37enKJhkifnhbbytVW3ZSkIuXP+d8=;
	b=o4xwe88OAwCuuUcZUdhVy8jNxXYrWI9nHW05eYN2hbhKohgLfPxOcDX3YcPJlZvHO2Mh5a
	/SxLddEzYDrrtA3UPSUVNIGAt/zk3cdD8KxVE47sb3sJiEjAfQ3uF1aJ0fZD5aHhhQ2iy6
	yEekLyzQO8ED4r54r4PbCa9KQJXhzWxElna8LpJsiW3lz6ngGPUNAILRF8+PJQnnRQtTwD
	+ubfEPX+NXLLB92iEqVh45op2a4PFIEKUNHBV6i56e1MxDfQImAakgLPyY2HlcP+3247TC
	YF2TgMF40rX8+lBHAduvsXRRo+wZhyj3IJ1IsTSIBZZiZYWeTLHnQRdTusf6AA==
Date: Wed, 24 Apr 2024 08:37:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Marek Kraus <gamiee@pine64.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, didi.debian@cknow.org, robh+dt@kernel.org,
 linux-rockchip@lists.infradead.org, krzk+dt@kernel.org, heiko@sntech.de
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Pine64 boards
In-Reply-To: <171388492373.250779.3280449198658307048.robh@kernel.org>
References: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
 <171388492373.250779.3280449198658307048.robh@kernel.org>
Message-ID: <f1419f4b2003df69a3cd04d36de8000f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-23 17:09, Rob Herring wrote:
> On Tue, 23 Apr 2024 02:43:43 +0200, Dragan Simic wrote:
>> Correct the descriptions of a few Pine64 boards and devices, according
>> to their official names used on the Pine64 wiki.  This ensures 
>> consistency
>> between the officially used names and the names in the source code.
>> 
>> Cc: Marek Kraus <gamiee@pine64.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     This continues the description cleanup started with Radxa boards. 
>> [1]
>> 
>>     [1] 
>> https://lore.kernel.org/linux-rockchip/1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org/
>> 
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks!

