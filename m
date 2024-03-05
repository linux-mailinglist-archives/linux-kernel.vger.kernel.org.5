Return-Path: <linux-kernel+bounces-92498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BEA872136
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB611F23961
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358C86626;
	Tue,  5 Mar 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwE76vv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827486122;
	Tue,  5 Mar 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648007; cv=none; b=M77nb5JDOLalMraq7qdE5QpzHDg4TahcNI0Y+SrQ2Sap9C9DTsD0DnB4p5Kj73FlvIXkJOew9V1dEphGe9ql3XEkL/mjdLtf3ozYmmBi+RRfSJjCZ9XKksF3P9DKePD+HjLUqJa1R3E9cQZx/3TqJjyNVi/tYytWP+BUxsyWjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648007; c=relaxed/simple;
	bh=83h4KMNf2Qtu1AFwj3zSV4/ZmIK7eaCaaax4NQdKrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8YtTm8QqAWPMgkNJ/EOIcHe6S3+A5WlWHmV6w8i8g3UvG+lbDseOXykl/xPNtdb2tAr6AqLB4CMGoOQ1ZS7up3YYMgRvEANEBPPKaz6wws4/M0rXD7t5MP0XB1Gwm68xQgUzES92s2g3dt1uMS8CxrMeBBdWxM88FtWkwKgr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwE76vv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D0C43390;
	Tue,  5 Mar 2024 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709648006;
	bh=83h4KMNf2Qtu1AFwj3zSV4/ZmIK7eaCaaax4NQdKrOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwE76vv5o4qP2lMRPZPoAISJcgsk01rYQGruG/c5yu54idGP0vqPrYuJz7KNnDRaE
	 SO+3iovYcjB2F/kta85Lr0UD27LHPxbThLP7VKvzsaQx80+3AwteMBtG7pDkUz5TxN
	 DBN467pYwcIqUvfLyyOpX5NiJpzwSb5Mg+fgkdnQ=
Date: Tue, 5 Mar 2024 14:13:23 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: Add a newline after variable
 declarations
Message-ID: <2024030549-sanding-finisher-dc6a@gregkh>
References: <20240303100547.153636-1-bergh.jonathan@gmail.com>
 <20240303100547.153636-2-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303100547.153636-2-bergh.jonathan@gmail.com>

On Sun, Mar 03, 2024 at 11:05:47AM +0100, Jonathan Bergh wrote:
> This patch makes the following change:
>  * Adds a newline after the variable declarations as per checkpatch's
>    warning
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> index 2a92497c5570..a1b8288b101a 100644
> --- a/drivers/staging/vme_user/vme_tsi148.h
> +++ b/drivers/staging/vme_user/vme_tsi148.h
> @@ -34,6 +34,7 @@ struct tsi148_driver {
>  	void __iomem *base;	/* Base Address of device registers */
>  	wait_queue_head_t dma_queue[2];
>  	wait_queue_head_t iack_queue;
> +
>  	void (*lm_callback[4])(void *);	/* Called in interrupt handler */
>  	void *lm_data[4];
>  	void *crcsr_kernel;

Please always look at the change to see if checkpatch is correct or not
(hint, for this one, it is not.)  Also see the archives for many people
who have done the same thing in the past :)

thanks,

greg k-h

