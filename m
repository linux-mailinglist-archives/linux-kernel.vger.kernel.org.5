Return-Path: <linux-kernel+bounces-31133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C21832987
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D43EB20EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084F51C4B;
	Fri, 19 Jan 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w86O8Yns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276131A61;
	Fri, 19 Jan 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667480; cv=none; b=XPCDjHh9Otn9uEsvJosQVWGHLChxN6CA8TPEMiRb35uqu/hLsk1koj5pI5vaTE/nE7x/kInspkkY8X4HV/axWJ7/T95B9Rbzzlm9nXTqxBm1IR0SRkZ52ume/L6mQIFetVBCrS7nLgZtlxwwToMzNfmaxU0MNxJoAicmFUl0b+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667480; c=relaxed/simple;
	bh=ZeH7XUCaG9rG3fgSaELJxeq8hzzhMfoPy/s3o41Ehl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTCu8Y05fGi4AtPLBmDHtTN6fbLKFbEANVfBdCOapm5NBqpgsPgpkZpelznsK9X3D4n2OKb3ANUHt2jfZ12GF/Lg7t3rh+TC72A63u+cWJ1+3GnG1d7eTXZN989G0nhmprK/o4zLWJwgI3u73e61PsfbJ5yU6MdphaQfNPnlYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w86O8Yns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95903C433F1;
	Fri, 19 Jan 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705667480;
	bh=ZeH7XUCaG9rG3fgSaELJxeq8hzzhMfoPy/s3o41Ehl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w86O8YnskLjKxi9sl4SKfZAq6Cim9BwIWzqE8qV6WVdcxXT3QFjiXM/fFjW3tqOwa
	 x1UPOpXhO3k0kWTgyVna7sf0G5WoqCYLRiyvTu5tYWSbJWHHbtaqpiYKV0sKLR7avl
	 AgdOQeTXLqGI1gfNx5YyHKrHzGHbGTo0A1KIBmqg=
Date: Fri, 19 Jan 2024 13:31:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, michal.simek@amd.com,
	p.zabel@pengutronix.de, piyush.mehta@amd.com, mubin.sayyed@amd.com,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Message-ID: <2024011907-wavy-annuity-b395@gregkh>
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>

On Fri, Jan 19, 2024 at 05:06:21PM +0530, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Needs an ack by Piyush.

