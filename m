Return-Path: <linux-kernel+bounces-106330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EA87EC83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C61C20C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B2E52F62;
	Mon, 18 Mar 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDIOWmN9"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACA4F5FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776894; cv=none; b=tIumFLenTGYyaToU1r1bTGw88Q94EQQmzUS0vypB6Gi+pWz5UQX8EZ4RELeUv55/aGpJmEGA0VP0e0VrW+3TerCAsiiTYvQmrBZDKunGhY7D5ZL2pzqUe0u3Wx3xSPpQ4gEPpunKU9EFk/Wedk3hzVNIXx8eAQ97MtPys8E0/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776894; c=relaxed/simple;
	bh=DpYz0hySlKxEHAOQmWqMeZkwyJg+LhqeQY2mrmV/0cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdSpJIzH1kFdAAtl5v8aueqRxy4QFsz91Bt/KW0zfOF/f8R5ljsB6euDjaxF9aHAzqPs15U+6WIqCjc83HBQXIFaVoQ1TwgCQgsrFxH2i9cyOnrVUkKGNL2I1ihE4/O1N52xIGQ75xW1nNK1a+Pr6K4SV6+1UM2rrVf/BnFI2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HDIOWmN9; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710776891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bad6F74F9fm5QOGUdbjG96YKjkLK+JYj8KXYElcQaw8=;
	b=HDIOWmN98GCxTIBHZkDR4L2R1YYSH4ojjz6vVh2nYaXg5czvF/hU6MMYVwYzuEdzCEefgT
	hbe14o3GOvFshvKX08m5PbF20mU2qQqAOIn/bWXSApW8P9pxU0QBhzlGxh9c26pxqfhCg3
	0L6+8ygQ/QC+NUOb+IuM7ZbCFHJmFho=
Date: Mon, 18 Mar 2024 11:48:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Michael Walle <michael@walle.cc>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
 <20240318-scarf-startup-64088b1d8d35@spud>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240318-scarf-startup-64088b1d8d35@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/24 11:40, Conor Dooley wrote:
> On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
>> On 3/17/24 11:10, Conor Dooley wrote:
> 
>> > Additionally, should
>> > they fall back to t1023-sfp? I see that there's already some dts files
>> > with these compatibles in them but seemingly no driver support as there
>> > is for the t1023-sfp.
>> 
>> I checked the reference manuals for these processors, and all of them use TA 2.0.
> 
> Sounds like a fallback is suitable then, although that will require
> updating the various dts files.

Yes, a fallback (like what is done for the T-series) would be suitable,
but given that these devicetrees have been in-tree for eight years I
think it would be preferable to support the existing bindings for
compatibility purposes.

--Sean

