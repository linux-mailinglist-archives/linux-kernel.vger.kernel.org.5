Return-Path: <linux-kernel+bounces-48798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB68461A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0931F274B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046E12FB2C;
	Thu,  1 Feb 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8wIXqJ0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED4652
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817563; cv=none; b=lZArwzk1DfT0AXvmz0Sh+js2Xh59Y0Xrcd0WtZ6l+nNA+q4Ay0qq+CQ99c/a8Aof1QZTph8+L//RHKTy0KXk/lFtZ0AZu/cIzyKT90PFE0y6yJYzgB2uuIZBLXpR8h+CEadZ6WvxYLV9Al5PYT9KW8hECo8rUH45865hmVJzcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817563; c=relaxed/simple;
	bh=rM3gzDUzimJEmUsDrjExZNK+VD+OpcpAPvhkvL7N8Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oucHvc+YV6s6JXJ6O9DwHounEffKIs+9D7AHtZZzlShKfq3AYYHqrLV/jVyTzVWak2qaq+nMkwjbe8qtVJ03B8qsT2rlTFQSaJh++D8rlkkz7li0UkPgH4ZSaGX+BXkY/4p0Na5JsnTniyLHVXXNNI0bekKvAs1r4lwZhpL3uOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8wIXqJ0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429d7896d35so8597291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706817561; x=1707422361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n9DvwxhWrni98DeD8vtfOykkyP/L969kf8kLV0M7ao=;
        b=k8wIXqJ0gc0pNIOuKZxBZ4AFdbI861TfJWIO28S4z1Ffz5QmMM8YRg+qgl4qYCSk0M
         nwr95pkC6/14Tg7o4sJQLYf3cA1mspE7JW+hsh+TxEQOtL8gZ7up0eQocJDuQB+zZRh6
         HpsiNbhR+ky/fubwvzTWkdx4Ck9TA8ukZ+qD500JTGU9El/rS6Rxv12a8Hq+mwGWpzoY
         T5nnTue7El6/rxw3t3XIIqSR9YLqCzcp7SwVF2rL0SaqCo5EUUBn7LTWjSV6CNDCBf1C
         2qfqHbnsEd144P/BB6Q0nt+PqthBKi85cklU6GRMOHbVlB15TWnzZNPQbGGYIDr5cjik
         lvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817561; x=1707422361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n9DvwxhWrni98DeD8vtfOykkyP/L969kf8kLV0M7ao=;
        b=YmxcwdVC45mNX6BVmUw5OYkmTbmt8sUds6ePDc81IdHiakpqRu6FcU75HRSvXZCVgf
         kElJHA0JSrPGwCeo4rBBepfYcdYSrXkYpgMWxWCqRaCPHmdOTCjm1CBGaFjGH/iX0jW+
         awYvdnjAvXU8WsOYhk0gRBX76kYGzzWZFPVH0npiHJaCIx3ACZR0lKnotjl8nUXD/vw0
         RKeDv2eNUnoj5ou23Drld+RUze0XkyhVUQsOU7YAC6GDSN0wdf6ox2Mw7hTDLsT0z5XS
         N5XjOb/LiPyFdKUgRoMVsb2PufLYevf5VTtEAvE+OiC88Qe+/XB3o0mlhwE/r+m1Tk0O
         xa1Q==
X-Gm-Message-State: AOJu0YynYyVUNid7D3DcjMiyr0juJ4lya8U+cb3R+1T9O32TcTfP8JM/
	Ys0LsWR/yqDR6IvZNYQUYI57RbnGixcMhg59k86VIHyYdAyN0KLL
