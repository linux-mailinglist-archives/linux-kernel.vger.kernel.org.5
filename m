Return-Path: <linux-kernel+bounces-75890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7B85F05B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275921F216A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511161775A;
	Thu, 22 Feb 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlHwMEvM"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D1111B2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575002; cv=none; b=YOk/fs/qFqq9I7jPbG9zMTxE+l3P3K3blybs750ifdi6CGwEGhlkEWsyKs9ojoT5ZC/xoKWENeWUhFvOumkwCkYCPotXsuc7KqqRuLEBQm/Y9FINKV1vvT0ow2XST+bs1oTnAM86R31op5GTpCZ4BRWf+Wp1LRNwL2PBYKR77QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575002; c=relaxed/simple;
	bh=lNpdvxVQB+Ja4w9cttr3xOLZjaeVT98m0wlOQ4rhMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9tTKNFIwv+oIkIYVMrNArHUK3BBu7SFkQ6U/T87F3EG9fDS9/BYT2wS5Kx+yKQiMWPyVQC9Y2+0ca59/hRO1gatZxB3DxTrXPmHsny3GR0Mo6hinSoHla3VIaK77Am5MNLX7cFNEAZzoDonw0eX3kfnDzLJILSFU3A7IZPONPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlHwMEvM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68fb74416ccso2157476d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708575000; x=1709179800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj22LBR+51pOXZIxllnMc6WPgpZHTUsShsSy/FlWOYU=;
        b=NlHwMEvMtIraSH90kHA9uAqyDKkRkLKA/gxT5Ze+AZFmw17FtJkLLuFbBHcHH/1ipu
         KcMeAJGO5aEWBLLa/5cNzwN2M00rPGjpYt3SqZ/rhxoKN68kOb2LcCAXCGwnZRvLvMkm
         RRrmUKmrLvhjVBwjQvPijSKDErBF0VDUsgaGm+AnxPxkVA3EF2xkNZieUczVafvS2R56
         YI+DsfgrS0ixEHchlI5k4O3Job0TMH6kRLLAl4bP44E1Ugq9+YoL1/ofjnZkNflaxE7o
         gDNInmxSlVKq0u7Gbx4Yr3NPtKZmXZlEyeNNSYROEOgFuYRtp1YDuqICvcBnuBX4MIUs
         Tb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708575000; x=1709179800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj22LBR+51pOXZIxllnMc6WPgpZHTUsShsSy/FlWOYU=;
        b=QXY52oxakM4v4ozHzQl0/GSx9q7y+zyZ2kKj9jwU4RLwNBuEY0ttyTzPDoyNfsEXR9
         piAmUD2mfN/doRp/EdxLfyTZ1XL6QaPDY0Zagi+VWPtPd+gAcsNCaWod8Y3PLGZpRSj0
         l/t3SvLwi7dIhG6rqj3/7DpUv63lsxFpyPXfHOxQfRguYB2CsM9oJ/hEhkgktNpyUG/T
         J+Kyx4jn3ArLBsafeL9b69YmVeSWKQCvsuCUvLsbSGFNHeWK1Sgj6jVv8wmS5tP1jVOK
         Ed7kNA5e/F/ueKGRWb/UGvlTH/iWWdeh4OZIg/6LHD9LDjecWwrpaWdDiK8QYQGx48WV
         nJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCV+5XdanYHcaavjRmtNtoXKZKW7MO+87laqt+DDNX28ONOZ2B0iH3KydMAf9aGJMFyY27mGy2ZVfDQrWLb5vkK9hJqnLRYC+3MGp/DZ
X-Gm-Message-State: AOJu0Yw5Rb/Eo6DyX2bgWwluQHV1hv7kZNZqS325WbQu57TvObGKC733
	eK0K8TVlvuaFujzoww2ozfXYIgvObC3Tu1PIjN4EXdqlc9pg/rX/
X-Google-Smtp-Source: AGHT+IHGinWxvBxIlpqDXQDX3N4YMbsozyKiZkGVfdp63gqR/2Ygem9m96DmdrdZhooOSSfleij4Rw==
X-Received: by 2002:a05:6214:2687:b0:68f:3c39:c63e with SMTP id gm7-20020a056214268700b0068f3c39c63emr18606989qvb.6.1708574999944;
        Wed, 21 Feb 2024 20:09:59 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id mf18-20020a0562145d9200b0068d05b81fb2sm2509030qvb.15.2024.02.21.20.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:09:59 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 88E481200069;
	Wed, 21 Feb 2024 23:09:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 21 Feb 2024 23:09:58 -0500
X-ME-Sender: <xms:FMnWZXQfhl0qdNUQF2q77h-k3UvEki12sNziT2OgJoVGiassTsg1wQ>
    <xme:FMnWZYy4QzHj03KNh4Vtl3s6oWrSAOSoPlDbHpzj0GP8kkleRtRaFa7_2QhiAGYtq
    GUeEoDdsZsbpFAK8g>
X-ME-Received: <xmr:FMnWZc2zE1IvwVhwbzMzceFsXdKuChF8at9L_BWZygoluO1r-WXrHvJ6gvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:FMnWZXAozXFJVt896Tbqmt-BKcIhgO5hL-aDAHC79A5ROKyhAB_NIw>
    <xmx:FMnWZQicMmq25sYG4oX0eHhrER_1wioXb1oTlorIi0LbFWNiwFCEzg>
    <xmx:FMnWZbo7AvguoMATA0EJx0UyBEKFnoRGROcwV2R0eJZ8PGO7ilIVSQ>
    <xmx:FsnWZZUp-459DncW0d5tbQIqxR92aX3CTuoO03VEfPhqI7T-oZCBylfCKYI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 23:09:56 -0500 (EST)
Date: Wed, 21 Feb 2024 20:09:33 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] locking/qspinlock: Fix 'wait_early' set but not used
 warning
Message-ID: <ZdbI_cFBTNKJqnFj@boqun-archlinux>
References: <20240213031656.1375951-1-longman@redhat.com>
 <20240213031656.1375951-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213031656.1375951-2-longman@redhat.com>

On Mon, Feb 12, 2024 at 10:16:53PM -0500, Waiman Long wrote:
> When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
> set but not used. This is expected. Recent compilers will not generate
> wait_early code in this case.
> 
> Add the __maybe_unused attribute to wait_early for suppressing this
> W=1 warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  kernel/locking/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index 6a0184e9c234..ae2b12f68b90 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -294,8 +294,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>  {
>  	struct pv_node *pn = (struct pv_node *)node;
>  	struct pv_node *pp = (struct pv_node *)prev;
> +	bool __maybe_unused wait_early;
>  	int loop;
> -	bool wait_early;
>  
>  	for (;;) {
>  		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
> -- 
> 2.39.3
> 

