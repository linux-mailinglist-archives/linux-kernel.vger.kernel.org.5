Return-Path: <linux-kernel+bounces-48902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC5846305
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D6E2882B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500047A60;
	Thu,  1 Feb 2024 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXA2R/UF"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0D47A55
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824460; cv=none; b=drfJFi6U/1o6/Nmy5/Vf/5QpbXbeMbO9XQoQKhuKppxrwULbcDYVkkqIf3gTKhBf2WQ/kiheEvC3jKWuYrMnsPucr5KM4C3EwBLQ1T7sfXuFI5xtbumdywTo2Ko8G1Rr8ZE0x6KoxSZpmH4NTnQ49LwdMMVPQfis5ncCbpH6HRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824460; c=relaxed/simple;
	bh=wdKPTFIog63ZZe/d58sZa/gAiCMKpSWHVK4bM5O/zcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPiuGGJNimYDPfK7w+Mcldnprw7RYnqMFCZspUU1fr4Y+UU1J+P8j+fkFsinmI2xJJCfVLTESStXIx0vu6TeREGZMpPmqKgQfojecX4RWZM8rjbJX0AjOcEU9fBquLCSmJUG1JziqW4rxArngPzUeXu9o7wW1gS/I9XCJ5ATYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXA2R/UF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-686a92a8661so7887936d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706824457; x=1707429257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo3P4SbP3LGSf1kmSDqiVSjaS5ZakScwY6sfLSYt6nw=;
        b=CXA2R/UFMZpagd/LXsW80aIdh0KcBg2ztRxsUW4u6KqkSCxtVLAuSJ/vkRTYEd2iPd
         gjJjiPTdWbggTbfN3Mp0Zkzi7dIxT0XKyatCmMsC6XIviKlmqeVE8XnLn8cGNiO5mKD9
         NSFcUY5G5VMLr/kPbKoFyucHJF7nZVfBbvYCLM/aSmPGGI+HgJ/0Tn+TY+Ht6uEMnQqs
         8ySW5OU0NX9TF9j0/ZG9W/YGGhtxeCVs4b/LoYZO+FVvNFpsm9UE500k/yBOt2RgFy4M
         w6AwGxeXdxi6wbfS6pFXxbWeF6H0AsuPs4dJKo8RLuvacNubHn8F2Emv23RXjlm3/pbe
         i99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824457; x=1707429257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fo3P4SbP3LGSf1kmSDqiVSjaS5ZakScwY6sfLSYt6nw=;
        b=bAvl8CEUooQzIIBBEUgGS0Xu+nIkDa2wBM1OWjxhIR7wh/SSllNpcSiFizZBdfWgQt
         NXJ6YFyLT3ItFc69n8r61rxOJTIBzf2jXMEKFvPKUCbG3geO7LczWJM7bwnvcRqm4syn
         2ue5sVcmX8wbfRe4gsbMKHDd022yhgmrWlvpfFHutbBvQ4+rDP/McEcW+tw+Njpv9fGn
         p8/tFTU+9d3bwZQR8BmKKJ5YEysiTfs/Au7bLZIOeTKQd1BpJ3cHam6kAFtY0XdGJ3cX
         HV9/EaDCcGJRyGjhm//jvpGQ7ayfedRrHOK0n8YhrJtvQXbwPX4x33cIDrtAVBvMq5WA
         3MPQ==
X-Gm-Message-State: AOJu0Yz6RFKz/Ts1Ls9VXMalq2X/4XmGYm1JwMjdF2wgGSdEOOiSAc/W
	C7y6jsuxNQsaIaFxv+XKvTjWO62IoEGkCW+NncGwWMEkD0upFxhF
X-Google-Smtp-Source: AGHT+IF2dDP6YBXfL01fEZMXdbYDpVVatrGrAuAVBwxCvRimEfxls4nHyYLk8o5aroojUmzT3EBw6w==
X-Received: by 2002:ad4:5ae2:0:b0:68c:5e87:7032 with SMTP id c2-20020ad45ae2000000b0068c5e877032mr110985qvh.40.1706824457285;
        Thu, 01 Feb 2024 13:54:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4vTuxlVNynadWoXTk8mNP+NwwnGvsFxWsRjy13oyYwGWExImlgd1XvRlpSTcgC7tEJKxQxWzwa2c8bk8XF7eV0O8u+X+ieXR6f/Tdyq67HDjTsFaRb2r82OJWVU4Y20MZYXGANPdvAoVTIYi8krCXDNT4ZDrGh2ZkRJfvvX0kyLPUjPBZh6ozSMspinqmAu0moHmdHBvYpGqFjhAcSQPgFQMI70Q1p8eXpZbxDxnRp8Uh6YXoqZLJwNOvbFWqk32JMLM7qy9UkI00TaJyBTHlFfxm30vwN4KKQEtNRVAaKOJ3Y0P42Ak2MMB1dqpp88rEI2b2IG/sv0CttgLM0WhgHtE=
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o9-20020a0ccb09000000b006869ec9cd16sm159293qvk.129.2024.02.01.13.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:54:16 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id EC17C27C005B;
	Thu,  1 Feb 2024 16:54:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 16:54:15 -0500
