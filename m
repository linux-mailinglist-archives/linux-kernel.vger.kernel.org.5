Return-Path: <linux-kernel+bounces-117677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C288AE55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9343E1F65DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AF481BA;
	Mon, 25 Mar 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1LLldyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E03DABFF;
	Mon, 25 Mar 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389859; cv=none; b=sBrBmOWS0HVxU15Hqi8HsEwiKJ3x//yobwcQyBZxBh5R29YvJsPY7p6JHeldEkaf8ElMU1zmkOjhCq2Tf8noJKnpHXBi5Lvn6bUVfhb7oLNWxRIdKgcdSWkD5gvxmtrfbVdCZZQEWEaS2w2qrjD5O3YqdGcD932MVyCAp4vlJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389859; c=relaxed/simple;
	bh=xdi8INWQbLRIMRfRERnqBafSoZFazf5xxGPOYIhFgYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZxGcVwElhXh2wmRWx2OdTZ4Yc2YJUbmu8zUjLwPzM8xg2RtAR6nkUqx7lk/aojROiTnmNjarS3OewzhbZJu0yE01rFHtKwY21R8M0OwGFcVqK/EP6SbSrw7onZi0bvW6Mn60YmruppDgUS7R579yvpMM+Egamksd+3HysltBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1LLldyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6DDC433F1;
	Mon, 25 Mar 2024 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711389858;
	bh=xdi8INWQbLRIMRfRERnqBafSoZFazf5xxGPOYIhFgYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1LLldyzDGxhPgV/c9dk31PiSbTYacby4szZGS9m7qvUsmKyPc60htLGhF/aAysvq
	 nkG6cm9cNs2QspkxqNLNFfZmqwsF/V/3etB479NWcYk+v5XfvCf+9NK38gO+gVRGyg
	 pQCAQmOEutzEH2fO54HiNkAAz+PWvwTMbWg9eyt0=
Date: Mon, 25 Mar 2024 19:04:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: dan.carpenter@linaro.org, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, rjui@broadcom.com,
	sbranden@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3] staging: bcm2835-audio: add terminating new line to
 Kconfig
Message-ID: <2024032540-scrubbed-reluctant-8860@gregkh>
References: <20240313114126.1418453-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313114126.1418453-1-ppandit@redhat.com>

On Wed, Mar 13, 2024 at 05:11:26PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add terminating new line to the Kconfig file. It helps
> Kconfig parsers to read file without error.

What in-tree parser has a problem with this file as-is?  If it's an
out-of-tree parser, that's different, and the tool should be fixed, no
need to touch the kernel files for no good reason.

thanks,

greg k-h

