Return-Path: <linux-kernel+bounces-78366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A2861288
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1513286193
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860837FBBB;
	Fri, 23 Feb 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLn+NWth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58867E779;
	Fri, 23 Feb 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694272; cv=none; b=poXCQe6aOhykG615sTp9LYhwsY/Cs4q4g0g38lmOOWt1X0G0jCKSP6pzzJcANdiAGSdjY4LqFrMK04tCiS4PtxK9EzxMD5GyCcBJ9PkNgd56REWJaqEJectIXZSSEy685Aid0L9EiBU4wZbAy6sTZ4MRITWpNQrOinn69uh1nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694272; c=relaxed/simple;
	bh=Dah7nKbNvgz0/8dvPVQyf9mzODhi8A9Za+//Q+h+nOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+/1XwdRHW4/rSK/TPcl35eCza6wdIQPC+QI8eoNcsMiUOcPZPhJmc+uaN1fnRzLY718BqK6FzrWYcYjzoQ/ZhPoL4kp6sZhUqdPOmJnid8JXNZoRJavBoAIDp9961DfdLqKL7oW7XRfIjH9VC+DntmN9mCYmkSYSY7b/FNo8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLn+NWth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ACAC433C7;
	Fri, 23 Feb 2024 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694272;
	bh=Dah7nKbNvgz0/8dvPVQyf9mzODhi8A9Za+//Q+h+nOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZLn+NWthQGZDjuQdLhDm9cq4Z+NCyABBvxxLqqJvYpMnsAcNi7UZ/YrudXsXlJPJR
	 I7vVywWsWW57tgfWCgvWV77uy4Q77QFxCUPg4uvEld21dfq0WwWnm4lhrXn1eExFO8
	 RvOkAm9AU+voMEa4+V2yo4Hqtaq5Nkax1ah/vsy0VrbBphdcjh4mfJamTi6pX/FEuH
	 uX8bjiTH7weTUkKEbYnoeURf50E7qrqMICYoLdPAKz9O0bJNjVG8aesiOB0fNk9Qji
	 5ZJIwE4jJABFElU2Xk6PbcCFg6lpFOREGu2axf11wROsAi7FVqW1SyP4xkcpqBv4+g
	 o8Z3uA2T03RsA==
Message-ID: <48e63867-616e-4a37-ab17-a6977c600ec1@kernel.org>
Date: Fri, 23 Feb 2024 15:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] usb: dwc3-am62: module removal and errata fixes
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com,
 francesco@dolcini.it, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thinh,

On 14/02/2024 11:46, Roger Quadros wrote:
> Hi,
> 
> This series fixes errors during module removal. It also
> implements PHY core voltage selection as per TI recommendation
> and workaround for Errata i2409 [1].
> 
> The workaround needs PHY2 region to be present in device node.
> The device tree patch will be sent later after the DT binding doc
> is merged.
> 
> [1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> 
> Changelog in each file
> 
> v2: https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/
> v1: https://lore.kernel.org/all/20240201121220.5523-1-rogerq@kernel.org/
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Roger Quadros (5):
>       usb: dwc3-am62: call of_platform_depopulate in .remove()
>       usb: dwc3-am62: fix error on module removal
>       usb: dwc3-am62: Fix PHY core voltage selection
>       dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
>       usb: dwc3-am62: add workaround for Errata i2409

Any feedback on this series? Thanks!

> 
>  .../devicetree/bindings/usb/ti,am62-usb.yaml       |  8 +++-
>  drivers/usb/dwc3/dwc3-am62.c                       | 45 ++++++++++++++++------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240206-for-v6-9-am62-usb-errata-3-0-233024ea8e9d
> 
> Best regards,

-- 
cheers,
-roger

