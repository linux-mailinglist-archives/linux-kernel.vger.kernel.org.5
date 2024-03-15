Return-Path: <linux-kernel+bounces-104613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E0A87D0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510A91F23EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CEF45C08;
	Fri, 15 Mar 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OBBobAMD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AA4596F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519043; cv=none; b=NxJN73Ah3LzKfTY6jjxnTCngEpKFi0b/9+mWRbcqW29VvJzrq+XaZ2fv7nyTZZ49E0ynslRezYEYySMsEOJGKHHjf3Shb0ONQF3C7yBCeDY1uloZkiInxtDeFMH7BawJQSmZ9KC66fXAxyuuBjvVoWyOV4wkrqmpy8Lpipr86Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519043; c=relaxed/simple;
	bh=pFecakHgas7dZ17aVxicBuLRtbRh+a49PVUxlI7Kv2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJHEEWkK55zXOJttcuvl+Y4eZm/dX9R77k4o9EU4EiPVTmi1CkC1EBtHkuOEMoaMx5TAAbYD1TrfiXGLiqkmN4Oe/hLdt0tlTOhquE+lhgzARQFzGZRrGPIaR01yc5bxy7JjmPioLdyoMVF7Jk/fzIncUU6jpQGjRhVvizMIGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OBBobAMD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46966e9d30so69741266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710519037; x=1711123837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVUZleVAuVw5wlLMqPdhoHzp3Uog9zAPKsHSpJJYkDs=;
        b=OBBobAMDu71sGZEyjPeozBlcueiQR6lNiZJFisxjxs3e2DkQvQSQHKwZ8WYJfr/i2D
         PKScQyqswXJuA13OLVnciEkthpNq7yOygCx3nnPLkQ40Ys+7wtEXO8VPgBzR2zc1nVLT
         F0ftGFlTWmapYwLYwRAIxJB4nGClmaJQrhNLsPhI7TfWzkSbbFhblf32hohK+0UxO07R
         Oda0ZsB1dhRjxUH1fMYQ+wTtIjhyYuB0X0PX/ntnJoNc/pWJCRl7dlsANptPA/xdImAH
         /OsQqJ7jadV4PsrvwcuZB8+a7j/IxfpTYw9o3+RszW/fkI1R3MIMMnnNuFj1nSIPsJwL
         KUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519037; x=1711123837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVUZleVAuVw5wlLMqPdhoHzp3Uog9zAPKsHSpJJYkDs=;
        b=T2ztGIsdiPwCZt6IeAxRy0EPwjfTTO3GeL5G7COp5kChDjh90qyeVJKnnZgShKEix3
         EoIKVJktPWcQ0RrYI/HPYef0AkR+pGAiD/4ZP/bouDCNInDYaD07oxA1gOPBd2yA0fYq
         2PWFbZi1NBGmXnvhWT+ADxvaPSq0sB5t9wmn0j9E36ApXuOo4YClCXQbsbsUib704UPB
         MKg6gLW7WZnQkfEB7FnAl/0O/k9ud93LFkkzskjZ2gHEfpirrpKLv2X1kgMDcMhLnhyT
         le5QhuZtN3j95D3Za0zeESpxP/dgx3DOMIiH7peu/Bv+P5OXfy6F3TGk8YrGREtCB6cS
         b5RA==
X-Forwarded-Encrypted: i=1; AJvYcCXyFr6hmhuZUTcD4KVvIYcStrPOHI4bBHcN/XVFSymDtR2sKC09sNHI/oYJ92EBhMrQUMRgtyy/ryhtH3R7/anRE8p6SK6xuIK2sKHT
X-Gm-Message-State: AOJu0YzcUo24QpU8NZ2zZxVKOsJ3RfH1gssYvNMERwpmAZqxX+SZlJaJ
	Z5nEYuk5SBQATerz2cajoTQObEOXGTl4b9Q3xtI6RM2CEZzhDQI3UToTonjZbLE=
X-Google-Smtp-Source: AGHT+IGRvXb1d/P37NbcREcW8Py8K4FC2SqlXDhgvkMMp+nJzhFA8Ec8cVTUVgh3ZG0C9OHCTpjcdA==
X-Received: by 2002:a17:906:d96c:b0:a46:9cec:b5f0 with SMTP id rp12-20020a170906d96c00b00a469cecb5f0mr242801ejb.7.1710519037183;
        Fri, 15 Mar 2024 09:10:37 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s26-20020a1709066c9a00b00a4617dfc36bsm1827609ejr.178.2024.03.15.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 09:10:36 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:10:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()
Message-ID: <ZfRy3hsv_m9kNhpR@alley>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
 <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
 <875xybmo2z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xybmo2z.fsf@jogness.linutronix.de>

On Mon 2024-02-26 13:07:24, John Ogness wrote:
> console_trylock_spinning() may takeover the console lock from a
> schedulable context. Update @console_may_schedule to make sure it
> reflects a trylock acquire.
> 
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Link: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@quicinc.com
> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes perfect sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been committed into printk/linux.git, for-6.9
branch.

I am going to give it a spin in for-next and get it into 6.9
either in the 2nd half of the merge window or in rc1.

Best Regards,
Petr

