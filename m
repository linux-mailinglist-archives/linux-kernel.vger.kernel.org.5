Return-Path: <linux-kernel+bounces-119036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7E88C2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEBF1C28296
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5B74411;
	Tue, 26 Mar 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3BPGshZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ETN1EH6y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493396EB56;
	Tue, 26 Mar 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458496; cv=none; b=u8v02o78+AxVpT/9WLLtM8dyw08nW/1d2tNqji1Zez9Ki2WyabwfCs93Mj5xLy5L/7Swv2nbS+aul+6VTwNhzC5nVqy8VEGLNmSgp33B+6HGibIW4WvQdVJ9KL7gmHrCE+CW1yjFvECJJyqfI8Cq5MtKA3FFUElN4ckIrl51GIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458496; c=relaxed/simple;
	bh=EFshh7X9ubM0+XF5Ra6jL39fGH/o4V6QpqW2xLYoLl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rjzFIZWk+jnORBDLcA3WiAoQIrVQMZf81ZsRJxRDa7Arp9//KeQK0cEy5IFVfYUVg3gHKlOiQHrsuGlcHch1sd+45dhpmQBJWxkWO6fhT0EKMkz0/l2W4U3C9a1AByOcuVO/PxhWkCPdH6RHcGNbc7OjmSyA6O7ybAuZL2hgu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3BPGshZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ETN1EH6y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711458493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFshh7X9ubM0+XF5Ra6jL39fGH/o4V6QpqW2xLYoLl4=;
	b=Q3BPGshZjYjwajuB08w+lCsgYc4jwV721Wv5kUoUeHfAFvZkyxyndQHGFurpE95oBdR4bX
	YpJjFXDFZWJr7xwnkfmW3FHTGgNjgbHxVo3KcAN7n83/W4ps0adlGOwyu50R0Qk+O2a69N
	1xd2Ccp638kp4wALLynd+IL5F4zUqBdo/2mYwtWONS/L22/bdK2/pCCoK6Eqvs0u3M8Gzu
	Gotov/THQ8uRTkAP5UACHcIJVGxVQLYm0FD6D/oxxhY3szI+2N/c0ILavEIEfPDdTbHsm9
	PGQnH1iJAOWK1xQbzQTOCcciMsApeSFTClTAJR6WzEw1cNDufscUg0zVIcQDqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711458493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFshh7X9ubM0+XF5Ra6jL39fGH/o4V6QpqW2xLYoLl4=;
	b=ETN1EH6yWipj0JNpAd5nRCoQV2L5x2Mn9uiIkmMkcszRTyQQ0yU/InWK3ccY47SVq72IP1
	H6ZpPfeK79IJ7wAg==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
In-Reply-To: <d2623ac0f1cb07a23976416cdcf9eee1986747b0.camel@siemens.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
 <d2623ac0f1cb07a23976416cdcf9eee1986747b0.camel@siemens.com>
Date: Tue, 26 Mar 2024 14:08:11 +0100
Message-ID: <87h6gtb0p0.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Tue Mar 26 2024, Florian Bezdeka wrote:
> On Mon, 2024-03-25 at 10:09 +0800, Song Yoong Siang wrote:
>> This patch adds support to per-packet Tx hardware timestamp request to
>> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
>> user needs to enable Tx HW timestamp capability via igc_ioctl() with
>> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
>>=20
>> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
>> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
>> four sets of timestamping registers. *skb and *xsk_tx_buffer pointers
>> are used to indicate whether the timestamping register is already occupi=
ed.
>
> Let me make sure that I fully understand that: In my own words:
>
> With that applied I'm able to get the point in time from the device
> when a specific frame made it to the wire. I have to enable that
> functionality using the mentioned ioctl() call first, and then check
> the meta area (located in the umem right before the frame payload)
> while consuming the completion queue/ring. Correct?
>
> If so, we now have a feedback channel for meta information for/from TX.
> Are there any plans - or would it be possible - to support Earliest
> TxTime First (NET_SCHED_ETF) QDisc based on that channel? In the past
> we had the problem that we we're missing a feedback channel to
> communicate back invalid lunch times.

Just asking: How would that work? AFAIK XDP bypasses the Qdisc
layer. Currently invalid Launch Times are accounted in the ETF Qdisc
itself. Does that mean every driver has to take care of it?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYCyLsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggJ7D/9ZO6iQENtqCYv6/eWBp7S7wfIxVTnA
/O1AKCo1zVKtj0of1aR/1pAf1BsbmZNpYXHf0bTL74M6gzJtxRJDb+X9TX++wIRP
TBAKlWuIiOMTRgKJ6b8lO9Jv3MExJ7WOJDarXI7wFHsgUEwZ4XgDRf+v550KVztw
t1qEskkv0SCqZsidryG19aSwECAlvkie5JPX6WS5YuvmWRg6Gj4P8GKXUctHakfW
z2O/mFbuq+fkAsYRA1MLXQw+uVliEoSbNaMkUCC6bH2MmAHJPs9rrmXqTMuWz5tK
lTA4sh/OYTPJWhqvEPlJp3aCmgDmvd3VyEhxJPdnYdzhPCQ6CG+D4A5hzKjNC0eq
Dw3UR7Gqsa4lpSrwUOcGZjtmdUQbH+lsKgekCZq/FQeU4McrWGWDJSRHC9Ak6Wge
Zuh2KmRx7+8TynukUG+mZq0pso+F8bABY0/CK6ftt3KXhq3pS/jsMUZK6FQ0ASXP
8PFU8imBZQorzkKnXfQv4VD9ZtXuWA9eJ2ipGFCrg2a4BEcVltXEqgy1u0yysZtZ
Ajj/R8KvMplogG2/MSg4QS6mYxWd4sPGa8TmpSr+h4TPM+x5prFInVhTUTlUyt/D
2+uooj7jtx07znqgPaMRrRSitxd/qGxEMW+qwNwzDgpSiKFmSyftE0A9UPBo/nSP
SqzH1kto/s6nmw==
=EfO9
-----END PGP SIGNATURE-----
--=-=-=--

