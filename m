Return-Path: <linux-kernel+bounces-51973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A7849228
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6566A1F21744
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C70723BF;
	Mon,  5 Feb 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJga7/Il"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426479CD;
	Mon,  5 Feb 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096307; cv=none; b=mLsiV7letd9EZimp9iaHuQ0Dez7LZ9mXNHkLxz4NM801FX7QCvagtF3XPb/Z47duYcoDXgvm+KsSoC3QaBVINZ8k/yrUOgJKCt2EylnSey6HMFcKTf8Pv90Dh06RAlZZ2UL7RjWcMlD7pcLS65RhlZMGHGREO550WnFxdTFZTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096307; c=relaxed/simple;
	bh=jaTlQMSoBvPMfz8lhtZM+afyt7Xg3Mcrl0PWle3uKAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXGjdddW+kp0JDcQ7tasQQVt4XaZAtLDRQ6aZjJevzX3W5UzWack7bjoTulne7znsDb/rqHeX6WtpcJ+FXbatylh/2cqLCK3vZmGYsqfHuyLAzfD37tvcqWeY5BsrY/ZMcqnUZWi4Q1azmXvRIP0S9pvNE81Q+cVhwHmWHmPJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJga7/Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B786FC433F1;
	Mon,  5 Feb 2024 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707096306;
	bh=jaTlQMSoBvPMfz8lhtZM+afyt7Xg3Mcrl0PWle3uKAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJga7/Ilx5B5Twoz8i7yvieMirwqpPJuNW0A9fkxIw/QQNoT5h2A6+uddWSf5M08+
	 V22qolCkThsqOizpQVKfWC7EYYuhgsPa4h6AKl4n0uKFKnTMTLLX85c3hbeGnDoM5k
	 /xtBNIgrp9TX75Y9HC1Uja/zcDE9+4EfSSxlqFKI=
Date: Sun, 4 Feb 2024 17:25:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <2024020433-universal-resolute-024d@gregkh>
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <2024020410-bungee-number-f643@gregkh>
 <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>
 <2024020427-trio-clubbed-37b2@gregkh>
 <CAH37n11Tr9_2A=nFG7N8gi9DoC0ZdEQBGH3herTuP+C-s+3isg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH37n11Tr9_2A=nFG7N8gi9DoC0ZdEQBGH3herTuP+C-s+3isg@mail.gmail.com>

On Mon, Feb 05, 2024 at 01:08:47AM +0300, Стас Ничипорович wrote:
> I meant that there is no place for the patch in the stable branch
> until fix. In 6.6.15 there is no issue.

I understand, but again, please work with the networking developers to
get this fixed otherwise this will happen soon for newer kernels.

thanks,

greg k-h

