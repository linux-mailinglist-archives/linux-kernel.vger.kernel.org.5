Return-Path: <linux-kernel+bounces-104731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58887D2DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416521F21D81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6A4AEEF;
	Fri, 15 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHwbSL3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CE4AEC6;
	Fri, 15 Mar 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524093; cv=none; b=uk9B4kNDYWKAsNFaTZi8LD/HqwdtovRioXYw0klxE8bhhk3AovAzu0aTjGkHmiE47f28bfwXvyL2UCaZ1ABq/MDhj+3SQh9pOTeQD7zvVwJY9E0TOMp1rEQWTXRIw6BVRDFkyFm57oxNmFSRGXnnBh/8JqYK5nYJ9RVZFucLqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524093; c=relaxed/simple;
	bh=W61K6V34YLXJuWqdkt3GtIsvSmdw6zEsBmWGlTzLuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft9abgoTu7cmMvxQKRUutopUVlWpjfqkDZGc8WCgiQNWk+1mqBIqJopM4d53NzHwjOxOMfZdsIzedGr7tAw2Pp4C6M0FIH4HlZVjmM+1myK1hGpSyv15C+MJAC+ZTJRMwtxpEb656Rudr5sqki2ETUbpro5tn5A5j/4dMFvETwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHwbSL3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45646C433F1;
	Fri, 15 Mar 2024 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710524093;
	bh=W61K6V34YLXJuWqdkt3GtIsvSmdw6zEsBmWGlTzLuWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHwbSL3i8uCcUreurxDPOORl3qzBT65y5mnzN9/FyaCh7VnkWnNWD3+NaVludUCo/
	 LoKyE8ieX6kohLdTFsZ0Ja6QMW/as62EL2/9VxsHXHPTmqXmfoJv6NkGHD3b4mQNLk
	 j19vlbo+QYgDSK8fbeLIvm+cdqgOh/FbpuBN/+ITWBEHbnTIrEnDsQpQS4hxPX2AZ/
	 /2nYaGGgmV78+jzS1QaCExlvJ2v7b5OHktPxRUQQUqVw8KJ47l91QC3b8xylScc3FV
	 8Ati1Elv8AQ017A7VtMtvyYVP9YHfgMChNlnySA0s7tUNvjVjdB5Xrxw1bYS33Ibcf
	 hZzIPd94e0g6w==
Date: Fri, 15 Mar 2024 11:34:51 -0600
From: Rob Herring <robh@kernel.org>
To: Denis Burkov <hitechshell@mail.ru>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Message-ID: <171052409071.1519197.5980103537656654769.robh@kernel.org>
References: <20240314155306.11521-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314155306.11521-1-hitechshell@mail.ru>


On Thu, 14 Mar 2024 20:53:05 +0500, Denis Burkov wrote:
> Add a new board name.
> 
> Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


