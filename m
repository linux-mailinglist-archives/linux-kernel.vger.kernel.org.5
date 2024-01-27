Return-Path: <linux-kernel+bounces-41156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6B83ECBA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D3A1F236CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA4200D6;
	Sat, 27 Jan 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R8gHkGqw"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6D11CBA;
	Sat, 27 Jan 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706351740; cv=none; b=htL31F0p0Mkm9jDUHTp+ifAZeLucSzxt2VrSHNIZtccPi446EQ+Hs72soobEjWZSuajeEyovm8wYZqd4FM3t85bkeP3K86u4QELBrXjEQ85SMuY2Nk9yuM2ftAghuiVdSfEvSzF1pHPp9Jb9OEq4g0X+G90b1emaoR/D6Itb5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706351740; c=relaxed/simple;
	bh=bBw75j9IqFgnIbLcow/2PLqrMy0+1Vb6FnaPfM8nBGU=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=ZEF3ETJmoUlFg7+pS4F1cHq6h0EALDtRf7aZYsTxgRiEnN9FBKq4F36nAJNPDJiYU0+OXU0A+vc/NYT5p730Sxq9Qdtoxoc4E13A5FsBLxyG55BOXzpjk6vxs/G/uwSFsHIwz8hjUSNgh908FJ2HCcJGNXXYNmtmyzVRbAcSyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R8gHkGqw; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706351703; x=1706956503; i=markus.elfring@web.de;
	bh=bBw75j9IqFgnIbLcow/2PLqrMy0+1Vb6FnaPfM8nBGU=;
	h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:
	 In-Reply-To;
	b=R8gHkGqwm3Vw6BI9+PPK3bU00tIc5S/VlKUKmRx+VVchrkvx30esPB5/bcTj81z/
	 NiVtb1w8C24Yvjn/3aHwCIZFKLxF0tstKi0I6WpW6rdWpJazIWAbXVyTmTM512dKY
	 aluzYKK/HO5yxK4zYxrQOvr4fq5uSsfbm8hJaW6dlqhHhlc/OEMLqg3rNuzpgCw16
	 VX/ExCsYxqGM204aGGhw7Q8nSBxDMuEOc0pdbaaOBReScXIQGmySyRcz2OSgq9aOI
	 WTwUl0dglHzYh9fFS+iWY6ekrNAeuY86SWZTi5BhmZpw5JCrRQ939V5GnJLp2/xzB
	 WlJ4LhV7zqhlohqn4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1reMC81YnH-00Uaiv; Sat, 27
 Jan 2024 11:35:03 +0100
Message-ID: <72f6297c-99ea-4f92-b049-1a33fa864cf5@web.de>
Date: Sat, 27 Jan 2024 11:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Jakub Kicinski <kuba@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240123024631.396631-1-chentao@kylinos.cn>
Subject: Re: [PATCH nf-next] netfilter: nf_conncount: Use KMEM_CACHE() instead
 of kmem_cache_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
In-Reply-To: <20240123024631.396631-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9pUtgJwNPHO1FUc7Q6gwWDK324oGPWcIa8GDBsiT0bDwz8Q57ch
 48FajJ83+dQzUMagRk8tTnNdyGCXarlXje2J8EQXwCfqVTGUm5OyLfgx28Rm52yTuCwoYqR
 kOLSqYFweLsEyi1dc/8vfrncn2FIMw9Y0/XCgDJGbcrzPdPcTI8k58dgWTsqHWcJTitX7hQ
 /Q0e86go0eCnPeNBfO04A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fbPKtf/JPZY=;sgJWmdXtWZFvN7UxGJ2XVWET5uf
 0rjAClmMxvbIQhxLMWsgG9If2ddardVD1W5qH8kFq5elE+jt2ESUlAxd0/16LNJkahxamOpHM
 rBFOayVIBCSE7penEwQopZZIZxWAqO8uRle454OGP8G5GfEGXDAmaWtld8NDWrVA394lwe4kJ
 +goe2b3rOZ5g5HPEyt9n3bO1larbB1mAGQr1EZeZnV0tr6fArRU20tqvWy7mZ/puC9EI3YhE9
 GsJBDSNiP2hi9OCJeNSjI78UBHYYhfloZ3ndVNT1W1x2F59X0HKHivp/HtNIBq24/5ElRUvx6
 7bXKNIiZY5Cjqnd2Kx9ylpFVV4OFCOyuE0Da2pLlevE+yawJgJfItmzCaAqECzOj92wGbetrE
 BcmqanflwVvoM5IYqkZblx2POmitvm5bbngGqvF6UqrbaNzmVq4SAzoKduXnbmbVI103Weibn
 NRLqyQXan0zsiDHR9Z26xeRUXsIoBqTDpZ1B0K2OblQwDjZkFVypsBvuiREQirP2qdL5muvjJ
 sJWdPoyExdgorIqH2ZfOmdy4I7+dYMrwS9LqvdJoYlgW8esT6qZkcmqGITZaTNRZ5A2q+UQXv
 MvhShA+G9zFEqsYMPvoCYnQVUZaAAjeDoEeMzu9j9+VBYLaBp0ucA+6+/7meIs1URUrRion69
 CAiMwOtHjZjqKbIA0vsxR5atMQqbfcofJHLYNX+ZOsvtZy+RGZ7BOE/n23Ebn0R6mq5Ogl7rm
 is6ITHQP2x4Tf1TUUJotyGCHWh3T9faJwTs0iwh6qhjOy5HL0PbVKluAd2DYWv+yGMK1ZyMZO
 j2602NkPUGPIV0IUWqMGcAmTjoH1GVt2OJnCh1a28ZhBV6MA8Q0V4MpBDec/Gln3svwYROLeK
 ApHoM467gZG/m8dR2DVChHp2F4ih4qWWIfw6GNGnLEUq/oxkkTz6LoKDg3JHahUTSLWqxbdL5
 ZdSUSw==

> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.

I suggest to replace the word =E2=80=9Cnew=E2=80=9D by a reference to the =
commit 8eb8284b412906181357c2b0110d879d5af95e52
("usercopy: Prepare for usercopy whitelisting").

See also related background information from 2017-06-10.

Regards,
Markus

