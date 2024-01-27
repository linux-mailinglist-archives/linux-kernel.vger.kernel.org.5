Return-Path: <linux-kernel+bounces-41148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA083EC9C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EC61F2358A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1D1F955;
	Sat, 27 Jan 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KfOkAHNx"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FA1EA72;
	Sat, 27 Jan 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350082; cv=none; b=nAq5XnB07pblssRw3iJiIoYmHquSsU9HK8QxYfWb1V3l621XRk6+WcRgnP0iL62mxqelK8xiBC2DnvaUbEYW+5WxmU4FUmNu+QkHU0OnUozpJ+3TsuxlIN4lnQGgA1Da2iza/rBm8jW3OtY1JhFr/dXufh6Nz3VZJYPzkVCLLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350082; c=relaxed/simple;
	bh=bBw75j9IqFgnIbLcow/2PLqrMy0+1Vb6FnaPfM8nBGU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WUlzwYAb3RPecZHo5a5OVwB9wvyMl8h0DBpCoDK1NOG4sPtjy3dNhK2eVYHHOQi2d/KVxbsfeOgBzEUWTo5+ck4J/lfh2sZCQNB7LiEFx86oyIWca5QAHKsVzboj15ui9kCoSNZ5rKQKLIOx4vfa5pEIwI4ekT0UpWPdtU589wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KfOkAHNx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706350033; x=1706954833; i=markus.elfring@web.de;
	bh=bBw75j9IqFgnIbLcow/2PLqrMy0+1Vb6FnaPfM8nBGU=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=KfOkAHNxxuZ9iWWuu+OUG97AQblwOQIOaoSk0kAFqNoachBFbxkHhAWpe741trbC
	 7ZeSrwEs12mqXojMfgmzlJDyepSfgfymzq097IoLeDo+Eqzr0z/YUxKY6EciKWWTy
	 Afs+LR6NI8Rf/bLQdDuwUt+xFMy1vFnZoHaGeGM6OCS6aJTHifmJJl5HICl4ldxDL
	 yC4wajXcBefUxC98ILQbVrWt2wbwPcuH/+Xyp+lWCLpX4sggo8DNI22pVXfs+absA
	 cEz9t/gbQk5ccWPn2tanbMUC1rMAJEaEOPNByaoF57og78LIzdeNe9XmL7MZzx88s
	 +NR/eUguEMFY5N9PIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1qmwnM0rK1-00lTfE; Sat, 27
 Jan 2024 11:07:13 +0100
Message-ID: <60e674ca-6018-4f4e-a0b1-d8e27f4cee3a@web.de>
Date: Sat, 27 Jan 2024 11:07:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240124063150.466037-1-chentao@kylinos.cn>
Subject: Re: [PATCH ipsec-next] xfrm6_tunnel: Use KMEM_CACHE() instead of
 kmem_cache_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240124063150.466037-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dNrUMlzmaXK4pxFerqVzZOWEGdnTq3ZTolScq2NlNQzW2IO/0dD
 3SLOvXI1IA+tCzdYJam16bg2Q77VFIIfFQlBE0yHdpME9HAt0EYNpuYWl4yH2Zy/a+TTs/8
 DCYc+EnSYfvQanO2BK+X7wm+Ay39k4LjeaUTS3CHpl7rtMtXg9rqpJvMwHICFeBg43sIn+/
 g/vZhVVN0KN7/TX1mcSzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WrYeNNe5XXo=;vPbqom3K9Tel6t4CdK2X0uZEsAf
 hPYbceZrOiTyMrlMTFsWtcNz3ONXBCFw2MyT99DC5d/9uTA1B2FXV/qTZYzQ1Zw+JgqF94SLw
 624O4Cced59N9+KcLFFbY29q91vdsbsMlOT0Bc4JEDKT7VHylQ2lk4T4COY54jiypwLxN7/aL
 RZrbHNUevZva/MmQVAQSE1Gx+qfkfM2Yn9hEk4w9lnP01VKYCy49HqRfrcDjxbvVIn/l5cfg/
 G1Af8GMVPlElsQ7FN1frclZz4jUsRQ0ADIJtcM/k7iw+CS/Ez5mho4/2ztiZqUwnaRfvjU8oz
 ff5nSTR/KoE9L7fgATvhxTupMlsYR7m8t6gyKVreVkoUV01SuCdNs4/RL12CIVfbco0B+CM4I
 yggYX2SWipBb737abxfvQqB4sWffSouTDwQojeqMvlgiw6zj4jMNkEkXNErTMYOzlWYbD2bio
 GxuPRw4AhPo3lcSAn9DF1k8eGgoRnM8kvrCTYA8IFqeXhEn1trzlgML7gYorLP09BA6jGwjAI
 LjpNPqSQQsebmYTtjypxxPEZQES5RvsgeBVkTzZguTtqpKpsCyQoLAPCOTd1d5tugi5/ibUB3
 XEWvhKSslPPXuJqgy4dLFpX58EegQt+eC/Mx3luTpLsTL0K5P28NB0I262ZPU+3/q4qCeN/24
 i+CbjNW1ixiSuWab0wzGuMwLjsf2bDqnhPbihhxzUnqXng1yeMzHsQqN7/Zv1vItB14cZjmNR
 voiuupNor9Kvc+q43Qh4qy1JHUWbIc+QgQwImQyQ7kgBGOrymDitR2vxdL6+jXthQ6/vYAw8y
 Xh+UhftlB+mcFKr1RRt9uPUL8x2a3rHph9xSmc0flQ+sYrGw5mLmfI9hAXXk/tcqHfOU9jIFK
 1N+2O3uHqNfZFu57KQO9M3ULGwDgpC2grY85cuH3D989fJXmeLrDgu2NAQtPtcHYL8PPnH5UB
 6AHzbQ==

> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.

I suggest to replace the word =E2=80=9Cnew=E2=80=9D by a reference to the =
commit 8eb8284b412906181357c2b0110d879d5af95e52
("usercopy: Prepare for usercopy whitelisting").

See also related background information from 2017-06-10.

Regards,
Markus

