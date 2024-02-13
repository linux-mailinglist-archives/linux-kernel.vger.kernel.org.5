Return-Path: <linux-kernel+bounces-63177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BA852BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E90B24049
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80A208CB;
	Tue, 13 Feb 2024 09:08:00 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024662231C;
	Tue, 13 Feb 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815279; cv=none; b=R8ZcNed3RzU8MrBj2szX7l7DQAHDLJn59aMguVgQZSAbmCr/WvrnHZB3q47pW6jZYABJcvCYFH2yOP9CV7jzudCCs/+aBy8xOdmc3Q3o23eeKNv6eMehsL4QZZzePAgkMikmrmTxR+O60l0sce+ACyOCgtkGp4/Q64VTCnxDjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815279; c=relaxed/simple;
	bh=6bs7SErVT3CfTr4R0wEWjpG2eNuE9rUybLdZOMUD2iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9lTCkATZWUGLaTo7jJkxFJ/bZA6pndgqpAli9hnT772upmsf5taCXI8VpX1CvaBwCBbP5ffPf3n9o+eeATKN6wlVuZ0fETJxaoTU8prZlMCIEgPqc41ZF4fEV4SgwBeZzX/0kGVYEco8d9O+nHVB1uef+Bh0KwwyK1dK4Cek+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 922E26EF5B;
	Tue, 13 Feb 2024 10:07:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id dicLrwJAa5ue; Tue, 13 Feb 2024 10:07:53 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id DE5596EF02;
	Tue, 13 Feb 2024 10:07:52 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 7576B469; Tue, 13 Feb 2024 10:07:52 +0100 (CET)
Date: Tue, 13 Feb 2024 10:07:52 +0100
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
Message-ID: <20240213090752.5g7cnzkaqrfdqi4p@runtux.com>
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
> > On Mon, Feb 12, 2024 at 12:25:48PM +0100, Krzysztof Kozlowski wrote:
> >>
> >> Hm, I don't understand how exactly it helps. The GPIO expander has its
> >> own example and as you pointed below, this is basically the same code,
> >> except rw and backlight GPIOs.
> > 
> > The hd44780 is a display that is very often used.
> 
> GPIO expanders and their usage is nothing specific to this device -
> other devices also might benefit of them. Or the SoCs which have enough
> of GPIOs... I really do not understand why do we need expander here and
> how does it help

The hd44780 is most often sold together with that specific I/O expander.
The idea was to help people with that combination how to get their
device working.

> Anyway, binding examples should not be collection of unrelated
> solutions, because then we should accept for each device schema several
> other variations and combinations.

The solutions in that case are not unrelated because they document the
most-often-used hw combo.

I also didn't find any documentation of how to actually *use* the
pcf8575 I/O expander. Even
Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
has only docs on how to instantiate the device on the i2c bus but not
how then to use the I/Os of the chip for something else.

So I'd ask again to not remove that piece of useful documentation.

And to get somehow philosophic:
I think that docs should be didactic, not optimized to the least
redundancy.

Thanks and kind regards,
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

