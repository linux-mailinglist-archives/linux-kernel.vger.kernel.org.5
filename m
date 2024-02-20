Return-Path: <linux-kernel+bounces-73230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1685BFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E079D1C20EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFD7602A;
	Tue, 20 Feb 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BpakPrzQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF0664CF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442220; cv=none; b=bVOe8vfugjLUagH66/ZrrYrIKW3MHnSQjoC11pt9L1XNPxwMUYQrOgp45WVhwhc/ruJB/jitr/lmyPZTcG2HfInet8T2KljJlDf0aOfkfrHCJ4ITnsj5a6FVPZGois8GaCPb6GkbRFgG+BEOF/euUOUxEL3itnRVJP00+Z71xUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442220; c=relaxed/simple;
	bh=oKHdoiFZ3PscTMXufpdRXrc/0hmFVJlyAuvTku/UtCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJ6cNtC5D3KjjdfKV0wrschf83PBgOmcN7zWhvbeAFQwDDwhGCb6TEz0zKvI/FwIor/lfV3vnZnmgk70d/fu74KZHtXHBYz25zMOIbPhbmBRlUD5vtqtHvJ6mw70CR+cHGFQG9E2baTzbBzX5B+E3UcTFmsxOCVrkFYowFZ8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BpakPrzQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d220e39907so56767591fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708442216; x=1709047016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aXWCAcAEOs7KIPz5lYBFVbb8nJbXgzCW+tcDzwHJuo=;
        b=BpakPrzQkX/2bZI3DFQaSIRSvErBXvf3iEtcHuw8kSJpcZofwsPeABqos0Yh+xtgf2
         Ch9VRhLPkZGvzRtTpdqRgPwBHGAf3c498l0HxW6EzCMh4M5c9mgSKAosah77buPN+uPN
         o+uZxV9RCcOCxAezYbepkFIxAkDqCY79xdEi9yuLEYt0fk6eR9JnHbKK9kToXK/Lssqa
         CLD5VgLc7piYeZXhahNz6/Vgt4QPzn0i+hXpISTjeByCbNHQkM69/OtXfUU6W6pMGfQT
         DHuCpq/ELCSO/Lf7f6gZ8xVKXVfdhWDdS1VUvYK6NXZq8n9UIkSEo4f4Gk6JiBCsyGEF
         xzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442216; x=1709047016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aXWCAcAEOs7KIPz5lYBFVbb8nJbXgzCW+tcDzwHJuo=;
        b=saHsapXGqHn8O7eebx83xE0izFT2Bd5C434tqb9V5G5+OiFxNukFcNFQxT+vIorJPv
         B6EZhuWkNKmhXCS522MCSpkVGfxWcjjlG7nZHcbODHOn8GmksYTZJ4g8fV1jWpAjPi5F
         th6gZmU7X5BdSg6elwFmi3i3CXgOWVumZwDctIywuO6B4+kHWPK+jDq1ayGQqX3bYxD5
         sIYkLmc0wtC6DxXsfgCN0fFrm4JwiRebG9gLebe0zIULfnkEd3Qp/EnzexVF5d46VfvS
         wAbrkpBKN38BKsZNvdDeEpDxdbY/FIcV+djtPG3ItWFSVQvBFvHrDZxA7zb3NMqGpUen
         buHg==
X-Forwarded-Encrypted: i=1; AJvYcCXExAde8hyv6gvasOoeQUkyXon5MmqRNvNFeRzWXotWisPHjk7P5UMpYILd7S7TayNbRNhVYzHOHUno0WhDiivT7hkVJ+T7mznBaIHo
X-Gm-Message-State: AOJu0YxVf04MbUeg0s+BpL5dXw94IyIkSjJzdA20l/0lX4p2sldf4Q+P
	Ge5JihDSTKK134FJwVWb9/61TSm2Lko+2QKRR+OeWaLzIC+a49B99mC48y6kFjc=
X-Google-Smtp-Source: AGHT+IEPUrNBkOBD8eEgtSBpZj/2SoRw8ss67vQboeNWJS0Y/ibwBIyTcJ4l7FTjsjFjZFSfyp29Ow==
X-Received: by 2002:a05:651c:4ce:b0:2d2:3f06:5343 with SMTP id e14-20020a05651c04ce00b002d23f065343mr5596453lji.10.1708442216024;
        Tue, 20 Feb 2024 07:16:56 -0800 (PST)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b005648cab22fcsm1614800edt.1.2024.02.20.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:16:55 -0800 (PST)
Date: Tue, 20 Feb 2024 16:16:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/26] printk: nbcon: Ensure ownership release
 on failed emit
Message-ID: <ZdTCZqhZww8_WgSU@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-7-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:06, John Ogness wrote:
> Until now it was assumed that ownership has been lost when the
> write_atomic() callback fails. And nbcon_emit_next_record()
> directly returned false. However, if nbcon_emit_next_record()
> returns false, the context must no longer have ownership.
> 
> The semantics for the callbacks could be specified such that
> if they return false, they must have released ownership. But
> in practice those semantics seem odd since the ownership was
> acquired outside of the callback.
> 
> Ensure ownership has been released before reporting failure by
> explicitly attempting a release. If the current context is not
> the owner, the release has no effect.

Hmm, the new semantic is not ideal either. And I think that it is
even worse. The function still releases the owership even though
it has been acquired by the caller. In addition, it causes
a double unlock in a valid case. I know that the 2nd
nbcon_context_release() is a NOP but...

I would personally solve this by adding a comment into the code
and moving the check, see below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -891,17 +891,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	nbcon_state_read(con, &cur);
>  	wctxt->unsafe_takeover = cur.unsafe_takeover;
>  
> -	if (con->write_atomic) {
> +	if (con->write_atomic)
>  		done = con->write_atomic(con, wctxt);
> -	} else {

	This code path does not create a bad semantic. The semantic is
	as it is because the context might lose the ownership in "any"
	nested function.

	Well, it might deserve a comment, something like:

		/*
		 * nbcon_emit_next_record() should never be called for legacy
		 * consoles. Handle it as if write_atomic() have lost
		 * the ownership and try to continue.
		 */
> -		nbcon_context_release(ctxt);
> -		WARN_ON_ONCE(1);
> -		done = false;
> -	}
>  
> -	/* If not done, the emit was aborted. */
> -	if (!done)
> +	if (!done) {
> +		/*
> +		 * The emit was aborted, probably due to a loss of ownership.
> +		 * Ensure ownership was lost or released before reporting the
> +		 * loss.
> +		 */

Is there a valid reason when con->write_atomic() would return false
and still own the context?

If not, then this would hide bugs and cause double unlock in
the valid case.

> +		nbcon_context_release(ctxt);
>  		return false;

Even better solution might be to do the check at the beginning of
the function. It might look like:

	  if (WARN_ON_ONCE(!con->write_atomic)) {
		/*
		 * This function should never be called for legacy consoles.
		 * Handle it as if write_atomic() have lost the ownership
		 * and try to continue.
		 */
		nbcon_context_release(ctxt);
		return false;
	}


Best Regards,
Petr

