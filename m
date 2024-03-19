Return-Path: <linux-kernel+bounces-106996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C50787F672
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A27B21F92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D33032A;
	Tue, 19 Mar 2024 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5JM5mN4"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4662744B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710823297; cv=none; b=lIWhkL6cAYKJnMma+gU2t796kogweFADeALKRZOEQLcDD3zTsOoL2NKJgsZFwyxjbS3e4C7SuLLA9p56ZP8sqjBy6srcSsC3MTQJPyZ+heHDc2B5cxveIMmlhTzfnsBylF3prz0YKJXAIgCbOMevQl39GcUvIDMAPEDHqsZSAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710823297; c=relaxed/simple;
	bh=vQAYR/QJrIFmQtfrMYYA3GsHHTx1OndykVx+shpKmfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Veqmb2VX/2e3rHkXEqZZVBmPneupjUS1yE0q7YYr/sHzP2gbrTRW6y71RkTEVOircQhi4oaEQCikD7Ve6KymCrNiQ4+Gu60kYdheXOqDM15ls/Yp+i9ZdEbYWYHmOh5ZkGH8ptwnGvI3ke0rp60W3kfx9BtzNVXMxPSGpM5gOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5JM5mN4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787edfea5adso212920385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710823294; x=1711428094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SJjfDh4CSdjn5GHTdatszahsHORUg4IjHoGQ9cZLeM=;
        b=F5JM5mN4QMxvLBSMNIKehf2tJhE4A6hd1hbwyXdO9fi98wmMSUlQQkVQajywsJvwQ5
         hA9E5mDTrRgfs3QBKOeaJTphUTSkA9PPG5NP0inX8sKE6aRlcLrm/kztlDZZfV/SZSDD
         9XAsYAbUXOKIKBfQJFM+HAASBDSM4F6UK/yNOBJ7Yc3LSjJC5HMLFUErCAFk5jrH9chV
         4Pos7yoBJmtj9/zbzfMhNMSP0QMYIz0BbGYQn4i6jc+8xK7HoYLt+c75lZ2rzE4EWsOL
         KDzLlYDBIAcYAkXcGwG967VvmN86ftffdUx4FyK8zaTTv5NIz67v32H5m5ndXAaxCOHE
         d2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710823294; x=1711428094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SJjfDh4CSdjn5GHTdatszahsHORUg4IjHoGQ9cZLeM=;
        b=sEgiB95CnIsbi33GtNp3CpMxhSwVdNpzFLwIO4ILD+nwwM3EbgixGE4+am6o7C+Vnf
         WgcZtZpoVx2ovaitRd0GKB52vQKk8UrWSLjtpUGbONK4pP2zIWngthmUAqYfugVd4V91
         PRUgCuVpHl/iTRhzjWK+eoU2uTOMWo0CO8jAQpasTFk24MBY3lp9z1cvzrg7uJoa+U1t
         S1JXn0b63JRU8ZP7zM46UwvQOJFE/JKS3cHZHN4mlF5xC5SQeLfq+e/23Zq8Ro5XMk/T
         eDynXde/IqO+i0Bp0+7RcIjoSK5cbQ3IX6ONTbePYz2wIjShfF/WKs8Zzu18RqvzcqRy
         6qSg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9FNKljgIt2FXctF1qPixeBR+CSdLy2e1TCCSWXSeSsSQbo8wEMCyW86CLeHAwOObYyY9cgf/kv5Ct9HOfqJ8mCATKzPekfVO5MQ8
X-Gm-Message-State: AOJu0YygV7xsC4fgbH+UW4WtC0TTA3+TXt8QU8YRywyp4VY36ceHQuxm
	pFDmvpkEx1OnKGpmzdZDJ6lHcXOhpshXTp5tIizggwcadsgY9/Vf
