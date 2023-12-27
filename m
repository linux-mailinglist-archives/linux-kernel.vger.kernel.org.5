Return-Path: <linux-kernel+bounces-12103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8381F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73811C21928
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6245BFE;
	Wed, 27 Dec 2023 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l+YoCeyD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A045BE5;
	Wed, 27 Dec 2023 16:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E08CC433C8;
	Wed, 27 Dec 2023 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703693323;
	bh=9Y0t3qM0CiKNnTNgmCiJ2aCtE43VwSqrIgKnrDg5B6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+YoCeyDHZB2A4G4sux9yhTIj6acx31IkXDb24gN7cMoT6cQSk2l3r6jnzlF0+zuW
	 WywVfk60bB/XNZcjum1jgeNjGKs+Dousj7RIHdbIZkV5hcXlVuNVBD/GVXip889MMt
	 sv/0yVsLls+D4Vf8SnJWOQ2NKffvup+xghIhlCCo=
Date: Wed, 27 Dec 2023 16:08:40 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	d7271.choe@samsung.com, janghyuck.kim@samsung.com,
	hyesoo.yu@samsung.com
Subject: Re: [BUG] mutex deadlock of dpm_resume() in low memory situation
Message-ID: <2023122701-mortify-deed-4e66@gregkh>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <ZYvjiqX6EsL15moe@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYvjiqX6EsL15moe@perf>

On Wed, Dec 27, 2023 at 05:42:50PM +0900, Youngmin Nam wrote:
> Could you look into this issue ?

Can you submit a patch that resolves the issue for you, as you have a
way to actually test this out?  That would be the quickest way to get it
resolved, and to help confirm that this is even an issue at all.

thanks,

greg k-h


