Return-Path: <linux-kernel+bounces-135422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BA89C190
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13341C218D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166297EF1B;
	Mon,  8 Apr 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W8Rp+EBj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8477E799
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582272; cv=none; b=ANaqdoBY85+ijwUUW8gu8Rj4Ep1npcWYsrSXtLju2UmaM6jED5zhoUFQbtU5NTP2ZWxMDu3yScU8SoW4H0Pt3dXapEDWwLtXcD22RTXF2L/5AxbKwGoEB7EASmXN7jhSGE3Wn6UqzRSHllvTvKnenoeR1z67to4Fm6eQLwW+phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582272; c=relaxed/simple;
	bh=ayvnE6BfHW1tH8INc5vqSDMcxLkTDPXNg/rpLAGUX6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUxTSZRXQqiIyRi7UAqBUD9z0DgtkJaJgpMnAOyLyTDNglQKXUliDBtGt1k4avS/bY20sGR5mK4urblETsCb4Gvd+0owHa62esQbBBHJPR2RDg6fNqgZQc8eiRJM3aACjxvCwvNf9nXPuqDmhGPJ+55FJ5bHqu8/TgJlFbgxoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W8Rp+EBj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d485886545so78134971fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712582268; x=1713187068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtxTOxHEOLsKzSUJ56n3B0gVYXaG14K+c/NBlRc/+P8=;
        b=W8Rp+EBjBAI8lOhVF5YK3YDaYAbLgnG7htxZUgyW1u4NHIsyJHvyo7mtSbQNYL7TuV
         o7WJl/uzd/bCoPOHLv25PGeHPyQLrd2R1mbrSTFRIzVjWpXO/6kZp89V2EZrG6usI+hq
         pD3O6HCteAmwiP+6Eb1rK5qgma8lzi+15JFbNlXCg0oxRr4RJfp8JnTQrmLsEQwkobsu
         v6YoD40gTfkmJBmhzRDiShdUb6CH6blZu8phfbfN6V6oXDmWPbLNiyoxlH+agPROCXFQ
         We0OcxBKoct25rgKUzWYWj7nFnCFdZ5oSYwgGs9G7fJInTSNPAtiId/GtB0vkQ8mxGbO
         2DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712582268; x=1713187068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtxTOxHEOLsKzSUJ56n3B0gVYXaG14K+c/NBlRc/+P8=;
        b=hvWrbpdtTp3Trtuw9KSIFp/5cCgDhoruj8m1+SY5cbLvAkFPdhE883CSpZUBHn9TAL
         MlHHyodt0EqnaK/CRyxk74lSORM+V0L7A1RTnaf6BkxP+9i2mbXJEc27CZS3fbW0px9D
         Ksp6jmfnZ2YP0swkB5jcDzgBG2C/s+2SX8hQ7l/GNXhMgnm33V4UQBht0YorlhkrZ0rv
         NQTxq5bUkwS/8vzIXZX1xF1zBBwJmNaB9sQN52DN0aQPWMqE6SHXGSiKltuFc0MBDBx9
         VqT5zP6Wo87KTHkfJTqCZRXacDm/yKrItP9C8s1jnBTE5okcYwGF8W/d69Mp9NdG0LAw
         9XOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpPb8aN/AS/3FEZglkSotEhF4AX4f3WHSAvdwxki9sB+Q+E7UMY5hNDhaGXekl19ZvhpGWbW/txv3eCUhaOz6pjwVcix03gnUWIL2H
X-Gm-Message-State: AOJu0YxMKI5KRfKCFUIpfvK9Betzo/adFqgJwb2WcDVoQLDs0iUyvraV
	ZVqjxlFtT3VQS6lcOZkah8iIXoB585CHNyLeUBWHaGlc9Ew9Dec6SYxRT6mtBWS1GjurEE1xRxN
	5
X-Google-Smtp-Source: AGHT+IFtLmlQcPmyyXRctgdecYzEzsFka/loJjM5BRMYdyjfD6Ti21kR521k/zK7vVxJbMvcgb3ohg==
X-Received: by 2002:a2e:b6d2:0:b0:2d4:5c03:5ccb with SMTP id m18-20020a2eb6d2000000b002d45c035ccbmr7721725ljo.10.1712582268195;
        Mon, 08 Apr 2024 06:17:48 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a51def4861bsm639739ejb.91.2024.04.08.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:17:47 -0700 (PDT)
Date: Mon, 8 Apr 2024 15:17:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 03/27] printk: nbcon: Remove return value for
 write_atomic()
Message-ID: <ZhPuep7cMc3i6wro@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-4-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:05, John Ogness wrote:
> The return value of write_atomic() does not provide any useful
> information. On the contrary, it makes things more complicated
> for the caller to appropriately deal with the information.
> 
> Change write_atomic() to not have a return value. If the
> message did not get printed due to loss of ownership, the
> caller will notice this on its own. If ownership was not lost,
> it will be assumed that the driver successfully printed the
> message and the sequence number for that console will be
> incremented.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -889,16 +888,16 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	wctxt->unsafe_takeover = cur.unsafe_takeover;
>  
>  	if (con->write_atomic) {
> -		done = con->write_atomic(con, wctxt);
> +		con->write_atomic(con, wctxt);
>  	} else {
> -		nbcon_context_release(ctxt);
> +		/*
> +		 * This function should never be called for legacy consoles.
> +		 * Handle it as if ownership was lost and try to continue.
> +		 */
>  		WARN_ON_ONCE(1);
> -		done = false;
> -	}
> -
> -	/* If not done, the emit was aborted. */
> -	if (!done)
> +		nbcon_context_release(ctxt);

I thought a bit whether it is better to release the context before
or after the WARN(). My conclusion is that it does not really matter.

Anyway, we must make sure that it is safe to call WARN_ON_ONCE()
when nbcon context is acquired. People will use it. And I believe
that it _is_ safe.

Best Regards,
Petr

