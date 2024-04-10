Return-Path: <linux-kernel+bounces-139345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1498A01A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5861C23475
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9F181D1B;
	Wed, 10 Apr 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gXHSiOuY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003C181CE7;
	Wed, 10 Apr 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783014; cv=none; b=nkder3BmqfpwNuvHmFjsrloiXoEz0pFxo2SnjWzmNc4dP4UaUT8+BsqXwNZNhKjEMCrNMYvOZyWuA+xEkseG6fa5tZlrMm80nCC2GkuxRZG2ulriVnwY6Hybpf+FbIp4PTGmjt1pJFv6NPVCiS7K8wIe70Dd82A7ncFpqWkeXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783014; c=relaxed/simple;
	bh=xDvcLUt8TABbBKvvueZklfK8OPJKY7AI2ONeDlESIcQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAHR152jjNajJnl5Ou68uEXk/2dvmT0FEmYc2pO/WuCyi06JlJ4L5u6eZG38gooysf93dmOMS6OBWy4N/yTCdLmv1OnNkHpo6RNbIJggcaz/zxx0y/wTdMxwobhUJX6NIfvEOj0JnCIlT4e46B7UxXr3g6+uhsb+GnMwDSqkKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gXHSiOuY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7E39747C26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712783010; bh=QIVGDSoFQ4yNcDIaV0oF4mQgbe7AuQp2+Z1TRp+EZMU=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=gXHSiOuYGPAR7WIXpjTsK98AsZfUvBPbha2zh1/R37mHW+RA/YCGhdFLjnQJ9CL9a
	 yqYSu6WIi82pQpz9Xfqh9DzpffHvmH/fmia+Qux9vdji+mZTgtPButOm8+2qgq34fn
	 I/HXJwS+b+BH6xgQbaA4YPciOca3rG3SfCfSDpoDcVYv4C24GsAc+lHRJwX4AoA46F
	 tixgu7SuY4rTA1k06O0ihymNpBAM0F+YD9LB4Q5m2EuLjR0Z0mrHxFhy/uUv6JzOcI
	 9CyysEHisNAJA7F6ownxXHEOtNFxad68BxiOjxq9ViDpIKsM7iVKn6RXnjcbn+m45y
	 CgQkVqGWKcv2w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7E39747C26;
	Wed, 10 Apr 2024 21:03:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Karel Balej <balejk@matfyz.cz>,
 regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: *-regressions.rst: unify quoting, add missing
 word
In-Reply-To: <3e53f18c-12aa-4bf8-b3f7-7945bbca6882@leemhuis.info>
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-2-balejk@matfyz.cz>
 <3e53f18c-12aa-4bf8-b3f7-7945bbca6882@leemhuis.info>
Date: Wed, 10 Apr 2024 15:03:29 -0600
Message-ID: <874jc9szfi.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 28.03.24 20:29, Karel Balej wrote:
>> Quoting of the '"no regressions" rule' expression differs between
>> occurrences, sometimes being presented as '"no regressions rule"'. Unify
>> the quoting using the first form which seems semantically correct or is
>> at least used dominantly, albeit marginally.
>> 
>> One of the occurrences is obviously missing the 'rule' part -- add it.
>> 
>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>
> Thx for this:
>
> Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>

I've applied this patch; part 2, it seems, is subject to further work so
I have not applied that one.

Thanks,

jon

