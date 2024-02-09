Return-Path: <linux-kernel+bounces-59238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE484F3A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C915B281537
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA020300;
	Fri,  9 Feb 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uo5bmkFy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4091DA52;
	Fri,  9 Feb 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475427; cv=none; b=jJdlgoChvmvZ00wWlHwaLggxp1CAO82LIdiUsUdUqlBlN7L42b7C3uGo7Kyzdv8AeaFyUiHHOKkPz/khYk4IvQvfJ1hqvMUhwdOe44wpcZMVbO6Q2nfFoajqI0c57rQE0p/Y+7VRH0Bd0mLyazMirdu7uGiTBr8bQaPJu7FBdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475427; c=relaxed/simple;
	bh=XGOcEQpCEz7+aBrJ/3advf05cWhhKVfgPNw4Gll2W6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q03TVEvNfcIoHtd62pkezKswtYUWIpd9hobaN8Np71AYNsXoGMxq6YOkdffba5yQHQSHueGhQH6zJst1kvO1SYhGZKaXfzGcJ9dhrSZfHscLzdpXPLuL/8pvDVlOPJ7eqejqryxCi4YbKQdViIklQ9gIP8onJrmsrTW6vo7cQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uo5bmkFy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707475424;
	bh=XGOcEQpCEz7+aBrJ/3advf05cWhhKVfgPNw4Gll2W6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uo5bmkFyaOON7oMs67Ewrv6kTDqWYGpmY3I3yCwMdOFmLsf5N5yp0rmKkjvh6TGIv
	 ZyjCXA3h94b9oeudN7dvSH3/I8eq90SEOjFN7NpdQ1ubMNXHADRv2D9vWNX55hdQhl
	 DaeHkSo2DwMVnVYPuLQ7qfoNu4eoM/teNLdmsl695KzATyDVasHlbEkdCn/IMGRExw
	 A6FCc1f5aVTbTkNmfeE8pVtWI3ooSlYlnwbVhqC1JnF9hpSpvSExZFVNBU7hysgUOY
	 FH2Dm91U/XQFD948FehzzJh1mqrWU8cfXCLgjOg3xoGlQdXBO1kc33HZLg4/QRnkjv
	 QcqibOg/gHviQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B2503782078;
	Fri,  9 Feb 2024 10:43:43 +0000 (UTC)
Message-ID: <c47db4cb-cfb3-4e1c-88c9-f8b82c805b31@collabora.com>
Date: Fri, 9 Feb 2024 12:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: Fix locking in ACP IRQ handler
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
 <ZcX57PGUn5cABns1@finisterre.sirena.org.uk>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZcX57PGUn5cABns1@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 12:09, Mark Brown wrote:
> On Fri, Feb 09, 2024 at 01:43:14AM +0200, Cristian Ciocaltea wrote:
> 
>> 1707255557.133976 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
>> 1707255557.134068 kernel: in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 502, name: irq/66-AudioDSP
>> 1707255557.134089 kernel: preempt_count: 1, expected: 0
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

The commit message got indeed larger than I initially expected as I
tried to document two different contexts.  Should I try to shrink this
up a bit and resend the patch?

Thanks,
Cristian

