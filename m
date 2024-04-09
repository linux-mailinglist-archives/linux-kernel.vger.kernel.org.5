Return-Path: <linux-kernel+bounces-136537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912FD89D548
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A28B21C33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EA07F494;
	Tue,  9 Apr 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f9kS6DsV"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFE2B2DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654449; cv=none; b=BxkpeeW91/Pd3qolys+qvDbkCuW8FKlHuWdaGHJyDktSEGqlf7bVMBlZhA7zR6nckbOaZ2FGLf0XfLtJ4jVI+DfnmsGWe99idCqxhgdeq4C0OU8TtD6r9mV/CUKe5sVZHGZ+ooGxhU1KggWy0Qjjo8UtPW4AHGnB+vTIjbb3DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654449; c=relaxed/simple;
	bh=dzWgJIr+elQQqzhnrLVPNLwsqNmviyJGgqIUxcUQWqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2ZEvPsJx4DdzzcDmvaViETdj0TiqbEJ+92GYRJkGdl2/6Edu7bQp3GSp8gWDbuqi+ZrNw0e48N8SL6P0aWOEo7zGGQEt61D4GTGXJ8LQ3vWHK5/AY5vWc94R6muBrsoBXcV6KvrDODjTWgxiXZPS8EjZgtqVo1ENAbGHAmF+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f9kS6DsV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so3953187f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712654445; x=1713259245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AT6TTk+LhAPd9pV/ZdmRWE2NJwTKZCbDeN6oR+wQ/4=;
        b=f9kS6DsVb4DnrdEPxPn7uNsk2hFTpMIzxf8wQWKBMrIU7eahlx1FCq7ncmDtaukraG
         ARFQipqYhAjc0Ww8yxGs/D0M28f21aiUJ8PfSZoj5TN2ysTfY4k7poH5fqz0YiX1Rz3m
         Qp4LLwJotQ4ASKewISiCP6MgqlXpNFQtGnmQkWr35Z2K9va4MmZ3elnigJhls7Z3pN+b
         MM+czGavSroLjIjBClwN1hizPGeXGXXsuvVxFb/HOJyxkZPDWPOIo5GKwwND18ieT0DY
         EvXfYIFvSQ5uFCTPqM2cIZg+QUHI77zJ7EFOcwmiM9B9odj3BBGRN22s8Aaak/y//WS3
         LrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654445; x=1713259245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AT6TTk+LhAPd9pV/ZdmRWE2NJwTKZCbDeN6oR+wQ/4=;
        b=vwH+iSPgABepCmZK8NUiU2KFArw1z6+9PM9TjS2n9QYPQ17GpO7zGl0Oyfb4lKZt5q
         xecr+l3HFXzJYCI0Td19jvQetKq3SHbvkqgaDr+pu/M7BGVEICxhKcAl0/rEyVkqm9PO
         CC3T/3Gv9zv9/6IUOhI3pLttLIkuE3yUoRQrk5dQPbpATZaBMj0CvmBUC3TxUHD6gnsg
         IaFj/CDh0Z/k3cndjeADM7PSGLnfDb2ZAvUvKGSyqYJLufquHqS0ak19vQymohjwjg5s
         LpuyjwiDIBsYV5IhL/WtbJNVKIZo5hDV5mnzUAyOezuDR7BbPyEDDo6VH5MDTMAlmRO/
         GrIA==
X-Forwarded-Encrypted: i=1; AJvYcCXghamnI4Gr2d3qbZa11FNgoCg3G2nY1r9pVu+Q2PINXuWtahya+9rYHyOWjzqgncbP41ivN6juz/RylwyQVJ1caCIZhTikhyeUHfcN
X-Gm-Message-State: AOJu0YwqFPdhyPxQT2G7Q16pIViOZZBu5pm9tQu9vmKvT99XldTbTwc9
	7WdGRIfxpVIiunhgcG/32bpYk6qzwc6opOgbYWzYUpLRq5OtTDioeJ2MfVwiKzWSKFJGNN85OtO
	j
X-Google-Smtp-Source: AGHT+IFihTpQSWOgUGCFfZeSy+hQwBLIikiwaB5BmDMXbwBdPJSCfJ9GxBk3l9MRH2zrv22ix/1dDg==
X-Received: by 2002:a05:6000:152:b0:343:96a0:cccd with SMTP id r18-20020a056000015200b0034396a0cccdmr10005535wrx.33.1712654444898;
        Tue, 09 Apr 2024 02:20:44 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b0034174875850sm11036893wrw.70.2024.04.09.02.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:20:44 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:20:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <ZhUIatzxietD4F-m@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-7-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:08, John Ogness wrote:
> Console drivers typically must deal with access to the hardware
> via user input/output (such as an interactive login shell) and
> output of kernel messages via printk() calls.
> 
> Follow-up commits require that the printk subsystem is able to
> synchronize with the driver. Require nbcon consoles to implement
> two new callbacks (device_lock(), device_unlock()) that will
> use whatever synchronization mechanism the driver is using for
> itself (for example, the port lock for uart serial consoles).

