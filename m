Return-Path: <linux-kernel+bounces-8811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318181BC92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E716EB217A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A05990B;
	Thu, 21 Dec 2023 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VygcCCWR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B085822B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E17C433C8;
	Thu, 21 Dec 2023 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703178347;
	bh=MOlaIwLa5xUrA12eqQnEY3SwNVlERvafhZgCE5i4JSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VygcCCWRhJNcr21fOSCfolZw5ubcHlKX0RRLeQKZv7dDpliwu+Y40DG89snT7vfQM
	 RtsZsZH6MuywlkxE9y3LFDREBVW8sMtN1dHA9sqkd0Q3rClmNLQdDBW5YJwLoQTWPB
	 P7vYfPcSZ8vByZMnz5FIX0BBAbs8Hj+tfoNIZj1U=
Date: Thu, 21 Dec 2023 18:05:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] debugfs: initialize cancellations earlier
Message-ID: <2023122129-seclusion-qualm-3084@gregkh>
References: <20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>

On Thu, Dec 21, 2023 at 03:04:45PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Tetsuo Handa pointed out that in the (now reverted)
> lockdep commit I initialized the data too late.

As the patch isn't in any tree, what is this against?

confused,

greg k-h

