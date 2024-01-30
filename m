Return-Path: <linux-kernel+bounces-45266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D22842DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0BA28B90B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28F79DD0;
	Tue, 30 Jan 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Av6xhef1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB58762C4;
	Tue, 30 Jan 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646558; cv=none; b=PA5CoqIDxlwLxRFXKYmJxtGkG6ZqPF7zmKpxFn2Ax9/AY542OeeZaxHKGo8KiQBR3G5/P/SYYFG2HT5XFKK7E7kIcR2RUwWPEDpPn6sSOf61WFjLImEe7GpKptyxCT+HnN4P33DHczHVCLz45wpdyObYRqJrVsQUTSz8qJWHyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646558; c=relaxed/simple;
	bh=c4Zn2fPM9nlKOdP7NYS6LCsExp/U5CB3n2huSaT6234=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsGjecphvpBjgZHvfTwUfajOfeJMVV5hPSOUcAVxwRmQm8NdfFg95xutaBBT1C9GQeGf6gP0LMrRrRNOPqKLp3nUpC04K/1/RUB647XyOqCEvCL6QuDS0nCzAR69rdmN7eyv01aU4BWb/4l5HRoTJ2O/j+1ZOKg0WOiRkZcjLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Av6xhef1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3F62A41A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706646556; bh=XxMlfKWWi9hCnxPW7oMQi87Q7yXv4M/LYZAS6n45AVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Av6xhef1nF8Fff2T5qkClsuGnlVj6PXzMe6Z4D0L9jaFvlL3vgRGB8AYvTG8s584o
	 Kha5c6mnmf3n1SVrf1p0Urpl9XQYchvYdm6ZylrWJUpJMEfiIKbYZgcV0XhJMMq/6M
	 +eC8UJdKMSo3IIxO9UOflbOOW7LgF0C0Lc+Q3tkqfzsn4+Aw04KSfZu3j68vf+W8v9
	 QMvU+EH5rWGT1IuCapgML5dItVWNj8bS1bzm4xbMB9Lccr8KfL5YqsZjvrFIkfKEEc
	 cyiqohlWgl4Ec92VvamC4bpf8fkxgoitNGrnDKLi1LdFCXr8wCdA3CGxkMdr0dcM0E
	 sEuU9vo2Iob8w==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3F62A41A47;
	Tue, 30 Jan 2024 20:29:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: drop looking for "MACDOC"
In-Reply-To: <20240108003700.13418-1-rdunlap@infradead.org>
References: <20240108003700.13418-1-rdunlap@infradead.org>
Date: Tue, 30 Jan 2024 13:29:15 -0700
Message-ID: <87a5ombm5g.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Linux kernel does not use "MACDOC" in any documenation or any
> source files, so stop searching for it.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/scripts/kernel-doc b/scripts/kernel-doc
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1907,7 +1907,7 @@ sub process_proto_function($$) {
>  
>      $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
>  
> -    if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#\s*define/)) {
> +    if ($x =~ /^#/ && $x !~ /^#\s*define/) {
>  	# do nothing
>      }

Applied, thanks.

jon

