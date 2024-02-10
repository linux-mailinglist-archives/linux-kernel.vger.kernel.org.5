Return-Path: <linux-kernel+bounces-60557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0748506AD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403061C24311
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD3605D1;
	Sat, 10 Feb 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K95GaYks"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8E605CD;
	Sat, 10 Feb 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602011; cv=none; b=FbvPDI8cK5ognvBFYEHyJuMwOXh5Jy2FViBDl5s24bGphoqWKFeiq76CbAbqS9qloSbDFPgi0jMgjgrMN5X0lNvtI6rl6348JYcACcDnyZVDZc+vmJopx8mYMS4jhFlNNJTrtkO5EhSuRZTUWxYuuZJOwTb2/2I6ivZkntPAKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602011; c=relaxed/simple;
	bh=2HQBC1oCduA1pQkfyPQWKTxZnkT8froQM0NxJlNV7vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HguZArN5U7T3Sdgtji2iqcdlfQxY6H1yYjzNiNDllfDjAGwcAVTMPxTj95q62i7Y7FYsEZy/zg7GBclKvdRsUTXIFpwIfrTQeGrptXMyaBxorB6ih4aOekHiExwuDYJrhemJT3qEYqOImHQzbziy279qaIjNQ1gUj+ydwfSAdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K95GaYks; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0ce22b5f3so22955021fa.1;
        Sat, 10 Feb 2024 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602008; x=1708206808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCEBZkfO61YkhowePRQkJqIBYwM4+/L7NoDioaq1Xjk=;
        b=K95GaYksu40tCIzBWF+EsENOAXhkY9qU0IGPFFN+Vz57zzWfT8fJFVRsZfV4RPMnFn
         xuU9jkUvGVeVyh+KJcVCGZEuLAKmnKQFzJOL55iTZFy+XnkfUfNu/vdZr8Npt+2LJXik
         DndQOBQQORZNWNrw8WHDMfmYfvVBUqrSaZXPyz8PKpuzJlZ9miCfJhdgTv/QlToNiWVR
         TAwDLSJcPqNpWm06VUs3MmSs96wg4GuaTlRj8drhtQDuDMb6w4BZLhhY+LauYOiZwJhb
         XC+w95mvKxEXUg6dYlctFQRt/JV7M3uiDY8Ggl3BJnvGtZi6U870Ry8r2N/rm1k2/1+I
         Ne4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602008; x=1708206808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCEBZkfO61YkhowePRQkJqIBYwM4+/L7NoDioaq1Xjk=;
        b=nxhXeMYEmx90RFKvwZvLvb4E9SCME8AsVvV/mSiNGJz+lvEN8SAAI9s8WcwTPpDMSA
         qeMWa1ewiP25WxvdeT0LoKAzUQiixqP/wYwWX5NBQYukEocFLdeyFEeK36PZE7gOFmyq
         5b7WlsBq4InDNytyR8iitxXRCS+/VeYt8NuxBwgsrUizy92wQi+jZydh2DJ0ovO21oWZ
         /yygLYkHSL3zns0o6Dd8GT/mdZW3Kz1fOciFu7ggYK8LxUFJ7HDJZ+sb7uYIXTmS+L0Q
         KYp52tLORSjym1vX2Dp28KwP+1cLgxG8xeuqQ5Jv0E/GYbU5INeGo76sFII5unn6Njvm
         EHvg==
X-Forwarded-Encrypted: i=1; AJvYcCVanm+PvCoeW4NRY81vsTZAqn1IjMU6jXDS1u4+6Rhg0H5AkFkQHnYORowdmNYAE4hTRX7Xb91bvRCn5/MNUIjl6N9URgjtNNE4xoB//GxypVWjc1RcoD/gJHgndcfhOJ8OaSmhk7Z3XSk=
X-Gm-Message-State: AOJu0YyPJYZa0zsWzfw0+kUKIvX91rv2KdpIBIfVV5Wg2y2bvHs/ssZs
	59uNVM90l22UspzEeAnBF8EDHmG0JvNiC50Oc3Cg2ppHvTHUxkQb
X-Google-Smtp-Source: AGHT+IHNtXs69wkFhrqzHye+hspqM6GAnmLGKC8Oqu7KdPDJ832kJlkZXzfmfSfDRdwvgxFMeBaYYQ==
X-Received: by 2002:a19:6501:0:b0:511:636f:ac29 with SMTP id z1-20020a196501000000b00511636fac29mr1426761lfb.64.1707602008134;
        Sat, 10 Feb 2024 13:53:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK9kSfWuJsAjJtx34wlp/Sj2QLR8k0bLBY3mFY6YRkal3tGIOAusIHwEHuJ4b0DRjK/k8DiNiTwoXEQEKeNsrYxb4K6Qb17DznISY17hsFB2YrEXOpPlu46TsGxKj4DG88oiyyeywDqa1CfFcG3A9CcZ0czweZYKdXhtCfZHX8JqY6N0gZUG04HXfKa8jhly8HdBj42aSre7K4kDyErH2qOWWoapaN0DpMqWXJTZovgLrWGj/T9GmW89iInQSpxJipc7KbexFrXw9qtTQuK7R1/FxSGPzE8vLOY0VB369MNSnVQ8o54MnztpGct7H5cKEmBX7I4lwZokIjd+Ln/pf/LLilrlQX+VzoWanftkI5ypCDKKewZA==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:27 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 10/19] hid-ft260: uart: do not configure baud rate twice
Date: Sat, 10 Feb 2024 23:51:38 +0200
Message-Id: <20240210215147.77629-11-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uart speed settings are configured twice per session:
the old settings - by the ft260_uart_port_activate() and the new -
by the ft260_uart_set_termios() routine. We do not need to configure
the old settings per tty session since they have already been sent
to the device in the probe and passed to the tty via termios in the
ft260_driver_init.

Removed their coonfiguration from the ft260_uart_port_activate routine.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 6266e4f1100d..63839f02e9b5 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1524,7 +1524,6 @@ static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 	kfifo_reset(&port->xmit_fifo);
 	spin_unlock(&port->write_lock);
 
-	ft260_uart_change_speed(port, &tty->termios, NULL);
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
 	/* Wake up the chip as early as possible to not miss incoming data */
-- 
2.40.1


