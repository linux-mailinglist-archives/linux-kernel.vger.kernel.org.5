Return-Path: <linux-kernel+bounces-3139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE78167E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B931C224D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64053101C2;
	Mon, 18 Dec 2023 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Oql7Iv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31C11188
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702887414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUag13Qv3e+BRTg6Ynxq8V4FPLpzx1zmCnPquT3Mq0=;
	b=V4Oql7IvFqhCbrsxfhR/LiE+8C2raAVASnA2cIHt1aI6995FBMmzEhdwsCoxq+mR/2wR9x
	uK8JtbfGF1isbtKTpIU8ef3+f1xuIFmocawgJiCw6M5ohvayvMunmNSPJWNOqC8/sWXEi/
	VaFNtzUlLzXF2F2Nv23Iw4tkZv0v/ao=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-EEKwt_BcOr-nKjAiI0OWEA-1; Mon, 18 Dec 2023 03:16:53 -0500
X-MC-Unique: EEKwt_BcOr-nKjAiI0OWEA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a236822e39bso247766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887412; x=1703492212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGUag13Qv3e+BRTg6Ynxq8V4FPLpzx1zmCnPquT3Mq0=;
        b=w++Cl4ntFyYeDSgyQ6yd0E1BmQiymFsxMaLOh1SjJbmRIu4RM4cLkcd7GMChLEjfCP
         11bxet6EuMBgCWPgDL/4S2+7IsPrhKccmDPmPZSsWGrLiak6ktr/Ie8Snw35ewAcT/Py
         2GlYtEkn/LweMUKuPDSnWRdkbNCHKUoM27l8r/fogwAU8bODxgvyBIm6TiPE4KfGTSvt
         GCPSDyRopJ1ncfpPY4TR0CACBwINFVr5YGnA/SrzIJUTb7Hs62ppmFfYspi2sFWHoZCe
         EoaW3tdlhqXrTznq1DMc5177Ppv+8O8VBpOD9F3oOJt9op1tR7KE6oQsCH6/Ivv0eviV
         6oxA==
X-Gm-Message-State: AOJu0YzE/UUJjMQi5n+WxqH2FGlQQ+wQGZ6XDCzHJ+1zr94Xb5MboSJA
	J1SOHOF2f3VV1woSXG14GnDYhMDw2xy34c074U5epL/1heRdau/OnJuvFfjmOP1j7Ms5u2D3X0u
	/Mr3DVlbDBu1TWrbitTwhwlCe
X-Received: by 2002:a17:906:f586:b0:a23:5c9d:4233 with SMTP id cm6-20020a170906f58600b00a235c9d4233mr1057285ejd.7.1702887411749;
        Mon, 18 Dec 2023 00:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpHjyXraaufwnJ/sd16XraNMKF3PqVp7EJZaPzyYZIgs84Jdx80T/2ekNop6io/r6Qk96Gdw==
X-Received: by 2002:a17:906:f586:b0:a23:5c9d:4233 with SMTP id cm6-20020a170906f58600b00a235c9d4233mr1057264ejd.7.1702887411423;
        Mon, 18 Dec 2023 00:16:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b00a1dc4307ed5sm13745382ejc.195.2023.12.18.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:16:50 -0800 (PST)
Message-ID: <e6509e106251c10a9f65bf5e520911cda26060a6.camel@redhat.com>
Subject: Re: [PATCH net-next 01/24] locking/local_lock: Introduce guard
 definition for local_lock.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Mon, 18 Dec 2023 09:16:49 +0100
In-Reply-To: <20231215171020.687342-2-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	 <20231215171020.687342-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 18:07 +0100, Sebastian Andrzej Siewior wrote:
> Introduce lock guard definition for local_lock_t. There are no users
> yet.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/local_lock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index e55010fa73296..706c4b65d9449 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -51,4 +51,15 @@
>  #define local_unlock_irqrestore(lock, flags)			\
>  	__local_unlock_irqrestore(lock, flags)
> =20
> +DEFINE_LOCK_GUARD_1(local_lock, local_lock_t,
> +		    local_lock(_T->lock),
> +		    local_unlock(_T->lock))
> +DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t,
> +		    local_lock_irq(_T->lock),
> +		    local_unlock_irq(_T->lock))

DEFINE_GUARD should fit for the 2 above, right?

Cheers,

Paolo


