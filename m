Return-Path: <linux-kernel+bounces-111157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13788687A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8AD283CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90841AAD9;
	Fri, 22 Mar 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Sz+QOfoT"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F031756B;
	Fri, 22 Mar 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097351; cv=none; b=Rbi9vgl4ELQ6rm0eoNINUTzRHbKRekWKMjB99xnOdKc1hpjzbYG2CuAO/XnJb8nNE3AP4Y8KZWGHYoGerdxe2y2ifkkwzYsvHv7YBUIcV4p5rsOLMg4XwJu4vP5ejgmSZPVkfuhgvmYGe7Ko0TV3PWs5cqN0JMIB6TM6zScrQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097351; c=relaxed/simple;
	bh=dTYtO0jE8wKYKJFcNaD+LqthVoE8a2KnRw+uYik6gTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCoFbH4RQarIfBIRs95EMzpE1Pb+d3ZXCnKT321acnKeyQwCjoRxP5jvJcrbIqGQMzThpo9ror8EIVz5fagzD1LZ0IRTwES61crD1msRUxkZwFRjXqZfCoV8tpNdxZdxHJyZ7yZxLekg/EtPz9hiSgdU2H8wNSNsywd+jms7GvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Sz+QOfoT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711097319; x=1711702119; i=markus.elfring@web.de;
	bh=dTYtO0jE8wKYKJFcNaD+LqthVoE8a2KnRw+uYik6gTg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Sz+QOfoTD5Bpl9wGXJrzR7Ksj2hc9ZMWXKuPOVVkcJIo/2955grVbFz9Zkdlqq+1
	 a3yjXRxAtaAEZlRun5zFoV8E2k03VmQPOlM03BzQjQtK9rLmwAkzBIL+4TJ+DVE9j
	 QvpLEA95pWcJy/f4HblymlKI7wdYytyGtbqaES/4877+2ehtdioJb6hbQp31cVpQ0
	 9y2WPLi1zLfG7tcLRHJn1HktVcNvXnbp5ygTFaIys19EBO9fuvRwOcs5vX0jpEGrG
	 J1eeCBie4ftMdtGE5YLi4Dft6t+yCP4q0/peaFSiHsLazxJqgDdvIfDanQblKCuq3
	 9H6qvkbL/dy7u9Wbcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1rdRYY2bZd-006i6z; Fri, 22
 Mar 2024 09:48:39 +0100
Message-ID: <5412e9e1-2470-497a-a879-d28e6039be15@web.de>
Date: Fri, 22 Mar 2024 09:48:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ice: Fix freeing uninitialized pointers
To: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, LKML
 <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Kees Cook <keescook@chromium.org>, Lukasz Czapnik
 <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
 <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9YXkvZdYpqeXj5WB8AcK0LWQYNWMZbgwO0vYGnbOxScaxdApu0A
 /wGrtYc+l2huJpHcvNNT/1tZcW/e7ub95xlO4cy1Zi2g5iveCJACnZEZAxlbdwyQfqkN5ee
 3JfFsFxlVMK775YZ8vqtGLBwf74q6UBIBZyWpm0F3PNzdPiKJdcSuT1zLtKuEqGCdgRbVOy
 9HIZtqoXS2nyv+XOb1+1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eGYjQvfGa2w=;8aqjLC4e8Qn3i8gHlnKYxMR90PI
 otP3Ewl1/O20JuaFJwwDQibzoecYfetjeu9HAkew3SG+utku+ttOzFmVK5+nnJOF39MPo1dZJ
 Ht3GGhh5IUrvv82ADmD1A0w+f6++0BVbJcUX30PKHKz2ZRc5tNneT0vTREp+W5elGnouMV+x2
 TXjV/R0A7RVgJ9+hvPqMsUgEqvKa6GXbaH16ERyx/gLpirXkdFAsn4phqqWcY3AuiLgvp/z6D
 4pG3dYpEE3o0ZpXFtob3KUEJuzDQSmlxz0Ok2ANTBt43rLnNICwi8SPvYVOZYM4nqgXl2Fmu8
 xvFoytyWjrHCzbIONmIpHyT6uCG6fwfDc4s2U0n+/BIC+ebPdv4nLUHT248MsQleGKxpGZ7xe
 9wfA6QD6IA5nA70QnMYr4RDvI9oLKihilwDGw8rExQtkixGtDrsEBFRk6GjSqW6v0exz76oSy
 F74K6nFt/WkVHW5Kbuj4vWwegMapIwxDLAdA3Jn5U1NdSo3Y+tmpctsQCB7TmULsqQ1af3bOc
 L4uGN4ZaqKEuPVXX80aCa97ibUCSStQCzQWgvas7st7w4fhGwNgDGGlXbFFKBEfej2RU/rKZ4
 1nSYTE3/tRvFu6BUnPV7jmtWKW0lkuU/s688IhVHYgah6V/wyLP9+p+Xu9ZEGHSmkBUG1Qh3b
 6G8PI/cwldbw2t5R/4ZpUMYltcaTAKy7gQ3Nv4Z235ovhlOyRjPXtYHSASEPKcv6WU6TfoaUw
 Joe7kDDizCqbYkGbK2fbxZJG7Y5/zYA1rAVsSA2SZtLuZt+gcuhfQ2unsbbYd1odhctZE5Avd
 y+KFWCW0whvRwvg7LZgy8bzOrLOA+d1k2pKeNPb+oHRRM=

> Does one prefer an initialization of null at the top of the function

Several developers got used to such a programming approach.


> or an initialization to a meaningful value in the middle of the function ?

Coding style preferences are evolving more with the growing support for
the discussed scope-based resource management (cleanup functions and guards),
aren't they?

Further developers can handle variable definitions at the beginning of
a compound statement (a code block) at least.
Corresponding clarifications will influence the change acceptance for such definitions
without adding extra curly brackets.
Would you like to consider design possibilities with scope reductions?

Regards,
Markus

