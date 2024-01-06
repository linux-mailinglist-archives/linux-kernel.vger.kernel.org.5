Return-Path: <linux-kernel+bounces-18697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78181826137
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AB1C217AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC20F4E9;
	Sat,  6 Jan 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMg9zbxJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8FE549;
	Sat,  6 Jan 2024 19:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB4C433C7;
	Sat,  6 Jan 2024 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704568196;
	bh=dP2nZH701L9TMAqVguGNOhHDKbiRw3c3croztrjhPDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMg9zbxJfxWtMuqrx1NETpg+utc0fs1IQ7eJNvYv8yk2Gudc+7wj96pG4ZJ47Heng
	 x9dPkZUHGtpnzllsIbNCUKF0IjYcpncdhruN+JaX2abSdWE/7Gvfarho5Q1oUOPG/2
	 w/C/lULoXjVj8l+aTjRdRTQ3sOVpDrYm4avauf+ZetSbdjgJu2VrmPrA1RnqGIHM4y
	 OOS2ioFssdTDZWRNCdwKdnZqWbvmCc1F2Y7IGeiF+ONI5yS9HH+DTFBql/Oh7HMxwJ
	 eMcb1g+AsvPD/54cBb5uOW0lZSi4ElqHWHzgpdH6a04cw1rgSinqzrzP/xzq5hVe/b
	 86pjjj1pjT2xQ==
Date: Sat, 6 Jan 2024 19:09:51 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2 net-next] ipvlan: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240106190951.GG31813@kernel.org>
References: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
 <216fe71e690580aede0d3def17b767d9559edd3a.1704446747.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216fe71e690580aede0d3def17b767d9559edd3a.1704446747.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 05, 2024 at 10:27:09AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper bound of ida_alloc_range() is inclusive while the one
> of ida_simple_get() was exclusive. So calls have been updated accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


