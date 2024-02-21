Return-Path: <linux-kernel+bounces-74090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D385CFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D741F23FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7D3A1B2;
	Wed, 21 Feb 2024 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3u8uOeY"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B23A1DA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493965; cv=none; b=D8LwghMxygJ2YF8e/ORU72uTKv3iDd9vmpjMl6o2aal+D6Yo1I8wtpZa4O9bxVWa06YxXUhGcyo23acydOPuyWSiZX3vh6ypUQ2yYes7WUNmLOJH3NIEg8Wpm8EZdljQZL6qfnNYMiy53nWM8xdvZeHyQfUF9XNBaRudyMI6CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493965; c=relaxed/simple;
	bh=3KQ2d0VXRqHlBaKDbzY5v53E3zGxHP9x92zd9i3KlLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebaf6FNrjaqhL/bBZfUxg0h1LWhWPIwEq53ZTXETNcxVl9F9tosm4ryYavhr1tFkJN657mwmQcu87XjkyF/DdnPTg6DZf/wiHLRVzOj0Nft+/FsEOqzhkGHdZvslnnSJzHGHMG3IDHu9LOCHCk/hjk9UCYxoqoY14oyKT/xcV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3u8uOeY; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c15b7b36bbso69184b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708493945; x=1709098745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17RWatD3NjWAziCFIgZJklHdcK9l44N5iH3LSmPOJgg=;
        b=H3u8uOeYMlnPdUhDSHAFDZyqFmE4k7AZpPQXBG4tE7MuoqAr7D+6weOxr5OgHYv++g
         ZlL2V8uUV98FPSWDkHFLb8YGr3kX3RBpZVbUV/ZBEFuJoLjit5/kCBZmnFAeblZjNajs
         MYlyBB78xgUJibS/Kd/G8kcOnEK89uH8JO3J29j5fGkMijRxwFRG4nxStLpmjFZkZlDw
         fjM8EQqU6Q5XMnZHMasUp0bBImv3GKVt3CLxXJsXNLfBEczLDq08gMH4eOAi9t13IMDX
         MGAGsWGvceuhHz9C2cTQVIKABwQlE1yeCM73+rrUacHv1omz49fZtwyU0F4bcLT49way
         sdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708493945; x=1709098745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17RWatD3NjWAziCFIgZJklHdcK9l44N5iH3LSmPOJgg=;
        b=PPvDTfmRCM+OTwzbzoJiIn/F6PEK7DV19G+aDoywXnyZNR+ubVazDqRnwbF32oQpl2
         PW2yw2PCVokk432EHi6V89Q1CZ5+BeFUV0Ojy/jbPfTMq9/1U9NXJdFq9PlZylzqh4hA
         s2X5b8Dm7alFJqkFZQ/CIr3B71seaLiNNlooNlKl8m1/qqL4a633OU/MotVxqs7njJBR
         CVd5LhhXpF/UfBxnJcSCA6skk7x4R0uOnVJRXT1NhVt1e7J0t3sl9JOir8iC4wjLz8wC
         CUYxrtTCf2yP/7zZFYfScjnx2t8j69+fmO8fYAimVpFFoDTIFRrxzrX921QZ/XFomMfI
         W+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWYZizSXv6pwLyR/dreW//LfsrFTKckHNulYOMCpOt9fw0l/ZnN7Jl//VdyYRlSt3IJkLD48yo7APVxfmQfDSRZDJRT8BAEfKbJjEmj
X-Gm-Message-State: AOJu0YxQ2C9xsYSPug/0Ekjmd6rsdUzcOQgp7OCEZMdWw8xFHlgmoxkR
	xfJ0midw7mSB0G9gG9eSvQs3nKX2s7Dr6DaublHuv+elN09QU+ag
X-Google-Smtp-Source: AGHT+IH6ArJNJQFpjVg8e9CYVBtjypBEe27aM0Fx2Pa/PWCIfpzwgyU0JNh30+GS+9kb92rePziu6Q==
X-Received: by 2002:a05:6808:1891:b0:3c1:3f1b:ffea with SMTP id bi17-20020a056808189100b003c13f1bffeamr18022723oib.47.1708493945626;
        Tue, 20 Feb 2024 21:39:05 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id h26-20020aa79f5a000000b006e410699a5fsm6069882pfr.191.2024.02.20.21.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:39:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 19:39:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement
 disable/enable_work()
Message-ID: <ZdWMd2rHjCEUOfAp@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>

On Wed, Feb 21, 2024 at 10:39:05AM +0800, Lai Jiangshan wrote:
> For 0001-00010:
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied 0001-0010 to wq/for-6.9.

Thanks.

-- 
tejun

