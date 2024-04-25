Return-Path: <linux-kernel+bounces-157874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5C8B17E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7ADB2757F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B799A38;
	Thu, 25 Apr 2024 00:13:31 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34C36E;
	Thu, 25 Apr 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004010; cv=none; b=AjXzxDQOx1+oa48xJ6TBhQfS4ScCuVwYRdJHmmh2Vzk1HcAgu3k4s0F4lWXxvd1mDBHcq0DZCcLXDgrhyVkOewAxyYlial8IXk5vA42SVUD/mZspAWn+gXLKE8uOLEsw/3rB4Oz+Nr8VcfsA/LzSLSxKlJq4xo3DbIbG47BYzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004010; c=relaxed/simple;
	bh=k5rZlX9rMq8dEAL/jkEgJryimt3ATZ52RbI4UmbttsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=i3ia+8WN6P8aSwbGwDY/xBew47p4WicTpfhxa37RVs/VJCWMU75tfFkM27Iqh8VRGwLvG257s8kkaX3q3DJl1FX9iY4nuLDIgJA6BbshjczehBnM7bLSo/mH5mH0EphNpWS0d3xgfD8V+MME2IDgFtssvzEz3WfweVB353CBYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Apr 2024 09:12:18 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2F6852059052;
	Thu, 25 Apr 2024 09:12:18 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 25 Apr 2024 09:12:18 +0900
Received: from [10.212.246.234] (unknown [10.212.246.234])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 8B095A6B50;
	Thu, 25 Apr 2024 09:12:17 +0900 (JST)
Message-ID: <612963b3-2bca-4ec7-91bc-03b2b6b3f6a4@socionext.com>
Date: Thu, 25 Apr 2024 09:12:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: uniphier: ld11-global: use generic node
 name for audio-codec
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240401140952.97923-1-krzk@kernel.org>
 <171394159879.43787.1190606574458902919.b4-ty@linaro.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <171394159879.43787.1190606574458902919.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/04/24 15:54, Krzysztof Kozlowski wrote:
> 
> On Mon, 01 Apr 2024 16:09:49 +0200, Krzysztof Kozlowski wrote:
>> Devicetree specification expects node names to be generic, representing
>> the class of devices.
>>
>>
> 
> Almost a month passed, no replies from maintainers about picking it up.
> Dunno,
> looks abandoned, so let me grab this. If anyone else wants to pick it up,
> let
> me know.

Sorry, I couldn't reply your patches due to some problems.
They looks to me, so you can keep on picking them up.

Thank you,

---
Best Regards
Kunihiko Hayashi

