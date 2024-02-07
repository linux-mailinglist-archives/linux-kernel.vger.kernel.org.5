Return-Path: <linux-kernel+bounces-56760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591384CEB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63001F24A26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45E811ED;
	Wed,  7 Feb 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IDk+BHpz"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9ED80625
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322585; cv=none; b=ch0D4Ygz5NbtkHbq2lbgBIyo5E25qWm8pw4dCjan2YDrlWNByUpSeQtBobPz1PuaSW0cm/6RiH3wFol+zhLb6sYkK3bklRiX8dMSpURLjPtyIKTH5sl+25QyudobfT5KVWUhctf69wNvfCTVpijoxOnwFtvJaNI7fLHa7VTw/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322585; c=relaxed/simple;
	bh=BOKr26TfbLV5p2rMhdEIUAqtyhY8h7WzRYzgqghRnz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKhCJof4C2t9Ht6KiT9zGUp82Co0ec96QiR26NVZEiZrY+XyWp/uk7X2QTGHNAoklUNB26a1ZnsZErl0adIS4rw0gm+Zstf+3bYVwEDc/CqSwso+n1+ElT7EB14OqEkUZ/wCxmY/M4W9F9LuFcw1yolKHxZXmfRdlVdvTENot6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IDk+BHpz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0abdde3easo9954331fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707322580; x=1707927380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LG59njZWuFkviqiovWGZzoOS0eL7wO+Cvn37jpvLeU=;
        b=IDk+BHpzHroffKXqrMMamnhqj8GiqecZdhbVyelKDfsY5TWZxY27PuZWuw8rDi6HaE
         rL905ynF3y8e7HXN1Vl+CJxio0c655VCSY3H08aht+uMj6Og+I3P25SQ3sXnA7EQDJ8p
         ho+qisVCxA5XJ5W6SKxqidixlakisxLDnlVowwVrmj7tCDyn5RQrbem1GUO7Kk4FN6fG
         tYAXy2BJXFhwxvlxJsVLdbKIt5veBpyFHDaL06pa3G7+LIWblEBeuH1M6LSZmbOlgB7a
         /MJsMshhuJPQbQRPJXPcJCuZmqnFNs1EochBceuAfBfs1H46G9z5KkUO22QRg9y2pp5F
         oZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322580; x=1707927380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LG59njZWuFkviqiovWGZzoOS0eL7wO+Cvn37jpvLeU=;
        b=XYSLYPXt70W9bRcA/R8VnYEDL70pVwV5VT1lrJIXHPHhXUBKnQhN4sjvVooj6uYUZ5
         8EDKbmMfTsOIYBLB84TDPQoOHCIaB93TEoU2xJ4+vnbWawaW4zUeXQNAmxkicsly7NtK
         TYBLaTMgkVvpR+L2prjTxgZRqX53OVoryd1aBqlaYD1RjFZurdphTAkK9OGnivM/P80F
         uj8n7SJiONt3iTYHe/kr+YdNfmqEimfPpsXYzN824GcNxhrifKI8ye/L8K9VlFhSmiG0
         167mdNUvLlNQtjyv0NO8pBpEc1R0gSR7wpbQZsVKXrG3OlA3cQr5bJ9Au3iwYLvLUjT8
         ZASg==
X-Gm-Message-State: AOJu0YyxsfluyGizXxH3T61Y7XHdaR1LHEgqz6yQpRgcwgJH8+lcGWFf
	4Ur8Dfcc6ZSlf+aL13V+LtTS/hixtIkiJooXcn6t3rh0LJ8o8CNvwVky/M2gXZ0+OUMEg8BITig
	5
X-Google-Smtp-Source: AGHT+IFpsv+TOo5kbWckN+t3UWWQ4jvzbTFlrK3LSjSsNMjTjlDJsak9Ra+d45MZmakbdFe0duZUwA==
X-Received: by 2002:a2e:6e10:0:b0:2d0:9ced:58ec with SMTP id j16-20020a2e6e10000000b002d09ced58ecmr4098882ljc.32.1707322580462;
        Wed, 07 Feb 2024 08:16:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTFA5cQOEXvqd4/sNIoklXf2LGHZkbAPFWqORKIDTYzCLzXaDCF/OS6dCsvtEWOVoxGPTsGxRbTdrbQSv/oDUd9r5mTa4RYjW6Sok2p5fKwcZBpUAFP5NAePZaTtC1g7GiyArJ2dqOnpbyJ2AQt0WRQZ4p7mI=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402270b00b005606bb2cd20sm810141edd.54.2024.02.07.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:16:20 -0800 (PST)
Date: Wed, 7 Feb 2024 17:16:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 14/14] dump_stack: Do not get cpu_sync for
 panic CPU
Message-ID: <ZcOs0nG3KvkGKyF0@alley>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
 <20240207134103.1357162-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207134103.1357162-15-john.ogness@linutronix.de>

On Wed 2024-02-07 14:47:03, John Ogness wrote:
> dump_stack() is called in panic(). If for some reason another CPU
> is holding the printk_cpu_sync and is unable to release it, the
> panic CPU will be unable to continue and print the stacktrace.
> 
> Since non-panic CPUs are not allowed to store new printk messages
> anyway, there is no need to synchronize the stacktrace output in
> a panic situation.
> 
> For the panic CPU, do not get the printk_cpu_sync because it is
> not needed and avoids a potential deadlock scenario in panic().
> 
> Link: https://lore.kernel.org/lkml/ZcIGKU8sxti38Kok@alley
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

