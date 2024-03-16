Return-Path: <linux-kernel+bounces-105179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7B87DA2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4841C20C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59118AF8;
	Sat, 16 Mar 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l2MVLw3N"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C517BAF;
	Sat, 16 Mar 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591726; cv=none; b=qENxKKprhmujOW1hrfMIUMqnWK9LMvbZls34tzRDMj/ZV3S2mvLuWmVxoU0LW1Wau7yk5RZbKus70uK2QuAKrv93/nJwrj5A0ZuBk4CrKlAdgGKlQ986EGj+MLZnZ5No89WncpQK3T6BY5jKYz6yE7jCiuetX0YkAjAH/+GumdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591726; c=relaxed/simple;
	bh=XxGy920P9DR0EZIW7+Yb4OcOzn4dQ1bS2DyY+nDGDIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv4HNYmF6VG173Pawvguc04uzb8bSNik+oauAq4sEM8wSxuDxeW07tTIrvQ/MypOSLFa0mT1uZxmo7//x5MmIlT6MCUq+bADk0E3ExoObxNayDfzjpD8TUQe3LOQOrcp8yC88md7qB6K1KzWBSzUlDemIsDsoljndkAZSEnZRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l2MVLw3N; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710591699; x=1711196499; i=markus.elfring@web.de;
	bh=/QEqgj+Ltvb5OtOACFmXDcDy9+HrKk324HPLGGfFo/0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=l2MVLw3NsJrTFcF3Yy3k+a3aQzrwT0E160jWyKi9qpmd3akGxhV4YYElzHRJV225
	 96irb6BJc6lfHaUObWetKgUsqUGK0ejZglw8HV/tMS2vlKSGwiJQ28TUt2NJGZDV+
	 zW6o5WopqgFzOwy6lWyb6n6y9E2iuEYprpfB9VSNFHBnbz7KjOPjN/BQKHXkTHfO9
	 EexQ3Ax72k3D8ggTaJ/+pIpQcNnYOk/VOYVyaJCcT2q7KlsZT8q6H+LzeiSQulPWl
	 V6Jbflimsg+dltdy77kCgQj9etUzVeuojDy/2Oyyh7gHozzCBBTJCqlB6h8SgBsDw
	 0bj+iPIit2VqLpb3sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1rWP0411x5-00KlSo; Sat, 16
 Mar 2024 13:21:39 +0100
Message-ID: <aa212ffb-1786-4b86-95cc-f2ee0cd455bf@web.de>
Date: Sat, 16 Mar 2024 13:21:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
 <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
 <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
 <ZeWnD9YrXLWJYmhT@kekkonen.localdomain>
 <cc121bef-8bca-44e6-81aa-bf8e682bdaf5@moroto.mountain>
 <20240316094652.GC2092253@ragnatech.se>
 <0b77e146-df2f-4fe1-a4e8-206a62a5ac59@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0b77e146-df2f-4fe1-a4e8-206a62a5ac59@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CYSazAyFcqwG1K8ccAxElR2MFdI5csaNRfKL+ujpwkyo75gM003
 sMdgTgvdVoJrXQqCpIJj8HopF1R1OxI9nPHiSzk7esSS/5NYTTfIlgcVjVkkgwZEbs7216C
 EmoXtU4prJmU/9IoNYgX3mpnRvbl5gb+CtrmeoTjC2mz0nI1in6INRD7iQygE7G9GbfJqI4
 hkJTtovI1y/iB5bGh0omQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vkl82kTfK7s=;dI3oT/euE+q6zJprge2r7OksWoN
 y+lxnkJvAhGefLtmu4hbfogcGfAA5IK3XcSyWPTCm6pBxqb3ENZhR7YQ15RTd0ycw8fRjuNJ2
 8hip2ZKvg/3cdQxL3fbNdynx4kk2mSv9PI56RDP6PTjl4FPZ/QQMGrwo01R+FMBN+VZVMBlA0
 fcQBJrxNrdQVk0Gge534xgeLY5MZWIwZCdern3as+xezRNoRKLCo7KJYuNnmMLp8GLZhlbsJX
 p5WZZo/3MSWAHrifuqusg9QTdalqtiYQwZtLfRNBmhnS1OZhreoiiXJBxcqjsNNFgEjQ7sxqK
 OoDhHzNDmKO6ydMziKB/TVB/HYiViICXeRmnUym8DoTDFeQ8BNFKhzfM1ugpQBMETa36BNdv+
 UfUb3npTGPcTQnjENWrXFhblDUC2oTqgp9YEK6PRh/TD5AD43eN704VlyalWMXY3CymQO5oeO
 DM93HPfmqQE9XSwQFny/gMwvU0plaUwh2UKUiATd1DYutEd0SX5lL+39MWPyt+mMtFiWEWp+Z
 KDBHP7dJ/07uVclbXQaJ+LuGm/m0ZR7HN1MzywA9oDYZUMoGZXmcj27/GMiScFgX/Xzc2r05o
 eZLtGxx/YH9qXy9oK3JWJPSjpU8V/IkbXym6pZ6RP/Xpd24gwTOk3XsWxHyawQwxjNFOOsYZs
 M3xygpKuYZPdWF9rBa2Za65h6XDDW1ccdAda+Xg/plMjnRsGA2jn1MiV/vhJSSFLhBQcgdfzA
 SEBs4paGpOwy7+QAFHgkJq5125wLhiuNua1Czq3tNywIB/eKuBZNiAf5IbiLit1oN33DEE+60
 mKtP++GiXuLFsR3YsPeJnUlOs4HhEGdUJGNLSK/o81GfM=

> I said I would send a couple of these but then Markus went ahead and
> sent the patches that I was going to write...

I dared also to touch some software components.


>                                                And then it was like,
> "Oh, these have some questionable style issues"

The patch review is still evolving, isn't it?


> so it wasn't clear what was happening and I lost track.

I find such information surprising.


There are various source code places left over which could be adjusted somehow.

Some contributors would appreciate further clarifications according to
desirable collateral evolution.

See also:
question about kernel cocci and cleanup.h
2024-03-07
https://lore.kernel.org/cocci/CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com/

Regards,
Markus

