Return-Path: <linux-kernel+bounces-58305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17784E44B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8080928CC75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32B7CF36;
	Thu,  8 Feb 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFVSqJ/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929537D3EC;
	Thu,  8 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407342; cv=none; b=UL1xHc4hzK8tZFRQJ8ZbZgOvYxy+jU8DtHUverjeNxx6C9FmwVzJ3qVfkl/zwjfkpg/YuaiLVTAcMSkkzFltX9dDX0jWMRNg3h15Wr7ciXRnklki4G/9iV0fZo0F9aS4LOPCBzDPRXqS96wM2TFEVDzusVIPJCAQbnPE8gcJGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407342; c=relaxed/simple;
	bh=qo0ouGTCY7deTxJNrQ9RKAeZuWz9vdx42ORr8o4UP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqEdLmFh6YFh5/xp9OTEQ4dzwAgrpumrwXE1Eq4PhIeF4FVFh8RxXUAO444x/4hRjQj3miE616bSC00qmVQFRrTDQ7tMtAFNoZSC+zJUh73w+zvkc+yKF5KXETOSe5iCjQCOjRfK77H+89FJUxPlS/82DZaZ6wid44WVkBA9CfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFVSqJ/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8CCC433F1;
	Thu,  8 Feb 2024 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707407342;
	bh=qo0ouGTCY7deTxJNrQ9RKAeZuWz9vdx42ORr8o4UP2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFVSqJ/e+AY/vAnlseHFjZt7Q9H4+npCrgL29OQtrfsrwz0MSfZBy2NYleku2YWgh
	 r5m5vdUkUw2WJ/YijKlOKu9nJXUjCr1YgIZC8K4SO9TAweR1XgRIO38Hw0vZltcAMe
	 G8cBIKPBUabvHSW8Dfz2UGy/lzheMo+8vkGc+IXY=
Date: Thu, 8 Feb 2024 15:48:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [linus:master] [kobject]  1b28cb81da: canonical_address#:#[##]
Message-ID: <2024020840-bladder-service-0341@gregkh>
References: <202402071403.e302e33a-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402071403.e302e33a-oliver.sang@intel.com>

On Wed, Feb 07, 2024 at 02:42:43PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "canonical_address#:#[##]" on:
> 
> commit: 1b28cb81dab7c1eedc6034206f4e8d644046ad31 ("kobject: Remove redundant checks for whether ktype is NULL")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478 (v6.8-rc3)]
> [test failed on linux-next/master 076d56d74f17e625b3d63cf4743b3d7d02180379]
> 
> in testcase: boot
> 
> compiler: gcc-11
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> we noticed this issue is very random, as below, observed 4 times out of 68 runs.
> but we didn't see in on parent.

Ok, this is odd, but a good enough reason to revert this for now.  I was
worried about it, and this confirms my worry that there's some codepath
we aren't taking into account here that those checks were protecting us
from doing bad things.

thanks for the report, and Zhen, if you want to dig into this and see if
you can figure out what is happening so that you can submit your change
again, that would be great.

greg k-h

