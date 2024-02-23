Return-Path: <linux-kernel+bounces-78428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6286135A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2821C213CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FB7FBBD;
	Fri, 23 Feb 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Micciz/v"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F07EEEF;
	Fri, 23 Feb 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696341; cv=none; b=U0yM+wKqCx8+FXudgM7Jjk2gPNqaELIJUNqpgCEvBfbwzqvTTDd+KyRBnhe5koE5XBNUCxQBHhEjsFjohTPzjMmUsVP+r/9CCY3yh8opvN49eYjjuroASbgrtnYAgiJo3U4bGSDBuO8jm4mIxxhw6684/jAgQPTjakLGdbO3ANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696341; c=relaxed/simple;
	bh=SSbcekuKU37u4iVwr4v1BamUBWLf7HRQlSNIexqrmUg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fdNBT3UkifCUMpy8GNky160ZGdCNwpVBe2B8bqix1G7sUm3V+giCmCCcsrMQRpYq1HmcKUVbwT6P4Kp/mIbUP/n/PWEcPZOwsXOFkVhBPpwOHTbBwvfS6RIfKujy3/NTZTHTr9Q+/ivX14YqjwHkEtCKj5f0idq4zp7q9ZNQhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Micciz/v; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.1.114] (unknown [185.145.125.130])
	by mail.ispras.ru (Postfix) with ESMTPSA id C677740F1DCF;
	Fri, 23 Feb 2024 13:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C677740F1DCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1708696333;
	bh=wGQQwmvAj0Pr85DaZXbE5myrycMIAmGkPsozBb2dZhw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Micciz/vvQ6zbKhkOD8kAazqyBmZsTQPv1bkvQ6s8tniNnEx6m3nVMHY919s8ZRVA
	 56Wovr8rexRyJtOl/LcQz/pfXCA/+ZvdHHcmdfFLc1Ei/Vy22anjMIASgFfhK5s4da
	 5w7jZ28VBNtO764szi9zMIxZdTSZgW4RKfgeaI54=
Subject: Re: Linux 5.10.210
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
References: <2024022358-routine-selector-0770@gregkh>
 <2024022358-cope-dividend-760c@gregkh>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <7806f609-35df-747f-1166-b83df8c25d82@ispras.ru>
Date: Fri, 23 Feb 2024 16:52:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024022358-cope-dividend-760c@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit

On 23.02.2024 11:18, Greg Kroah-Hartman wrote:
> 16ad71c250c180a095f9d11b02579b81a47aaa84
> diff --git a/Makefile b/Makefile
> index a4b42141ba1b..613b25d330b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  VERSION = 5
>  PATCHLEVEL = 10
> -SUBLEVEL = 208
> +SUBLEVEL = 209
>  EXTRAVERSION =
>  NAME = Dare mighty things
>  
> 

Looks like something goes wrong with scripts here.

--
Alexey Khoroshilov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org

