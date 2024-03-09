Return-Path: <linux-kernel+bounces-97923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C58771B2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942D2281C02
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AC43AA3;
	Sat,  9 Mar 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYmgjMHQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBA22325;
	Sat,  9 Mar 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709995799; cv=none; b=JfZv/XU/9bgyHzuZkUv24xWXbqSb9HMK53N6Hwtk6l+T+DQFG+zkq0mqNj7ZwZ/GsRwFgN53eqUpJGgjGL1caJXHhVZC5toBgZHHCIdekNoNtvGaiX1m1Rft2X530UR18drzgUDh6hZKeEUQHmwrC4KP17HpCy/oKwTqOEBzemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709995799; c=relaxed/simple;
	bh=m0fRX6Klr4hL7HKDSzkO0KpHF8yKajILIBRNBCp469Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqSKLlEWcKFg7THXjICbG6rbAF2ppJqdkVphzsc5x65oxAoNTJx1AxLZBzAz5xYrhUrO9f4gnekbUfB2Ea5PmExYSjvp60fKfNP8PYO6sivE3fLNQBtjJS72xzA98Ar5FHRdHLUTgt2g6n3pnHQQR7q1dsyPxbuJH5VFcGErai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYmgjMHQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5132010e5d1so4256642e87.0;
        Sat, 09 Mar 2024 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709995796; x=1710600596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0fRX6Klr4hL7HKDSzkO0KpHF8yKajILIBRNBCp469Y=;
        b=JYmgjMHQgKcOp54UrEGeGxAKAOP0RMzNv1tjPq2d0MKUGLBoi/I/Don7kLteWT4okE
         1L5JfeuwlJmNFQOznEB+idx6WpQad6BlOQUAVYu1KGEUwal6tssXMd+h7zxesC18N4Vt
         mEf6tw8CF0r6tShw2K5T8iM+gf38qyWHCCENaKK1GgeFdsyARCWd+1zezWWug5MhHEaV
         PMgclpgeq5Oe/nMDPGLaxVAaj5w8EPOKP6IZZXule3KldTqiEQ/tyz9C8ZeFdQz3v/7y
         FVE2jNAygIWSxWpVekGBlpR0+XCzUujZccrkPNXc/1YPcBBG/7P8D/gb6eC8IpTpyPMM
         xEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709995796; x=1710600596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0fRX6Klr4hL7HKDSzkO0KpHF8yKajILIBRNBCp469Y=;
        b=aXxV17vY5Kj0ZmAUNeUPZCdch1jl/ZcDFTuPMMc/cF1qEhbdWgz7i58Vma9mkCNeR5
         zhw/b15C++Oeqhi5QSwft5uop3k/sEZ/XQ6HqDS+Hi6RirTucIF4f/GLjgPjDRglqwmF
         bpwEAR07P4uP7BoKE0dE8kKauHtgcROLl/CPLV5fKvtJxjlJDr2Fe1sCbB/8+ufckmZ9
         iUMMbLx80RKzAGrvRbuUZk6wvn4nUMFeTcBbsClHDuF1DhcPQgyHoeKJNMwTjy9qL59L
         QAnFPbIiewmzN9+jL8bX9vG2jf5RzAyMcSnms50DxUq1aSA33Yfk3S5ZMSstLV0mb2jG
         A8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCV1HEe2klZYZjZrU2vlDQ/SCfoK5pGuGkgYTWQIiyFjDwWJhJh3mLA7dEXMCSzuA3fo94vKqWyW9GiXGjTER134gIzoSbQ0FhjwpXKb4vRemko1VQEhJTjWRbZT8s7nutLJGviD
X-Gm-Message-State: AOJu0Yxhu1iVJjLvubDhdaar0LZJ6pldDr6IoHOfElhoKDv7Xb1LF/3S
	5Je5SOtkMFS7CoihxqVOlwi3unnbTpY/Kn0KX54TKvjK+YMaUxvQcZka6CmEA2o34SUtHRUqiuC
	u/6rap7MKqc/6h44qXYzocar8/w4c35SkI/AwNg==
X-Google-Smtp-Source: AGHT+IG/V19PAOGxhrGvgZcXjevkdaBQ0p6IbUzgLrUUhhNYYgMDdQGrl0RPxzPqWqB5Be/ZqoEGyxLfN3Dw0oRC3zM=
X-Received: by 2002:a05:6512:3e19:b0:513:2b35:2520 with SMTP id
 i25-20020a0565123e1900b005132b352520mr61277lfv.58.1709995795723; Sat, 09 Mar
 2024 06:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJRXjYTojFyHN6s1Qu9Vkkk6RwxPF=bAKPjOg9zT-GupA@mail.gmail.com>
 <tencent_4E77E34FDA2F438430621DF220620A882407@qq.com>
In-Reply-To: <tencent_4E77E34FDA2F438430621DF220620A882407@qq.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 9 Mar 2024 22:49:19 +0800
Message-ID: <CAL+tcoAHN_-c6eVuOY=O_8xJ_KLPS9yUpeW524nuSMo5RXd3jw@mail.gmail.com>
Subject: Re: [PATCH] net: mark racy access on sk->sk_rcvbuf
To: linke li <lilinke99@qq.com>
Cc: edumazet@google.com, alexander@mihalicyn.com, davem@davemloft.net, 
	dhowells@redhat.com, kuba@kernel.org, kuniyu@amazon.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemb@google.com, wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 10:10=E2=80=AFPM linke li <lilinke99@qq.com> wrote:
>
> > OK, but what about __sock_queue_rcv_skb() in the same file ?
>
> I notice that, but I am not very sure whether there is a data race. If it
> is a similar situation, then the same patch should be applied too.

During that process, I see no lock owning the socket, so sk->sk_rcvbuf
should also be read locklessly.

Thanks,
Jason

>
>

