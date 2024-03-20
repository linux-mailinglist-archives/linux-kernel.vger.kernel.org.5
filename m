Return-Path: <linux-kernel+bounces-109054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF1881402
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE79F1F25026
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85074C61C;
	Wed, 20 Mar 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="HLR9STqi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E840866
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946886; cv=none; b=Y3d5w5LJJM9CQ2HZcFgW0Rbq4QuClqbaI7kS6/D9TwmOLVn6GmdcOWNf1wJmNhguenTXSTvr+Zn9T7+p1p/YNc9QjAkDpQrxNzf/abhUzKCnxfQ2oeczvAB8q6kMXGyeuLqQWpmFXEsDzzfcxrUs0jVF/kbKo1tqXlqB+a3vzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946886; c=relaxed/simple;
	bh=QYn8wEwrd9F4hJD7q6hMGPoTg3d1RRAdEsqO+3Eu13k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sc0OtO+OSG6T2PxpJFg6HD/a/Ir8DVCIwlJdhZKGhgfm4O8MuyU6DJsmH9Iz7MZsbDCENTe8j+rcTcLV5aeaO4iH9HfbPn+A5dznIbGXQE2MHObA1bzdTFGLOFSJEC5irmLZtTCG+hMgUND/Ig3cUmTWi3Q4T/ZjOqyBjRwoXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=HLR9STqi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515830dc79cso1911950e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710946882; x=1711551682; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vWgthiM1p7crGecz228u37xQ7MHayTxVxgS78EJVGE=;
        b=HLR9STqi06aeHzo2WG4kI+lXAYGbJZNVFeQkTD76izmdp8Hk5Os5Ll64nucGVivLPs
         ohqiAyhrIqme5cMLihF5PUjK5elFADY7G7hqmGSwlEZIJxJmyTzYtTGqGQgnd7b1p7si
         vzOSPn+W0xjwBvMvRHEWZ4e7sYLKi5nI9xn8Yt672IFNLoP4tLKm+0VPFqnMRX/6ll8A
         tYhCT1ABU/axn5luqOYrAPIuO36d+YuceJrxg2aN0wOm+xgMiSPR2x1yZKWcUqPKmQc+
         hO/VS3MNsexRU43VyMUnUzr2Xql9bv2r3RHx0XY6b0KhcSsDiVqPQGvV/wMBQW8msEm+
         tXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946882; x=1711551682;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vWgthiM1p7crGecz228u37xQ7MHayTxVxgS78EJVGE=;
        b=v9+UaGSHQYqPh9IwJSnQjOFFnF7UveYOs189LXSzftKZOFXFcbfeOry+cmdlvE8xl3
         BK7VTDjBy/Sazru6RjVEd9ZZ4eCo29gu5nXbym1tGQBVVX90L9QRVv82zy9W0X1JPJWb
         RZvpLRGpYNCAEOyapUZR6udp6p3uJp4fx1iLlntJoAZfQfUYnFFFoda2nlo3RkDZtKCA
         a0ysaEqAI+pYOUk+T4f9EYDM7hp49+QxRFXnkUjkAzlT1n1XId4NXHpq8acvmkzUnFz/
         85ve9ru2GjiNpAUIcdOdigHeP8m5p4pYKR1cp5VcRHK6B7OKqJdJYwn26/GKh0SuA61N
         AWnA==
X-Forwarded-Encrypted: i=1; AJvYcCXfy5EtOcdc/RQYeUIDHVhGy+PKOOGw6Fz74Vcqrt75WfiF3k477aPDwiIx3hinmxRPjM6IAPA0AG97Czfm9sjEoKHPW9RFKbo+mecw
X-Gm-Message-State: AOJu0YwGzcUgnr3aWE42+EnTAyo5V3Zru+77U8uGmSTpH7RKOKXszkmt
	eBsqxa75JCJrmB822Nr+tT7oRchZU3ZvTlGlfHO9yNJmNKgCGObQWx7U5Uuvwec=
X-Google-Smtp-Source: AGHT+IH28ox2ZKxLrWNtq84tgrFDOkL6Ztn0chSueQwh894ihTgGyWEffg6JNmV6hMqYn9YUSIJGfg==
X-Received: by 2002:a19:690f:0:b0:513:ee27:2054 with SMTP id e15-20020a19690f000000b00513ee272054mr5625764lfc.42.1710946882374;
        Wed, 20 Mar 2024 08:01:22 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:6198:fd02:45af:2ca2])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a44fcdf20d1sm7371801ejb.189.2024.03.20.08.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:01:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] tracing: Explicitly cast divisor to fix Coccinelle
 warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240320192715.22eeeba84c0fd3a8c2353c79@kernel.org>
Date: Wed, 20 Mar 2024 16:01:10 +0100
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAA3D15D-F96D-48AC-B9C0-B2290E1B38AA@toblux.com>
References: <20240318105243.117911-2-thorsten.blum@toblux.com>
 <20240320192715.22eeeba84c0fd3a8c2353c79@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 20. Mar 2024, at 11:27, Masami Hiramatsu (Google) =
<mhiramat@kernel.org> wrote:
>=20
> Hmm, strange, trace_do_benchmark() has another do_div(u64, u64).=20
>=20
>                do {
>                        last_seed =3D seed;
>                        seed =3D stddev;
>                        if (!last_seed)
>                                break;
>                        do_div(seed, last_seed);
>                        seed +=3D last_seed;
>                        do_div(seed, 2);
>                } while (i++ < 10 && last_seed !=3D seed);
>=20
> Didn't Coccinelle find that?

Coccinelle also finds this one, but please ignore this patch as I just =
realized
this was already fixed in another patch of mine from February.

Sorry for the inconvenience.

Link: =
https://lore.kernel.org/linux-kernel/20240225164507.232942-2-thorsten.blum=
@toblux.com/=

