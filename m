Return-Path: <linux-kernel+bounces-24446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC282BCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FF4B23ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625AB55C2C;
	Fri, 12 Jan 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5wlikbM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1955776
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705050492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0nU37kM4nLQS9a+jTPJKGaIKOCiVZSywQ1bcEx6PRdA=;
	b=P5wlikbMljbwhJKtZ0LoHpqOSgvp7mmQ+zj8zC5QgaMOdkJv8+Y+zPqGOlHJQwhrmqylce
	aLnUVqMLKnYwhLeji+ag7Ye+rXj20xDoYKoEA6J9MK11oJoOMRJG1PRDSc0bhpuBR7Nu5Z
	YVN7obTpjkm3UECHIWn3lTCEtzkz2fA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-n-M5jY7MNryNZHpjZ9xFLQ-1; Fri, 12 Jan 2024 04:08:11 -0500
X-MC-Unique: n-M5jY7MNryNZHpjZ9xFLQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a29de6a12adso106922266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050490; x=1705655290;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nU37kM4nLQS9a+jTPJKGaIKOCiVZSywQ1bcEx6PRdA=;
        b=L/6FQ8tlRdd7CUm4BW34d7C48DffmngCzCSr9jWqR6W0uEccflOe5YQqFAYduD7QK0
         oBd/PG8tYL5s7y9vQQ9h1jBBtD87pJUe+BgD57UBmcFxKzs5NdHeYWOPsJbqNF5qpGXZ
         OjZRZ/F3TNQw35T23sApxI7aQvszIf+G4U487j0e9OxhF0/CNnysUTn48BCYALo3z9Er
         3ewJHwI1W7a/w9FSfRQGLxbOCHpJc93BheJCHH0vPOyJEeVjKmu/Af11iZvkqPLgkp6S
         PBLaFmYmvcevxuPn7pn6XP+GNSOh2sI1hmW4ZmDur60Lve7SdHVavdHs/asQOaYZmU46
         YxJg==
X-Gm-Message-State: AOJu0YwT/ZrVhZltZhlvsmjKskjdJGwHLv9yfMPd8UgnY7PMjkwl2/U+
	mjyAR6LeOmu7LKV2ugse8C3JXxvGxiQ4QxSyXFSuS27Skej+DU4hZYFmco766Gm749GyzqG32zI
	snYiUttL7SNCdtJ2Ab5lbbPS9StFzj+QP
X-Received: by 2002:a17:906:fa92:b0:a28:ab63:db33 with SMTP id lt18-20020a170906fa9200b00a28ab63db33mr633344ejb.7.1705050489809;
        Fri, 12 Jan 2024 01:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI0fSC0TiL2xLcVeN1hBaSKH6whBShEE/lG/8jI6jkjQ0M54/xxght+KyT2FlZfEGE4gqV2Q==
X-Received: by 2002:a17:906:fa92:b0:a28:ab63:db33 with SMTP id lt18-20020a170906fa9200b00a28ab63db33mr633336ejb.7.1705050489508;
        Fri, 12 Jan 2024 01:08:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-119.dyn.eolo.it. [146.241.242.119])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709062a4d00b00a290920c78csm1565764eje.187.2024.01.12.01.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:08:09 -0800 (PST)
Message-ID: <9619119e125b0e30461e147f5654001397eb0fe6.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Valentin Schneider
 <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 12 Jan 2024 10:08:07 +0100
In-Reply-To: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
References: <20231115210509.481514-1-vschneid@redhat.com>
	 <20231115210509.481514-2-vschneid@redhat.com>
	 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
	 <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
	 <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2023-11-23 at 17:32 +0100, Eric Dumazet wrote:
> On Thu, Nov 23, 2023 at 3:34=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
> > So AFAICT, after we go through the hashdance, there's a reference on
> > tw_refcnt held by the tw_timer.
> > inet_twsk_deschedule_put() can race with arming the timer, but it only
> > calls inet_twsk_kill() if the timer
> > was already armed & has been deleted, so there's no risk of calling it
> > twice... If I got it right :-)
>=20
> Again, I think you missed some details.
>=20
> I am OOO for a few days, I do not have time to elaborate.
>=20
> You will need to properly track active timer by elevating
> tw->tw_refcnt, or I guarantee something wrong will happen.

I'm sorry to bring this up again, but I tried to understand what is
missing in Valentin's patch and I could not find it.

Direct link to the patch, just in case the thread has been lost:
https://lore.kernel.org/lkml/20231115210509.481514-2-vschneid@redhat.com/

The patch raises the initial tw->tw_refcnt to 4, so it tracks (in
advance) the reference for the tw_timer. AFAICS the patch is still
prone to the race you mentioned on the RFC:

CPU0:

   allocates a tw, insert it in hash table

CPU1:
   finds the TW and removes it (timer cancel does nothing)

CPU0:
   arms a TW timer, lasting

but I understood such race is acceptable.

Could you please shed some light?=20

Many thanks,

Paolo


