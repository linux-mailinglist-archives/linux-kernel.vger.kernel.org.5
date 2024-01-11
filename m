Return-Path: <linux-kernel+bounces-23379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555882ABD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D876B281FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B312E70;
	Thu, 11 Jan 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="C2dgKMm1"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4812E60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704968452; x=1705573252; i=efault@gmx.de;
	bh=QPbVmelpM5dGwFNf433SrjsCCVj7Z+uNG08B8wuFktk=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=C2dgKMm1/RMbwvks7ZE2gmTCCUpM7Q5wy3LW1Ehomg+k0omH/JJeLcQD5Ktti1ph
	 llDeJgLWElm2XfMrIvEe5/iMUFtbxgkJR1uVLwzZwRxbUqEcP8CZbzw3umMRNHYa8
	 AAjcVJ+ZItBo53HuiSd3E1MXOqizCU3AVOuYmHOapRGwKJKP9VjWN0rPyqyQXrXxr
	 O6Ns2ic/rgIVtfNGcUa1SmqMNW5dU9uRg9fPdAURAEf5mDV1BQTH3RdXs16GbvHU4
	 TzGpbFTumwqfyEvpIyrri6hQkQBaPBHth5L76LcJp9hXpcExDz4y1F5NToq7xnK6I
	 5vrZqalxD4aOsXiitQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.137]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1qnRUu0F9Q-00aSQ0; Thu, 11
 Jan 2024 11:20:52 +0100
Message-ID: <06aa6b4faf3332d8138022afdcb61b83d848704a.camel@gmx.de>
Subject: Re: fallout: 0fcb70851fbf ("Makefile.extrawarn: turn on
 missing-prototypes globally")
From: Mike Galbraith <efault@gmx.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 11 Jan 2024 11:20:51 +0100
In-Reply-To: <ed6820e1-d294-4e70-ba3e-459311e4a8b5@app.fastmail.com>
References: <f8e84ac04537b2c7d02c1515d2f94f7c66216a04.camel@gmx.de>
	 <ed6820e1-d294-4e70-ba3e-459311e4a8b5@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UX3VkkXUUc1ug0zBUzKIXnvwomuGRpYHQbeqhhW9e6ZFel/pvDP
 PrAwpkYPfhH5eJqpy9lt5DAo0eeShG2KI8ulyAMw9Cb+DihZpwKQ2CNzug4Q8w+fOn70w8C
 +NC+vE9veG1jf5EiKNukoKA8Ol+qT2nCiUZrtxSnXhKag25rmaVVGRoqWK06JOU5AI2XS9B
 K53iUepPFwZKvCSgaDsyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L01Dgd/XJCo=;g1zSbzHg+T2nks/Oh/kyigjKH61
 PXRrNBXGr+DhXOLgz4K2BfBQ0IarMzm1er0Db5Ye4Vo6mFJaoA+yNxyr7DWV/aGu2subLmtHU
 cD0gmvsHaFOovE8OHjeqdadoQhNUD4g3n0NV8jYLNC8hBGXg3EFlu/6lt+BRAwrZ9DzA0OvET
 ZEMMDj1u0w8Sw5b6dKo5fqUoQ1fGgEz+Shij0ISEioL+5v19GpHGcEFg0kGlFQI9Cd2KmhQbK
 PwlyEg+cEcu8Fl9s5VpwXR11boMAgVJCNnOGXmxian6OCM1IJe4RQPnwap46oWFldCidvuWvj
 QSjrfjgy3eXl6hiSft4R6vQCPRg01zZjUL9D7Gx13xRg+3Q3s+VHw1+VoBtRJ5E2tEcWLCsvT
 q9iKzCWiAfNgX/6Lg4Vlb97DyydQNtait0B5jUzRHUbLuZh0TxqIutrq/PZOw2mpVpqn4+ghi
 T2TcKmx9EWa+EDOU3wAVbdRI1nZ8TL4Mwnff7HyApl8yDwgA6irkfg/VUsUvE0mv8F4lgRpys
 7OgETAR4ZiHUqPJugiokw9Q85rPfK91DPR1QaYRhm5+Y/49jXwaMjE1fueFHz9QixSyhNEdif
 vPopxGGA8V6mzygXv+aRpsLNy1s3qnU/KkfZgLER/xW++5Oi27CzDKEClMeWc6aho77o3EONJ
 kRmPWlR6KjKkdeJKMuzUPIQeco0eoTEe/5CqOQUhOL/5zkIx3SwEHVlTE2h6zHfrqkabhtSgB
 DIfW0yN7K/8eobc6IqcdWd2RPy5kFGn0u8P115brGxpj+FM73//1nY+5DO/k9hIlZxpj0UrRH
 PLdOO60hczh1tm/Iz6DFUk2380zxNRzv3NkjONEmyi4KNCrqXjjTLKrE2x4NDiOw3vZqJJ8kH
 /iOJUcno2ixgX79axmkgE8UgF3wwsKG2JtfzA3CQ0cJw4v38x9v2Lm/5tR8P5mwljoYhisRX9
 22NC7g==

On Thu, 2024-01-11 at 10:03 +0100, Arnd Bergmann wrote:
> On Thu, Jan 11, 2024, at 08:09, Mike Galbraith wrote:
> > Greetings,
> >
> > FYI, $subject inspires moaning in kernel/bpf with attached config.
>
> You may need to wait for 689b097a06ba ("compiler-gcc: Suppress
> -Wmissing-prototypes warning for all supported GCC") to hit mainline,
> or add the prototypes.

Yeah, 689b097a06ba squelched it.

	-Mike

