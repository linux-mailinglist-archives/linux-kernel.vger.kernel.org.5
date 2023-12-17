Return-Path: <linux-kernel+bounces-2624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F46815F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C19E1C21ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9D446D3;
	Sun, 17 Dec 2023 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="i/IT2APc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736344C6D;
	Sun, 17 Dec 2023 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KLcgIgfOC/I8L1esnfcT/awnqV649hEG4n1S1QAUSes=; b=i/IT2APcnpOPsb+x/qrwIwg1Si
	WzwEwhmfd0VEUpuHfnFLMVDZ6PhnpfYbNH9aHNyJST+xNyy8WN5C/aTJXNGXogOSIeshQWS4D4X0l
	bjGp0Xw0BfKsjSoD0WXZaF1NsduNFzoJvpuXKaaqDNX3m6N0LIOIAmAUHOlkvPO6pyh8ToghSXcs8
	GtQlzPBSAi1swxXK8JxbfSy+ACP80s0sqFoVRh24XkTRFCKmZEnWfMfBDvdB+LcDGmtZUWTo4yPvk
	sHsxTtO0SffSI5h5OJKb7uEPNPd1yhX0jOzQrrm13HhBupBOKvHEhd7svykVT9Wh+5FzJB2fyu9KL
	f5iBZeNA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1rEryq-0006nM-Lh; Sun, 17 Dec 2023 15:18:56 +0100
Date: Sun, 17 Dec 2023 15:18:56 +0100
From: Phil Sutter <phil@nwl.cc>
To: Samuel Marks <samuelmarks@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] PATCH [netfilter] Remove old case sensitive
 variants of lowercase .c and .h files
Message-ID: <ZX8DUNj3Dn/bSvgt@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Samuel Marks <samuelmarks@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
References: <CAMfPbcbUD_29FihCpePpKOdJUAAw5XE_ciDAb6Lf_XcDU0JKRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMfPbcbUD_29FihCpePpKOdJUAAw5XE_ciDAb6Lf_XcDU0JKRQ@mail.gmail.com>

Hi,

On Sat, Dec 16, 2023 at 02:22:46PM -0500, Samuel Marks wrote:
> ---
> `git clone` fails on case-insensitive file systems, e.g., on Windows,
> MSYS, Cygwin due to case sensitive files. All but one are in
> netfilter, and they seem to be old code that isn't necessary.

A good one, sadly 105 days too early. ;)

Cheers, Phil

