Return-Path: <linux-kernel+bounces-65461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06747854D61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2227AB22719
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C65D916;
	Wed, 14 Feb 2024 15:52:17 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE55D8EF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925937; cv=none; b=A2B3SjaeiIqrmgl5laqwICMq1ghgR+MSdVxBRkCKbklkZLlaBNvCyJsUbfpIrBhtH55NmlYUhr67VWrGq7V4RaVLWUePq2ptoVsQJcX3WefOnOg59qOYl/ZjTM+kj3U4r/T7/ljPk+sf3YntUNO9z86XDViuKqt7W/bOIYiy0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925937; c=relaxed/simple;
	bh=V6qNUL1nKdXu54YcvU1XIkiQF5/92WTEtIFup0YeBAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2IfQ/olqeGpB/JHeJrXbYYyzZRtzsjwV6wvkhHVNS5UBNJCwMhoZdwmXIjPioBTtd8vcja+XJ2f8nnhy74544fH1puwK/sbaD02EW6vMkWV9p12RZE3RVKMJxZv9nyAqQbGbRzeDXG7moaFJYrCCOihznfjzix507yruF/a2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 15:52:13 +0000
Message-ID: <8b469fca-e1bd-4c7b-9311-cf4d2270f8cd@sdfg.com.ar>
Date: Wed, 14 Feb 2024 12:52:10 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-5-rodrigo@sdfg.com.ar>
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240129141516.198636-5-rodrigo@sdfg.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 15:15, Rodrigo Campos wrote:
> +		/* For functions that take a long buffer, like strlcat() */
> +		char buf[7] = "foo";
> +

I've improved this to not be the same length as the other buffer (we 
can't catch mistakes like confusing the src and dst buffers like that) 
and added some trailing chars, so we also test that the \0 is added at 
the exactly right position.

