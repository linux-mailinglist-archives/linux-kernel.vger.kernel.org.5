Return-Path: <linux-kernel+bounces-164179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B78B7A45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1307EB235B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639121527A8;
	Tue, 30 Apr 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztt7YBFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83F152792;
	Tue, 30 Apr 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487900; cv=none; b=p8UY0Rznr0iQWSx+WwLwCxR5ym/pCgu61KGwxSD9qw6+Hgff3oAAozO9sTUxTXy2U9JmTQb3jW38H7JlFL1RnYN4xLxLaDj7kltfJI7JvomlJkX+8EHKgKY4GllM/mk5KcWqbHZi9Q0p3eRSvp4XdKDV39k1FfddhtFwL3nDTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487900; c=relaxed/simple;
	bh=oGfLM+JpV5sViGZ2Vpf7J/f8gvRUnXP9VaLcHxnTnSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHNhuSvdwTuiBSfMEDbAlNCPTzBgGyl4fGiuwrrJ1KHgx5ldemJMNv8VpvMyo8yRMyRcIJR/+wf9rd8HreR0HuxCPfIA1dzYKyqpiCk+0CfTO3M1VRFkJYTXxgyc6HTFWwbkOqlav0maEB1xX5OcZFNiWrboOUIhFWBnRuE2jjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztt7YBFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED43C2BBFC;
	Tue, 30 Apr 2024 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487899;
	bh=oGfLM+JpV5sViGZ2Vpf7J/f8gvRUnXP9VaLcHxnTnSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ztt7YBFa4aDz66h4mrfkDt0dfIFkXPV4hKv+sme+50mhxcGNCHYuub59M3r+jSWxu
	 iV9c9r4UaPRoc9LwRnVCIcrDouAUwwhHQswgy7Tvt8BIcSCviVE+exqHYsZwyZ/Guf
	 3nNEs13LlL+bconO6zkRyBy18kQXKOwzcBESeB77FInc8WQQqGcss4rc0+mDKY2kDR
	 0zs08DvflDyt2LTVoJl1UP6rmW5vYlO0szYOk8J2aKeKha23eLI9TSE0ere08grUi3
	 j/J9TK63MPzXloQ2BtQzNEi9n3l54Yb0Ucpxaa+Js7Q0E97LM1s+OMC9He/drCgfO1
	 L9Bt24mui5ODA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1ocf-000000000k4-0kOz;
	Tue, 30 Apr 2024 16:38:21 +0200
Date: Tue, 30 Apr 2024 16:38:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZjECXbC6taKWVmJV@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <CABBYNZ+pPTTOSzb2HpStRo273EPsLYgwMFRPJTaJP9Xk038nwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+pPTTOSzb2HpStRo273EPsLYgwMFRPJTaJP9Xk038nwQ@mail.gmail.com>

On Tue, Apr 30, 2024 at 10:21:37AM -0400, Luiz Augusto von Dentz wrote:
> On Sat, Apr 27, 2024 at 5:51 AM Johan Hovold <johan@kernel.org> wrote:

> > You're right. I'll drop this check when revisiting this next week.
> 
> I assume you will spin another version then?

Yes. I have prepared a v2 series. I was just waiting a bit to see where
the discussion in this thread went.

Johan

