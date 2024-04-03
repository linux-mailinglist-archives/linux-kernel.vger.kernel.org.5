Return-Path: <linux-kernel+bounces-130590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E62897A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB2DB25697
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF68156643;
	Wed,  3 Apr 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="q5KMlX+V"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927C156241;
	Wed,  3 Apr 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176748; cv=none; b=ra39Z9oNRe/VwD8jj/bWky/9lT/l8gp4boRSY7s8XnExpcx6tVpe806JsWKKdP6nvbqNsstk70PfV9F/uiRPgPhYp7rvhAdw+oC9mtXhpadStoUZgDe+SFgUKZ70DXOMrgy1d06DP+iHpn67SsuA+H5v7Qm1uS4cLq2qgwvplIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176748; c=relaxed/simple;
	bh=Mf0E1LOV6BLyakJKEycZcKKzbM7jRgFhb+ltvV49FDA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm5v6oCfQWPWT99Z1EMb/J7xKwOPS0T4KebqHOByxY1y/zgymnMTrAPm+ej1ZIN0kgiLlwnw91PeWn6z88iNYn/OsCd2uaxtiCg1c8u8V8FS6pm1xTaoiFrClme7Tvr0a2DW7IJTa1XINPclXfWnfNwYYO0UNPSqyOoolpUguIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=q5KMlX+V; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 36A3194484;
	Wed,  3 Apr 2024 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712176739;
	bh=Mf0E1LOV6BLyakJKEycZcKKzbM7jRgFhb+ltvV49FDA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=q5KMlX+ViUGKpMFw9fGq5Deed8jHYH3Kfh+09+moZJnG5065IEB/ktL4FBcCZU49c
	 jo0LkE7rj/p9tZFADlfIw62mKsuUuEDwSOlHlL9FFzsDAy/XlxM/vuD2bdiZf4fyYq
	 jvty6Wg0BxIgRBEdyk97v8qo0U6yOQsXxRpLTrgBymE0AiFYpLUwH6/w75bY/1/9yS
	 VSaTLh58+ZKG6H7bUlQ7m42Op7WnsCpdisRxlesUpEdrEdDbbM/mFRaRLMVmgNUFRH
	 6L+DdjHhD0CLc0m2xoP1hFNsMpWUex9lr3R97U8nuGb+2jWvJMRRpHLACm5nyzzjHM
	 yDL/euRvrpbDw==
Date: Wed, 3 Apr 2024 23:38:55 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Fix multiple issues reported by
 checkpatch.pl
Message-ID: <kczljnvpyfsddfhg2yffjftbvm7g5abbcyr7t2hytnusbfgxsu@ecpgrhl5fblc>
References: <20240402183751.107948-1-me@wantyapps.xyz>
 <nip5vnycbq6vbtwx553yaym6mtnz5f3qzkfzpduidf7qrky7ux@7hufve7ptxwi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nip5vnycbq6vbtwx553yaym6mtnz5f3qzkfzpduidf7qrky7ux@7hufve7ptxwi>

On Tue, Apr 02, 2024 at 11:10:16PM +0300, Uri Arev wrote:
> Hey, it seems that the CheckSmatch test has failed for this revision (v2)
> and the first version of this patch as well. I checked lore.kernel.org
> and patchwork.kernel.org and it seems that the test has failed multiple
> times for multiple unrelated patches. Is this a problem that can safely
> be ignored?
> 
>                  Uri Arev
> 
Hey Luiz, Sorry I am bothering you. Did you get my previous emails? I
fixed `__func__` as per your suggestion and added the tag.

                 Uri Arev

