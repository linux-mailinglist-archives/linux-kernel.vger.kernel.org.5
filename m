Return-Path: <linux-kernel+bounces-135415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6489C12D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99984B29E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8597F46F;
	Mon,  8 Apr 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRggopEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B537E575;
	Mon,  8 Apr 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581960; cv=none; b=Oek6g7nGBasEA8a5xTsrwO3D9SQ7OQpwxoPXU1lAYmZ9+dBqmoaMmxOTyBdNpOmKEjIsvq0yPnlI+HeeVYzNnbOunjow5Z0SOlnDsk0RgqMgSs15iCsq+Ha1YcXc+nWRw09D1Np5AE3i/lGfLfQOg4cOqQnC1cRFKZpIdEU57XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581960; c=relaxed/simple;
	bh=FDyXl726c9B9U4ZoE70AwoSNthND7FSk/8PQFnBAXIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObdbRN2wKUUuU5+B60kDNJ4bY/uQvNjfCi2wI2R+ittPEkCeUqkymYFj1AwFJOZaYBw6cJAHdM1IFha3D/Mx5dxqikrIFdMWn8M/c0wgJUgblq0n7u9e6z33WsMLAB6PCF4spJ3KQ+RsgxYJErYYBi9Qyd1fvBCOqMaLAQc0aeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRggopEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EE6C43390;
	Mon,  8 Apr 2024 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581960;
	bh=FDyXl726c9B9U4ZoE70AwoSNthND7FSk/8PQFnBAXIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRggopEWyiJOQ1Goi48EjKmJ/RpM5o2bYUPDpk/CcnySwjHAkM5mGQ7Cn/S4ZcaNx
	 RpSumi87UT83FC6tnrmfTshrX5rbp9LmmkvtA34WKQDhVYx/Fz1Gno6Tj4cSu/GdBt
	 LNx5wHvReuahjW6/wua7KE6bOtRS247xbfNqRDK1uYnQ9UdjcAQYMkYsICzu+YCpV4
	 V10Ko0DqGMgkVgFoYJJTMyn+iROs60s3FTYysS13ST/4HOWeS09xNdEprDXqeyZcZ4
	 cFWv+gIlUBb4AnPo9QETsE3eSN8OKoDFgLhOWIG1RNtYsUGb7A1kty7KkLKVVX9b/d
	 +Vt8lQqJi8wyA==
Date: Mon, 8 Apr 2024 09:12:38 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	tim.c.chen@linux.intel.com, sean.m.gulley@intel.com
Subject: Re: [PATCH 1/2] crypto: s(h)aving 40+ bytes off
 arch/x86/crypto/sha256_ni_asm.S
Message-ID: <20240408131238.GC732@quark.localdomain>
References: <5EEE09A9021540A5AAD8BFEEE915512D@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EEE09A9021540A5AAD8BFEEE915512D@H270>

On Mon, Apr 08, 2024 at 11:26:52AM +0200, Stefan Kanthak wrote:
> @@ -315,11 +315,11 @@
>          jne             .Lloop0
>  
>          /* Write hash values back in the correct order */
> -        pshufd          $0x1B, STATE0,  STATE0          /* FEBA */
> -        pshufd          $0xB1, STATE1,  STATE1          /* DCHG */
>          movdqa          STATE0, MSGTMP4
> -        pblendw         $0xF0, STATE1,  STATE0          /* DCBA */
> -        palignr         $8, MSGTMP4, STATE1             /* HGFE */
> +        punpcklqdq      STATE1, STATE0                  /* GHEF */
> +        punpckhqdq      MSGTMP4, STATE1                 /* ABCD */
> +        pshufd          $0xB1, STATE0,  STATE0          /* HGFE */
> +        pshufd          $0x1B, STATE1,  STATE1          /* DCBA */
>  
>          movdqu          STATE0, 0*16(DIGEST_PTR)
>          movdqu          STATE1, 1*16(DIGEST_PTR)

Please make sure to run the crypto self-tests too.  The above is storing the two
halves of the state in the wrong order.

Thanks,

- Eric

