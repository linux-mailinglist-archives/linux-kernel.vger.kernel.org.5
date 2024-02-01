Return-Path: <linux-kernel+bounces-48422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5B845BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DD61F2C30F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA4626A6;
	Thu,  1 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FeAHbqf3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC195F489;
	Thu,  1 Feb 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802008; cv=none; b=QX855JXK5TxnX9JuRB55coZlPY6qFIvzBEi3GN7/4e9yo+zespzuByYOlsaGegiOzYbi0mR6aN4cSjiXfDjsn8cN3rrMtboKTYpPnLNxJa9RvxbVKI85/c5zuvUrE4mhbBsdSSoem1umJp365rsrue8gmgrL/6J7V30aHGksQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802008; c=relaxed/simple;
	bh=2qcjkYA/09qzTjU0YMvalmbOHyCge4tVY/zh9Oyji4s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bperc9YpdpYkay2mvcFCLIzkUBQzJ0161S070DPLZdFlFCJV3Hel/+NyhUJTNjQzacT/ukDQ5G/mEu/ZIVoJmbMknwSVovTBgAUw6EiNkipthZlX1Zch+aPsF0dEgzokpaAKoiVrHZE9u/Rs2HfPkwA3betM/bHCsODWFZq9htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FeAHbqf3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706801929; x=1707406729; i=markus.elfring@web.de;
	bh=2qcjkYA/09qzTjU0YMvalmbOHyCge4tVY/zh9Oyji4s=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=FeAHbqf3ogXWj44u0MXNmHNOOmA3iAt4a5Qh0dmKmISUfboxx++coKrQuTkg962S
	 PKhyKmQeQb8RBGHwXH8c08RImpHz47ZXUyZYn60xkKIt48ShQ4Nu6oJykjCSiekpp
	 N3mc483lRibHiEvwHsPcetqNTiyxrEiFIQtu6S9vyZN/KelFwCthgRSbNm7LrkF9F
	 lAbGZNzx7AjT1Q6R7iEZDqtaaBYQJzPxZ8ctH4fYoPBfgJ3EyImdDSwumpFcDCaEk
	 DASud8pm3Tph05qfmlmAkutav9Y3iBK5OHensfHpI99Ne2j+UaBThDjmWa8dVmJdd
	 lofuQo5llUOHXVHZLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6Jz-1qfwax3asl-00pZSG; Thu, 01
 Feb 2024 16:38:48 +0100
Message-ID: <078e0e4b-688e-4f98-aab1-ddd387f7db0a@web.de>
Date: Thu, 1 Feb 2024 16:38:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marc Dionne <marc.dionne@auristor.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240201100924.210298-1-chentao@kylinos.cn>
Subject: Re: [net-next] rxrpc: Simplify the allocation of slab caches
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240201100924.210298-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VCDUuQeQNKj5tUf0gdRVcgdhX57d47HiTV7SNmo7l5VI23hoGOS
 XiwQQFS70ixo2jFLBXrcv2xt9Jf6Ywjs4Dy8jHU8YOC1DWsjxd8YPR23Dv8Fk4EoEsVDGnt
 WIEEu9ZhtGn+yle4rWPNC1td6Sx887gYj58uGLJx+IFaXRmvQJef7lSBxAJ72GrQLdI2bY+
 mIEB7F561+4ryJaEgdNFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R7D/xcBganQ=;+WUL+cplBtvdlYhCP8x/4mZxQ+G
 YtR5DFgB3+/lGSU0SvO6hbdDSeUSGEtfixllX5Wy6YtJlY0Z2FQaQVj4xHcdf4JvphoFaQ5+y
 3xo33OjUBKdzSLYGGa3KrBCBrWII15NsjC+AtjS5/8xf1DFOdUOxLHZGhuIxdId2opmVKe0tr
 3gVyLF23IZ+WDWJ2pEGpw7RhM4pArWW5KeROC5ZBougDA5x6Nqtj6r4UdDXRQUH1kuRn9fIXW
 G27w96XF202T4cwn0o6ZRsHm4BOHxeotoFFhOVp0g2JmY5TyWQx56XZyyoeNrmMstdda2pwdk
 aACIW+B1oIJ39plELSCM7f5nGY5gUqiQgDQi3gZ27FhFYZUnrDIA7S464IzTgAqC+riOAczTo
 tpqWVjNihG6ssR0nEZZpf2nhOToB3dChRfkcCg6amZFxv9LE2NKgS7FtNXBLMpBPh7S1RfDYN
 JWr8DXAhpOwO0tOn2G7blfUcVuiN8Vvp+zX1sZNh19CSo0PLMf19d88Bpp8D4ZEEr6FG5XLxm
 Vwrkde1lpWSFVrOb3wFxvBUiE99gy8WtYpD0FXmL6gNWDhMK464D4j6gvHWQATYRKnrqhddXe
 I0FZePNAcaJtehknDB2Od5EYhMx3+YfPaCxIsgCSo9BsdGO/x0TCiwQeCM+vDEpXtkycr+lV9
 N6b0T7SWWs2y7yOb9ln/PrDrUEsfoujpJD1WiY++XBHku89/46d4tC3BOOUE2eHANaXNuusJt
 EwK/Qmce+vzsoDDoU0bWKUEIZqzSOSh30wUQpadKlVOeDvVvu0aFdoE/fbBBmNu1EAHTg8ocr
 2wAFt6/nvbQASoLh22uBbFuP/3yfJWbtgJYyOizL7cd1s=

> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.

* Please replace the word =E2=80=9Cnew=E2=80=9D by a reference to the comm=
it 0a31bd5f2bbb6473ef9d24f0063ca91cfa678b64
  ("KMEM_CACHE(): simplify slab cache creation").

  See also related background information from 2007-05-06.

* Would you like to take another look at possibilities to group
  similar source code transformations into patch series?


Regards,
Markus

