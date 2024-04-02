Return-Path: <linux-kernel+bounces-128297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759E8958FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680BC1C22674
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FF81332B3;
	Tue,  2 Apr 2024 15:58:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA41E480;
	Tue,  2 Apr 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073531; cv=none; b=HAVaW9WkdeMwNrvYLH19BPUkxIEuO4L/LxTjx91eu4aUgu/6VNbJmeXx7v9R8ZehfMZS752wMg3FxTRJNaf4hRS/Lre2Z6B5zxPdMdxVVdVmXmjgO3/qBc8s1SEE8TnYHxv9W2/03VzlR+pggTZPSJPBtGxzN/OIzMBAiq3Cur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073531; c=relaxed/simple;
	bh=Gidpon3Z5DPHUkBqcS5U3KP9v3VSp4F1/+bnIqyCBYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMyepY4zZ0x5zbMuBk+4Q5/VClr35VOgtPtxSxpBhXUvdyN2CCduI+9G0uCLLvEaAkBPFD0RSgsAPCgfi9S4262F7jMt01T4CrQ0U1UcA6M3me0cwcjVtvDKWzrNKhzWKeE3nMDYSuCKRRlFW6JKY8FADZR5rcEsSNbWJS9snb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654971007;
	Tue,  2 Apr 2024 08:59:19 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8863F7F5;
	Tue,  2 Apr 2024 08:58:44 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:58:34 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgwrKnx3hb59OG77@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto>
 <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>

On Tue, Apr 02, 2024 at 04:06:06PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 2, 2024 at 10:48 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> > On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> > > > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:
> 
> ...
> 
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/scmi_protocol.h>
> > > > > +#include <linux/slab.h>
> > > >
> > > > This is semi-random list of headers. Please, follow IWYU principle (include
> > > > what you use). There are a lot of inclusions I see missing (just in the context of
> > > > this page I see bits.h, types.h, and  asm/byteorder.h).
> > >
> > > Is there any documentation about this requirement?
> > > Some headers are already included by others.
> 
> The documentation here is called "a common sense".
> The C language is built like this and we expect that nobody will
> invest into the dependency hell that we have already, that's why IWYU
> principle, please follow it.
> 

Yes, but given that we have a growing number of SCMI protocols there is a
common local protocols.h header to group all includes needed by any
protocols: the idea behind this (and the devm_ saga down below) was to ease
development of protocols, since there are lots of them and growing, given
the SCMI spec is extensible.

> > Andy made (mostly) the same remarks on this same patch ~1-year ago on
> > this same patch while it was posted by Oleksii.
> >
> > And I told that time that most of the remarks around devm_ usage were
> > wrong due to how the SCMI core handles protocol initialization (using a
> > devres group transparently).
> >
> > This is what I answered that time.
> >
> > https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t
> >
> > I wont repeat myself, but, in a nutshell the memory allocation like it
> > is now is fine: a bit happens via devm_ at protocol initialization, the
> > other is doe via explicit kmalloc at runtime and freed via kfree at
> > remove time (if needed...i.e. checking the present flag of some structs)
> 
> This sounds like a mess. devm_ is expected to be used only for the
> ->probe() stage, otherwise you may consider cleanup.h (__free() macro)
> to have automatic free at the paths where memory is not needed.
> 

Indeed, this protocol_init code is called by the SCMI core once for all when
an SCMI driver tries at first to use this specific protocol by 'getting' its
protocol_ops, so it is indeed called inside the probe chain of the driver:
at this point you *can* decide to use devres to allocate memory and be assured
that if the init fails, or when the driver cease to use this protocol (calling
its remove()) and no other driver is using it, all the stuff that have been
allocated related to this protocol will be released by the core for you.
(using an internal devres group)

Without this you should handle manually all the deallocation manually on
the init error-paths AND also provide all the cleanup explicitly when
the protocol is no more used by any driver (multiple users of the same
protocol instance are possible)...for all protocols.

This is/was handy since, till now, all the SCMI querying and resources
allocation happened anyway all at once at init time...

..the mess, as you kindly called it, derives from the fact that this specific
protocol is the first and only one that does NOT allocate all that it needs
during the initialization (to minimize needless allocs for a lot of possibly
unused resources) and this lazy-initialization phase, done after init at runtime,
must be handled manually since it cannot be managed by the devres group that is
open/clsoed around init by the SCMI core.

I dont like particularly this split allocation but it has a reason and any
other solution seems more messy to me at the moment.

And I dont feel like changing all the SCMI protocol initialziation core code
(that address a lot more under the hood) is a desirable solution to address a
non-existent problem really.

> And the function naming doesn't suggest that you have a probe-remove
> pair. Moreover, if the init-deinit part is called in the probe-remove,
> the devm_ must not be mixed with non-devm ones, as it breaks the order
> and leads to subtle mistakes.
> 

Initialization order is enforced by SCMI core like this:

 @driver_probe->get_protocol_ops()
  @core/get_protocol_ops
     -> devres_group_open()
     -> protocol_init->devm_*()
     -> devres_group_close()
     -> driver_probing

   @runtime optional explicit_lazy_kmallocs inside the protocol
 
 @driver_remove->put_protocol_ops()
   @core/put_protocol_ops()
     -> protocol_denit->optional_explicit_kfree_of_the_above
     -> devres_group_release()
   -> driver_removing

.. dont think there's an ordering problem.

..note that the ph->dev provided in the protocol_init and used by devm_
is NOT the dev of the SCMI driver probe/remove that uses the get_protocol_ops,
it is an internal SCMI device associated with the core SCMI stack probing and
allocations, within which a devres group for the specific protocol is created
when that specific protocol is initialized...protocols are not fully
fledged drivers are just bits of the SCMI stack that are initialized when needed
(and possibly also loaded when needed for vendor protocols) and
de-initialzed when no more SCMI driver users exist for that protocol.

Thanks,
Cristian