X-ME-Sender: <xms:BhO8ZVTm3UnqpNlqkw77aNu9RTvTKyC-V5wVcDoQs41KjdlqNeqpIg>
    <xme:BhO8Zeyl0EUeLYddM2L4ne_UJaylaTY1JZxEoxc6mqJ8y_Bb2wRe-G_6xtrHQ2w5B
    Ttly8PmsMKN7NV96Q>
X-ME-Received: <xmr:BhO8Za0F2cP0sne6y6sdP0qy1t44d-6vuy2nDHa5F6Is_AlxeRJ_LJGZpzmYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepledtlefgkeefhfeitdeludfgffehveffteefhfdtvdefkedvfffgveet
    ffeliefhnecuffhomhgrihhnpehstghhvgguuhhlvggurdguihhrvggtthenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BxO8ZdBE4OS_yZG0PN1pAU8nz38UmgnVTWAEIsC--d5CO2If_scJnw>
    <xmx:BxO8ZejwU_3AyqLz06JCR4cmYIdaVj4kY9RAVj_MTBnhy7NuNYLWsg>
    <xmx:BxO8ZRqf9A1whEkfKdssipjEt5feIz1WdAhMqBmM9Ks8ws--_VrjWA>
    <xmx:BxO8ZVqsuIoUhQ8Xt9QQASvp1FniFLOM_8zjSYTD9Jdaoecz_0jGGQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 16:54:14 -0500 (EST)
Date: Thu, 1 Feb 2024 13:53:08 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, xuewen.yan@unisoc.com,
	Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <ZbwSxGpySa8RBt9A@boqun-archlinux>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>
 <Zbv31aq6aZuSXpY1@boqun-archlinux>
 <c485e96c-6aed-4c4c-bbba-de5c8784be69@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c485e96c-6aed-4c4c-bbba-de5c8784be69@acm.org>

On Thu, Feb 01, 2024 at 12:56:36PM -0800, Bart Van Assche wrote:
> On 2/1/24 11:58, Boqun Feng wrote:
> > On Thu, Feb 01, 2024 at 09:22:20AM -0800, Bart Van Assche wrote:
> > > On 1/16/24 23:48, Zhiguo Niu wrote:
> > > >    	/*
> > > > -	 * If there's anything on the open list, close and start a new callback.
> > > > -	 */
> > > > -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > > > +	* If there's anything on the open list, close and start a new callback.
> > > > +	*/
> > > > +	if (need_callback)
> > > > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > > 
> > > The comment above the if-statement refers to the call_rcu_zapped() function
> > > while call_rcu_zapped() has been changed into call_rcu(). So the comment is
> > > now incorrect.
> > > 
> > > Additionally, what guarantees that the above code won't be triggered
> > > concurrently from two different threads? As you may know calling call_rcu()
> > > twice before the callback has been started is not allowed. I think that can
> > > happen with the above code.
> > 
> > No, it's synchronized by the delayed_free.schedule. Only one thread/CPU
> > can schedule at a time. Or am I missing something subtle?
> 
> Only call_rcu_zapped() reads and modifies delayed_free.scheduled. Direct
> call_rcu() calls do neither read nor modify delayed_free.scheduled.

Have you checked the change in the patch? Now call_rcu_zapped() has been
splitted into two parts: preparing the callback and calling call_rcu(),
the preparing part checks and sets the delayed_free.scheduled under
graph_lock(), so only one CPU/thread will win and do the actual
call_rcu(). And the RCU callback free_zapped_rcu() will unset
delayed_free.scheduled, again under graph_lock().

If you think it's still possible, could you provide a case where the
race may happen?

Regards,
Boqun

> 
> Bart.
> 

