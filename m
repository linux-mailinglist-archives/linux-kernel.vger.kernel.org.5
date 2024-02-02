Return-Path: <linux-kernel+bounces-49597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB7846C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CFE1C257D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ADC77F3C;
	Fri,  2 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCnPmSGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01762628B;
	Fri,  2 Feb 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866622; cv=none; b=foNJaoeKfPHqWGFpr9DeIvUmlTdMi02m2FXhD+p0Px2pq74ANMJzJ3kKLeCZLA3LcG1P1MCssOcpvvBIywYahkqBfdvnA0wl7LiCH7ZcDhZ+IUKczsSDRvJ8TwBC9Uzdia7dcIgWAWz8wcUAUX4cdt4zibsVJP6rZsNq7BohzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866622; c=relaxed/simple;
	bh=Why0zHMkeFsSyoZEGZoXgy2Y9D41NUYSpKgaun+woa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OPcDyFzuNgm6XqK54dVw+eVRZEACUOXml+9Zr0JQNOr1QrozlPysZqfiA3apqsbX3qHNDxvhDBcZ2QOFKC2/YsHQla5cK4OZzueHpJK0xQkN7BRGkku3L8ULTqsavGDPYIQLHzQsdlK0Tgb21ImiaObNkKU6UKgIXHadITnbR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCnPmSGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2032DC433F1;
	Fri,  2 Feb 2024 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706866622;
	bh=Why0zHMkeFsSyoZEGZoXgy2Y9D41NUYSpKgaun+woa0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gCnPmSGTi0ow2ZYJ2vJzTcR0GzjiMFR0VJ1A5EiIThFHJGC+Y5GTcK6IGNdl2QJql
	 IheNYyNUxGYq8cbzn0tceVRgxlAHW3QVw7Y/klWjIcCcEOj5ipFj1u6SfoLXyRzVFd
	 Lhyf4ew9B/xLvkbvyoLgC4S3cIUTuRkoLqcYEFNdJ5lgPfUJ59oiKDEQTSJSGsafbW
	 J5dI8JVFtjXdR9i5io03e3uUacrbAo5Nc/Wfa9+zrNg2p5bBexP0nDzY7O8Nxo2SHm
	 KA0vWJSOJxkBBGFLRXvCi7Oqu3ELdG0ZfdPX/ECZGZxVjo4cANgqqtjOIuYHDTfMO3
	 pC/GlpyuZVqTA==
Message-ID: <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
Date: Fri, 2 Feb 2024 11:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
To: Conor Dooley <conor@kernel.org>, Bin Liu <b-liu@ti.com>, nm@ti.com,
 vigneshr@ti.com, afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240201-clad-unopposed-ccfdfe53b770@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/02/2024 21:13, Conor Dooley wrote:
> On Thu, Feb 01, 2024 at 12:35:22PM -0600, Bin Liu wrote:
>> On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
>>> On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
>>>> On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
>>>>> So far this was not required but due to the newly identified
>>>>> Errata i2409 [1] we need to poke this register space.
>>>>>
>>>>> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Actually, where is the user for this that actually pokes the register
>>> space?

https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/

>>> You're adding another register region, so I went to check how you were
>>> handling that in drivers, but there's no driver patch.
>>
>> See Roger's another patch set 'Add workaround for Errata i2409' posted
>> on 16th.
> 
> This patch should be with that series, not with these dts patches.
> 

Why not? There should be no dependency between DTS and driver implementation.

As DTS and driver will be merged by separate maintainers I thought it
would be easier for maintainers this way.

-- 
cheers,
-roger

