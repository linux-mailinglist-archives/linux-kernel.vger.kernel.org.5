Return-Path: <linux-kernel+bounces-56503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739984CAF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E141C24765
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FC7605C;
	Wed,  7 Feb 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ouZ6Mk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ABD76034;
	Wed,  7 Feb 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310543; cv=none; b=UPmgSZ/ayoy+DJkp7SAworf4ycrZgwUhiVn2ZzQkTr+MVKfTbvEB4WsLj1aVe5EqTAY/w9NwWhEDl5Ce4N+UddC1sn/myOSgyDwVpTfUI9K8iwZO358VaCdL2ntFkd5fkkMzSaGbispHRCwdeynn9Ttns0nLRhiFYigMAsyS2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310543; c=relaxed/simple;
	bh=OqO47zrMtFcqPOc5eFmBtHhP/Vp4uEHbdMjDNWFDyDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayr0Eaz9b9VNqWJCita3Oe5YU1uIdxNeAKkiw1KT0DfJQoUg0CPWqhnd4rNmDhqa38++tRhtvMth6fGkBEWyqfJeAt7RquY4gS7H5eqyrkWAcc7rMX7bX2RcTRMkzr55UkVVmKIdAYHJDq/6vf9m7akIoF/3c/smIPK17OHJavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ouZ6Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295D0C433C7;
	Wed,  7 Feb 2024 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707310542;
	bh=OqO47zrMtFcqPOc5eFmBtHhP/Vp4uEHbdMjDNWFDyDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J2ouZ6MkZ6Aq1Hi0Y3We/Gn/CLPgFPHOZd3JpzD+EnxJrxY/Foaono86PQnCY3/3L
	 neeign9PDE8fspUqWU8jaMAslNYdvVw+DGmtJhgc5Rn+ssD4nLdgo7DtvxwEhZYrJ1
	 qi99a7HI7YJBfmvhKcS3oAAu5V3Ay6NZ98E8tfdyBczVYb5KvxTJ5ockjO/fh0T5rF
	 5AlCtH9ivlUGlQyNOz/3AJDmDqdG65BImOdkqBeDUq9R5OrvAgGbn/97dzFFSEApwD
	 e3J80Nn/F7DNsWbBuJd61iB+Hi+9LST8cs5A5aifhmI0xF2y65m94GUfRfkKpDWu87
	 NSuqC4hhG9B8A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <87plx8y5s3.fsf@all.your.base.are.belong.to.us>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87h6ily53k.fsf@all.your.base.are.belong.to.us>
 <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
 <874jekag3w.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XJYTfY4nXWtjK9OP1iXLDXBVF-=mN1SmJDmJ_dO5CohA@mail.gmail.com>
 <87plx8y5s3.fsf@all.your.base.are.belong.to.us>
Date: Wed, 07 Feb 2024 13:55:39 +0100
Message-ID: <87sf24mo1g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

>>> Hmm, seems like we're talking past each other, or at least I get the
>>> feeling I can't get my opinions out right. I'll try to do a quick PoC,
>>> to show you what I mean. That's probably easier than just talking about
>>> it. ...and maybe I'll come realizing I'm all wrong!
>>
>> I suggest to wait for my v13 and try something on top of that
>> otherwise we might duplicate efforts.
>
> OK!

I did some really rough code sketching, and I'm confident that you can
get rid of all ids_enabled_bitmap, hwirqs_used_bitmap, and the
corresponding functions/locks. I'd say one lock is enough, and the key
is having the per-cpu imsic_local_priv.vectors change from struct
imsic_vector * to struct imsic_vector **.

Using smp_call_function_single() to IPI enable (and disable if you don't
want to use the lazy timer disable mechanism) seems feasible as well!

(Let me know if you don't have the spare cycles, and I can help out.)


Bj=C3=B6rn

