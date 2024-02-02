Return-Path: <linux-kernel+bounces-49859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF784709A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8051F2CF0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6983D63;
	Fri,  2 Feb 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO697k6z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE31FBE;
	Fri,  2 Feb 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877956; cv=none; b=IGGK5gIKDKDu9X1xxgmLEFlQt7jFGWqVKuGpguHxZFI9zBE7dKq/2WEFkHhkjs4TFVhR0oSdsVIXVqfAnyn1I574aKfjnsCP99YiqhWcIOWrrLOlxvonK6Z4dJj1ZgObRNlstvhNNXI8DjyFHZc4Npg8IJQPAQlU+Q6CMh1ckZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877956; c=relaxed/simple;
	bh=FDgIgQx6F4Vxc/zUiQjVU9edU9DR2pbGAwQcgEUKIEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5sjq/6h1qzUJ3IE/RfxC5585R2AfstFhacgbg0JLfZsbsSGv6tngOS5APJzeux5Liypv+LIM8uU5V0kYOClSAenGg5qMWF7elwpKRxyf3oZDL3i48ZgQhtOqUTgVNUVh7sdGhYomWUlW5/ikAAybBILVmJbwCMnCJFjPKzIsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO697k6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3115DC433C7;
	Fri,  2 Feb 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877955;
	bh=FDgIgQx6F4Vxc/zUiQjVU9edU9DR2pbGAwQcgEUKIEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO697k6zqBlZI4D07eSvvtibwaiYa9NSdujicLlb2Y09jSNLv65v1vdw+ztroY8Bw
	 tinMCuatAQ0n/OEENX0o4wEtfO1/TALh6KlE61qjgMH6gAYxhp60xwNEnXwzD8zFEE
	 JkvwMbU6xA7wo972Rc9n5a4xCrhGsfjX4xsXziN51B9QKidjTEZA38j0HNoFrzhghY
	 A8ZrLPa8HffDNpa5+69VhIv1uxL0Bu2Zib/vIhc26HGgsRA8gBVwfWlY7Reyd61Asw
	 4Nu3+YLAA/AasZ8RPOcSZfbFuqytkj97ieo8MGY36dVBe9CxXCIkdV5o48dpVmYgKz
	 QBFkJZMtxX6vw==
Date: Fri, 2 Feb 2024 12:45:50 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
Message-ID: <20240202124550.GE1379817@google.com>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
 <20240125122634.GE74950@google.com>
 <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>
 <20240131110311.GI8551@google.com>
 <CYTURHOW0WMR.2UMOT0D1GFZ2W@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYTURHOW0WMR.2UMOT0D1GFZ2W@gimli.ms.mff.cuni.cz>

On Thu, 01 Feb 2024, Karel Balej wrote:

> Lee Jones, 2024-01-31T11:03:11+00:00:
> > On Sun, 28 Jan 2024, Karel Balej wrote:
> > > > > +	/* GPIO1: DVC, GPIO0: input */
> > > > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
> > > >
> > > > Shouldn't you set these up using Pintrl?
> > > 
> > > You mean to add a new MFD cell for the pins and write the respective
> > > driver? The downstream implementation has no such thing so I'm not sure
> > > if I would be able to do that from scratch.
> >
> > This is not a Pinctrl driver.
> >
> > Isn't there a generic API you can use?
> 
> I'm sorry, I don't think I understand what you mean.

Perhaps I misunderstand the code.  It looks like this regmap patch hack
is configuring pins and a bunch of other things.  Would that be a
correct assessment?

If so, where do we draw the line here?  Do we accept a 1000 line driver
which configures a large SoC with a bunch of bespoke register writes?

-- 
Lee Jones [李琼斯]

