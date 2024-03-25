Return-Path: <linux-kernel+bounces-117617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880088AD93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10DFB333FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6A136994;
	Mon, 25 Mar 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grzTfEa0"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3786135A50;
	Mon, 25 Mar 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388530; cv=none; b=qRUXD28mT0DQ62sYR4Vu91n2zmZL3+VYdO65qYTmo3FxGCGxZUWamrNEUkhxvr2qmHp3fuFmN8/fU2WDxK2PT6XChMQGnzTa/jU4DcjRm8xBrto8N/wMbAvzcDo2/4mShyR0mCgRkjXW+xw6L3OBeiWdW9pklSOv2JTMTYm1dI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388530; c=relaxed/simple;
	bh=gBgA6T8eRKAqy5lzFm+XmWUZeR3DWZFxpr3wK0zxihg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7/tTrKZVhfp2K2mOBz/7jraaqrYVwfy9biPllw224ZwIE+lhRmXOPEmnqEHA6tDkfUYW/mVC9GgNRpugwlEZnPgYG5Ypr+Mbipvvj1ux3vYACYvOBwsTAi7yX57GpKf7dWCk1Ykpk3UdLV/m7D/YegyxohEzb9SFDp90vR7CoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grzTfEa0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789db917876so283582185a.1;
        Mon, 25 Mar 2024 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388528; x=1711993328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6OUbeVHIo3ToUl+begwMOweCvELDiiYMMm26LbAxFQ=;
        b=grzTfEa0eLea5QfMgGjG6qtP9KMCJLtuzGhq8C6gz6GSBBMFpUugZkdhpu4DeS2daX
         mALliBvi2Ld7UNlQsy8/qPOTeU29VME0k5tj6+AiMSEq1iDipoD2pSZu958t/biKu4Rs
         naMWqwa/J/I4+h9EqQ7Vvd+pKoQKog2cIBwOGeny5TF2OwCYfyjMaDj8fE+c4WzyI05M
         o22xSOYUTFeyVrr4TaQ8rygO0rneN1BcixiFOWxnM+B4dbKKZW5zBgm/+qQXEs4E0F1W
         4py3NG4u8B8Ia4cyVzQwb8ZI8Wyn3wp0Uz8zkXDxIFIutON0Zs3itWLuWdsHNMGSU0fc
         QLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388528; x=1711993328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6OUbeVHIo3ToUl+begwMOweCvELDiiYMMm26LbAxFQ=;
        b=eIPm3tDRrC1dE1ZieEFUsaCg9/UeiAPHlg/ZJw+czONt7LziQQbCCuglj33yljeNC+
         5Xq8wQea6U0Q4zDD7FIs2N+oQ/S+/1fLBi8fwqTI+iBg7VbVLx1S8rhrkCYeyro/4hoo
         r1bbU6xlb4eZckdFvwtsktm4d9j+rbJ8ruY3r2S78cMiezHpBmTPGpdDhYAEiqGkRiEr
         F5meSwlKgSUBoQ0xNcd1Ercs2KumaUExN3rxlN55cnuokQrvg7QMKr3D6bxvPAZ6GWuU
         cz4FlF0xuterk2RmSRpqYot2mxFuVu9FBr2jfVzGbb3geEOJpwe/i7QMzUcTEwjuXa8X
         5yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk0b3ESuW67yBOturriR+8pKDf+7SjeHfLqvnIQ0wxbSezoZV+uSSHRumczOVcENZfx0CcSvsVx1LpIFVh4aH5oVAelyZYNe8+ze+z
X-Gm-Message-State: AOJu0YyCBmDlm2GblJEeRx1ntPgp3+hn0n+xYUgwKzod/BoYa6Q6hQnp
	OXbuuDKqsM4ulhtaLaV3dHT287QMney8Bx74vXAZiaZKDOterO9i
