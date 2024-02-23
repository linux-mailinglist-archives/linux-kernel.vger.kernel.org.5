Return-Path: <linux-kernel+bounces-78636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D32EE86163D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64168B211F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FDA82D76;
	Fri, 23 Feb 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BF4zmww+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19937C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703280; cv=none; b=tLAO2U6KeTfLIGk5eZnNr+mcznczpyTwWxdp/kbK2R27h8QRkDxr8xf8i+oRKgOb6dJ3JNkrU4DXGioWiGmF7emp2BFK9wOeM7ICFyUCGaaKqRlgxlmfnsWEdPrRtrYEEihNZ0zW4bj6DSnMChHKO/25rvPo6gI9sUYwDh44rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703280; c=relaxed/simple;
	bh=YowW39RnHyxR8Sr1jr1RCHtQWhfbw1YLL+7hwcIXf1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+9XTxNafuyuOTXYHnjvwQw0cdw3wvmFjHU/6DswHTVijUyC31xS2tWTC+PqzQr9U0pEOtBbAQwE1E4z2+wYXbc9NtWerZVBrYHeSZOd0znCewD7zfdD48fQ5VWK/r2yBxQGC1WOx3FGLBQoTOaTy+JlwfeDHI6phnFjtbZQW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BF4zmww+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso134972766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708703275; x=1709308075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pXttl1SKbecuoNHatfapx+UZ4/jWzMcuT4nHY/jqvY=;
        b=BF4zmww+VuW2AVbBQvksTGH/yZxmnSrtg/U40lqnrN5nsIqifAqcNSt29uDZvXVdg5
         UtK32tw6EyUaq65Jp2SjlbhUlEvxQOJqG8KLIi0rfiCViprHMx0sKRkNumofJC//qhgD
         nr+0cu9ESUib788qSH6wfr2I1A3+tu/19xRKPurpWvwNvaDa0B1FHlqkXylCWwaVnZLZ
         biFsDRITFdblUjeip87iSHsX0NRRXV0zGHH8bT4rTwn+hPr2FlQQBUO4yeb8J+deV1bT
         VPrvfIVFWlf8VjEQ0HHRhflCWZZ028r2/NnQ71mtSbY5ixvAeN4HGjxr0WlANtaPBNGm
         BLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703275; x=1709308075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pXttl1SKbecuoNHatfapx+UZ4/jWzMcuT4nHY/jqvY=;
        b=jyeSPltgl594fBkQAZ/0nWuBKRs4J0Ulhqw4gBKV2hDkV5K5SMKkJ7UnQLFDMGIMfx
         ygSrkIhEk07IZkrVFDnPDAsUfkTvoa14oYxL8cBXPIajWuBBQN5MfTnrmuioY9W27lCW
         obE7dxl8K7GNAmHXbIumnORF+MCz+eegu+naoDBAgGkWjG2algpz3Iw0d8Odud/rah/6
         zaffNfOolNMPk/frXWmWBlLp4B7Umk0wivqaSg1TLgS0lypJZk28L++zMcCHCUgHbTqJ
         aR2Nai1Q/isspjM2FCbSsKay6UhKMb+bfCb0BESQEPad4g4+P299+hBP9mybmPAzkYid
         ewVg==
X-Forwarded-Encrypted: i=1; AJvYcCV6iPYGD72y77AeVo6ZqUAwfKg2h5Lal/rTp1FSXKJ/nj9HT01je9qyWOCJR/85d/JMY2izNBqyK2crNwT+mUpY4AjQrrb8GMFRKGGE
X-Gm-Message-State: AOJu0Yz6kPH9S07b7BFOVBUyiMkV6niFR+OXkbtsUvXDcduS0tnFPX+c
	tEemv0D7/75vxvbAVBDExdtnHwNFo9N49irvG/P1Urv4VHbYWagnYt4BXM2dAn8=
X-Google-Smtp-Source: AGHT+IHfBX43pogn25vvtZ92Zzr9mxeWd+KLuHSwZBC7itDHx2ieHMB5GtkUqbstabyXoEeCE3fMrQ==
X-Received: by 2002:a17:906:2bcc:b0:a3e:6f98:c69d with SMTP id n12-20020a1709062bcc00b00a3e6f98c69dmr131688ejg.63.1708703275383;
        Fri, 23 Feb 2024 07:47:55 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id se7-20020a170906ce4700b00a3d26a25cbasm6954683ejb.37.2024.02.23.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:47:55 -0800 (PST)
Date: Fri, 23 Feb 2024 16:47:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 14/26] printk: nbcon: Provide function to flush
 using write_atomic()
Message-ID: <Zdi-KXfBScocqBR-@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-15-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:14, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush_all() to perform flushing of all
> registered nbcon consoles using their write_atomic() callback.
> Like with legacy consoles, the nbcon consoles are flushed one
> record per console. This allows all nbcon consoles to print
> lines pseudo-simultaneously, rather than one console waiting
> for the full ringbuffer to dump to another console before
> printing anything.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_all() will only
> flush up through the newest record at the time of the call.
> This prevents a CPU from printing unbounded when other CPUs are
> adding records.

I think about using slightly different name to make the difference
more clear, for example nbcon_atomic_flush_pending() or so.

But I do not have a strong opinion.

> Perform nbcon console atomic flushing in
> console_flush_on_panic(). This function is not only used in
> panic() but also other locations where there may be stored
> messages that need to be flushed.

The above paragraph is a bit misleading. console_flush_on_panic()
is used only in panic(). I guess that you wanted to say something
like:

<proposal>
nbcon_atomic_flush_all() is safe in any context because it uses
write_atomic() and unsafe_takeover is disabled.

Use it in console_flush_on_panic() before flushing legacy consoles.
The legacy write() callbacks are not fully safe when oops_in_progress
is set.
</proposal>


> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

The code looks good. After updating the commit message,
and eventually the function name, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

