Return-Path: <linux-kernel+bounces-156271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9988B0097
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90049B23DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95215358A;
	Wed, 24 Apr 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcnYxgdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A42152DE4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933147; cv=none; b=HY5vJNGE5qc+iTRZ+6tyPw9f/2gU3WFAWtfNqrCF5pby1ab9O8vSxd5OOdDAC27lhO8U4cAJJRKYy9J0dpCRGFd27shXYvx28ob+4rwjyKAeOMzQVbWk335qOjgtyHoGehGs595w4P32RVT+ioe7orSJYDPZ61B71rhkTGWlsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933147; c=relaxed/simple;
	bh=k7pN2KXlqMSU8lAV83Hzq9FVYo5DmXtPRb058mbP4/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5MROFuzEVhtQnNKe1S7i3XXWuOIW3y7Y8Urxion6ruoaA2hEFDO9e4mWccKnqN5BmemkmcacDSdJqyzqB9AXi45WAt4ImnQu0SWT/OPxyN7ujUnqiAutU117XwerCTw3n3GObiC8GKJMSBGGjvshEMYtRvmTorpB982V3Bh0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcnYxgdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE8FC2BD11;
	Wed, 24 Apr 2024 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713933146;
	bh=k7pN2KXlqMSU8lAV83Hzq9FVYo5DmXtPRb058mbP4/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcnYxgdb0NjsGQVp7Ggh0QOJ503fD0J3LvM5R0HruE1WkcJS4gbrhS2QCStgSejfZ
	 ZQXndEQFwvvGrfGvxGlFV+thdCR5Tm4HHk0l3CJ6gT37a/0VhyhH38xi7pKpk1Z+l9
	 k4FnycZU1chKkm1F94bzMzFSQ/6X3fw4CKkmDAOY=
Date: Tue, 23 Apr 2024 21:32:16 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.10-rc1
Message-ID: <2024042308-strongbox-unsaddle-42f4@gregkh>
References: <51cf4c457f1cb77468070e3ec8c3901cd1d056da.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cf4c457f1cb77468070e3ec8c3901cd1d056da.camel@intel.com>

On Fri, Apr 19, 2024 at 09:45:08PM +0000, Winiarska, Iwona wrote:
> Hi Greg!
> 
> Please pull PECI update for Linux v6.10.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:
> 
>   Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-next-6.10-rc1

Pulled and pushed out, thanks.

greg k-h

