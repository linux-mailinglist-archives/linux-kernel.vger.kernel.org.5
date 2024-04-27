Return-Path: <linux-kernel+bounces-160971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89638B4549
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73998281407
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885746424;
	Sat, 27 Apr 2024 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MTobUfBT"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20C653;
	Sat, 27 Apr 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209152; cv=none; b=UmwRgF57Z73Xv7cKCqBU3VzMfaVML0g3f/7s/5+cQGHqxp1FwuRf1baqbs3VZogG/LQW047zyp3ZpG6eorKvLHm82+Xn/TWHjHB7eH/V9D4aTBMI672YOUATZ4Jl/ElRzZQUWIFkQUpSY91/QpEWeD00sus781YgEuzg+kS+YYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209152; c=relaxed/simple;
	bh=/xUk67PN/piLmYuiK8bKqr13B/hDGBvoKwdPCUFkcB8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tX8XI087iFbweLkiWII6G9eZQupzlzX/0o38XJ+ye1PdhV+7XGsePyxsViFfz3M3Dd5uPEfVctDgxHwwt12LSmVhjqGltqKhZP1DU6+aO/UrqpWj0pwKwZASYXZW7YqMhpgmjq/XHpp+T7U4YY+VSzQrZuIX/OgNIZtnuIaX31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MTobUfBT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714209108; x=1714813908; i=markus.elfring@web.de;
	bh=bGYRi4hDpraTh6L96Bqc9vwhRnZcF9ttS5i++hemawk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MTobUfBTQdxdpqyAvUGudIE6VMHg9DZt/tMxsB8wNadfPrY9F2BHB5BYAEdxOHW8
	 IYPpRculOWRjnbvIFaFzhPUUqeVC+1hugwQDyzATe5T/RS5ahMh5beezqX33PfpkF
	 UNhQ5fptNUIqs/32PwHgk5t+ZDoZ7LOW+oBPvIJWC7Lf6JvWzEY3lHB25DoNhYMFd
	 Y0jG32ei7EG34GbyIUK0opci/dpAx/jF2AW3gJaECaBwZOF/5ETCZ9FdirHYKv33x
	 U7gOyRLVEP2Do15o/FcAhHtWlU3dnR0kX7lkY1um3z0PC+A3HzGz5viXIQA6+JjtM
	 Cc0N1KgovzJL4HpVTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1sDHfO0MTO-00Wnc6; Sat, 27
 Apr 2024 11:11:48 +0200
Message-ID: <d1ff7c50-7810-45ef-b31b-9189348fa09b@web.de>
Date: Sat, 27 Apr 2024 11:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LuMingYin <lumingyindetect@126.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240427072347.1421053-1-lumingyindetect@126.com>
Subject: Re: [PATCH v3] tracing/probes: Fix memory leak in
 traceprobe_parse_probe_arg_body()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240427072347.1421053-1-lumingyindetect@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3aCTPfz1dpBnXB33+rL9kND9c3ORiQ5rZM12p8HdfHGENMgrPv+
 Z+QTZVXdS+wyF1fOSJWBNa2GB/sHSPH/0fb0bBcwLdrYAYo1LsBxxoHByC+Ojl6tWNwz3ta
 QEnqarjVscY5IRkqY072mGY9mYTSGDgxtDmnCfDdkwQ84HfYyV5hxFUQ6e9T+cEBa5LMfJ1
 BStiO9P/ZyoXKLky245yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w7Cxg2AAj9I=;MwCHZFhO6hZnCo+5SjFy+Grky69
 zp4OIak+X7dizzbj1m1mbD1CUlCo6ZqGbnsG9ama6+Pf56jZFiF3T37cqPFqsvmfqou51UCvp
 J5ymLWIATymIUwb6JtMGyb9uHPxwJ9Twp6VqIVUVnbShFpo3jk/2/VinPzQ2+NzDA68RSyuEK
 UQ2l10Rba3x7lqOZFpXMDqG9vlAxjF62pqlg8hAzguwHG5CQNKYIIKQYf9opCtUYREsLIZaVQ
 ty9zGLC93kSX1E8vutKnhwzh+WW/wjj2revIx7Kf+8qthbCj3ypP6PC5N4yeSVSPheWmahQ7x
 D1sN8hzkCmT8ShibGD2NNWAdbB9JLPJVJtjuqcH3eUzvtH7u15duTnsrfLdbEAjCditN9kHNW
 rJezN9qa+mrqXqGh/I+XvnSjHmYks7kxJCYLQMP4yxZMx8N+/17vE4RWgi60RVjBwYXODl609
 KU72gX5MSH7PFfdbHCWxx9uhHmEUUhAU0PNC1hfrmkb6yuIm5XHsItTsr38EIEA4pqenYF/dH
 8LOWOquyMGiAeAU2iJ/r3Im1Q4n9M7xrQKd/QggCOeUFf8bgOCY2kjrmbtfLwUlkEeSPQ8lkC
 swE9PZjFcaR4OJALxRQwRcbUJ1pQje5Ub3Uy9mctMHb+ax7Aul8YfYQOnd7G1RaEeeVWcN4yv
 Qcej+hpbvr93zbOrzVAGz3HKWiwSISlYgoncD70jJCBIDC35Bt3tVdJ3nsPdyXaAVGg/1EJ+h
 X1ONviOAae0Zc2rwmlE6MoglMXvw3WHWuC3qjCGx2Fc+CqmEDvPgfgr/1Z2GNUqMABo4hxMRo
 QpqD9UzJHsllNJ2i8kOeSZovJNaSGR58eSNYX8qN7O0ds=

>                                             =E2=80=A6 by mistake.In the =
result,
=E2=80=A6

I propose once more to start the second sentence of this change descriptio=
n
on a subsequent line.

> ---
> kernel/trace/trace_probe.c | 2 +-
=E2=80=A6

Unfortunately, you overlooked to add patch version descriptions behind the=
 marker line.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n713

Regards,
Markus

