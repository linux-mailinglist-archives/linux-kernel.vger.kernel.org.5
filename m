Return-Path: <linux-kernel+bounces-79673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD408862557
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63806B214EC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0024CB30;
	Sat, 24 Feb 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="fRU68jDr"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17423CE;
	Sat, 24 Feb 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782638; cv=none; b=rjh/y75BaM0QEdCzNRNZQ0PgT4OXJwUROcW8PH1Z3a6t0urqKtixT90mk48oghwcPucX1B+nsy0CNLNFEquGtFkKzD1t7xB1oDynraS6GrEx9BLzidTWVjksp3kcv3J7+NKIR6ZAlxsMB4LYvJrUkqq5A03/dHwDDq74qFMOnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782638; c=relaxed/simple;
	bh=bA7hd8w++uVUc0cYik9/qvIUQcO7GzpA41GuPWaRpSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcEewTSYz0WMtEiGCl3Esn6RjB5wExNnrfI8LqxwXt0jrw2REpc8Zvcpj7h/a0GDt+g83DjCocepmcvsiTI8Og2NKdhhFS2xuIomagy85z3ryPfc907Oinic2dC8AGsVFpK27TZlferzIFqxG+5DBCy0ufSQEynATTNc2IIfBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=fRU68jDr; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708782632; bh=bA7hd8w++uVUc0cYik9/qvIUQcO7GzpA41GuPWaRpSo=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=fRU68jDr6/yA2+a996tgyGvvxlFnaoOTaSl+8JflvQZR7JfIAmF+ZcAaLRKkP9Bxd
	 XcDXDkCQA4NlmnhnUctDY517DGukKuYjZZ27KJOP6JS6xPooh1jRCesn7xma1WIsEt
	 bE31ENl02kbCRDgr9DI3DqkZ0KGsdghfGWaVgfLY=
Date: Sat, 24 Feb 2024 14:50:32 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/5] dt-bindings: sound: Add jack-type property to
 sun8i-a33-codec
Message-ID: <sdkcau552puf5afga253hyxc3lqn3dmwk4hjlhojjfe5vvl5zh@ecrx7ecvsj4b>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240223015219.3618111-1-megi@xff.cz>
 <20240223015219.3618111-2-megi@xff.cz>
 <42d3ac7d-4b51-4332-8892-a4f03a315a80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d3ac7d-4b51-4332-8892-a4f03a315a80@kernel.org>

On Sat, Feb 24, 2024 at 11:31:07AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2024 02:52, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > The codec driver needs to know what jack connector is connected to
> > on the board. Add proprty to describe the type of connector.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.

Yeah, I did run the script on v3 where this patch was not present, and
forgot to re-run it on the new version. I'll resend. In any case I did run DT
tests on the patch.

kind regards,
	o.

> 
> Best regards,
> Krzysztof
> 

