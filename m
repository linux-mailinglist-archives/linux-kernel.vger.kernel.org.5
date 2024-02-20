Return-Path: <linux-kernel+bounces-73592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66C85C4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FF1F25570
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323C1369A8;
	Tue, 20 Feb 2024 19:26:05 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D98135A4D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457165; cv=none; b=FPrq/q/cvHOJ2GefNLpihJa3cHaHolFTXlXnw/xmGqqOLPJ8UM0/SemzBskxQtn2rND1yWxoWGtSwjY370ur60+G2oQmOA1F7HU/1nasvju8Qtll5JBqOSJsVMOEHF0VrsGqzplJwNcMMAIZQiR9Q12YSEmM2Z/C41UTPvYDiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457165; c=relaxed/simple;
	bh=QYmCLvI3FZYQ2QPMQa3QPVInMibi7cvFQXZmIXVIhO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTaVy3NLx3bl692MBfKaG6HOupqrXdbPNCNEiMr0MzSLX1/m+4iHR5R+IePgjTvkG9Aa2Qm1+4svMeNJsKGAQtKFZPBrA4m/0UBkPuLGotLJQrxVBIfrTuxjGkaU1TO/GsHtg1cGIX7whqi+IpiQKZLduqY0sKaHkfm3nsBzKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Tue, 20 Feb 2024 19:25:54 +0000
Message-ID: <566d21cd-c634-4fab-80b4-9111ca0b9f8d@sdfg.com.ar>
Date: Tue, 20 Feb 2024 16:25:50 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Misc fixes for strlcpy() and strlcat()
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240219204821.GA9819@1wt.eu>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240219204821.GA9819@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 17:48, Willy Tarreau wrote:
> Hi Rodrigo,
>  > I finally decided not
> to change your comment for '/*' on a single line because it turns out
> that the file in question almost exclusively uses the shorter, net-style
> comments like you did, and you were probably inspired by the surrounding
> ones.

Heh, makes sense, I usually do check the file style before writing the 
first comment. Maybe it was that, hard to know :D

> 
> Many thanks for your work and your patience ;-)

Thank you!

