Return-Path: <linux-kernel+bounces-52201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D83849549
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9052FB22723
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF4111BC;
	Mon,  5 Feb 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl7hsvJK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5071119B;
	Mon,  5 Feb 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121428; cv=none; b=Xqpv9TLqeLeO3cClhukUTp2Vipo27lTWZZ5S8VwAIVb+MS6jBGR/hzBwkyBaNqqdwuDLu364rMt+Y8H01iM2pkiF15Xmvf9ZT10sbKxlAOdNDTy5WyxFyfF1u9ojrF1SVVQaYajWvTN/Jx035JTl9jukBwyFQFh3Xj1fLu2Nr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121428; c=relaxed/simple;
	bh=r50MUdBEVI3L+BkjAcLaYUKqx2sz5zl+bGKMWWXk4UQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArcQCobEuCXUmm1RJjUGKieEm3viwHJF9I13zy5UsvGxPnXtITRkKJRiknSnmjuVJl9Z3r/DsIcsA+VonMw3ZdgDNKWGfw9LRs0anHL9Dlf4VYVlQlUeVqIuUt0hPZCGSIwjAOsMboXfMpG/FUqGGko+v0F5qgebitpECsQ8J7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl7hsvJK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511413e52d4so2048999e87.1;
        Mon, 05 Feb 2024 00:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707121424; x=1707726224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r50MUdBEVI3L+BkjAcLaYUKqx2sz5zl+bGKMWWXk4UQ=;
        b=Yl7hsvJK7n9fZyu/LXXDTMyJ/A1IIL+BTDL1/rFMD2dx1gN7r7igg1BEzF3iJiTjBU
         zHV5tKpkGolu9J2rNn3ObwtPp9TQnAGTdk/jhcQKFT61CQCJsJoiZqpajtNT7vzOYsM0
         VXQcvxUJExEjf5K/ZlECXrO1pcDGiVoeOMspGBDRr5qxFCyRGRh6SOvM2phupkNUl8wo
         8HJYkSmId+7xCEI+KuBPp8eNmzhXJDS1ztzm23QLb9auqIspyYxsibLss2jfS0tJGxIL
         nME6goM7LkNRfy5WYypN6dwjZIpi2sNJg+e0ZCw7ZaBQ8YAR3WQUG5ArMnxhjPIqdnP7
         X86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707121424; x=1707726224;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r50MUdBEVI3L+BkjAcLaYUKqx2sz5zl+bGKMWWXk4UQ=;
        b=RFLbUYGUAM55Q1W5HUI2/M8bdn2SUlXKuTlX/Y0FXngHlOJboOo4Hz8WICkdwxLKIS
         kyh1EVZodRPLM1+oHjWEEDONwfUA8/34zLvJosBk+kwGBg1NfmSR01T1uXZXRUizduGA
         PwvV/LvRdC/eyqLNt+Gw6Bo0bPHqRBaWaPikqIDOEZPNslqRuWLXmC53CP/Ty3v8ID3M
         B2qVCmFfNryT/M1TDATj3/+Whst8cgvS2QBqlany+6zsMxudbkx2M5YA1XDfktxQa/8I
         jPYJ6NwLPE94NYhArZMKaVjuQC+/HJWSRRsU58ugIF+PQOf29I9Do0UpmOc1itIAmoTa
         kFlQ==
X-Gm-Message-State: AOJu0YzMej6/mKp1S1A2WHCh8jOhY7NtPb6bUU4WvwwO7RFXy/puX3k6
	FPQjs9WBitMqp8vjJBJKuKfL8alJ5BxcB7FWIPrMG0LDjBx6gad9
X-Google-Smtp-Source: AGHT+IFD14D8N3tmy8vEWSiFWMp1+4bWUi8vnaqG4jhykIspiTc0H4P2KclnQEfZsjKg+BazdHYrwQ==
X-Received: by 2002:a19:5f0f:0:b0:511:1765:7ed with SMTP id t15-20020a195f0f000000b00511176507edmr7454514lfb.61.1707121424240;
        Mon, 05 Feb 2024 00:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjdJ/5W+fmH81OyjHd/Gk0tGfDMuUi+21Q6KSF1fPRt7GsGdtV1EktaWDHYFP16X6JyJMYeOCou3kN+sn4ScAd6YF87WqVh8FdPnMhxDwWskyHMf0BxRNXiYyQ6wj+dOKJRewLh6dP50bm5MiLkjwtBQxUOLA6L24zP/p/paafF1S2tuVJAverorPgXXS58g==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0040f035bebfcsm7791475wmq.12.2024.02.05.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:23:43 -0800 (PST)
Message-ID: <be773836d75d20ac079328d20637dc24a3a15622.camel@gmail.com>
Subject: Re: [PATCH] spi: axi-spi-engine: use common AXI macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Feb 2024 09:23:43 +0100
In-Reply-To: <20240202213132.3863124-2-dlechner@baylibre.com>
References: <20240202213132.3863124-2-dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 15:31 -0600, David Lechner wrote:
> This avoid duplicating the same macros in multiple drivers by reusing
> the common AXI macros for the version register.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



