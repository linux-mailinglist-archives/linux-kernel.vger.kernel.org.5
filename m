Return-Path: <linux-kernel+bounces-151102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF188AA921
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404531F21AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9494087C;
	Fri, 19 Apr 2024 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4zM+gxI1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46592E3F2;
	Fri, 19 Apr 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511606; cv=none; b=p+j/oGM3OrrYYFvMEjz93pmDLPN8BBi4j8A4ZLnGiAxSAwYB/3t3FjVzkQGG729GwHv7so7kfXp0ZYg53S7dVgNY3mlekSdX8ZuDnqxgW6Pkw7efxD9gb3cjnWV/oy/jnFBfXq3QxoTLNAyBKz0Xqo16NmXaD4/h6KQPtcFeiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511606; c=relaxed/simple;
	bh=NbiX6SQgDac8YMpn0q71EvxqdfagHCgz6XEdm25gKWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfgg8CjBLEq7J3yTG4xbJ+JUgROM1JME2AFzzbwv3NkoykcArDgNIBNfv6HfafhRxPMxQRxlzSfmyeN86Lb8E3ouzx7seYm3i5CNAjmzKprrG7e0MYXgp1OIliDf72Sjr2kHEb21nb24RIj4+27xixctC96Moul07i7Lgr9etms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4zM+gxI1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713511603;
	bh=NbiX6SQgDac8YMpn0q71EvxqdfagHCgz6XEdm25gKWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4zM+gxI1fphZpJ/WXGnyXqU3d1RrtwcZGGsTFDRZexxL+wj3LnDTprdHJt6z73T5r
	 Hs8pHuIDjO2zZDlIy6ZklXNVdjMP4LU281TBF+rfA4+zRofL9k1ivtj5farMG0r2Hs
	 oZ9Os8TOsdC7mTcXXD+JTXiM8G+aWYyOTnDNp/E8eNBiOa2d440iBjgirrHCNIxckh
	 A3H6KMaoLkh/6/RsApVgxvQFJuuXopH/4lByR0f3YKhwckjfurBOrGoO2Dm/xVyqrt
	 ZRn7KFrnhBwhRnuuxFUze8Hw1rt2UBVsf+OurP8Sx/5abATZcnhQdZXZU7nlptTjIO
	 vD+KGU0kuZI8g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 769203781104;
	Fri, 19 Apr 2024 07:26:42 +0000 (UTC)
Message-ID: <f8c0bdd4-58fb-45a5-a70e-cc97f176222e@collabora.com>
Date: Fri, 19 Apr 2024 09:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/04/24 19:34, Nícolas F. R. A. Prado ha scritto:
> Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> specification as required, it seems that not all batteries implement it.
> On platforms with such batteries, reading the property will cause an
> error to be printed:
> 
> power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> 
> This not only pollutes the log, distracting from real problems on the
> device, but also prevents the uevent file from being read since it
> contains all properties, including the faulty one.
> 
> The following table summarizes the findings for a handful of platforms:
> 
> Platform                                Status  Manufacturer    Model
> ------------------------------------------------------------------------
> mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> rk3399-gru-kevin                        OK      SDI             4352D51
> 
> Detect if this is one of the quirky batteries during presence update, so
> that hot-plugging works as expected, and if so report -ENODATA for
> POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> prevents throwing errors.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Nícolas, please, I think that sending this commit to stable for backporting
makes a lot of sense since you're actually fixing laptops (that does not
really require a Fixes tag) that are supported upstream since .. lots of time
ago.

In any case, this LGTM.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


