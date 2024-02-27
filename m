Return-Path: <linux-kernel+bounces-83442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEF869958
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D51283E54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E728148319;
	Tue, 27 Feb 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ociEBA5K"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389C146001;
	Tue, 27 Feb 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045740; cv=none; b=MvHFbiTI/HMYPLLrZQsOTdeUOPs7pT3VsVpYdJVpw9h4XN80jMtR47xUVX0xOrTduwbtJIM9wGe0rvF21AGpoYbH5/Ajchz4TKXND+14ZPSQN5IuFlQMQF1UaPZ8ZtmI/KhyIwPbl2a0pjF4rot25FgaKqaXByJce9bQdYX2BUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045740; c=relaxed/simple;
	bh=c6nAddq+joHIj3aBJ5XpAdzF2ktzWSmOTZPUik72jyg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bo+uCJK3Vu8yBoZ2BldGKB7Pe/IjQlQ/l0eXovKoviWviPcWvDpkoxlZEXvgSVn2un7BAN4Abeu3XnY4R1SXephwpTrdvWFfQHx2zX1V2CoJTisi451Os2hSBRI6WWDPBv+Aw8MZKGKEiiSvumdrjSDmdHdtykYLRbHWSWXVEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ociEBA5K; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709045729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+buA9KQcshQo11eLqij6u65fXQy9H9bVSZZKj/86ws=;
	b=ociEBA5Krod3ExR4KO+TwRlaQsQhio31/u7nVUn5SOGGQyPOonbCNwlQhh5OAbSa1XFGxJ
	WB7Ti9m8vg1Y1oVLvVW0Tn4lhAyjqCdU3CTH9DTZ02ATz8TWV5526kfE9EklDdzqv4fqoz
	S324zYaRdlnWk566Mg1rgII2+VpTrbLsGQrleCoivuW6Vtm9FO0T5NeOPM1u0IBbNZgFec
	g6GumCX2voAPVqqeqcMqH4bEn23soZUH/jpNiY97WXzSY8drPkS7YmNt9yq4ha5pXSCJVt
	l4YhisH4rgH+E7MX4uMTmYauBNuKFnTj/iYOR91SUz/I+vcU5tzEd2JxKiFgzQ==
Date: Tue, 27 Feb 2024 15:55:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Quentin Schulz
 <foss+kernel@0leil.net>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with
 devm_reset_control_get_optional_exclusive
In-Reply-To: <CAHp75VcuRacheLt=sAJz27RMEZqvZ8CAZSPvxgUbSFS-dUAAOg@mail.gmail.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
 <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
 <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
 <CAHp75Vft3kJEF9JiuEqVsS3biQ6YsuDXON_P3FOZRjtb8NaB2w@mail.gmail.com>
 <d2a7954926e328cbf898aac0a42a6e24@manjaro.org>
 <CAHp75VcuRacheLt=sAJz27RMEZqvZ8CAZSPvxgUbSFS-dUAAOg@mail.gmail.com>
Message-ID: <509bf12609dce4fb4bdccb657dd75a95@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-27 13:48, Andy Shevchenko wrote:
> On Mon, Feb 26, 2024 at 10:31 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-02-23 15:39, Andy Shevchenko wrote:
>> > On Fri, Feb 23, 2024 at 3:10 PM Quentin Schulz
>> > <quentin.schulz@theobroma-systems.com> wrote:
>> >> On 2/23/24 14:00, Andy Shevchenko wrote:
> 
> ...
> 
>> >> I would still be reachable at that Cc address without having to modify
>> >> the .mailmap after the fact (which won't make it to an earlier version
>> >> of the kernel for example). Some maintainers don't really like this,
>> >> some don't mind, we'll see in which category the IIO maintainer(s)
>> >> fall
>> >> in :) (I don't mind either way just to be clear).
>> >
>> > My point is that Cc and other similar (non-real-tags) stuff is
>> > polluting commit messages. It means that this will be copied to the
>> > Git index to all kernel git repositories in the world from now and
>> > then, This is at bare minimum makes additional burden on git log (and
>> > parsing and so on) and moreover, wastes resources becoming less
>> > environment friendly (no jokes). Using --cc or moving to the behind
>> > the commit message will keep email copied with cleaner commit
>> > messages. Yet, all email tags are available in lore archive
>> > (lore.kernel.org). Please, really reconsider the commit messages
>> > content in the Linux kernel project and elsewhere, it will help to
>> > make the world more friendly.
>> 
>> Believe it or not, I'm working on some patches for Git that, I 
>> believe,
>> should help a lot when it comes to handling Cc: addresses.  Would you
>> like to be included in the list of recipients for those Git patches, 
>> so
>> you could, hopefully, provide some feeback?
> 
> You may Cc me if you want to, but I can't guarantee I have time or
> valuable input to that.

Thanks, I'll be happy to have another set of eyes on those Git patches.

