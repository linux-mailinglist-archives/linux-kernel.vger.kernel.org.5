Return-Path: <linux-kernel+bounces-79204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE9861EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0701F26411
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06131493B1;
	Fri, 23 Feb 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2quoiZY"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AA1DDC3;
	Fri, 23 Feb 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723374; cv=none; b=CtFUqnZ5x/i8fHA6KnA/6iN13Mt9efV3m0IouhYvjVAWlUfLC4nGuiKRTuHg8LYRId0B1L7qwpqkGFbOyeh7h2Zw5eX3ValNMOxCbImmNC9x7TgtfkyLmbNWSZbutNANF4MlBeI0IcTKJ2VJBkyezBz91LoICcAPN8Xo5sKpK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723374; c=relaxed/simple;
	bh=D9xlkAwetO2YYsp4AzG3YrTgZ6UnVD1pIb+/R0M9yxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj+McLpI1k0DtHEsR237Xpr/OUhNUUlZnJUl2L424EMs2nzsTcaWPSOgjjKeB5Uv85ryJlhxm8KSmloyhdP+KL4MQLqhJXqAMFZt2UtcFUqwqDmAhv6DTvn3NhIqjl6AsmLF1NR5cBM2Et47sYPJxxA7iJVaXKTW4m9Lnziwt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2quoiZY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so606389f8f.0;
        Fri, 23 Feb 2024 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708723371; x=1709328171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FighQhaXjcHvzu/cP/qcaVJd6ZUW+O6jZf8uJbTD2qg=;
        b=O2quoiZYslg1y0C5mMQHU1y3J2iUBMxdsgxy0W2Hk76Brzj5DrhGjUqIanNSS6K/Os
         3SmKU9aUWk22o7bh14DURBbd0SQzPqTFZC3DkLYxdZPys27+wfJPYPdjLNSIK/DISLIL
         cSDqokRsVPvnlVHvRcufjcnwCgJwPjMqOBPlCzFLyBAcsvbHG0fl9TYhsGq/XbFkLm6S
         Yzysz8uOSxX8cezfzFnyBIngvyWzOUkxu1gUirvdEDs4HGx26he4pFqeoLlMq7W1ZN6T
         zNeS2IKnG/0p8/QlxHxFS0+gWy8Xy0Fm6rpwgGoYSo/s1LFHgeadi0vl7sXqZcvT6SYt
         B1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723371; x=1709328171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FighQhaXjcHvzu/cP/qcaVJd6ZUW+O6jZf8uJbTD2qg=;
        b=ACwWfzaT9zpB0NOu/0buJ39VHSZryCl2S0cHs3AiDA9r0uGck2OSpf1LO5KTQL5sAR
         pXar4xh5lhplwelTSI071mr0EZFGLVfFABRXh2drqqZqlESwqamC+gjKi8lH/52y24Q0
         KcRzFVR6qpicFtYQFN2d0JqYOwxwv0ivu5r/K2HbJCENkJuEWQcTEoAO04zMkFsXLst2
         8YksjaP+DXoNWT1X8/xdlEFJgC1TFJnAzOZxjE8phJ+7OfuboFLstoTpbjq8xRDAYcr/
         cZQUy+zjjee2Cw1M0K1FLXrdBTPJmQesaNyAJnnKAZKeDrXYGVJJVVrHS1DPgLLT+Tx2
         m08A==
X-Forwarded-Encrypted: i=1; AJvYcCX73zVzPwNydoSczZcgnjVXMHhPJK6iyyqjFxx0NaLwjXq0t+2ZMAnxgKxwUtf10xHKiZaWOEJbXSxVuUxV7HWu+mxvu/vPjEGLy4lofxnkB2uDVVCNpNldk1z5hmsIjz3XZbnT8qUShxo=
X-Gm-Message-State: AOJu0Yxp8lnELeRQiYwQ9YBHBJLwA7ozF6NB49le7lyFGQIQfW5A5ved
	fzi46wOA4cEGAmL/n9QW8qgUD3RZHuGn1FPrhdj14y79SNpXYUom
X-Google-Smtp-Source: AGHT+IFDBAaVDq0LkSeFnlg7HBYqY64qEoifclU9wuWbudpVFSVqQQA6UsymPdnn6EifuGspZgNgMA==
X-Received: by 2002:adf:f98a:0:b0:33d:adce:568a with SMTP id f10-20020adff98a000000b0033dadce568amr606581wrr.33.1708723370468;
        Fri, 23 Feb 2024 13:22:50 -0800 (PST)
Received: from m2 (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0033d640c8942sm4062605wrq.10.2024.02.23.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:22:49 -0800 (PST)
Date: Fri, 23 Feb 2024 23:22:47 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de, daniel.beer@igorinstitute.com,
	jikos@kernel.org, michael.zaidman@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org, equinox@diac24.net
Subject: Re: [PATCH v1 19/19] hid-ft260: uart: improve write performance
Message-ID: <ZdkMpwA1ZPWRUvWM@m2>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
 <20240210215147.77629-20-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210215147.77629-20-michael.zaidman@gmail.com>

On Sat, Feb 10, 2024 at 11:51:47PM +0200, Michael Zaidman wrote:
> Tx performance with the current buffer size of 256 bytes is lower when
> the data length exceeds the xmit buf size.
> 
> [134331.147978] ft260_uart_write: count: 288, len: 256
> [134331.157945] ft260_uart_write: count: 32, len: 32
> [134331.159977] ft260_uart_write: count: 288, len: 256
> [134331.169990] ft260_uart_write: count: 32, len: 32
> 
> 1. Increase the xmit buffer size to page size as used in the serial core
> and other tty drivers.
> 
> 2. Remove the xmit buffer fulness against the watermark checking and the
> tty_wakeup calling in the ft260_uart_transmit_chars routine. This code is
> taken from other drivers, but other drivers may call the routine from the
> interrupt context. In our case, this condition is always True since xmit
> buffer filling and emptying are serialized and done synchronously.
> 
> Tested with picocom ASCII file transfer by 288-byte chunks at 921600
> bauds rate with above 20% performance improvement.
> 
> Before:
> 2821.7 Kbytes transferred at 47367 CPS... Done.
> 
> After:
> 2821.7 Kbytes transferred at 57788 CPS... Done.
> 

Besides the performance improvement, it fixes the bug of outputting
characters to the local terminal when local echo is disabled and
printing every character twice with local echo enabled.

> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 6b172bfa4f98..1188b8e09938 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -308,8 +308,7 @@ enum {
>  #define FT260_UART_EN_PW_SAVE_BAUD	(4800)
>  
>  #define UART_COUNT_MAX (4) /* Number of supported UARTs */
> -#define XMIT_FIFO_SIZE (256)
> -#define TTY_WAKEUP_WATERMARK (XMIT_FIFO_SIZE / 2)
> +#define XMIT_FIFO_SIZE (PAGE_SIZE)
>  
>  static const struct hid_device_id ft260_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
> @@ -1211,7 +1210,7 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
>  
>  		len = kfifo_out_spinlocked(xmit, rep->data, len, &port->xmit_fifo_lock);
>  
> -		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
> +		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
>  		if (ret < 0)
>  			goto tty_out;
>  
> @@ -1219,10 +1218,6 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
>  		port->icount.tx += len;
>  	} while (data_len > 0);
>  
> -	len = kfifo_len(xmit);
> -	if ((XMIT_FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
> -		tty_wakeup(tty);
> -
>  	ret = 0;
>  
>  tty_out:

