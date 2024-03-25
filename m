Return-Path: <linux-kernel+bounces-117433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E423B88AD27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A3FC0077D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008012C540;
	Mon, 25 Mar 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTvTGA1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C46CDC0;
	Mon, 25 Mar 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382554; cv=none; b=cK50XSdWGjgmp2bBRvHChdTocztaVqw+Lir+cwksKC4J8e2MrpoHQMhz89HpquzDb0hK2TbXDlSyqdCwrd7vnXFAYjSAX2XW8Ftse7M23otnLUOhXN3Y+DFU+xl1/dauu8AoyjlMl4sQJR0qJRV36HpNzmSEFi101grj98EjX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382554; c=relaxed/simple;
	bh=JJbCkZzEeycIyoj0urV1Upiq1UUSkSdddBASm4fPN0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGBUtmjKiWoomo/dl9Vjte4aFrSzOFTKL8j3pike8lAt5sI0xAVGqHfMVr5fknn4MEtxRt5iIkym2cHIqy+X7LnqtZpfZPhpbuHZfjofInCCFHjv0agKefBG14SMytTbyIsHhuJEP/VmtOrgifr42gv+dQa9nDeQv+iG9mglgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTvTGA1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5EFC433C7;
	Mon, 25 Mar 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382554;
	bh=JJbCkZzEeycIyoj0urV1Upiq1UUSkSdddBASm4fPN0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTvTGA1E9BKCJpr3ZAlylSmsQXO03Fx0lP70d90iIXHmNw0NaNlJfaf+U1o/ATU5Q
	 66xMybd1UghWaAftZYlXsGWehYRqWNsV5pcHmv7YgUvhgxH5U492A4CH4fXpYGEHC9
	 fsLRL3Vdxv+LVpD3W+oKpLBTYKAdB/yrxpkWDpqi+3JUHVgw0zTKRqE6cDBwgRzYKc
	 ARHP7Gq40d1KFtR35r/PVGg4OmPAgIAwB8A55OY9bYbWz9E2xl8OxJEvX/FdA6JrTe
	 iKKNwU8LNkQhBgKpDy3hL8E50ii6DsoyFijxFx6vHhVCwJHIx5hWe5XoADfw3h/cK+
	 CVxNKg6qquCLw==
Date: Mon, 25 Mar 2024 11:02:31 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: rtc: armada-380-rtc: convert to dtschema
Message-ID: <20240325160231.GB4035876-robh@kernel.org>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
 <20240323-rtc-yaml-v1-1-0c5d12b1b89d@gmail.com>
 <20240323233742bfb9ba4a@mail.local>
 <6e68e0ca-2f3e-41a7-bb96-00fbdadc4436@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e68e0ca-2f3e-41a7-bb96-00fbdadc4436@gmail.com>

On Sun, Mar 24, 2024 at 01:02:31AM +0100, Javier Carrasco wrote:
> On 3/24/24 00:37, Alexandre Belloni wrote:
> > On 23/03/2024 23:46:13+0100, Javier Carrasco wrote:
> >> Convert existing binding to dtschema to support validation.
> >>
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reg-names
> >> +  - interrupts
> >> +
> >> +additionalProperties: false
> > 
> > This is not correct because at least start-year is supported. Please
> > check for all your other submissions too.
> > 
> 
> allOf:
>   - $ref: rtc.yaml#
> 
> is missing, and then
> 
> unvealuatedProperties: false
> 
> to account for that.
> 
> "start-year" is read in the RTC base class, so I wonder why so many RTC
> bindings add a reference to rtc.yaml, but then use
> 
> additionalProperties: false

They may have pre-dated support for 'unevaluatedProperties', or you can 
list out which properties are used from a referenced schema which 
disallows unlisted properties. There's no hard rule here. Either way is 
fine.

Other than this and my 1 other comment, this series looks fine to me.

Rob