X-Google-Smtp-Source: AGHT+IG8FrhCVljV3BtNec31rdoyodE7O5MwONBsIIwZ34/KPNdXUIdfE8PnYOFzx/bCbWzrP3wQbw==
X-Received: by 2002:a05:6214:711:b0:696:1ffd:a32c with SMTP id c17-20020a056214071100b006961ffda32cmr4398482qvz.31.1710823294456;
        Mon, 18 Mar 2024 21:41:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id e8-20020a0562140d8800b00690cb8eb777sm6106964qve.59.2024.03.18.21.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:41:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BF7641200032;
	Tue, 19 Mar 2024 00:41:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Mar 2024 00:41:33 -0400
X-ME-Sender: <xms:fRf5ZRxFToNPNTd1oXZQtEgVLL3d9SvgHpCZ7EnIpLTjZlTNqaRpYQ>
    <xme:fRf5ZRSxMIAay_CAwgLEUIhhF4WVjzg2OIUVa8VMhidZZWqHXEpdaCg2N2DQAU1yC
    gY3gEEFeEt7v4JYyw>
X-ME-Received: <xmr:fRf5ZbW1o-G6CS6sunKKoXc3UL-SGPgzadFQ_WPN8RGhSYDvLXBgXPeJcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fRf5ZThotOUpGG2KrT-B2Wp7J83lXhx7x1S2A-WVmbegMLshtVu42Q>
    <xmx:fRf5ZTB0VsMmTXPabJxYcClNYD-BW6DYgoRuBgPfiBMhmFPlUN2nOA>
    <xmx:fRf5ZcI0WRXpps1CzlN81VNCnyj0PBQdjnWeGtXCtzs2BiJ7BRZKfA>
    <xmx:fRf5ZSBU140qmWHkOBMplAscOvGvqh6YXA7UCM8j3lNmKIs3GubPZA>
    <xmx:fRf5ZVCoOJ1-aXYg9iGJU88UPtqmok07omiZHrx5lNIOlG1BFCOQ_xzpXuQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 00:41:33 -0400 (EDT)
Date: Mon, 18 Mar 2024 21:41:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] locking/qspinlock: Always evaluate lockevent* non-event
 parameter once
Message-ID: <ZfkXfMnyG-nUZf-q@Boquns-Mac-mini.home>
References: <20240319005004.1692705-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319005004.1692705-1-longman@redhat.com>

On Mon, Mar 18, 2024 at 08:50:04PM -0400, Waiman Long wrote:
> The inc parameter of lockevent_add() and the cond parameter of
> lockevent_cond_inc() are only evaluated when CONFIG_LOCK_EVENT_COUNTS
> is on. That can cause problem if those parameters are expressions
> with side effect like a "++". Fix this by evaluating those non-event
> parameters once even if CONFIG_LOCK_EVENT_COUNTS is off. This will also
> eliminate the need of the __maybe_unused attribute to the wait_early
> local variable in pv_wait_node().
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  kernel/locking/lock_events.h        | 4 ++--
>  kernel/locking/qspinlock_paravirt.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
> index a6016b91803d..d2345e9c0190 100644
> --- a/kernel/locking/lock_events.h
> +++ b/kernel/locking/lock_events.h
> @@ -53,8 +53,8 @@ static inline void __lockevent_add(enum lock_events event, int inc)
>  #else  /* CONFIG_LOCK_EVENT_COUNTS */
>  
>  #define lockevent_inc(ev)
> -#define lockevent_add(ev, c)
> -#define lockevent_cond_inc(ev, c)
> +#define lockevent_add(ev, c)		do { (void)(c); } while (0)
> +#define lockevent_cond_inc(ev, c)	do { (void)(c); } while (0)
>  
>  #endif /* CONFIG_LOCK_EVENT_COUNTS */
>  
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index ae2b12f68b90..169950fe1aad 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -294,7 +294,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>  {
>  	struct pv_node *pn = (struct pv_node *)node;
>  	struct pv_node *pp = (struct pv_node *)prev;
> -	bool __maybe_unused wait_early;
> +	bool wait_early;
>  	int loop;
>  
>  	for (;;) {
> -- 
> 2.39.3
> 

