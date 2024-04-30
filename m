Return-Path: <linux-kernel+bounces-164770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A28B82A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C89A1F227B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D01BF6E3;
	Tue, 30 Apr 2024 22:24:55 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA131BED74;
	Tue, 30 Apr 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515894; cv=none; b=Lw2iYXTCfh1Lso/ZMuJb+zMgeJB+qqYHyqzf7kMscZRHtl6xQ25x7sODUpPX/6z2PZuV9bdA0BPT+A1jCZh8DVa2aLhrNUdBcaXIwkyV2LDDwY3wGZD3zJ/9Xb+hOb9AlF7dZxuDWGfMz9AmIpALnifcXOfBMIGwl5xv5Y/JUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515894; c=relaxed/simple;
	bh=17NkYFO9dywn/blIM0Gpoy5e7x7EYKqNqeOoLXKiO7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geezfcFI/Wj+75dwg2ssaorv6vUTwiOr1HozOz3PZBMAJc1jNI6ZkSEK5XLiL3gjBwWg+ls+VEmoQoD4dWCjo1p6AzubW9RS7eQZjZasBPTDTlC9+Ang7kz2s4sjIUvLZlUD+933fesRiG8p8UVXNaW3Z2/tM2rJ6HGtEwiL9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2db101c11beso73349081fa.0;
        Tue, 30 Apr 2024 15:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714515890; x=1715120690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECpIuyv+gzN+0Jumi8ixAEg//MH7TPT3J6p+EMrCEyY=;
        b=TAS14O78Lx1Kio/qtaG3OLBmeObd0qO79cvk++7xzCNdgWHGXKtz2jKxuZy/gQhkzU
         BMT//ZpzODP+MAqrf4yrxdA8dfYrwnuxnTj+w7Iw8N7/hmDEsdBHFPlLGy+93EryJCQu
         8EQdtZozpNXDVADhEOTMvObd33Nf6aZJ9AvBu9x+Lt/X6m3uhXEggyDYZJ0//HPOZYET
         o/Mg2EmEXQPeXRkJvoS7O0MAVJxtXktpGBy1+GOKPyeAYCLBsEZzsS6vwHaeGdXiDaGH
         OYjNVqwX+Q0i6D8B+3EntPfAjQt/OxCb3zv4bUDCREh5cT6KXkH5yRfVqVb4+MbGUpFF
         z5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3/cmGaEaFifLgxgATtSf3M7s049luyIJAtlYW4v7InH+7vs4kjQQuMYn6NhSFH5FAilHytVtcg1+5Efr3n05CpZyVnd9wkHW4OEFKAmD8DnRRg95ZftzXSOxuDxf5B0bjeRXxjG+BVQ==
X-Gm-Message-State: AOJu0YxCrZ4FQ/g9o/cFFBF6q9h+8JZ+gkYaJCWJMoK9lNF1YWmbN5oV
	4Q5S/8ZC0imBG5fxiKBk5Vr/2OTGKweXb8rpdZhaaIsLJ2mJeZNT1FLFWNJMqV0=
X-Google-Smtp-Source: AGHT+IFkDqWis1cth1ly84iFSo11IVWjc4Yk7t+fpJ5KyD5XPZCLyZbXH2DoWlIIg3mBIwhf/dustg==
X-Received: by 2002:a05:651c:1992:b0:2d4:9201:d505 with SMTP id bx18-20020a05651c199200b002d49201d505mr615301ljb.51.1714515890303;
        Tue, 30 Apr 2024 15:24:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f28-20020a2eb5bc000000b002e0e78240a4sm365162ljn.77.2024.04.30.15.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:24:49 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518931f8d23so6465425e87.3;
        Tue, 30 Apr 2024 15:24:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRs5xWcYFKTtjNkCZKop6XbkeTv9uZt5xZfN19KGWvgwEK2keNBBrE9pLKZgmFR4eNqhfaBZvJqsewJo6wBk9Qt++Y6nmHV+n7VSxkBV1F+G5ykMEHfm38trWPgFkNGJqGLm4RC6CzUg==
X-Received: by 2002:ac2:5632:0:b0:51d:68fb:5d73 with SMTP id
 b18-20020ac25632000000b0051d68fb5d73mr498752lff.8.1714515889769; Tue, 30 Apr
 2024 15:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501075038.2d07189b@canb.auug.org.au>
In-Reply-To: <20240501075038.2d07189b@canb.auug.org.au>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 30 Apr 2024 18:24:35 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+-Hb29VE2-DLb1Vo51rwhJrYmN9J5_mxocFUf8Y72Vww@mail.gmail.com>
Message-ID: <CAJNyHp+-Hb29VE2-DLb1Vo51rwhJrYmN9J5_mxocFUf8Y72Vww@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the bluetooth tree
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the wrong fixed tag.

On Tue, Apr 30, 2024 at 5:50=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> In commit
>
>   91708e8a4376 ("Bluetooth: msft: fix slab-use-after-free in msft_do_clos=
e()")
>
> Fixes tag
>
>   Fixes: 9e14606d8f38 ("Bluetooth: disable advertisement filters during s=
uspend")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format=3D'Fixes: %h ("%s")'
>
> Maybe you meant
>
> Fixes: bf6a4e30ffbd ("Bluetooth: disable advertisement filters during sus=
pend")
>
> or
>
> Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by addre=
ss filter")

The correct tag is:

Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle")

Would you like me to send a new patch to fix this?

Thanks,
Sungwoo.

