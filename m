Return-Path: <linux-kernel+bounces-35123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88124838C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B15B26AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5A5D905;
	Tue, 23 Jan 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgzZEtxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFA5D8EB;
	Tue, 23 Jan 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006811; cv=none; b=pc7KjJQVU+vjpyz8y2+SDoVzaOtjq0oMbdF6PveiMqRSGHCk3YZi4YbhMaR9N6s655FbnPChh92hG6YmogmWla5D7/UTBK+AXRL9Gj9O4Zb8T+L6oodYcjoKJqVEry5eQn94BtgF0olB4LPJGGiwiEfnnKmSAx0nMP4fIhyF4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006811; c=relaxed/simple;
	bh=fmnFRNk3DGbij1NqfpRfJbXCh5B74PM4xjfpxNmQv+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=StSbOo61X0TMZkUAXTcByIdEt+0BEV1q0kOtRaNyEip+E90r6mo0WyXYeRgM/fREoDdhHu29l8FdQYdjoY8CSXRuhubRrQYoHh1NyUQ2NdgGZnFaIFicGTFqem1p3ZQkSQZCjffemR4XirZ9UlzhF+n0NfKGEXWIacjcDLiWKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgzZEtxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7082C433C7;
	Tue, 23 Jan 2024 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706006810;
	bh=fmnFRNk3DGbij1NqfpRfJbXCh5B74PM4xjfpxNmQv+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bgzZEtxEj+NvNBngQs7fU5qOjKcjJoP5BN6xw6VVwvZ9nFduvYww1QLlK6kPVEL1C
	 f3CQJ39BekGWL5NyaqwO/stL8LBRiF4eCpB7ZcmZsi8M4zTAm2ji4I0VI3uztLTB9a
	 8NEuzkoVdjwPKoFr5euWM0zw2cPQgRmd03oQDj+hLvarrcfp1+qqiDAyGCETOBJI0T
	 UaWGVhk3n+4qFG52vwd8ecjGi+suaC5wm+xXvZTIcYjwagIWpL3/JDVcCA2+OuGaFi
	 FZqkK7R4FjK9bQzRhYH5zxZ6z3WsdzWgpdkBnKNqTGXCkybOwaZL7H8/3TfP5Wclnx
	 U6H4xMRpvsuOw==
Date: Tue, 23 Jan 2024 11:46:50 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
    Mike Rapoport <rppt@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
    "David S. Miller" <davem@davemloft.net>, Marco Elver <elver@google.com>, 
    Alexander Potapenko <glider@google.com>, Shuah Khan <shuah@kernel.org>, 
    Johannes Berg <johannes@sipsolutions.net>, Moritz Fischer <mdf@kernel.org>, 
    Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, 
    Dipen Patel <dipenp@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kernel-doc: Remove deprecated kernel-doc option
 'functions'
In-Reply-To: <20240122132820.46633-1-anna-maria@linutronix.de>
Message-ID: <nycvar.YFH.7.76.2401231145320.29548@cbobk.fhfr.pm>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 22 Jan 2024, Anna-Maria Behnsen wrote:

> the kernel-doc option 'functions' is marked deprecated and is simply an
> alias for 'identifiers' and the conversion didn't looked that bad. So the
> first patch replaces all existing users of 'functions' and the second
> removes all parts in documentation and also inside the scripts.
>
> Anna-Maria Behnsen (2):
>   Documentation: Replace deprecated 'functions' by 'identifiers'
>   Documentation: Remove deprecated kernel-doc option 'functions'
[ ... snip ... ]

>  Documentation/hid/hid-bpf.rst                 |  6 +-

Acked-by: Jiri Kosina <jkosina@suse.com>

I guess this will be all be merged by Jonathan in one go.

Thanks,

-- 
Jiri Kosina
SUSE Labs


