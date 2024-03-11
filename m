Return-Path: <linux-kernel+bounces-99509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6804587896C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D8B1C2110B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7F56776;
	Mon, 11 Mar 2024 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZkZ8tnfq"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94D56751
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188747; cv=none; b=GAHmBEIdfGe4w2xKt4AFHFi1toN+fAqfBm50rLS8F6c+mEQctI57gS5l6B5RyTw1wGunKksCPgTL68LMgP9GsQp2Ic5ZXGZfGYg1lliC7vGyXATb/dA1jOnE5s9YVvSbmoH8bE8Ne74tIuGKGa9Lm/HzPdpN/K/At5TcIX7Iia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188747; c=relaxed/simple;
	bh=UxnbAUSo+88lJQ+P6Sfv/W5dV/HCtXbh5r5tC2bZbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+RT7DoRQKQ7zuXEDjyIR9QxnRh0hzek5zCXH2Q+OJdj1Ru/hnpkGHa8faohnutIywEkYrnV9aCYy56yQvWSCn6tEH11DabWZVaHThaC26SE42TprbWgC54DJNqc0mS4sEZAcKa4etsvD8fQfyOdoDfmZi8kZMUZqnlcqsVy1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZkZ8tnfq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6EC5E48A9E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710188734;
	bh=o9YLDdfCdflFyCMs5+/nFPe6338k23U+/2LO3IYQYLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ZkZ8tnfq+VO//MAmEoz69O2PHQCO7HiysuWoRH4wUTshfD05w3FeZigwBrYGnbjOu
	 8hr0kmIQC7Gc3hKsweQTzyJRJiOXYlitqscIlOQYErZjrvSjDuFXProzwc38BGlcGh
	 8qdxkue4vtzStP2L0QHZGMww23Sv0jB+2PHQtzFT28qCRVG6QC6z8khliD1D7jZaXp
	 1SiPqTMy2unhFqCYIXqWV3abQUvpwtb2IXY1ZKNnn3I3ptxb4rojTqIyJOw9lbFSst
	 zXcLoAD3ynNcC8M1mprQRyHQLr6MaPbuz6Jh7FrCg8uoUBCLgulRfjKHlzMM2m4bpI
	 +LJGY24HrvLgQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5684b85e0c9so2193931a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710188734; x=1710793534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9YLDdfCdflFyCMs5+/nFPe6338k23U+/2LO3IYQYLE=;
        b=Cw5PHtdsdHVTSQf+Itgn6zUSn46qfoguooH0MaHro0mwG/cEDMCvbt7NT4gTF9GoN7
         52XXHPYwrqzymN69URsRyWvBXfchoCni9UUwf21nM0AUukYur/kLw05cQJs2xunaGdDn
         KID5/8u0K1BfnpIxSCUOzLXXSQu5X9Y49cZkFk8CdTJDRCC9dVoeBbbDI3yoRRWDU7du
         ioxr4Ud89dcgyeKkBDrScLGy2wfKXTN4e8bKnqkSm95lkgCvnzPfcbzqkxmXaxRYqwQw
         KZcUap8tPum02oXRAwoxhW4MfNvUx68f5Ib2wg11tYRaISKV6HJ5wGfnYVy5Kph1dcFk
         37Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUKUM0b0ehhQm08PA8QHTmaXJ3Ipq3mEtTg6rNHnT6N750oJTEMN/UGaFjCri1cQTklj6STe0DcNMqBQvsHjBm/5qowKWOakieyZNW6
X-Gm-Message-State: AOJu0Yx0m3eT5Z6BWjx5+6pNZl1ESzdcjfjuFYQ/Dm/yCCOJRFdJKG+z
	BTV2sxfDQdRhTBDMZQZ1UcfHwFzjPw0o44ulsgXr6uTWA6HM0gbYsWZn44S4mICMsHN+6D7D56e
	1aw3jAufBHuZVQPMy1gnIJgFkUQkoF3Li0+EgeX0mcJkigdtVA9VttLLM4s62M4UJIq5ZJnJA7B
	tpzA==
X-Received: by 2002:a50:875e:0:b0:566:6a9d:6147 with SMTP id 30-20020a50875e000000b005666a9d6147mr8824855edv.0.1710188733944;
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRSBKB/l5WrY2+SCwqGjztOQYnHF/v6oCAuorX/wc86bW0V0ykSX2IazmuHEnnDeQZHtJVA==
X-Received: by 2002:a50:875e:0:b0:566:6a9d:6147 with SMTP id 30-20020a50875e000000b005666a9d6147mr8824824edv.0.1710188733443;
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
Received: from localhost (host-87-21-72-46.retail.telecomitalia.it. [87.21.72.46])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7dc14000000b005684fa1c4dbsm2138489edu.52.2024.03.11.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:25:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 21:25:31 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: ringbuf: allow to partially consume items
Message-ID: <Ze9ou-OrYO8NZsDb@gpd>
References: <20240310154726.734289-1-andrea.righi@canonical.com>
 <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com>

On Mon, Mar 11, 2024 at 10:55:57AM -0700, Andrii Nakryiko wrote:
> On Sun, Mar 10, 2024 at 8:47 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Instead of always consuming all items from a ring buffer in a greedy
> > way, allow to stop when the callback returns a value > 0.
> >
> > This allows to distinguish between an error condition and an intentional
> > stop condition by returning a non-negative non-zero value from the ring
> > buffer callback.
> >
> > This can be useful, for example, to consume just a single item from the
> > ring buffer.
> >
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index aacb64278a01..dd8908eb3204 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
> >                                         return err;
> >                                 }
> >                                 cnt++;
> > +                               if (err > 0) {
> 
> So libbpf already stops at any err < 0 (and sets correct consumer
> pos). So you could already get desired behavior by just returning your
> own error code. If you need count, you'd have to count it yourself
> through custom context, that's a bit of inconvenience.

Yep, that's exactly what I'm doing right now.

To give more context, here's the code:
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

> 
> But on the other hand, currently if user callback returns anything > 0
> they keep going and that return value is ignored. Your change will
> break any such user pretty badly. So I'm a bit hesitant to do this.

So, returning a value > 0 should have the same behavior as returning 0?
Why any user callback would return > 0 then?

> 
> Is there any reason you can't just return error code (libbpf doesn't
> do anything with it, just passes it back, so it might as well be
> `-cnt`, if you need that).

Sure, I can keep using my special error code to stop. It won't be a
problem for my particular use case.

Actually, one thing that it would be nice to have is a way to consume up
to a certain amount of items, let's say I need to copy multiple items
from the ring buffer to a limited user buffer. But that would require a
new API I guess, in order to pass the max counter... right?

Thanks,
-Andrea

> 
> pw-bot: cr
> 
> > +                                       /* update consumer pos and return the
> > +                                        * total amount of items consumed.
> > +                                        */
> > +                                       smp_store_release(r->consumer_pos,
> > +                                                         cons_pos);
> > +                                       goto done;
> > +                               }
> >                         }
> >
> >                         smp_store_release(r->consumer_pos, cons_pos);
> > --
> > 2.43.0
> >
> >

