Return-Path: <linux-kernel+bounces-74109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905385D00B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E002A1F24FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF539FE9;
	Wed, 21 Feb 2024 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mttcrzko"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76239FC6;
	Wed, 21 Feb 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494274; cv=none; b=nkSWGhvGhnhlHo4UUsn7pJF2ugmJkPv9yvGy+C0k+O3SBdOnETRUDopE8TJlGlOiNAaA2sCZ5kZ6nEGiwNL5ofghUAaL1MjMoZ+wJgoBI1LdJrY0LM57dYhvcsuS6NDXMzgYBL+21Y8QvW6vFhaREBH1hh05G5d7WKUkiIR4//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494274; c=relaxed/simple;
	bh=2XpWe7jQS7ujg5TSj2OD9Gq8ArrACGZvdM9hBYF6WSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9Jd7TtotWDFT89JiJzqmy8MXuE3Bw99k7k87bE+Lkt39LzcIfPdp4asgcEYlwYc/Otgxd69jLrDiEUz/KjXa31r3s2htwxrZNKts8KoAbe+r+1g6rpRsVC4scuzc/KtvHUnrG7pMnM1TpnQ3YE1M9it/SjtGVEeQmjuNoBuCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mttcrzko; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71cb97937so61425905ad.3;
        Tue, 20 Feb 2024 21:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708494272; x=1709099072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rQAtEOLQpkAZ+mdYYeoqAaD0LWVwNIo0vsdpvK78o8=;
        b=Mttcrzko4NMHbH4rpyGf3EmqlKcJKqfGwtIlbPk80Z83n6Sf2ocn9ZzL8P2HWWyvzM
         mx8p1rDGLmdeEi3d/0dEADvLACda6IzsQfmyApiozfcJawhfEs4386fKnOcbwwKkyyQ1
         GWnbXXc5ssibzNRR2PGiyoRoywBqUjAeVu/GoZUdkcmQhnB/blox3M1z1360SAxBdqfN
         m1aD5XRuaW0FkkCioYFQG5Q1pgPdIqB2N537ROH/AAw4dBcL2vLq0if3q4sHbf7mPt4G
         3D5rKQ5oRcsPJfeoD1ziL7qy6eXbu5/4T28eA996k9drhbvaB3OLOiLI4y5tc4xcQGc2
         tdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494272; x=1709099072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rQAtEOLQpkAZ+mdYYeoqAaD0LWVwNIo0vsdpvK78o8=;
        b=GW/1qvOcH+iAGD+GF1kc2zX3F5/QwwXV1wrYYsqjAjm/urxRFEPUmgPCGLjHdP9q1A
         V0U/TQnw51L0GvzgmoNfn50adtcPlii6WWt0TT7OYoguvqmQaL4Yyf8XVfJjjDySQldS
         Yd1t40mX4F6GBmOum2dIy7uveJOhdfCSwSw9xFiwpoxa5qBO0e8M/Rop2ix7P9QaNk/1
         Wi0E8Fz94WuZwUSQKXIvkgrOmv//xBpfQ9RWCNKHTkenMP3NbaQ+wsbgyfcAucmq0lOU
         pD+FQND4n3cal3mDt45+18IUV487iyT8zSDSf3BLnHYHplTD+ojIlfm/5cY0spMxsE0d
         pwxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJfqmXUMPB9gwNYHgk77msNeEQN822dcXDBniyx/9MZy6XD1GAiwfykalwHHJCsWZEp5HPvNmxl9uSfv0H+x9aJzUWvE0KuZZhA93xjL7Avhj0qTPVNKvDJJGXURJwz2DPl1UnaXBa
X-Gm-Message-State: AOJu0Yw8L67/O5uQ2zgNF5oNKNOq2WjsSaUDCgcDdz9cFBOFzgyM4cQQ
	PaL1m/zI5F9MoXROHLXyNAyIXVE7nrmsIVKxBFo7qEEp9C8B9Wp0
X-Google-Smtp-Source: AGHT+IGFVlbeVIXOpT4HMYhwl0kML0AtWdRXds5MKSxkf86lvF5shb4tvc2szntarK/2NDTzw7E7dA==
X-Received: by 2002:a17:902:e741:b0:1db:fad5:26ad with SMTP id p1-20020a170902e74100b001dbfad526admr7912801plf.51.1708494272171;
        Tue, 20 Feb 2024 21:44:32 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e20500b001dc1088357asm2745409plb.1.2024.02.20.21.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:44:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 19:44:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jiangshanlai@gmail.com,
	corbet@lwn.net, paulmck@kernel.org, rdunlap@infradead.org,
	peterz@infradead.org, yanjiewtw@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
Message-ID: <ZdWNvolkfPCyMNj9@slm.duckdns.org>
References: <20240219074634.2039-1-xuewen.yan@unisoc.com>
 <ZdTXWrB8dascOIM_@slm.duckdns.org>
 <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com>

Hello,

On Wed, Feb 21, 2024 at 10:01:17AM +0800, Xuewen Yan wrote:
>                 cnt = atomic64_inc_return_relaxed(&ent->cnt);
> -               if (cnt >= 4 && is_power_of_2(cnt))
> +               if (cnt == wq_cpu_intensive_warning_nth ||
> +                   (cnt > wq_cpu_intensive_warning_nth && is_power_of_2(cnt)))

If we do this the nth name doesn't really make sense. Maybe something like
wq_cpu_intensive_warning_thresh is better? Also, something like the
following might be more predictable. Let's say
wq_cpu_intensive_warning_thresh of 0 disables the warnings and it's
initialized to 4 by default.

	if (cnt >= wq_cpu_intensive_warning_thresh &&
	    is_power_of_2(cnt + 1 - wq_cpu_intensive_warning_thresh))

Thanks.

-- 
tejun

