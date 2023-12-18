Return-Path: <linux-kernel+bounces-4265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD7817A26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D901F234A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD55D746;
	Mon, 18 Dec 2023 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="YeyPUT89"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853201EB24;
	Mon, 18 Dec 2023 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1702925748; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=D+FmKTCl43bfhfUKQmCUxHOQTjaAXyP/W5ffXJWbfaxcgQB/Opu/E19h3mTIqqYWPo5T9+RJnRcu/B8vf7tHwSAnlY7UOkqGkdU4Cs49aG9Op1nMGQqQOgjPDzOIg3X3LkUkjQQtzPQKt1+pk69LtTJ5cHncUngMOfWA1YZvdNw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702925748; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U66pKooJUfR7TnaJpMLRYIeBDW23xBDJpRAZey+fgdc=; 
	b=GVvbEJseT0kebZPXxsw7+wdSWlxZv5kXEnr9OSmrUGYWOm4DX5BRqWiB8jYRPWCpRiXiPy1hF+9gIGpfN+SkLnRzwioIcpsQXvG61/aDnK4bolZuk0Q/OVWkx0bLMG9Q5H7QnZngoikq7Vr4MNJsrAwyvbTt7NS2BNjvGwBSIks=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702925748;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=U66pKooJUfR7TnaJpMLRYIeBDW23xBDJpRAZey+fgdc=;
	b=YeyPUT89Msd3TQhtUSVEOVig93P0jLiNesER9OZuP4tRriHJVfbxnkhGSRFPogAD
	ibBqva0KEsYUmHq2e00ax1zcRwnqkfqmFj6JuzuFXsUN7jrKSR0dNJwxIwtz90aTKqr
	qOHmRnv052/n9pzdkwq5sVB67M9Je+wsLuZV0dQA=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1702925716591727.0450941163903; Tue, 19 Dec 2023 00:25:16 +0530 (IST)
Date: Tue, 19 Dec 2023 00:25:16 +0530
From: Siddh Raman Pant <code@siddh.me>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Suman Ghosh" <sumang@marvell.com>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"syzbot+bbe84a4010eeea00982d"
 <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c7e484c46.35167daf376072.28325334020826186@siddh.me>
In-Reply-To: <6160aa1e-5f77-4d7d-aafd-e1ac7606bf06@linaro.org>
References: <cover.1702816635.git.code@siddh.me>
 <0d812b9aae2f16691d373460b06c5f3e098ed2a6.1702816635.git.code@siddh.me> <6160aa1e-5f77-4d7d-aafd-e1ac7606bf06@linaro.org>
Subject: Re: [PATCH net-next v6 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On Mon, 18 Dec 2023 15:09:00 +0530, Krzysztof Kozlowski wrote:
> On 17/12/2023 14:11, Siddh Raman Pant wrote:
> >  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
> > @@ -959,8 +974,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
> >  	}
> >  
> >  	new_sock = nfc_llcp_sock(new_sk);
> > -	new_sock->dev = local->dev;
> > +
> >  	new_sock->local = nfc_llcp_local_get(local);
> > +	if (!new_sock->local) {
> > +		reason = LLCP_DM_REJ;
> > +		release_sock(&sock->sk);
> > +		sock_put(&sock->sk);
> > +		sock_put(&new_sock->sk);
> 
> Why is this needed? Which part earlier gets the reference?

Thanks for pointing out. sk_init sets refcount to 1. Actually on a
further look, the next line shouldn't be there as nfc_llcp_sock_free()
is already called in sk->sk_destruct (== llcp_sock_destruct()), which
is called via __sk_destruct().

As sock_put() -> sk_free() -> __sk_destruct() -> sk_prot_free(),
so we need to put.

TBH really don't know why nfc_llcp_sock_free() is not static.

> > +		nfc_llcp_sock_free(new_sock);
> 
> This order is still wrong. Unwinding is almost always done in reversed
> order, for good reasons. Why do you unwind in other order?

Oops, extremely sorry about that :( I reverted back to wrong ordering
from an older local commit and didn't check.

I'll send the fixed one.

Thanks,
Siddh