X-Google-Smtp-Source: AGHT+IGudsnCRKAQHt1b+a5dXS/Jc5i4kIEM8aisjt3/uSYanJoSxxXcb6bG21qg2HFxbe8L5liI3g==
X-Received: by 2002:a05:6214:1c0d:b0:68c:64d3:d98c with SMTP id u13-20020a0562141c0d00b0068c64d3d98cmr8171693qvc.53.1706817560958;
        Thu, 01 Feb 2024 11:59:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWU5Vs9WudRt6wWqhR+e5IhsFlsZBXEoQbGioaUhDbgOEE1Yf6ipuO9m0ADC8UfZmZBdbgAdNNB3Z694BrSspzI0HmTAs8RsaIff6jlBqx45pbpg/Tyg2yC4ZzF/iwS6oTVq7ybOmSXFcwZYR/JUaJwxrOYTylC4k9YHQ5VamvJlSSeKK0IlhohCEoOcHqarFloHU1EmGvENsBgQ/z4nN4vN7p/08CqGqg+OtXeDYS0nTpSbJsj3JdZlnLhVYQURb25LYXEsi8uitc/KYXF1x3lHqkrtz7P+t8jlBbnzNUyUezbEZG4riNG8lZzhAUepquPweoUy0fgYE4Cqie6bpemeFU=
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d1-20020a0ce441000000b0068c4b445991sm83510qvm.67.2024.02.01.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:59:20 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F39951200043;
	Thu,  1 Feb 2024 14:59:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 14:59:20 -0500
X-ME-Sender: <xms:F_i7ZW-e5yuhGGeWaLpqz1ZDCapSbVK81HGNXDzO31ZVzT-Gdq96_w>
    <xme:F_i7ZWtLQGIIqmSoGETjxZS8ji-dc1Q8IQ4NFjpg6KQvfQYoxHLGiBEi83OaZT0_7
    TkWp95SiDju-iZ9_Q>
X-ME-Received: <xmr:F_i7ZcCWJuF07Xm3xxvT8IHfBS4aeQWsvTLoxMnOWwvPjBdoa-4KItBr7ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:F_i7ZecbwkZ8_jWxKWXugFisoKLfywQdmrEbq6rCUKyqNyPM-6YzHw>
    <xmx:F_i7ZbMv78wVBSpR2yD0GkD0clG4nrb9XDnQzGzddbU3g2hhQXsAgg>
    <xmx:F_i7ZYm9nNo_NWNdwBkwaUwgHU0HuWtcemXZ99Ov2KvDPLVQOIHppw>
    <xmx:F_i7ZYlE8Tt7YCC5YY0jBPeW7hWwUyiaxjDrTdutJZUSC-ntz1_8501neMs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 14:59:19 -0500 (EST)
Date: Thu, 1 Feb 2024 11:58:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, xuewen.yan@unisoc.com,
	Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <Zbv31aq6aZuSXpY1@boqun-archlinux>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>

On Thu, Feb 01, 2024 at 09:22:20AM -0800, Bart Van Assche wrote:
> On 1/16/24 23:48, Zhiguo Niu wrote:
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> 
> Is it necessary to support lockdep for this kernel configuration or should we
> rather forbid this combination by changing lib/Kconfig.debug?
> 

RCU nocb is a quite common configuration for RCU, so I think lockdep
should support this.

> >   /*
> > - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> > - * the graph lock held.
> > - */
> > -static void call_rcu_zapped(struct pending_free *pf)
> > +* See if we need to queue an RCU callback, must called with
> > +* the lockdep lock held, returns false if either we don't have
> > +* any pending free or the callback is already scheduled.
> > +* Otherwise, a call_rcu() must follow this function call.
> > +*/
> 
> Why has the name been changed from "graph lock" into "lockdep lock"? I think
> elsewhere in this source file it is called the "graph lock".
> 
> >   	/*
> > -	 * If there's anything on the open list, close and start a new callback.
> > -	 */
> > -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > +	* If there's anything on the open list, close and start a new callback.
> > +	*/
> > +	if (need_callback)
> > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> 
> The comment above the if-statement refers to the call_rcu_zapped() function
> while call_rcu_zapped() has been changed into call_rcu(). So the comment is
> now incorrect.
> 
> Additionally, what guarantees that the above code won't be triggered
> concurrently from two different threads? As you may know calling call_rcu()
> twice before the callback has been started is not allowed. I think that can
> happen with the above code.
> 

No, it's synchronized by the delayed_free.schedule. Only one thread/CPU
can schedule at a time. Or am I missing something subtle?

Regards,
Boqun

> Bart.

