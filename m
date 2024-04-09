Return-Path: <linux-kernel+bounces-136815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A513E89D897
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F8B2639A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EA12A144;
	Tue,  9 Apr 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJUuUUiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D16128826;
	Tue,  9 Apr 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663719; cv=none; b=qkpLWU9XaZ1gOrL6fnJycEWdEC1IYclnQFIgfugAWoR3s4AcqQuniwfXvGN6oC8/tZywvoGZxoQNndNgjUXzeeEGHfDZgJUK2pmtENQMwmVEYyuzvkTRMGYwPjHoPZjgPuLfCXL0yLDNjruDLcney7YLvdUQLUqX3vxqOKCuJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663719; c=relaxed/simple;
	bh=scdbxbgPLUxnACHLCarB1DGbiD0xhDlyeS1PSLZ+6/g=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=KooaOQ/GDSUg4LCYuPF58EBdfK1l12EqzGdrnMyA7Tboe8XUX6QjvHXH37T1ne9g8O4eoairo3BTCNfmrZZV8B/eEXVgiX8oBD+piHnJY4pZZZTHfBAe9AGh79FLqpN+W5GLDA40RMqpDU6gHSAp5q0jqj+n0sQoDcYzeIo7UKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJUuUUiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556A4C433C7;
	Tue,  9 Apr 2024 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712663718;
	bh=scdbxbgPLUxnACHLCarB1DGbiD0xhDlyeS1PSLZ+6/g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jJUuUUiHOEu9bts8I6ePvqW7e9BYs/4iyEclGOFfg661+yiwsyUiWSYxnTBJWK/Ml
	 HmGrjB5nAnJsMlsL/Hshp/R5qAhpi9IVUIHh0T4fie2MjKZG2nHz+9k0TDLJbw3/hX
	 tW+qboleyWZPwJEkIwEWUthoL0SEanLBKEUpg0MeWIZVa6FQ8dmXc9+9bVKyBkNLEI
	 5BqNWUQDWPA8DwXz5Pa2o6dFy4bv5+3SFUS6Mskuw7olJRmnvYPdBa32Mwk5sdQDy8
	 1YjYt650Q4wcvXixeF/oOo+DLrnsjBX7TYKqlpIRQMeSJQFBXSp+8YjJ0HB2i/WeBt
	 TlYAlQN6d+xQA==
Message-ID: <306af49fd69707feccb640d02dc4fbc5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPDyKFoGxxSzykQ-=o08LD_P_=8m=KRm4SHK_grBFgXNNv4OVw@mail.gmail.com>
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-5-sboyd@kernel.org> <c1dc0e4c1d4c9ba2b5e9c0fc207db267.sboyd@kernel.org> <CAPDyKFoGxxSzykQ-=o08LD_P_=8m=KRm4SHK_grBFgXNNv4OVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: Get runtime PM before walking tree during disable_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 09 Apr 2024 04:55:16 -0700
User-Agent: alot/0.10

Quoting Ulf Hansson (2024-04-09 03:32:04)
>=20
> Apologies for not being able to review this, it got lost in my email
> filters. Looks like you manage to solve the locking order for the clk
> disable unused thing - great!
>=20
> However I think the main problem we are seeing with these kind of
> locking issues is that we are holding a global lock while calling into
> pm_runtime_get|put*(). Similar problems have also been reported in the
> past. It's been on my todo list for quite some time to have a closer
> look, but I haven't reached it yet.
>=20
> Without going into too much detail, let me just ask a related
> question. Would it not be possible to call pm_runtime_get/put() within
> the clock framework, without *always* keeping the clock prepare lock
> acquired? I assume a clock can't be unregistered, as long as there is
> reference taken for it, right? Wouldn't that be a sufficient guarantee
> that it's okay to runtime_resume|suspend its corresponding device?

The problem is that the clk tree is being walked with the prepare_lock
held and during that walk pm_runtime_get() is called on different
devices. We hold the prepare_lock while walking the tree because we
don't want the tree topology to change while walking. The prepare_lock
is also a topology lock.

If we could walk the tree, figure out what all clks will change, drop
the prepare_lock, pm_runtime_get() all of those devices, regrab the
prepare_lock, check the topology to make sure topology hasn't changed,
and then make all the clk_ops calls, it would work because we have
extracted the runtime PM calls out of the prepare_lock. Dropping and
regrabbing the lock is probably a bad idea though, because we may never
make progress because we're preempted by another task that changes the
topology.

I was also wondering if we get stuck again if the clk driver
implementing the clk_ops is on some bus like i2c or spi, that runtime PM
resumes the bus controller for register writes from the clk_ops, and
that resume function calls clk operations, and that happens in another
thread. Maybe that isn't a problem though because the runtime resume of
the device will also runtime resume the parent which is spi or i2c?=20

Either way, it really seems like we need a per-clk prepare_lock. That
would let us know for sure the topology isn't changing while we walk the
tree and figure out what we're going to do. Anything that calls into the
clk framework again hopefully gets a different prepare lock for a
different clk.

BTW, I don't think lockdep is aware that runtime PM is waiting like
this for a parallel resume in another thread. Probably we need to add
annotations so that any locks held while waiting for the resume or
suspend to finish are chained to a pseudo read lock and the actual
resume/suspend operation is a pseudo write lock.

>=20
> Or maybe I should just send a patch. :-)
>=20

Sure! ;-)

