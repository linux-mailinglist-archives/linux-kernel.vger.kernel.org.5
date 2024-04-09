Return-Path: <linux-kernel+bounces-136937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047889DA1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF48F2873AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0A12F38E;
	Tue,  9 Apr 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqKVDGWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EE8287F;
	Tue,  9 Apr 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669106; cv=none; b=XjpoqjN938O2JevvKgTnjJjd13GWjSbPh7D+9cQYvfUjZaimD/0sWoZgvjlskCPJFDDxYq9g0cyW1TUiIj1Ox52qjHANq4MqYObGmmDjM2C5mmTFAstkoy69fxpvhxz3k3N/nA/TG8SeujhchvXTxTGWGdEVWHpss0ckFzP2IcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669106; c=relaxed/simple;
	bh=lYb+9nYvWZ6/nFOvZ0AnbCOYQrH9S92MDjSojdFNMLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMq90WqEo4ch4sZap+DRShXRmfrVVdWkQgXgCct5gldTPLl0ayWA+OkLXJjZHHDEY/5btnmJINU87e2KiBLhhlJWa7Ch+TGJp+WskN19k94+pXHU+4NzZRmb1jhrHKwdNVcS0lEyBWPcZTZPvAf63L2LpMaBSKSkNmNoFpfLU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqKVDGWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7152C433C7;
	Tue,  9 Apr 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669106;
	bh=lYb+9nYvWZ6/nFOvZ0AnbCOYQrH9S92MDjSojdFNMLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HqKVDGWenvKG+1md3BZViUm6OUHXEea/2xOh2UiaGdonxT4FUiFtM1NT2NixP5VGQ
	 kSjB057DuhGjauEDkP2xAReiF710GsfjZPBXelpwdZbM3aOsCQBnXITOHm9QiNXZ/S
	 9DPGMVwKGUjEoUcu0RRqnM1OXIPjAQBXkA8PbeAV3thF/pxPisMniFwQNte7DWCu55
	 y6SgfbgH0Jn5th/ApTmco0xS254asHOulc6gDn6RoZu7q24XRd9DvwP/Q4/Vo9lW4Z
	 uDbyjYONqXNLvB06PUVjzVlpvWVrItB67YbwX35+6wRFS+eX4o1F739ZpF7muD/yEt
	 37bl8nBTDdhEA==
Date: Tue, 9 Apr 2024 06:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation
 and maintainer for page_frag
Message-ID: <20240409062504.26cfcdde@kernel.org>
In-Reply-To: <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
	<20240407130850.19625-13-linyunsheng@huawei.com>
	<b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
	<c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
	<CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
	<09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
> > Just to be clear this isn't an Ack, but if you are going to list
> > maintainers for this my name should be on the list so this is the
> > preferred format. There are still some things to be cleaned up in this
> > patch.  
> 
> Sure, I was talking about "Alexander seems to be the orginal author for
> page_frag, we can add him to the MAINTAINERS later if we have an ack from
> him." in the commit log.

Do we have to have a MAINTAINERS entry for every 1000 lines of code?
It really feels forced :/

