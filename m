Return-Path: <linux-kernel+bounces-112417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BA887991
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430D41F21805
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5951C33;
	Sat, 23 Mar 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lIVm9CBQ"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAB3A1A3;
	Sat, 23 Mar 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213036; cv=none; b=HIbxia3dmr+R48cUTXB86uX6CW3RwaILMZje098ulDY78k2y1Yti4fKKQNSsvTaJ0I+RIu8SGVTUOhgPoQo85T/pyd+iU+BOi5/7g58xPwG1CRrZKzlNJB9TrUn0/MCcQcJnJ6dtT7ySCi+IojegJPct+u8xyD/yrDB2GufHzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213036; c=relaxed/simple;
	bh=95s1LxwD46f3RtcC8PeuotIjmcLiiX0ljaeHhJykyOM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aOuKaaf8Sa7k25Z6EW+4QCmlTIJ9GcFS2QNH0lD0MwM6cQ4AP5pIxgb31XEi2keOJWcW6tatrylDbhtn53E8ToZYaP0iczlpyvynqwJfqTFbveRjmoQTGevw+wZ3nGmuDBoqkmnVfy/TGg7sr0PRPbPJlTpXQEYNdyMv64eyUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lIVm9CBQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711212994; x=1711817794; i=markus.elfring@web.de;
	bh=Mm4VZjgznOtn+DsFuQ/+wbzhd9T3mnnR8PtcFlTVgYU=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=lIVm9CBQIGpAwxCkaZ/3KyokahHzcoIXCHe0iQFkB0bp75KLBDjin1OvQpffK7pA
	 oLoEiZTVGh8Z+q/dQZT2v7npFVyOp/egYZEdV3zrswAapQ7SIf9SHtUTha8WSFdQy
	 oE9TrrhEqZgJ520C2IZ1b/3t3UYIeSrSdRTz7x2cluIoZBSdeanstrgnYYXAZrjrx
	 OvoxFZXdrCHM1d7S0zduv7Gz++qNT/j9+zXhIJbLuLt5jb/Uc/7sGxMQhRJAn7PjK
	 I2F5jr9oVZJGJWRJYVyvgFviqygSbYDspBkSenBrcjLh2Qs72EkN7appBIXl24scR
	 7uNvUhm+nv/pafIxwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rPI-1rlrkQ06jA-00EeCJ; Sat, 23
 Mar 2024 17:56:34 +0100
Message-ID: <08c9f970-3007-461a-b9f9-9ab414024f68@web.de>
Date: Sat, 23 Mar 2024 17:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, smatch@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kiRndK7BLuqFNuvVd1HXr4cnMYe9v3VzpVM5ramyWfnyTZFlD9k
 jDgrNy/xc1Igrw6zJX46ksdqOAEaGXkpq//gCpiR7kVDv+sqxUcItMvJ9uF8RqEuJgG3Psc
 bfZ0khznwVaXT/soerN977m+mA6ciDIR3eJjMnc1Zn/5R6DorbePBTrGJBGkegEP4/45eTO
 zx/KKh7vxXRssW+vjn9xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PMFs1vMvo1c=;MP5SqoEPyH6wB6JcLKh21elBcjh
 ORtQoEW8RXCAUKrYrlNE59jzLNMV4ffv/gcBPaSMk2F2DY4OE3Hp4ruvt3MHqXLEq4pUgEJ7G
 R4BgRVjxnP4iemqB74azluTGiDDxszrrptAyBKWD1izc9Vw6I4VV73FBWutkJgFDhOnXBI/1v
 0mVlZ3WG+8cMGzg3UhmdlvZRxStcd3M5Sc/1eDfsYHIij7jlpGOdkr3cMpvwaQDxht6dSV1FH
 LkNgX1QR8PFqHTGfY6K77hB2tRDE9cJa2jJ/1sMWjNs9mduY2PMW7fTQ0S+oAf2+O9dSa1vpt
 vCpvcIq9hjELeVqs0nVNPoioeO64S01tIuwJcssYpx/M/NN+RYyGXDZsa9Y5v9CEmz2jpZra0
 a2YqPXAjfjmHkuqGvfZJNyb3fdcDFeY+5WXzKL36srPqdXQe6oG+iaS2KThnVjNKXjQ7Ylq83
 zUfcmsZaV7PD1ralRp4lVtRSAWbVsHTvJqoTGMrNM+SWdvoWXXajbtNZficqydKbtgmPIsEgq
 txTFb+Dy+tXEOB9t15MZ4O5hPYSo5hOyffgbRO4w/EJZdmQQ8ruKnxGL7VShHI6viVBlB6qfW
 VTirBVHcSYXFWtVxxpZuYmWmC9AYJbZP+qij1k83/g/JBVjTUTQ5XjJA0BwEWwBK/ggLBS8Gm
 Tb/N+/ouJRfuMwuf6vXdQ+a3codQtXH2fUqW8h5qG/ocF3XK0CN2bGBvx2cpdF0FZ/Zu42R+0
 yz3Z9pZgDoUzUOz6MoZGy6UCZvfNxcLFAXtbtK2nLF6W2dC+S0dKI4nQM30UhDP0u7RLarx2J
 KGOxkTrXY0NN10C4Z1pMBBpnffSQg/tebkWXHo8Gflr/A=

> Automatically cleaned up pointers need to be initialized before exiting
> their scope.  In this case, they need to be initialized to NULL before
> any return statement.

* May we expect that compilers should report that affected variables
  were only declared here instead of appropriately defined
  (despite of attempts for scope-based resource management)?

* Did you extend detection support in the source code analysis tool =E2=80=
=9CSmatch=E2=80=9D
  for a questionable implementation detail?


Regards,
Markus

