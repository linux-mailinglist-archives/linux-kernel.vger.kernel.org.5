Return-Path: <linux-kernel+bounces-142603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855B8A2DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AD31C21738
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221554FAD;
	Fri, 12 Apr 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy2sziAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA554918;
	Fri, 12 Apr 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922002; cv=none; b=SIOvnwJ8XG5gyB98y5+tdudaTHZ+bT+qzD6Ajgm2pslD819hfjb7fJCE/Urbkm2vQehipuwpk417au9jx27aCpDCDZrS8lmzfFKwV9TyxubBTa/W75IL4S9f/zfBUd8Vi3WNGHlNosqrJKkd9QxWPKcsOLGtk+rThlHqWMlhSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922002; c=relaxed/simple;
	bh=UINfiJ3VhsRAO46w08s/lQL5Ok6uLxhJZ2Bt5MPBkBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHKXkncFrKc2Cq5LXDub9jlkIzM1RLDZJbunkAo0cyaQBN16YcgH46Z4v81c+o97V6d5aCg8XZgOkPM5xK5jTPasDaQ0Fp61CDXuYRUwzxepLNoD+7VNdPzpClE9j9tejwSSAfYJLDdFNjbJLTyJkyUq7GJvlvSCkoGHZg4Z5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy2sziAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC52CC113CC;
	Fri, 12 Apr 2024 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712922002;
	bh=UINfiJ3VhsRAO46w08s/lQL5Ok6uLxhJZ2Bt5MPBkBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wy2sziAiEwd1bAKkU8uIx5s2O0Q1WZs+KbbQMAdnAnhE2xVuSVIhmqNiSpJvsjut3
	 Vf58o3jEzYPKvSaQBPtGfQN4WRMqVJfGU7IQ6uAAWA0/1bOzt/6jquAyj2lHlUF/UW
	 ABvIYKQT8HHSF6CgWWPMrmA7le9uG6fStzjFpT1hrcVTreOE+sgfPEUCt0ZN+POTpa
	 jnEYSApWlQ5fLIHpmfFf+ww9dDVEEUAyt9/+xAEar8O6EkC7lDrG3+BpSV7fExVWAi
	 HWVl0M7S/etFYWbnmcTNl7CUQjVOTo68RAasCO9lnli03/kxhulT0slJyP0eo0Z9Gi
	 iGV37tDKJAtLQ==
Message-ID: <81aaa055-f095-498c-97dd-aee10816a132@kernel.org>
Date: Fri, 12 Apr 2024 14:39:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-am62*: Add PHY2 region to USB
 wrapper node
To: Francesco Dolcini <francesco@dolcini.it>
Cc: nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-6-rogerq@kernel.org>
 <20240408095200.GA14655@francesco-nb>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240408095200.GA14655@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Francesco,

On 08/04/2024 12:52, Francesco Dolcini wrote:
> Hello Roger,
> 
> On Thu, Feb 01, 2024 at 02:03:32PM +0200, Roger Quadros wrote:
>> Add PHY2 register space to USB wrapper node. This is required
>> to deal with Errata i2409.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> What's the status/plan for this? v6.9-rc misses it and therefore we have
> this error in the logs (and of course, we miss the workaround).

I will send the fix for this for v6.9+.

> 
> [    0.583305] dwc3-am62 f910000.dwc3-usb: invalid resource (null)
> [    0.589304] dwc3-am62 f910000.dwc3-usb: can't map PHY IOMEM resource. Won't apply i2409 fix.
> 
> Apart for the error message, the change here seems required for the
> hardware to properly function (IOW IMHO it should be back-ported to stable).
> 
> Francesco
> 

-- 
cheers,
-roger

