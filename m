Return-Path: <linux-kernel+bounces-133508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1C89A4A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC7C284EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46866172BDC;
	Fri,  5 Apr 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6f1lJI4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11F172796;
	Fri,  5 Apr 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343964; cv=none; b=LqW8l36g2kFcC3T20g9GGKG6ytPjdVp0nqnK5RV6i53s4Box6cFF9Hnm7FxVHKXWf4mKfk5dVZ+p3fR2BDU1c46XZVNdfcHgbC22OqkPmOCBXv6OwVeFMNTojTpTJcQp9f23wgA5IOgf6zLAAQNlFu8Am4CeNfnyOfLwiGLEhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343964; c=relaxed/simple;
	bh=zFci7/zQH9wpVuV3O3qwf1utK2Fw0+XCVQcYfefS1Ss=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l5sp1XD+ELoKQlwxm72pLFRubjAoYhOlo7V5TAGjNSRaIBn4QYj02Yrm5UPuOZltU9ED4t5cGqAGS/mbQCziEH9OAOcGHDKS/BAVg6yn7Vx4xOwNIHfbFImGZiRswsY2ghZD5AqMI0BvrTHrqomD//5IW8h1GuXgQcGLxY56DNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6f1lJI4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d536f6f2so1118186e87.2;
        Fri, 05 Apr 2024 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712343961; x=1712948761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFci7/zQH9wpVuV3O3qwf1utK2Fw0+XCVQcYfefS1Ss=;
        b=V6f1lJI4hAWT2U23HDsn7arNZC+g2ZOUXE8+fTs/Ag7RU4KNCWRZgP/ZPklSgx+U5M
         8nV32R8D2xJrxdC6VW4iruWDKm8lRogAbNfp2s0ziEcoPqc3o6cIKiEoMHCFkQbowkU1
         truQJcyn0Da4En0NqSbQjFyvQYoyQqhNRC/meSB5tWDrLp8Bloe7ncwp07u6mQ38Mx8D
         P7WvDzdKRUGn1aaU4LBsef3Ddp16fXSZfm6l22+dxjwpIHMPMQXDwqd0ezJPgWpfKfP/
         wL5A35Qx4zceQKs3/L2v8aZaAxhNBRXOHFQPa9VT3jABuMxR7tB6QWpDsQuIKD2ETw47
         I2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343961; x=1712948761;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFci7/zQH9wpVuV3O3qwf1utK2Fw0+XCVQcYfefS1Ss=;
        b=T12aQn8SjiCaMX9DFGCFA3H4xGVS3Ky8N5amQ/ehdQ0Y4pGyNwzaxXVko38qUu2A7F
         8hRw5gXf4y+tgjwL7uvh78jBgYWEwSbObibYw2WK42g4PrKQxr8YBc7ojwkd5O+KAeXb
         2XHwvgvFm8qXnj5Vnik3E1dd6IMmvT/em/An1YAkXV9Fao1gQ+jV8yKICJ5FJlBbDgjI
         zaCm5gjEVJ3arNz7SiCxzg5NoM8hrnwwCJF8KWoJEnIhipcQpriKcvWgLS+QApAfqn7d
         6FNwnaw4l3tszh3aLs5icnAUHz4Ht/CE6xexAAT+TRwyLrLMCHtkYZSUzeKPeurQxOF+
         qIdw==
X-Forwarded-Encrypted: i=1; AJvYcCVe2YMXX6Fs8VsX+99dX9kfjYN1V5es9uWrSjWqEAkGZ18wshvq738jpzsHvax+QcIswmGV55TgU24LNe4071GDH/6Q4zp3gNUBg3HFh3PBxurlLQOgwtqAFb9JWTy+Pw4rATUvuIwMxQCL
X-Gm-Message-State: AOJu0Yxe7EqC9qEW8dJdg3NY2GtUgUt9YhRxJ/EhCHqpjNYIaRcY5a3o
	NMWczRMWtjzsL+eg6fkSOXJF2W6NDRtkESCh7DWhGZRgRvwyx1f6
X-Google-Smtp-Source: AGHT+IF8d6Tm00RPEfua/VpB/UdPM5cBubuR1FNzA5BoxG+5BDk3l4sBzRGKEiGeYtOcwDOUKS8BQQ==
X-Received: by 2002:a05:6512:ac5:b0:515:d3dc:43e with SMTP id n5-20020a0565120ac500b00515d3dc043emr2267678lfu.51.1712343960384;
        Fri, 05 Apr 2024 12:06:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d24-20020a193858000000b00513e466cb0asm268120lfj.5.2024.04.05.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:06:00 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Esben Haabendal <esben@geanix.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jiri Slaby <jirislaby@kernel.org>,  Shawn
 Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Marc Kleine-Budde
 <mkl@pengutronix.de>,  linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: Introduce timeout when waiting on
 transmitter empty
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
	<CAOMZO5Axz7un+9H2uEoQtE0=pYNC0hEyZiNobrSi2m0ajj8N+g@mail.gmail.com>
Date: Fri, 05 Apr 2024 22:05:59 +0300
In-Reply-To: <CAOMZO5Axz7un+9H2uEoQtE0=pYNC0hEyZiNobrSi2m0ajj8N+g@mail.gmail.com>
	(Fabio Estevam's message of "Fri, 5 Apr 2024 14:38:48 -0300")
Message-ID: <87r0fj1vfs.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fabio Estevam <festevam@gmail.com> writes:

> On Fri, Apr 5, 2024 at 6:25 AM Esben Haabendal <esben@geanix.com> wrote:
>>
>> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
>
> s/potentital/potential
>
> Could you elaborate on this deadlock? Have you seen it in practice?

I've stumped upon this piece of code a long time ago, and it's indeed
broken. However, to actually see a "deadlock", I believe one needs to
enable hardware RTS/CTS handshake on the port, then, say, not connect
RS232 cable, and then printk(), if enabled to this port, will soon
result in the loop to be executed forever, that in turn will hang
single-CPU machine entirely (provided this code is still executed with
interrupts disabled, as it was at the time I investigated severe
printk()-induced ISR delays).

-- Sergey Organov

