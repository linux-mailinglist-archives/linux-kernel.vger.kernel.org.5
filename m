Return-Path: <linux-kernel+bounces-62872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C14852725
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EFB26D93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945C28F4;
	Tue, 13 Feb 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDPiwvym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B211C3D;
	Tue, 13 Feb 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789151; cv=none; b=ecMl6ZPGg1BkfMbieriHuTdXroiZbcadTOE2anL8Lcvx2HaFn1URWdbGjgNFO0HWp89dgWoaAMIjakgnuZ29gHTRbD+0IgBFdelksqtsFcF1iUP2cDpw557f0ojsgObMUsGJ/5JOtNjoC9EC8GSF80yewdAtqsn+hqWN5pVsEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789151; c=relaxed/simple;
	bh=uGuxFzDBaFp/hIBEohjAhRGcb9tqim+2jqM2pnvtGo4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JhOoI0bw/0W11dX2k92OQ8fy0EEwLFld3zFpvcZ9bsjW/5bTDjnfCKxxuSw8B6Fd3cTgk18HLW3bkAT7+T1PivYQkfpbo16iFBnK1r6lOvfCdPoGYK/3WhKRMAd/kLPeR28Tqb/ZTj8pLDQJY2VfO9SSz28jH1jkS2DMuJYCMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDPiwvym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D323C433C7;
	Tue, 13 Feb 2024 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707789150;
	bh=uGuxFzDBaFp/hIBEohjAhRGcb9tqim+2jqM2pnvtGo4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eDPiwvymo5oHUt2DUOS2kOtbJ7K+J1wO6uzNETAr+HveASj7TBWCLPo0vpkjnTmJ2
	 ccMUkNfVO98UraNQfFx1ftopzdYwFMxx/abCEaVYYIF77JyaacAJ2zKN9TwbvVOBzh
	 fT70pastL/AOnilQY1w23dIlUVOcZ/w2dKCH6kqT49wcft0yx4KjGMtg55DevYUUkX
	 JL7slsqaAbdy7udDnSjT2JsnSFuUQ7+AlQFRF38x8dYrAnKxgk0KQqMDbGhmEumi9I
	 +1DkZ9mdRyBrv/6M7AEq4PWO/v2/oURpP9l1WnjmnNjp6Q/v7j3hX7ADfiJFEwE6se
	 /wbXLzukvQ/Sw==
Date: Mon, 12 Feb 2024 17:52:28 -0800
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>
CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Qian Cai <quic_qiancai@quicinc.com>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] configs/debug: add NET debug config
User-Agent: K-9 Mail for Android
In-Reply-To: <20240212170253.77a7be7c@kernel.org>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org> <202402121039.E14DF37@keescook> <20240212170253.77a7be7c@kernel.org>
Message-ID: <952DDEA7-E788-4705-B85F-6B28AD6A707A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 12, 2024 5:02:53 PM PST, Jakub Kicinski <kuba@kernel=2Eorg> wr=
ote:
>On Mon, 12 Feb 2024 10:39:55 -0800 Kees Cook wrote:
>> > Notes:
>> >   - It looks like this debug=2Econfig doesn't have a specific maintai=
ner=2E
>> >     If this patch is not rejected, I don't know if this modification =
can
>> >     go through the net tree, or if it should be handled by Andrew=2E
>> >     Probably the latter? I didn't add [net-next] in the subject for t=
his
>> >     reason=2E =20
>>=20
>> Adding these seem reasonable=2E I touched debug=2Econfig last, so I can=
 take
>> it via the kernel hardening tree if netdev doesn't want to take it=2E
>
>I'd prefer to have it in net-next sooner rather than later, because
>when our CI hits an issue we can tell people:
>
>	make defconfig debug=2Econfig
>	make
>
>otherwise I have to explain what options to twiddle with=2E And the
>refcount options do catch bugs, I had to do this exact the explaining
>last Friday :(
>
>So I'd offer these three options:
> - we put it on a shared branch and both pull in
> - you send to Linus within a week and we'll get it soon that way
> - we take it to net-next directly
>
>What's your preference?

Totally fine in net-next! Go for it=2E :)

-Kees


--=20
Kees Cook