X-Google-Smtp-Source: AGHT+IEZL5g2SrMspyecz2hc2S42fK6WPqsWsepIsJW1oc0Cezi7W5nZp4m9uTmhaoJk9cFuGUPgeA==
X-Received: by 2002:a05:620a:3b8d:b0:78a:3798:9724 with SMTP id ye13-20020a05620a3b8d00b0078a37989724mr8056988qkn.48.1711388527887;
        Mon, 25 Mar 2024 10:42:07 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id a27-20020a05620a02fb00b0078a00d309dbsm2289353qko.89.2024.03.25.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:42:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1B45B1200068;
	Mon, 25 Mar 2024 13:42:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Mar 2024 13:42:07 -0400
X-ME-Sender: <xms:brcBZos0P3XQwZccTi3QTyLk8_gVaFpZpVgKZ6BsS_0VX4zhptTFQA>
    <xme:brcBZlddOPcV6Ju0Ldzxpa6p9AFl8OuKRv5HfjNa2z4UPH7aO5iblVaeDDvzb3p0P
    ipc3V3a9xqm31rQIA>
X-ME-Received: <xmr:brcBZjxAcFzaELMFj2g7WW7LzScRkHsgSGDHYAv8CE1N2VRW_dhKms2S4To>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:brcBZrOttLnsDJaCFk4EnvhHBmXxrYch1_PW1HVaW9kw2t4X7HcvQw>
    <xmx:brcBZo-LRP2d84tg_Q4JIonCDJYH7SPE_rPjjr_E3_r7Z9xkIpIFIg>
    <xmx:brcBZjWCTJaYUGsJmMfdppmLszp-GXW7PV-EnICMrLXkJF0ZBs4glQ>
    <xmx:brcBZhegCC3q1MTsql90BpHW1BBKDNtkpc7pTNFhSCMfLxCENWYd9A>
    <xmx:b7cBZjahbIKeas-5yQNlhNLeTFqL0zknWIQJS8-4CkplLfvWxgS8Yy3u10Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:42:06 -0400 (EDT)
Date: Mon, 25 Mar 2024 10:41:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] rcu: mollify sparse with RCU guard
Message-ID: <ZgG3UC-x8wAIOdd3@boqun-archlinux>
References: <20240325183907.7205bf36489a.Ic3ac66ff5d6a9bd8a610858060117e1364641a3f@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325183907.7205bf36489a.Ic3ac66ff5d6a9bd8a610858060117e1364641a3f@changeid>

On Mon, Mar 25, 2024 at 06:39:08PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When using "guard(rcu)();" sparse will complain, because even
> though it now understands the cleanup attribute, it doesn't
> evaluate the calls from it at function exit, and thus doesn't
> count the context correctly.
> 
> Given that there's a conditional in the resulting code:
> 
>   static inline void class_rcu_destructor(class_rcu_t *_T)
>   {
>       if (_T->lock) {
>           rcu_read_unlock();
>       }
>   }
> 
> it seems that even trying to teach sparse to evalulate the
> cleanup attribute function it'd still be difficult to really
> make it understand the full context here.
> 
> Suppress the sparse warning by just releasing the context in
> the acquisition part of the function, after all we know it's
> safe with the guard, that's the whole point of it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> v2: add a comment after discussion with Boqun
> 
> ---
>  include/linux/rcupdate.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 0746b1b0b663..6a3c52b3c180 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1059,6 +1059,18 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  extern int rcu_expedited;
>  extern int rcu_normal;
>  
> -DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
> +DEFINE_LOCK_GUARD_0(rcu,
> +		    do {
> +			rcu_read_lock();
> +			/*
> +			 * sparse doesn't call the cleanup function,
> +			 * so just release immediately and don't track
> +			 * the context. We don't need to anyway, since
> +			 * the whole point of the guard is to not need
> +			 * the explicit unlock.
> +			 */
> +			__release(RCU);
> +		    } while(0),
> +		    rcu_read_unlock())
>  
>  #endif /* __LINUX_RCUPDATE_H */
> -- 
> 2.44.0
> 

