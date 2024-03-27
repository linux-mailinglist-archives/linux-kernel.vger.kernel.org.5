Return-Path: <linux-kernel+bounces-120181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106488D3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEA01F29D31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8E1CFBC;
	Wed, 27 Mar 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SGSYReUx"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724718C36;
	Wed, 27 Mar 2024 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503974; cv=none; b=WErRdHrKkSIxkgC4vNa4eO84IeKhI+nHTP47E6gcX6Y/yTl23td/eHOr4xio1ySfIp4Tkt6hCUOWXXlqoeueaMEKfbzpvxRlU6cSpiLB0jl1nJlxZFEdiqgI+enddF3ZMe4eI8xUc4DdMDbBEPoCriXCadWtJCXaaAzKG63e5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503974; c=relaxed/simple;
	bh=DoCy0+ib6v6kh81I+uYITM62RigPnYRn7LhIetEqj/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9wwvcRFA3GP2/v9WaJZ3qAtAwrBaOW4aMWX4+Sk0jJeiEqzgqKBLDUdF2i9hlLUKRllIwjJCSQzt9MBI/+FdV0OrKbufWGgKlRDcuytZ+MscWR7WgdoO9RvU4MHemvmRHlk3ivFR1lLkHyYsVPGVUBSD6AsCx0HbY/4fwJ5XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SGSYReUx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-177-226.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.226])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DAF60200DB;
	Wed, 27 Mar 2024 09:46:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1711503969;
	bh=DoCy0+ib6v6kh81I+uYITM62RigPnYRn7LhIetEqj/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SGSYReUx514D/YQ+nPzoRDe+VNpX1+4bd0+sgkj+S9BxnYQlJr28SitJmyf9HXSqJ
	 cAoo3H4VX01C2Y3o+30J+cacOIZL7GNH7K7do9jakxF8Wi2Jb4UzYEB9ZvM2QElWtl
	 RUzUAJs8iYHs0R/SNA1sl705EPRdGDdEyibHkwGiit4xrNUq9th6c82i6VQP4If63g
	 oBuHZ0yU/zev3MWsWtPS/FNHMzEC5u0l98XjYTCpScNnxblbYKLCPnZaL9rdtpWYcV
	 GkAfxBA5I+XVq6crl/Qy3isW1Ua0niQHTmy4Ezgc+hNAXHVKLTWKxFcou6fgItDI4E
	 ITJTm7v27wWKw==
Message-ID: <eb4171d9c46dba2aabca90319028ee6be8c80d55.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 0/2] Add Reviewed-by and Acked-by tags
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Date: Wed, 27 Mar 2024 12:16:06 +1030
In-Reply-To: <20240326103549.2413515-1-Kelly_Hung@asus.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kelly,

On Tue, 2024-03-26 at 18:35 +0800, Kelly Hung wrote:
> There are no changes to the Patch file, just the reviewed and acked tags =
are added.
> PATCH v5 has been merged into the next branch.

As others have said, please don't add tags that have not been
explicitly given for your patches.

Further, if a patch has been added to any upstream "next" branches it's
not necessary to resend the patches beyond that point, unless there are
errors that need correcting.

Joel had added an earlier revision of your patches to a branch of
candidate patches to upstream, and I've updated those in my own that
I'm maintaining while he's on leave. I'd also added your patches to the
OpenBMC kernel tree as a consequence, but you shouldn't apply tags to
your upstream patches that other people didn't provide you on that
basis.

As for the concerns reported by Rob's bot, I've got a series that
cleans up many of them. I'm working to find time to send them out.
Hopefully these help reduce the noise in the future.

Andrew


