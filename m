Return-Path: <linux-kernel+bounces-140717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CE28A1832
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15141F22BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2F14F65;
	Thu, 11 Apr 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpCxADfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3631757D;
	Thu, 11 Apr 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848070; cv=none; b=UUwYrvXJgXIxdWFautONVgRpqawRy/kN/8UfVEgRbto8UCMcwPwm6nVKLa+BzMf7EZfWe7g7DpoSAgUHk41iDvjxP6z3P7rqY4vIVqOAYuk8nfcxPAaTA6NS1LE51XDbwJri2WQDNbk1BK40a5DE3+/acLTZTNpMhhViQHXlvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848070; c=relaxed/simple;
	bh=CuTXFk8SVpH9bAwJ78Sr0NeaVIli6W0UqoQ/W4nDbpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAcQj83tGBoJzZpE1xxiCwmmEypZT2S26+ebSFxTC0r718ycVKztDqm3EssUHl/kOApMrNjj9lRP02FrOfGxQAtP1WesF2ofY4D8uT5HECE9h8nJfXYKVuUsRNOlvrm7FuY8e9XqMWcmQVm4PDePlmjtv0Sew1SX0NX0nWIOFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpCxADfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B0C113CD;
	Thu, 11 Apr 2024 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848070;
	bh=CuTXFk8SVpH9bAwJ78Sr0NeaVIli6W0UqoQ/W4nDbpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpCxADfBRhPK3MYJZqIA7y+CjSDlrrefPUKuyM0WAgNZLPSdbGnO9jNRT/KvAWGsC
	 JbntGXbZ7oLL/lelO5KwfP8TxaL98Vns85TYtL5lUGxBBSWRuj/+zgxbYpNHj9w7uf
	 kD35iD0IvhNR9icnehYe18fRaQbhZ7mHF+6OeNLZnJwWOFbagOw0o9xPQLs3B6pJqw
	 N2g51Em6GroJ9xJtF1jhvzL3s57lv+6LlkBQVJWjAKzcAiA8rN+LDqD921Wy6QbKa1
	 fn1NIbL0ZAuoCaeRdNUUfPKa2gQT+8Urbgeazte/gMawz7w4P2L6ol8DXD0U7zRnAj
	 rKwcbLS2yb/nw==
Date: Thu, 11 Apr 2024 16:07:44 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, tools@kernel.org
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add missing simple
 syscon compatibles
Message-ID: <20240411150744.GE2399047@google.com>
References: <20240402202413.757283-1-robh@kernel.org>
 <171283980874.2354899.3662943965972729204.b4-ty@kernel.org>
 <CAL_JsqL5M0gvjBa7VvRm9B3kRpj8=c6f8k2MnG7LbA-jZstB8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL5M0gvjBa7VvRm9B3kRpj8=c6f8k2MnG7LbA-jZstB8A@mail.gmail.com>

+tools@kernel.org

On Thu, 11 Apr 2024, Rob Herring wrote:

> On Thu, Apr 11, 2024 at 7:50 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 02 Apr 2024 15:24:11 -0500, Rob Herring wrote:
> > > Add various "simple" syscon compatibles which were undocumented or
> > > still documented with old text bindings.
> > >
> > > apm,xgene-csw, apm,xgene-efuse, apm,xgene-mcb, apm,xgene-rb,
> > > fsl,ls1088a-reset, marvell,armada-3700-cpu-misc,
> > > mediatek,mt2712-pctl-a-syscfg, mediatek,mt6397-pctl-pmic-syscfg, and
> > > mediatek,mt8173-pctl-a-syscfg were all undocumented, but are in use
> > > already. Remove the old text binding docs for the others.
> > >
> > > [...]
> >
> > Applied, thanks!
> 
> Note that something is going haywire with b4 or you applied a subset
> of a single patch... I really wish b4 didn't change the subjects at
> all since Gmail is incapable of following standard threading.

I think "haywire" is a bit drastic. :)

It's to do with the way I fetch patches from the list:

    b4 am -3 -slt ${PATCHES} -o - ${id} > ${MBOX}

Where ${PATCHES}:

    if [ "${RANGE}" != "" ]; then
        PATCHES="-P ${RANGE}"
    elif [ "${SET}" == "" ]; then
        PATCHES="-P _"  # We need this to pluck patches from sets
    fi

`-P _` means cherry-pick, which doesn't appear to know whether we're
picking up an entire set containing only a single patch or pulling out
an individual patch from a larger set.

There is an option to add a new Mutt key binding to do it which drops
the `-P _` part in the former case, but I've ran out of free keys!

Present Mutt bindings for kernel maintenance:

macro index,pager  M         '<pipe-entry>~/bin/apply-patch.sh mfd-next<enter>'
macro index,pager  F         '<pipe-entry>~/bin/apply-patch.sh mfd-fixes<enter>'
macro index,pager  B         '<pipe-entry>~/bin/apply-patch.sh backlight-next<enter>'
macro index,pager  L         '<pipe-entry>~/bin/apply-patch.sh leds-next<enter>'
macro index,pager  T         '<pipe-entry>~/bin/apply-patch.sh toys<enter>'
- These all apply single patches (single submissions or cherry-picks from sets)

macro index,pager  S         '<pipe-entry>~/bin/apply-patch.sh set<enter>'
- This presents a menu of kernel repos, then applies the whole set to ${choice}

macro index,pager  R         '<pipe-entry>~/bin/apply-patch.sh range<enter>'
- This presents a prompt to enter a given range (e.g. 1-3,6,8)
- Followed by a menu of kernel repos, then applies the range to ${choice}

macro index,pager  A         '<copy-message>=patches-to-apply<enter><enter>'
- Manually applies patches from a mail folder (does not use b4)

-- 
Lee Jones [李琼斯]

