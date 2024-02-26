Return-Path: <linux-kernel+bounces-82290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713268681ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005A6B216E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48C130ADC;
	Mon, 26 Feb 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ebeCCNm4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B90199B8;
	Mon, 26 Feb 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979519; cv=none; b=BIP3UtV6qWnsCC/gjUyOoQ+EF5lgbo/V67jzJe86dlCY8YiLTZKAjA5d0niX4GActfAMyGquHLGme2sSs4j3e8sU91nXajDnSpwYCe5M3wcpQWPhz1r2iT5we6q2/xwzOJ1lkKRyv2ju8xGF7i/SzDf99kXadCU8V+e9DKEYDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979519; c=relaxed/simple;
	bh=4C+bE5HsGzaEfOQGU8y/IBgbGd2pqpwC1a13cokRUtU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rm9cK3LC/31QRhTiH3DhARej9el1b8XAIj1kwnplOffAQ19lNd8ZH7IMiBlNu0qyUYywAIRXLVlyIad9zWihYdXuIjUJrrumuuPLAgRZFMzpJZ4GhybeR1ZGwbLIJXKVYhtzjSwAkCGTx7LuHd3pWCm3f52Nrz7EVZs0FrodXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ebeCCNm4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708979513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgkhkzFTn7wBSSzufZLmACRcoMW2v8xqIcKy+t/APpQ=;
	b=ebeCCNm46pYWMAGDQgJWbwV1W1KLshsDhPpoMisXIYeU6s13a1Bf7gH2L8/SzH+BCBgG8X
	c5NRnUmtYcZhR105DjnCh8LhLeC6Hb8QSpiAtXFTm05Yj6JLG0aI812v+vQ4AW9Mp+b1fl
	rukat8h10wEaX4T5LzJeN7ieYL4/+i1PkpEraYD4y4AGyXhByVTfQvPuMLjQmkm+BBVYJo
	SMIRK/kd0LjunaCJfgHyTHJat6EASwf+5+QsrQcGacnlz3OWsKlRzzIk57ns9dPedYDTAe
	ABBgOqBqPQTnfumdSHcCymlBIfgNyXxS5WrDhsDK5y99xavc7ChSRNiQlvo8/Q==
Date: Mon, 26 Feb 2024 21:31:51 +0100
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
In-Reply-To: <CAHp75Vft3kJEF9JiuEqVsS3biQ6YsuDXON_P3FOZRjtb8NaB2w@mail.gmail.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
 <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
 <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
 <CAHp75Vft3kJEF9JiuEqVsS3biQ6YsuDXON_P3FOZRjtb8NaB2w@mail.gmail.com>
Message-ID: <d2a7954926e328cbf898aac0a42a6e24@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy and Quentin,

On 2024-02-23 15:39, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 3:10 PM Quentin Schulz
> <quentin.schulz@theobroma-systems.com> wrote:
>> On 2/23/24 14:00, Andy Shevchenko wrote:
>> > On Fri, Feb 23, 2024 at 2:46 PM Quentin Schulz <foss+kernel@0leil.net> wrote:
> 
> ...
> 
>> >> Cc: Quentin Schulz <foss+kernel@0leil.net>
>> >
>> > You may use the --cc option to `git send-email` instead of polluting
>> > commit messages, or move this after the '---' cutter line.
>> 
>> The whole point is that my SoB and authorship is from my professional
>> mail address which is likely to change over time, the Cc is my 
>> personal
>> one for development. Basically, in the event that I change my 
>> employer,
>> I would still be reachable at that Cc address without having to modify
>> the .mailmap after the fact (which won't make it to an earlier version
>> of the kernel for example). Some maintainers don't really like this,
>> some don't mind, we'll see in which category the IIO maintainer(s) 
>> fall
>> in :) (I don't mind either way just to be clear).
> 
> My point is that Cc and other similar (non-real-tags) stuff is
> polluting commit messages. It means that this will be copied to the
> Git index to all kernel git repositories in the world from now and
> then, This is at bare minimum makes additional burden on git log (and
> parsing and so on) and moreover, wastes resources becoming less
> environment friendly (no jokes). Using --cc or moving to the behind
> the commit message will keep email copied with cleaner commit
> messages. Yet, all email tags are available in lore archive
> (lore.kernel.org). Please, really reconsider the commit messages
> content in the Linux kernel project and elsewhere, it will help to
> make the world more friendly.

Believe it or not, I'm working on some patches for Git that, I believe,
should help a lot when it comes to handling Cc: addresses.  Would you
like to be included in the list of recipients for those Git patches, so
you could, hopefully, provide some feeback?