We should explain here the bigger picture, see my comment
of the word "whenever" below.

<proposal>
Console drivers typically have to deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls.

They use some classic locking mechanism in most situations. But
console->write_atomic() callbacks, used by nbcon consoles,
must be synchronized only by acquiring the console context.

The synchronization via the console context ownership is possible
only when the console driver is registered. It is when a particular
device driver is connected with a particular console driver.

The two synchronization mechanisms must be synchronized between
each other. It is tricky because the console context ownership
is quite special. It might be taken over by a higher priority
context. Also CPU migration has to be disabled.

The most tricky part is to (dis)connect these two mechanism during
the console (un)registration. Let's make it easier by adding two new
callbacks: device_lock(), device_unlock(). They would allow
to take the device-specific lock while the device is being
(un)registered by the related console driver.

For example, these callbacks would lock/unlock the port lock
for serial port drivers.
</proposal>

> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index e4028d4079e1..ad85594e070e 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -352,6 +352,48 @@ struct console {
>  	 */
>  	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
>  
> +	/**
> +	 * @device_lock:
> +	 *
> +	 * NBCON callback to begin synchronization with driver code.
> +	 *
> +	 * Console drivers typically must deal with access to the hardware
> +	 * via user input/output (such as an interactive login shell) and
> +	 * output of kernel messages via printk() calls. This callback is
> +	 * called by the printk-subsystem whenever it needs to synchronize
> +	 * with hardware access by the driver.

The word "whenever" can be translated as "always" (by dictionary
and by my head ;-) Then the description sounds like this would be
the primary synchronization mechanism between printk and the driver.

In fact, this API would have only one purpose to synchronize
the console registration/unregistration.

IMHO, we should explain here the relation between the driver-specific
locking and nbcon console context locking. It would describe the big
picture and hopefully reduce confusion and eventual misuse.


> + It should be implemented to
> +	 * use whatever synchronization mechanism the driver is using for
> +	 * itself (for example, the port lock for uart serial consoles).
> +	 *
> +	 * This callback is always called from task context. It may use any
> +	 * synchronization method required by the driver. BUT this callback
> +	 * MUST also disable migration. The console driver may be using a
> +	 * synchronization mechanism that already takes care of this (such as
> +	 * spinlocks). Otherwise this function must explicitly call
> +	 * migrate_disable().
> +	 *
> +	 * The flags argument is provided as a convenience to the driver. It
> +	 * will be passed again to device_unlock(). It can be ignored if the
> +	 * driver does not need it.
> +	 */

<proposal>
	/**
	 * @device_lock:
	 *
	 * NBCON callback to serialize registration of a device driver
	 * for a console driver.
	 *
	 * Console drivers typically have to deal with access to the hardware
	 * via user input/output (such as an interactive login shell) and
	 * Output of kernel messages via printk() calls.
	 *
	 * They use some classic locking mechanism in most situations. But
	 * console->write_atomic() callbacks, used by nbcon consoles,
	 * must be synchronized only by acquiring the console context.
	 *
	 * The synchronization via the console context ownership is possible
	 * only when the console driver is registered. It is when a particular
	 * device driver is connected with a particular console driver.
	 *
	 * The device_lock() callback must block operations on the device
	 * while it is being (un)registered as a console driver. It will
	 * make sure that the classic device locking is aware of the console
	 * context locking when it might be acquired by the related nbcon
	 * console driver.
	 *
	 * This callback is always called from task context. It may use any
	 * synchronization method required by the driver, for example
	 * port lock for serial ports.
	 *
	 * IMPORTANT: This callback MUST also disable migration. The console
	 *	driver may be using a synchronization mechanism that already
	 *	takes care of this (such as spinlocks). Otherwise this function
	 *	must explicitly call migrate_disable().
	 *
	 *	The flags argument is provided as a convenience to the driver.
	 *	It will be passed again to device_unlock(). It can be ignored
	 *	if the driver does not need it.
	 */
</proposal>


> +	void (*device_lock)(struct console *con, unsigned long *flags);
> +
> +	/**
> +	 * @device_unlock:
> +	 *
> +	 * NBCON callback to finish synchronization with driver code.
> +	 *
> +	 * It is the counterpart to device_lock().
> +	 *
> +	 * This callback is always called from task context. It must
> +	 * appropriately re-enable migration (depending on how device_lock()
> +	 * disabled migration).
> +	 *
> +	 * The flags argument is the value of the same variable that was
> +	 * passed to device_lock().
> +	 */
> +	void (*device_unlock)(struct console *con, unsigned long flags);
> +
>  	atomic_t		__private nbcon_state;
>  	atomic_long_t		__private nbcon_seq;
>  	struct printk_buffers	*pbufs;

With the updated commit message and comment:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


