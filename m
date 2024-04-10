Return-Path: <linux-kernel+bounces-137832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201589E81B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C8B2853F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7CB8F44;
	Wed, 10 Apr 2024 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="GOM5bUwg"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B9539A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715804; cv=none; b=O07u6fawPSdriTczVH370SGBnfIQd0Gcn11nwvfvfzNJL4Ple4YscDm16rTtBa7n46sUzknyCq5dqhFPuPRu/6cDN0FVVYu2kHU05XYSbtvDY3Y+b4FgP7c81Ylropr26CcVFtKglMewH/bmpwj2uxU0xFOZdouijXiIng+xpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715804; c=relaxed/simple;
	bh=9sHL5LbebkwrBdLiCkbTw2BdnFhiSCphYDK66lRVEPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBgGV9JXgaHJptpXX3Fc/J4tb9Q14zyybUJQjQOW6LqUh1WXGrUIi1TlpN1rie5uX1vbPEyJ1rF2Z3QZYP1lk5rRbRqZoce5DTfMNm1kSh9zF6scKMI5MEIYol8OXC7wx1CpaB5ZoGkxbbmle/mx4v2P2cw7JiiHiv1CLYqCVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=GOM5bUwg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61804067da0so29065947b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712715801; x=1713320601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khwZnWm14dL8uE/PMsqyX7hSnOPMt8GrfT/vNnwgL7k=;
        b=GOM5bUwgxTHMLE7T0inRujbxzHL8rViue4maA0FB4EwuBFQbLzxXgQBKcuQlOiRKP/
         nOBDI8yHyFvQ1ngnchomXh/wdzrwKgLbDPmYGnqMdkKIZvdo85ueZTvnznnCNrF7qGlh
         7JT4cxEXzoMc3EN1fq7X7U3UfXJHFEyHGjPsq2reYKuaabrXQpjeXT52JUyr0JXlITh1
         U6lZaQlV9Hv5xUsRx58aDPFqzjGpceWUOWvlGbeWxVF1l1RiHdtnTi7YiA2nlTisTLed
         DSHHfzyoouDEabnRoqTwToPW3WUaobocJGdSTOnhpQf1K1CdIjZ7hX9MyEzArZPcZ71c
         ciIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712715801; x=1713320601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khwZnWm14dL8uE/PMsqyX7hSnOPMt8GrfT/vNnwgL7k=;
        b=eo57m0db6VcUBT11SZKoL9tVEqfvEFLGzD1TeBl0mYigLFLMHErCJzbNYEqgDdKxdS
         NLRgLp2VDHwR2v7h9aRmVbKjengECQ3YydEQIQgMY8yLXxTDWEmqJyWqAzj+1yG+Hmir
         p1cuxfFseOD2cyH16CaSWYrwBYMK3cqQ0cz1UXSSo7Y90gSWalAHijBj6sq+zAXRT20J
         /q8ENmpyORB93Pt4cvbd05ckc473qa2Nz0R3/dsmbf70h6EsKzO9N4uZohNBBMc0X249
         EBMs/u++8ATgwbvocONuWY3lCzfc4PEBJCe16kJlkdNUQ3kVVN4NfSDUVPcjcmUFMxip
         BqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvtqoDM7q/zajEg/dsDRpBd1NNF1hsmGoz1SZdxJywzlLhoM4gth0wmpfqmLN4EnNumfhVXhOCb4g7gvTrw1w2FuH6thlw+MabyDJX
X-Gm-Message-State: AOJu0YzN9QL0pjaC8RzI6yE7na5OWATjTUW83+BfLFg1EJaAp3J5/IbU
	hyFKPmckzP5i83EplHK78Y9B3a7M0nmZd1w2YoVxvpkm6CCo3hwnSStaR5UcpItOC5EDD/9Dvi1
	OV/AfPW4q19Tw7QTc1APL6ol5HygWZvacN8ocyw==
X-Google-Smtp-Source: AGHT+IFtrp/7l/2i9POMHsw6eREWDmyeLqci9yjdmkaQt9VIn2HnOxOlbHcG2dl4PfW2xl1WKSUQr8erN9u+LieXHos=
X-Received: by 2002:a25:30c6:0:b0:de0:d2fe:d499 with SMTP id
 w189-20020a2530c6000000b00de0d2fed499mr1325133ybw.21.1712715800493; Tue, 09
 Apr 2024 19:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409062407.1952728-1-lei.chen@smartx.com> <0e5a96b6-0862-4c00-b07f-7485af232475@lunn.ch>
In-Reply-To: <0e5a96b6-0862-4c00-b07f-7485af232475@lunn.ch>
From: Lei Chen <lei.chen@smartx.com>
Date: Wed, 10 Apr 2024 10:23:08 +0800
Message-ID: <CAKcXpBwE-8p+naDgJnCU41ODxRhWq7CkhEeeOAw+Ode4-J6CLw@mail.gmail.com>
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet received
 by tun dev
To: Andrew Lunn <andrew@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:52=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Apr 09, 2024 at 02:24:05AM -0400, Lei Chen wrote:
> > vhost_worker will call tun call backs to receive packets. If too many
> > illegal packets arrives, tun_do_read will keep dumping packet contents.
> > When console is enabled, it will costs much more cpu time to dump
> > packet and soft lockup will be detected.
> >
> > Rate limit mechanism can be used to limit the dumping rate.
> > @@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >                                           tun_is_little_endian(tun), tr=
ue,
> >                                           vlan_hlen)) {
> >                       struct skb_shared_info *sinfo =3D skb_shinfo(skb)=
;
> > -                     pr_err("unexpected GSO type: "
> > -                            "0x%x, gso_size %d, hdr_len %d\n",
> > -                            sinfo->gso_type, tun16_to_cpu(tun, gso.gso=
_size),
> > -                            tun16_to_cpu(tun, gso.hdr_len));
> > -                     print_hex_dump(KERN_ERR, "tun: ",
> > -                                    DUMP_PREFIX_NONE,
> > -                                    16, 1, skb->head,
> > -                                    min((int)tun16_to_cpu(tun, gso.hdr=
_len), 64), true);
> > +
> > +                     if (__ratelimit(&ratelimit)) {
>
> Maybe just use net_ratelimit() rather than add a new ratelimit
> variable?

Thanks for your suggestion, net_ratelimit is a better way to make it.

>
> A separate issue, i wounder if rather than pr_err(),
> netdev_err(tun->dev, ...) should be used to indicate which TUN device
> has been given bad GSO packets?

I got it, I'll remake the patch, thanks.

