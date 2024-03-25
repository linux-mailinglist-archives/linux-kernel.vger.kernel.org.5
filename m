Return-Path: <linux-kernel+bounces-117185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1679088A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1F4322AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D913C3C6;
	Mon, 25 Mar 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz5hd4pV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A713BC1A;
	Mon, 25 Mar 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375015; cv=none; b=WVbB+AtskwXePQrRaz3IXbdIZRjIwvF1qaZRzC8J8Z1VVlN8/0GkSo4k2Sf/B8JCKGet9hLYA7XM7XL1o+Cr4GNZhc+V3w1Olq950nt3YTxYL2sRja6wRlVfyeWKxPjr/H5YQlR+p2Sfh/Bs6IOjQabVEiL4wM1A2zp6GVbLEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375015; c=relaxed/simple;
	bh=yOT9XgocTLoLgZNJfGyS0y3pYO5d4ObVDNhvUTQcvn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdD4rI857im2nzjR0hgn1xemHajhFOdBs3EJyVmPMP6poaZUXF9HXn6wRDKSdiLtjNCtOvVuJ91pbMtaevpYxngqOu3/4P8dWpUBZCXN/FlogOdGkPwKZaHs4NR48rDP9wU1Kysl32s6RsoTmeK7LpvjyfjvysUADIORA7e+SUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz5hd4pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD027C433C7;
	Mon, 25 Mar 2024 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375015;
	bh=yOT9XgocTLoLgZNJfGyS0y3pYO5d4ObVDNhvUTQcvn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz5hd4pVWj4vQL/0xsjawemTQcOfFRCiCcWw9G9EGsSg34NK/ldM0hotOW+pmEQHG
	 UVqOBLbKIo0mK+fhKgzkYj4+VRxIm64+kEThwqbkTQzPAvPvueudXz+vmSuOEA3NV0
	 VAt4/L0CitPksuqLjcUwfHsqsMuuv6b+KN8MVex4haFOJfrpbLe9Xh7F6ZTzu34xCo
	 Z1UljccXHAZujL20WmZPbx/VcxGfjspGX4DzDeUSVQMNGe4QVNRVt3KyR5J0iXzCf4
	 cQ4CApy0uY7boFNT5jnwIfFGrWwh25SKnR83JghylcgXuL65LcNkPych/eAtzOHRhm
	 B0B+gLhxb5OCQ==
Date: Mon, 25 Mar 2024 09:56:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 6.8 119/715] libbpf: Add bpf_token_create() API
Message-ID: <ZgGCpYilzhJd9dTJ@sashalap>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-120-sashal@kernel.org>
 <e35cc021-7f17-479c-bd7c-ea6df836a04b@kernel.org>
 <c89f9cc6-9676-46a4-8f8e-01d8dbf41aa8@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c89f9cc6-9676-46a4-8f8e-01d8dbf41aa8@leemhuis.info>

On Mon, Mar 25, 2024 at 12:17:56PM +0100, Thorsten Leemhuis wrote:
>On 25.03.24 06:40, Jiri Slaby wrote:
>> But if you should take it or drop this all, I don't know...
>
>I ran into the same problems while building 6.8.2-rc1 for Fedora using
>the Fedora 39 config and its RPM spec file (with minor modifications):

Sorry about that, I've dropped this (and a few other bpf commits) from
6.8.

-- 
Thanks,
Sasha

