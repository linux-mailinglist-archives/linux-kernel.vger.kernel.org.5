Return-Path: <linux-kernel+bounces-122672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66588FB37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FD81C2519C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABFA657B6;
	Thu, 28 Mar 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lq1NRdOE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dzcrld9B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9iW08zh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="whEj5fn7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12D59B7A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617584; cv=none; b=Mmv1yHVlW+87EkhlKZ68a4VkKWnWTey3l5M+xLcE8PJEzq6KIXIxkyEnVT1S2JH2fo4wiKoNIA7rt6ealKDDMrzntZitXlC43J43BRubzhRlYMtMRyKp0kRN1njPkqqQ+Bpowv0oPgF5PYmd/JZa7jQz0cbkvkaE1LCqmVTTQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617584; c=relaxed/simple;
	bh=CT42nVx0KJiYgUvifXk3RG3r4PtdscMZCrK5HYFET0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWElIH/Gk6k4SENcisSccvHW7dvp3k47d9JZsBF+S5wXfjd2M1i2312JYI9VltC05k7I8/0djaIP5fbua6vk0xILSnpvPEyvhbSRuJ7FH9SbnBIfy2P578V+bmnxESbp8HsyxoeKdIyCkmWBLc/aUJdF7kfj8jRzJJOqQYBN2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lq1NRdOE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dzcrld9B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9iW08zh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=whEj5fn7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id E844F33C90;
	Thu, 28 Mar 2024 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711617581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCUD+Fm+27N2UlU9YzPKCx9HxP70bveIrJEb1pJ2WgE=;
	b=lq1NRdOEqAcuyWJNOxAcsqTZYt56wvs4Oa7sisjDWgvuUjJ3V7A9wXvxyYZcKxeSQYCpbJ
	4xE5rzqBfzMZux5RQs7ZuXIOA5yJwe2nmazhVlLM20Yok1Xel+52NkWWsI351kFYgwxEbW
	MnKN7IZgPtp5exDsB3XWiqEe/MKJyOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711617581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCUD+Fm+27N2UlU9YzPKCx9HxP70bveIrJEb1pJ2WgE=;
	b=Dzcrld9BscW+BIGThR36jlBbZ6JLpEd+5TIy+PkJzY3T7cwmWua7HHJg2SAmyhNGtffMni
	7smBvuLH7ripKqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711617580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCUD+Fm+27N2UlU9YzPKCx9HxP70bveIrJEb1pJ2WgE=;
	b=h9iW08zhQpcFKFcUzo7Air3WTrg3U7WYMvnU5TWAbv9FiWkZCLUo6fgNQii45vFtAej1EJ
	MrLyiCRECilRdkWyM/r8tqupLrCd+fQbJyjQfbdd+wPEa3z+fSpU06VGhY112wS6bWotmY
	TzNYuDeiBwmNvE+Z6MMqCjhuxjsd2D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711617580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCUD+Fm+27N2UlU9YzPKCx9HxP70bveIrJEb1pJ2WgE=;
	b=whEj5fn7a/34PhtWFfAELCRu0atKNUoNfBgNWASV7r8bUKZZl7K6iGRE6NDloz8Tm0t1jH
	9e/unmnO669lpiCQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id CF2F64AACE2; Thu, 28 Mar 2024 10:19:40 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: 6.9-rc1 regression: irq: no irq domain found for
 interrupt-controller@c000000
In-Reply-To: <b929afe5-c148-499a-906d-fcf208b02fcc@sifive.com> (Samuel
	Holland's message of "Wed, 27 Mar 2024 07:56:20 -0500")
References: <mvmplvfg90v.fsf@suse.de>
	<b929afe5-c148-499a-906d-fcf208b02fcc@sifive.com>
X-Yow: Yow!  Is my fallout shelter termite proof?
Date: Thu, 28 Mar 2024 10:19:40 +0100
Message-ID: <mvmil16g1cj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.98)[99.91%]
X-Spam-Flag: NO

On Mär 27 2024, Samuel Holland wrote:

> Hi Andreas,
>
> On 2024-03-27 7:21 AM, Andreas Schwab wrote:
>> The SiFive ccache driver fails to look up its irqs:
>> 
>> [    0.762329] irq: no irq domain found for interrupt-controller@c000000 !
>> [    0.769358] CCACHE: Could not request IRQ 0
>> 
>> This is fatal for the JH7100 based boards, since they depend on it for
>> their DMA noncoherence.
>
> I have posted a fix at
> https://lore.kernel.org/linux-riscv/20240327054537.424980-1-samuel.holland@sifive.com/

Thanks, I can confirm that this fixes the issue.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

