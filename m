Return-Path: <linux-kernel+bounces-63877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19998535D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D3D1F25D55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C25F875;
	Tue, 13 Feb 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awGYDM7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679D5F85E;
	Tue, 13 Feb 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841147; cv=none; b=iQVEkXdTCBejTQ2sqQyF4XqBCUBCWjpZrQjBoNdHiCbNSgXfZBPQ80LGbaDoe24wmKHW3XIaoSWYKA9uu1+rMINOn2VbluiBPv/2PbQivh/vhHx9rwTPWVPresUyxqOgSsgVxtkxxnCCX8s1IHA9vzgl+dfdpXIsl9akxE5PNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841147; c=relaxed/simple;
	bh=kH3SOr9TCZKMlM/gQHV4yrLVT8Tx3VF0/Q1Pp1UtomY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dumya26P9beZX8qMMKTlrBTTXnwA8xNJ4kWdqb8MYxlqAhOODB5PrIdRxNdNSpIkXaLJy18tB5ZqPLNsdCSwBIaYmAM/QuS8LEA55vkpY9iwqILHbZxhKqlXFyzwhyIDoGEs3HoF5y58xNUcsI8mtYZSXO5QJuiCKA4z7NmrxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awGYDM7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F88FC433F1;
	Tue, 13 Feb 2024 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841147;
	bh=kH3SOr9TCZKMlM/gQHV4yrLVT8Tx3VF0/Q1Pp1UtomY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awGYDM7EJhxCo8En97K9nMJomm/Ni4hAS/m42KS9QsV5x0PylA5YYTvIdDnxl+ROs
	 mYSU+OkdrzNM4SuQN3/USCGlKZXVxjWY/DVj57ZwSt5wSx+aiLo6qaLjz2dRU4lgnj
	 WKUEIU0LsqSQnYkvyoUKG2OnvJqGJAOJeBbIe9e7wVQedCBW9J6JB4F6w3qJvJa+tb
	 0gqIsMqA4Pr4aj+ArALEOuhjf2HrGsE1Bk1EaMZDweNOGD2fLnLPgtnd6SoZyNzfOf
	 nalnmi2X7mdUwHuHg65QnnIgh0Hc7MUqkiv1zG/bV7r2z8oAMMhwFmNrOCt14eJnfk
	 KJgmdZpoUFVig==
Date: Tue, 13 Feb 2024 10:19:05 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ralf Schlatterbeck <rsc@runtux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <20240213161905.GA1459669-robh@kernel.org>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
 <Zcogl6tqbMdQldKA@smile.fi.intel.com>
 <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>

On Mon, Feb 12, 2024 at 02:59:02PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 14:43, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> >> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:
> > 
> > ...
> > 
> >> Anyway, binding examples should not be collection of unrelated
> >> solutions, because then we should accept for each device schema several
> >> other variations and combinations.
> > 
> > Is this documented?
> 
> Yes, writing schema says what the example is. We repeated it multiple
> times on multiple reviews, we made multiple commits multiple times and I
> briefly mentioned it also in my talks.

While yes, this is the guidance, I think this case has provided enough 
justification to keep it. Let's move on please.

Rob

