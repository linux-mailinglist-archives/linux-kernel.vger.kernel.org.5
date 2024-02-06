Return-Path: <linux-kernel+bounces-54114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A884AAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8990284B75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD77FD;
	Tue,  6 Feb 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFmrFKbu"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B038D;
	Tue,  6 Feb 2024 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178426; cv=none; b=rM+Rerlc04aTFV/QxLRfKijtXMv7PwxqQMqTXZppA3vZDMsiq1McPoFem4oVSHUf+GhBa11MTyHWWBoOsIiK//7Zfyu19lgrKKXm6SaJxzyXYMMCzR7pdVKQ8BWONtFc/6G8zv4NgZYpFgOkjEj0dzdapTG4uZQB7H/utWVsjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178426; c=relaxed/simple;
	bh=wVoOc7tXbiz0JhSMMYV6nNNHF10fB0vLJK8KhFXOa0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMp3/mrupYpWbpSh5i7Bej6oZny2g8uWBErvgsjuwtlfoMBF75GlOAwy07W39aVC9HbzjIWUEvrAX7jiA55oHibTAbwIAioW9AVAt/2VX0aIH14+EAYLMUaQPeilBRZC69OCsPDWrgkg+NBlr2oHyjILxlKqF5u8HsL8AXCEmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFmrFKbu; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd884146e9so3985237b6e.0;
        Mon, 05 Feb 2024 16:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707178424; x=1707783224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98cWYkQ6MbAJUoSKUpZHTfrV4NmGt6n3dGfyyLHqfaI=;
        b=nFmrFKbumGdtfhyyluA76OBLt19Lv7+35hcBK7M1sbXKdn3clz52uZiKEWXTNP3QU6
         Z4DzqUQZzcm+InvvO13hfQNUBojWZBKblySnKZKSmAnmIzjdrL3TOhQ2SvPlY7exPfrc
         HUb+nI++oqmEyk1GJh2n8T7f33d4PNDdxDvPHjt2TNcswj/hegjqngT2T6QG/afqTFkR
         kyTJatOql52qdF/dZgTqC3LgNPgu35KdHT15l/V1ufj+WgXtO15G6xhOfxRTSv0YKQ6s
         6hKIxvi/OnmZEyuNj/bB1ndrYgEGsNRNVS7eCjinj96diezzYVHyCKQvn1W5+xO40zBT
         x7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178424; x=1707783224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98cWYkQ6MbAJUoSKUpZHTfrV4NmGt6n3dGfyyLHqfaI=;
        b=oZU2DuQV6QvpzTxjXwBEIYxGUVd+jQ6dqOq8/OiBOFTWi9NDYOBoW36JU2AfvQPUXg
         vHIyFwIMlnVGEC6qE43qtTt2KBcNzPq9UHIBXyiGuOtRZGKjIMRAtxTe6hJSt9pDfRP5
         u15uqZXrWADq75Ny3lq1tvpRuU0VrbSOnl9ifNDZaMpvxEkv4vMUBcook0C3x0XLXKaN
         dmC6sb2lOq8iS7REhbcWuaDC9rmlOTAGH8o7aGgiZFXs7Q0GbmaXnbaQCVeme+mhTgT9
         V0htvF4GwcCcYP4hT1qNg5qzuGGuMy098ekKnZX25Ph62ldwgKUdTX/VpXy17WlGKGdh
         mclg==
X-Gm-Message-State: AOJu0Yzsf1aPoYiKL/NFM5U1HMUTif+8wXxpZq0z4f94ziZEslRma6eH
	oYBRhYbSBKEIsRbLfg5yjkayr8lnwBMgn6h04r4y3ORuIxYaa6qi
X-Google-Smtp-Source: AGHT+IHLUR+sBwjDr6IOm1zDoDAON4oNTIGY9LMTcemysoH13cqXI49AucLFmhVmc38zQ+c6K/xdlA==
X-Received: by 2002:a05:6358:290d:b0:178:fe3e:1e35 with SMTP id y13-20020a056358290d00b00178fe3e1e35mr236386rwb.13.1707178423964;
        Mon, 05 Feb 2024 16:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyiXIEPlCl9kH9g5Q6KP568yzf3dLpU+37lr8nKGWWDIMOQhkdiFTYzoxjOsd+7uGCJMTatPWmPtzs7cNXWIGci+W6lg+PPlTiSNsKgdmFuC0jmuie5esKcL0sQB0lcEJNc1I1Y/8Ghv0r7tiYdgOTnbUWQNJrMh/6MnmpfKw=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id w20-20020aa78594000000b006e046c04b81sm481143pfn.147.2024.02.05.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:13:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 14:13:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZcF5tm8b9XaljHf-@slm.duckdns.org>
References: <ZcF2JaEuwMdg9kYi@slm.duckdns.org>
 <kksa5w6lgxu66h223quzkw33523zgoltqvl74lmthb4aaj7iat@rss6cnpn3t2p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kksa5w6lgxu66h223quzkw33523zgoltqvl74lmthb4aaj7iat@rss6cnpn3t2p>

Hello, Kent.

On Mon, Feb 05, 2024 at 07:10:25PM -0500, Kent Overstreet wrote:
> This one doesn't actually need to be ordered - if anything, we might
> want to bump up max_active.
> 
> Tejun, can you drop this patch? If you're trying to get rid of all

Will drop it.

> WQ_UNBOUND with max_active=1 workqueues for your own auditing, either
> you or I could change that to 8.

Yeah, can you please either add a comment saying that it doesn't require
ordered execution or bump max_active?

Thanks.

-- 
tejun

