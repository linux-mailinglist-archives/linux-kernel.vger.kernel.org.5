Return-Path: <linux-kernel+bounces-137344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A489E0DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162F11F22A97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA215381F;
	Tue,  9 Apr 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="KKkIWzjw"
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF971386C0;
	Tue,  9 Apr 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681675; cv=none; b=THPp+sRyVQtBJrNYnO/Aaiugxzny7IzQMbwFHh4SAnfXBt2sqLV9C8Fu4rZ8QvxecXpUaYx6HbTIFFo6wKpKGrTrf0DvjARFMUHMiTCVIIWa4G0FPZu98G9eoBnpRi2olNjMu3L7SSJA/dq9QqMY5MxtU3cQ8g4YqE/vql32z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681675; c=relaxed/simple;
	bh=HEj8fGwu2M7SCaKbJdG/QejwGPEN39S60SJHeImWezw=;
	h=Message-ID:From:To:Cc:References:In-Reply-To:Subject:Date:
	 MIME-Version:Content-Type; b=dDdLY2Jzef+16a8EQSrNgKBR4psz6uusVcdePLMF1p6qovLRcGIGQchlNZUqViUOJGtpGKiO6VK/NTcGl1REGt+VDDHdoIZdGaZn1t9pMWSSkVAIxltjXVkbXjxA0tvnLsNAUPVaxbo9r6/ZeVG33jNAFZ3Cr/IWoIdFacBvBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=KKkIWzjw; arc=none smtp.client-ip=145.253.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1712681663;
	bh=Oo30CQZlp5KZEr6FMyyQB9R5JI3hVckU9HntCkKGtq4=;
	h=Message-ID:From:To:References:In-Reply-To:Subject:Date:
	 Content-Type:X-Mailer:From;
	b=KKkIWzjwKJddxVViMBx4zI16tyG15t5cu5dDuNt0qeDI30LXWKnXfCUQGkOSiCLRi
	 9lBiKd0fyy/p+IHWbplCqd0jTKO4yKEtmn3TSDw5DcXSkHOX3z8waRAGY/1DtWAzSf
	 MxCVfDStDE/4i08MXEKCh5DmAtT+Bi4zRKvd1y8Q=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4VDX9q61dfz2FsG;
	Tue,  9 Apr 2024 16:54:23 +0000 (UTC)
Received: from H270 (p54805648.dip0.t-ipconnect.de [84.128.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VDX9Z3fKhz9sc3;
	Tue,  9 Apr 2024 16:54:07 +0000 (UTC)
Message-ID: <C0FA88ECA90F43B1BF9E7849C53440D7@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: "Eric Biggers" <ebiggers@kernel.org>,
	<linux-crypto@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
	<ardb@kernel.org>
References: <20240409124216.9261-1-ebiggers@kernel.org> <20240409124216.9261-2-ebiggers@kernel.org>
In-Reply-To: <20240409124216.9261-2-ebiggers@kernel.org>
Subject: Re: [PATCH 1/2] crypto: x86/sha256-ni - convert to use rounds macros
Date: Tue, 9 Apr 2024 18:52:02 +0200
Organization: Me, myself & IT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 783
X-purgate-ID: 155817::1712681659-FBFEDA47-1BACD483/0/0

"Eric Biggers" <ebiggers@kernel.org> wrote:

> +.macro do_4rounds i, m0, m1, m2, m3
> +.if \i < 16
> +        movdqu  \i*4(DATA_PTR), MSG
> +        pshufb  SHUF_MASK, MSG
> +        movdqa  MSG, \m0
> +.else
> +        movdqa  \m0, MSG
> +.endif
> +        paddd   \i*4(SHA256CONSTANTS), MSG

To load the round constant independent from and parallel to the previous
instructions which use \m0 I recommend to change the first lines of the
do_4rounds macro as follows (this might save 1+ cycle per macro invocation,
and most obviously 2 lines):

macro do_4rounds i, m0, m1, m2, m3
if \i < 16
        movdqu  \i*4(DATA_PTR), \m0
        pshufb  SHUF_MASK, \m0
endif
        movdqa  \i*4(SHA256CONSTANTS), MSG
        paddd   \m0, MSG
..

regards
Stefan

