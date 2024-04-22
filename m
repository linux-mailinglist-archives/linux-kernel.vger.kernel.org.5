Return-Path: <linux-kernel+bounces-153935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BB8AD515
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859871F225FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43D15535A;
	Mon, 22 Apr 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMOaSimx"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83797153BFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815131; cv=none; b=L1FMHr5mamnfU7PIDIfbZfMSwDiHzR+ZFdWLSfApLjfzlLUa9TG//AJ6ZOa+kzgHRPyd8D4abV3L/S/M3UzpuywUeuYnmi3nMvUFJtyS315zOUW9brdca1TJBQQf2U9+h410heXf7u4PLI4CjZy2N/afwRKAW6ZqrDeV0+m2Nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815131; c=relaxed/simple;
	bh=JCTuekCFiJjIYv3mB+0rClPkhd5P3ZD4j1WbAdIpCV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSTHXncXCXwq9SC6QsuNtUlJZdg0Qdx1uiq6N5cp+cgMe4rucwJJ5xFL/NY3g3FLQ9KW5+mWJQllwCLrbSOzp2YHjL0s/SBNOjDudhL9Fd4u0W56ZZaW6vJp/3GJjGPnyNIuJVVTzGYCdvvMF/MU2v70k2tls0KQw2BGWjVSQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMOaSimx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ef59a369bso359036285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713815129; x=1714419929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNksngP012bsXOiEvMGxmyYcdrAVliwL5a7RPH9fopQ=;
        b=SMOaSimxJ584e6wbHT+FeOAqlsBCi8V6opvIt/969feR5J7BOI5yESD6oaDiqfrzg1
         uIGYbBX3NiSEQiZbCPKxd0/OJfjHPsQ4396taFXuqb0YT9qZtGZUcuzJUfacMZSKnNLK
         xqWvRbd1RelF8Mgi5bvzESuEf6uDe51XHmSRyfqlATqB9D9hbkrS5UaSyCKv2Sao4XBo
         1JJKld7ZiU1oQyDg5ZozUZj2CNZckwXx4elyssivhEidOh9gO+jOoW02Ra7HlWj5j3Ln
         5Kedt81NKBqglViKUQ1bpfNRziAbNTj9nqOU5tTJNrEIQljDmdt0GxE3Edc/u4uKVPT6
         Y6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815129; x=1714419929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNksngP012bsXOiEvMGxmyYcdrAVliwL5a7RPH9fopQ=;
        b=huqearOehofrCwZncjest5m3hA/V3tz4aCoLvcd8NNHW1s7L4LRlcGE0LZxrym/Gzl
         AoMr7UHMS+4Znkawd9DzU6GzwRDjHwe+VW0o0jJ6FPEqF+WFZ6pIfW1ukpFtryuvq1Qm
         C3J4L0EpZsEXAeUTez61hhwDZ6wkXk13Fm57K7B4lsJ6cJnjd4juq0qyEH7SXJWgpDY9
         BawNjjf4596O09WdHW0zGmdRGftIqDLGoWQjal45X8m8GBEPNOsmSrpIyso8qkZDwqkt
         cM3jMxYrcpKcgzp8JenQlq/8WUIWN+SO5BcW1kKt6Bgqh7azZo2Og2IcQ+4uEq8mU3cg
         N+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVLn8oxboCNrUfu6moQXlNSZ4bJbRowbv31GutbzGC8Y/1lAva4SbwrK2QMj8wsm+VHZCb6hVTtM2658DvdakK6p03rlHfJOq6ClbpB
X-Gm-Message-State: AOJu0YwUdBtDIayya19zxPB+OFw31re/zZ2PH0opFcwM3BPDgYvqoSES
	jf2Kj/u8Ib353lSSAY1Z6Qebj6BMp9EnJyKVR+bORvLGpn7Gj+6FB2wF8Q==
X-Google-Smtp-Source: AGHT+IHKfVWjbK7om0citwhnVjYpUJSP/WuLhqoOb5+Vtj3FnhVaBNjMpe6qr5wSuPHceD1Kv8qV3w==
X-Received: by 2002:ac8:7fd5:0:b0:437:74fe:1a18 with SMTP id b21-20020ac87fd5000000b0043774fe1a18mr14584862qtk.62.1713815129332;
        Mon, 22 Apr 2024 12:45:29 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id m3-20020ac86883000000b004365bc5b9a2sm4512828qtq.33.2024.04.22.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:45:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1748C1200066;
	Mon, 22 Apr 2024 15:45:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 15:45:28 -0400
X-ME-Sender: <xms:V74mZvzjrkx7ceORW1A0M-WVEFjqxSzI0W22sV5L3xI9Hwmb9hmY_Q>
    <xme:V74mZnSWkcNffFQrwrwJ9EO5JwSQW9AIR4VkLisU2Okf0dP--Eny3DPG4uKqSjk4O
    f0DjP1GlKgY3A7yUA>
X-ME-Received: <xmr:V74mZpWfeVSz8eMYw_BCjpKhJ74kn4hiPj-mi8flgtN3ztwTO7pgYCMsjDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:V74mZpg8aNXTX24ZUTl3E_eptxDEoqXnKj4h5A3tnf-k1it8sULmjA>
    <xmx:V74mZhAhNmyvSfJvySkHW3lHarYNEbBhWzJBDcm9lBdLEvF57Vk33w>
    <xmx:V74mZiIQZ5D8d-_xk-6erVaix1iCs8ovqCUUXROC-MWuzf-dlju1jg>
    <xmx:V74mZgD8VeK4S3HChwfAJqP4rxRnGMsEWjQfiRZ9qnF60N1P0fbfpQ>
    <xmx:WL4mZtwYtfdP97CzQTLJX9qtPZRkUlTCfqyfoeLj2VjAaaBy8FzcajeP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 15:45:27 -0400 (EDT)
Date: Mon, 22 Apr 2024 12:45:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
Message-ID: <Zia-VeObR-m6Bf39@boqun-archlinux>
References: <20240422151752.53997-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422151752.53997-1-ubizjak@gmail.com>

On Mon, Apr 22, 2024 at 05:17:35PM +0200, Uros Bizjak wrote:
> Use _Q_LOCKED_VAL instead of hardcoded $0x1 in PV_UNLOCK_ASM macro.
> 
> No functional changes intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> index 466af57b8ed6..0a985784be9b 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
>  #define PV_UNLOCK_ASM							\
>  	FRAME_BEGIN							\
>  	"push  %rdx\n\t"						\
> -	"mov   $0x1,%eax\n\t"						\
> +	"mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"		\
>  	"xor   %edx,%edx\n\t"						\
>  	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
>  	"jne   .slowpath\n\t"						\

There is also a "cmp $0x1,%al" afterwards.

Regards,
Boqun

> -- 
> 2.42.0
> 

