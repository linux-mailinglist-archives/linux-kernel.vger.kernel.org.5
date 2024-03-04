Return-Path: <linux-kernel+bounces-90654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4EF8702C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D99A1C23C38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E623E494;
	Mon,  4 Mar 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ncl+PH7R"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A93D547;
	Mon,  4 Mar 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559060; cv=none; b=GCTwL6X2QV7FNF8fMJnsOu228cU0GqU5iEFaImr8B7vFyemeXBzRy9XUSX+2xx7YlUbQN8vV1fyOCF5QvdQUW19xuLgyu28XAk0uXclblfzenruXq3CAYY7qbqHcoSufE4TfL0kFg/kJGtV6h9PzlErt8YmTegjnoMruOr4pOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559060; c=relaxed/simple;
	bh=/tEpggeL4FP4g7AiM9zkr4WDOC8Z3r7V8asbPxSkyGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmMu5YFt+GppfcIoArLjAqdv9QNuL4CsLKrquzW+DMJ4lB0z+7bJyvlnx62kxDxnfPFxlTRuEnXF6oNl32ykx/bnV3FT3jaNzut4rIgtNi2IiTFUj14omgCz6OWL7+M8seqXdyRVxtAHArPIZwgECefP5l07aAH94TArUNXwJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ncl+PH7R; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709559036; x=1710163836; i=markus.elfring@web.de;
	bh=/tEpggeL4FP4g7AiM9zkr4WDOC8Z3r7V8asbPxSkyGc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ncl+PH7RDK8EgVjFo0dI7eobj3Tfoy0REc8/bcluX7BG2pUvOmf3hn8kqKR60Ja5
	 NuuGMNIASzR9eW4xZI9fv28eR7z63+a8I+Q4pwgTNQJrtRAoePbjW7ilThozzBVGl
	 GBnphNtGILFiCBuLUETt1ubNZHkwHB+i1Pdx5k8ea6tPhTg8uY+q6qnwwcd7CSj1R
	 nKK9K6uVYM7CZFx0JXem9p5CaGqapaeLoxnkdm/NmwIHH55/jAgSf9VZ9Vwd8UMQq
	 Khj4Uw4NhKlXsZtiHGit6zduUrzJzOI0fcM38iXCZvGs+2m6VuhM2S6uw7/XaNKtL
	 AYXr489Od65G1FY6Ow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUXg-1r6h7X46hY-00aOsr; Mon, 04
 Mar 2024 14:30:36 +0100
Message-ID: <472d8a45-4657-458e-9ff3-8cf55dc2b214@web.de>
Date: Mon, 4 Mar 2024 14:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Input: iqs626a - Use scope-based resource management in
 iqs626_parse_events()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jeff LaBundy <jeff@labundy.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71> <ZeVOPSt0L1D4BxuZ@google.com>
 <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
 <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>
 <2be02b12-84ce-4f83-b104-685f3b7cfd95@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2be02b12-84ce-4f83-b104-685f3b7cfd95@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LxD5vC+4LOqVHs7yIzbOKA23818+Gp/En37V4dAABNUZ5TrX+wI
 bw/9vdaV9P1IDacEfzrfJDehUnoj7osEF3ZASu50ReF8g3z34C/5OLsCpsNZYdv0pMRvD6m
 rJJUqfrGkU0kEtl9xBrOHICL/3gjwM6VohGiz/4ytLrBgM7p74dZ+AqVtBPcGLXR8tuYDv/
 Goj1bis3eP/wuUp1oGLdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H8FdFt0dBl0=;vwIr9GfMvSe7f373BmX88rghrwq
 fW1Q9/+iFM7Ozo3xXG9iaWY9jBzVDo12G89/fthHXTTKE7ZG1ijlmXe5XCozWYDIIaPjaGdqY
 RmCQ31eaGgdMeWNzjcvD6E2+okP81C1wMBn2Q6dQlgqGHK7axW4Lj8KBZuvIpWE96rg7+I9OA
 nSr5t7Fa7/KuDK9um6uUG1iwNAnCAFPhmeQ05d5QjjaMSM3gTeEI6jNSJBtXbUNzBWv9Ti0Tf
 XsDShIY4k9U4OPK7CbxMPqEvU+JeW9XVd9YyLYPEIZR2HKqoWjIWTwMJZOOkrHjZ6Uv93tV4S
 teXSrpbifYRJPW0BPEoc/h6+Vkns913pb6ubb4uJn29l4hd/QGrB4K4aUXRNhxqG6o8SDLy2S
 n2etaJ3n2Q9A8HQOglyPoX5+w6p2omj5yTg9GOqWGzpI9aNYeJUipUpKMhm4oeoDEMXAebLZs
 TU0+2iBz0n4c0zVFpnDm178mWqOn4p4HW2gyjPSNQkXfQhAfiBKx4Np1/tkgJGJ6EyOhPUTZa
 53F01F8h3TlXZAdlGJxgQGjHp+wmiK9w0eGFRCFUIVAFgfdv++UT24doWlQGJsp6e8bj2eP0q
 2b7zluINrU8nRg96tCfDTOGizV1Jf5bujcoQP1eIKgZ6llEOHLYYQ41LGulPx4x5aDcrQyJNy
 rjDSww/ajsrL0uo4dCMcf+9rx7sXwg9VPGiZXXritlI0FbgoLfgHd4Z4CFy4h8z2WlfsAe7qT
 R9tmY4T2kQEfDLOT9oc8Ssacu/5QFFnvgbjOatHyDtAlxm2RLwsCji4agqWh0i+gGMqXfntMY
 9CDzrRIz5NwDS6YnN5YfrkSNNmahZIpAF3XJIbtuua04Y=

> Generally kernel style is that you have to declare variables at the start of the block...
> But that's becoming less universal now that it's not a compile error.

Will it become more feasible to adjust the scope for further (local) variables?

Regards,
Markus

