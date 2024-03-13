Return-Path: <linux-kernel+bounces-102385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6687B178
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EAE1F281D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC946657CD;
	Wed, 13 Mar 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfllGhln"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6C604B8;
	Wed, 13 Mar 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355953; cv=none; b=LFLPeifyX0vr8zpSPO3FDTWSsNW7RRR7XJLk5HbdRoid/RBMLAmtGSF/jfTkes5Gi6k3IynFxA9iNN/QSzKBZI6QR12oxpo7AA9sWhE35WUIlE/MHToVsSjUmH3E7EqSfAQiHlIvih7EuBhMdM1BAqcoTXxn4FyejLdprl9eJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355953; c=relaxed/simple;
	bh=uiOhDb2aI1GM9s1bqPmkWJ30LvgnRIJ1fB5938Y3rig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdqL64/DKRcJ2chCsNyn37DoptEYbBaQrIp2EKu05VYOj9BaE/9xA2a2a0et0CJFuKCgsh/WUi//4pibP5J4lTN1FrSBvqXzy3xGiqLDTVAxJlsRnE2GWs3L5vEgaoicaJ+3UVXAUf7EQ9nYRqscnyao292OOs1bGyNQS/uZ5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfllGhln; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=w1PC9u+vdjtH+/OhAVuI9GgnMz4d8ZzYulX30ZT4Frs=; b=LfllGhln8mFk5kHvFr4qv6qvw8
	3Hp//2EKrunOZrdPkG3WMnlzSNDRB1ZUZNXoLbdYy1A/FwSt04d+dzRBx9an783YtmcVD7oZOkk3w
	Se2KWmjIDcj+BILbBgCDkufKBj2szXpX4YqfI9C3en1RPT31S3hV5uaXtvDcsWwiJ9szFrnj+aB7h
	LQP0Ma7MPVK8JXLgr/0B1TnWcPbTjFrqnyrmo5PiRbhjkY6hG13y0x267TdnZYkpJGXhOZ3riwrO/
	+qxO2AQ22ni4XY92Z0DkdTEOalDAloS+i6DZKxOyM0Cp/w5gPBXIbk4QvRC3ZJ4gHs3j/DvDpEjhG
	eyKGfIow==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkTiI-0000000BRE6-1pL4;
	Wed, 13 Mar 2024 18:52:30 +0000
Message-ID: <33aee996-8bc8-4063-86ee-e8ffff69000c@infradead.org>
Date: Wed, 13 Mar 2024 11:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs: submitting-patches: divert focus from PATCH in
 the subject line
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
 <20240301134637.27880-2-lukas.bulwahn@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240301134637.27880-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/1/24 05:46, Lukas Bulwahn wrote:
> Submitting-patches is already assuming that git is used to prepare
> patches. So, developers will use git format-patch and git send-email, and
> this will take care that PATCH is usually in the subject line. Hence, the
> 'include PATCH in the subject' does not deserve be an own section.
> 
> Move this note into 'the canonical patch format' section, where it
> currently fits best.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/process/submitting-patches.rst | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..2ec0c0d7d68f 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -384,16 +384,6 @@ patch or patch series which have not been modified in any way from the
>  previous submission.
>  
>  
> -Include PATCH in the subject
> ------------------------------
> -
> -Due to high e-mail traffic to Linus, and to linux-kernel, it is common
> -convention to prefix your subject line with [PATCH].  This lets Linus
> -and other kernel developers more easily distinguish patches from other
> -e-mail discussions.
> -
> -``git send-email`` will do this for you automatically.
> -
>  
>  Sign your work - the Developer's Certificate of Origin
>  ------------------------------------------------------
> @@ -616,6 +606,10 @@ The canonical patch subject line is::
>  
>      Subject: [PATCH 001/123] subsystem: summary phrase
>  
> +Prefix your subject line with [PATCH]. This allows to distinguish patches
> +from other e-mail discussions. ``git send-email`` will do this for you
> +automatically.

Is this perhaps 'git format-patch' will do this for you automatically.
?  I don't know, just asking.

> +
>  The canonical patch message body contains the following:
>  
>    - A ``from`` line specifying the patch author, followed by an empty

thanks.
-- 
#Randy

