Return-Path: <linux-kernel+bounces-11683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127981E9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4D1C2201E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA84C80;
	Tue, 26 Dec 2023 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM0H/V62"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035214C6D;
	Tue, 26 Dec 2023 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb907d28fcso2267356b6e.1;
        Tue, 26 Dec 2023 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703622222; x=1704227022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLliTISajJlRSyWREx9KaaHsKdXTEmO4wkxTJ/lMi6I=;
        b=LM0H/V62wD6+LD5kdd+6YgDLUvL4Sv/bAVPYOx1Ihb1ysx6/USuicHHt7yLbYdV6mq
         CNPQsHcyPoETwTJ0C0DCEB8xFQZmYFRgVPxNzesMJzUMVm4z36xDIPg/v3xwuSxLsYf9
         n6Yi65uCN7bTqYlGJW0isjR2ObB93BzYDgchpA+hpdP72mq8/rmhDyBKgvZ863t3t9EJ
         wEWjGHOocemhkjkzteggnH7/lqOLs7RQz0Uw3NfTA/MqhkK7qyNvhDtw0nFwBnhu0veM
         XGuI5htc/cqyQjwoN/jJFMV8P/EMLLaehYroEDySCq2YlgheIMheuewjzRDgr5/o1RRa
         jcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703622222; x=1704227022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLliTISajJlRSyWREx9KaaHsKdXTEmO4wkxTJ/lMi6I=;
        b=If7ahfis9BqfLyWHoWxCDW7itu9isK+Pxx9duwVdMqrYkWSR1r//8/jzUGnbkWIBtz
         o69MUhR3Dhst5WvxIGRCMKfSGUovnmEV3a09X5K5Rb9qIEA4nbHqBbjwa+7TebNy/1tG
         76uBGz4NUrw4hU5DdwWYfCDj2qChBKvQkWWsRm5eBSyhU6Lh6sigBvIQ8czQs5jD9/tq
         A1sOixUwmkNxol24QtrwXXU/3reB4aL9uBs2bz2jAAzXKZCgmiv+Cw9QaGf1y8LeuNum
         oxJwYRhmXcq5dJ5aRWFj/i4Yrf59xFKHXgZCN9nfwedUp6dHRsNl3XW7vyJASpZ4QGjc
         2mlg==
X-Gm-Message-State: AOJu0YzD3kjdvMAdJS6fUlIltM/kaAIpKBSauhmls1BRPQlvzL6fENfn
	OGzMrbfv83SxQ40CLTayTyY=
X-Google-Smtp-Source: AGHT+IGHdHO4MvaKw9Ec59joEgXAcQSdbPp+Q4ALvPXKAMaHL79WMmb2N7zJXC7tqBqkQcVXjVY/fA==
X-Received: by 2002:a05:6808:3995:b0:3bb:bf36:12c with SMTP id gq21-20020a056808399500b003bbbf36012cmr1131080oib.24.1703622221988;
        Tue, 26 Dec 2023 12:23:41 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id f15-20020ad442cf000000b0067f5ccd6e73sm4910195qvr.59.2023.12.26.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:23:41 -0800 (PST)
Date: Tue, 26 Dec 2023 15:23:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <658b364d56c6e_5c2a929468@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Subject: Re: [PATCH RFC net-next 00/34] Christmas 3-serie XDP for idpf
 (+generic stuff)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> I was highly asked to send this WIP before the holidays to trigger
> some discussions at least for the generic parts.
> 
> This all depends on libie[0] and WB-on-ITR fix[1]. The RFC does not
> guarantee to work perfectly, but at least regular XDP seems to work
> for me...
> 
> In fact, here are 3 separate series:
> * 01-08: convert idpf to libie and make it more sane;
> * 09-25: add XDP to idpf;
> * 26-34: add XSk to idpf.
> 
> Most people may want to be interested only in the following generic
> changes:
> * 11: allow attaching already registered memory models to XDP RxQ info;
> * 12-13: generic helpers for adding a frag to &xdp_buff and converting
>   it to an skb;
> * 14: get rid of xdp_frame::mem.id, allow mixing pages from different
>   page_pools within one &xdp_buff/&xdp_frame;
> * 15: some Page Pool helper;
> * 18: it's for libie, but I wanted to talk about XDP_TX bulking;
> * 26: same as 13, but for converting XSK &xdp_buff to skb.
> 
> The rest is up to you, driver-specific stuff is pretty boring sometimes.
> 
> I'll be polishing and finishing this all starting January 3rd and then
> preparing and sending sane series, some early feedback never hurts tho.
> 
> Merry Yule!
> 
> [0] https://lore.kernel.org/netdev/20231213112835.2262651-1-aleksander.lobakin@intel.com
> [1] https://lore.kernel.org/netdev/20231215193721.425087-1-michal.kubiak@intel.com

This is great. Thanks for sharing the entire series.

Which SHA1 should we apply this to? I'm having a hard time applying
cleanly.

The libie v7 series applied cleanly on bc044ae9d64b. Which I chose
only based on the follow-on page pool patch.

But that base commit causes too many conflicts when applying this.
Patch 6 had a trivial one in idpf_rx_singleq_clean (`skb = rx_q->skb`).
But patch 14 has so many conflicts in page_pool.c, that I'm clearly
on the wrong track trying to fix up manually.




