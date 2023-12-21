Return-Path: <linux-kernel+bounces-9118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428BD81C0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7633E1C23634
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2877F10;
	Thu, 21 Dec 2023 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d3htO9qv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D376DD0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D5C433C8;
	Thu, 21 Dec 2023 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703196779;
	bh=Xj5b7BBgsG+mfoh/BRfljpTiO2RqoZvx/iiu+mRkX6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d3htO9qv8US2F2TIt+dvaIcvSjW6dQ1/lZ73niCZsQNsCCoNVU7XucpyPeawILmR/
	 jagfUKXCEquHbWHNNpOsx8Rn3vbH+FtNvKKKprgHcr7ucZjgc3t5qt9KQhv6vBquGi
	 xYL5WxxtOx/gbSIZXKWhyfTqqqttqEAuwjIG44Qw=
Date: Thu, 21 Dec 2023 14:12:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Baoquan He
 <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec_core: fix the assignment to kimage->control_page
Message-Id: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
In-Reply-To: <20231221042308.11076-1-ytcoode@gmail.com>
References: <20231221042308.11076-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 12:23:08 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> image->control_page represents the starting address for allocating the next
> control page, while hole_end represents the address of the last valid byte
> of the currently allocated control page.
> 
> Therefore, after successfully allocating a control page, image->control_page
> should be updated to `hole_end + 1`, rather than hole_end.

Thanks.  Again, please include a description of the userspace-visible effects of the bug.

