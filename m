Return-Path: <linux-kernel+bounces-61832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9377851730
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7299A283E96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37303B2AD;
	Mon, 12 Feb 2024 14:40:05 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DDFC16;
	Mon, 12 Feb 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748805; cv=none; b=khE9Wwsh8K9EjPpTIEZ3TeNohgagZ/5RVnexVZWYgufAeuGh7j6PUDAEw9NDPbBV5k5PGXvFxyotW9zJY11qFZ1xCt9w16iepHW1IDVRqP2N/khjQml6hXdGqC2vdPOZ/Xhn+Z/COYTjFF8r+riAiHdFKXP/QyJJe30oFIF4mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748805; c=relaxed/simple;
	bh=stDOpKX2vOjeRZ0yU+kSRW2NtkeM5LOv9GIRMijbGtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrnIWI+eCPfpv6Pb5JBghH8oYshu6HheX1hBZdhszKSzRa3FLYl7u5oS1t7G6cNoL8SJk6IOJODDmirITr6n6nGJ6spiAl6Yw88+AGAXB31QVyrIW8B9Po0+hQs/ny86jG/W9TdyT0TbzGcmAr5p4fSBo6/Hv0/OV6eGFcfJ29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 6CA786F065;
	Mon, 12 Feb 2024 15:40:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id PkmeLa6QKAcP; Mon, 12 Feb 2024 15:39:59 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id E8B6C6EF02;
	Mon, 12 Feb 2024 15:39:58 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 44DCD46A; Mon, 12 Feb 2024 15:39:58 +0100 (CET)
Date: Mon, 12 Feb 2024 15:39:58 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <20240212143957.gaxxz3nt7pxhlmqh@runtux.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
X-ray: beware
User-Agent: NeoMutt/20180716

On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:
> 
> GPIO expanders and their usage is nothing specific to this device -
> other devices also might benefit of them. Or the SoCs which have enough
> of GPIOs... I really do not understand why do we need expander here and
> how does it help

Can we then at least link the I/O Expander example to the docs of that
display?
I've documented my experience here:
https://blog.runtux.com/posts/2021/01/06/

And at the time there were two out-of-tree implementations.

Note that I think that redundancy in code is bad.
Not so for documentation.

Thanks + kind regards
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

