Return-Path: <linux-kernel+bounces-117431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31E88AB59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652412C6D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222512B148;
	Mon, 25 Mar 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObfQTaa8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA612AACB;
	Mon, 25 Mar 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382515; cv=none; b=ggtWzAaRim/Czu+aRc/sE8sEmVkO1K+gICndrV8ihfHOP+8ZViaRKnHN/oTbmiMEDFrY02aq2L5j8p1F1mJ4HaSTaIcZufmi77nR4trsSEbs72PIVOGaVpL1ipzinVu0AugNJN0OBzo3agKGkzp+kweDXpu/MZK/0PT3AjwYA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382515; c=relaxed/simple;
	bh=aYpjV80/yHc4r1UbtdGYVelFqiqR0FuVq8cuG2hh0AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+/xIlki52r50hF8eFm+aLwzsrJMHiM0XzevuQUTgPMbD4HLXoBLAAjOuTYCEmiIvhNJ/TJB8biAM3svYqSZfYSqKZe/etY7rhzjyFbOXje0haB4JTt9OSCUO/s+Ln0ZWCwrzRmOp8qZhOa8Ecf5yLW21btMQ2QTZ/Boo/ncu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObfQTaa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81698C433F1;
	Mon, 25 Mar 2024 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382514;
	bh=aYpjV80/yHc4r1UbtdGYVelFqiqR0FuVq8cuG2hh0AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObfQTaa8XU0fmCTZx3O+0+SqLFBawedixLAibflQvEyg0ThMlW/5Q74ZugrOR4vBR
	 04zPqSrlo5IPa2NebniI3MsY06/CV7xRqZrspO/t7N0+YLtGx3HgUUaTsMqYwQ1Qw3
	 5RiTYY8WFoUlNs4zGGEg+OgwbXBeZt3Boiub6V8j0gfdcKrOoE3mE8UwG3qT2hjxHx
	 PWwY6HeqG3ZnjYNRtdQsn3F8GVd8HLYQzBVtTW0FL5ukXYsRKumPBEXSFJc2wwaGaA
	 ISGRiS4LhkF74XeP0tMtK4WJJsGgGUxq7DX+6ME0qWdMXsXrDbtQp3oNB7+rPfoKvz
	 u4bX3+unJcKnA==
Date: Mon, 25 Mar 2024 11:01:52 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: digicolor-rtc: convert to dtschema
Message-ID: <20240325160152.GA4035876-robh@kernel.org>
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
 <20240323-rtc-yaml-v1-3-0c5d12b1b89d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-rtc-yaml-v1-3-0c5d12b1b89d@gmail.com>

On Sat, Mar 23, 2024 at 11:46:15PM +0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> The binding has been renamed to match its compatible. Apart from that,
> it is a direct conversion with no additions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml  | 37 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 ----------
>  2 files changed, 37 insertions(+), 17 deletions(-)

This could probably just go into trivial-rtc.yaml.

Rob

