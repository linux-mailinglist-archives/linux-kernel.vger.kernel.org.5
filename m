Return-Path: <linux-kernel+bounces-15198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35450822843
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414601C22F97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CE179AA;
	Wed,  3 Jan 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lUOhxGPX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAB18021;
	Wed,  3 Jan 2024 06:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E3C433C7;
	Wed,  3 Jan 2024 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704262281;
	bh=mXoFmy8Y3AJ12pj/BfIyrgsROCK4abHRBJp59HxUUFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUOhxGPXiOv9qvzIoMUWK00D4AYNMMYZDBoMM+Zm9gCNZJrogT77GIGV1lIqdhMhD
	 4WwIBnmbsu6baNu+iBlY3zd9PYZ238EfbwF0oWjUiZradz5sAWmDhBivgSg6PlR2t4
	 qorkqxEq0FjXsSLM18dcdyUq4rdTkXWl1/JXrGr4=
Date: Wed, 3 Jan 2024 07:11:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: proposal to refine capability checks when _rlimit_overlimit() is
 true
Message-ID: <2024010353-legwarmer-flap-869d@gregkh>
References: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>

On Wed, Jan 03, 2024 at 11:12:28AM +0800, 孟敬姿 wrote:
> Hi!
> 
> We observed a potential refinement in the kernel/fork.c line 2368.
> Currently, both CAP_SYS_ADMIN and CAP_SYS_RESOURCE are checked when
> the limit is over system limit. We suggest considering an adjustment
> to utilize CAP_SYS_RESOURCE exclusively. Here's our rationale for this
> suggestion:

As I said when you proposed changing CAP permissions on the tty ioctls,
have you tried this and seen what actually breaks by doing so?  Please
audit the userspace code out there to ensure that what you are
attempting to propose actually would work, and then, if so, submit a
patch to do so.  Attempts of "wouldn't it be nice", don't go very far as
it shows that the work to do so hasn't actually been done.

thanks,

greg k-h

