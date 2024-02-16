Return-Path: <linux-kernel+bounces-68556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80E857C49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC3C2845A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3367868E;
	Fri, 16 Feb 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JtIcpkoQ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0754F9F;
	Fri, 16 Feb 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085055; cv=none; b=KfiYZ6pOtfiFTIZwnGkL4/Ce7ph0A3PLh1QVaPP+8YFrH0fSfD2kwCTbDPXOzyoFE8a/E8v8amXm3Ff75ZwapOVcCFA0ZkbcUMC2AF8xH4G03N6D79+2siTI5QCwznuYAdjAwYfG3uhG3JdwnXVM9lO5ydqrI8KCqdfKcuuCam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085055; c=relaxed/simple;
	bh=txhQp0jogdoMQ2L1WM7B/43LJL2QWlfyavzQEY/JY74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dqNhcMAIBkDycssgQjE1n99FwicXfmG12HB5TDnQ3eZnwn3baxr8iigM/1MNoR1RUeJL6JhXEdpCsFXI2qokrel97OOpqeKDLz/A+AyCJnqR+fUG6BYbjGrdJJxsTB1JhyBnHpCJVpfq48+Usn0x4tDOD4Dwi2LLSyYiIwQUXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JtIcpkoQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708085026; x=1708689826; i=markus.elfring@web.de;
	bh=txhQp0jogdoMQ2L1WM7B/43LJL2QWlfyavzQEY/JY74=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=JtIcpkoQZxGFlJ0IQOL97W7CuQay9aUKqPycYbs6uQRkTnSgBuHOM+Wa6idHAzRh
	 Nze5JgGNS2udVCNcaw/9Kyh9f6KjwHLIoIpKvQ9R2f3jPSCNttcxH9bT7WwQHNDIR
	 K1xoRTt2yQDI8+soLllF2qX0MU+Fg5+Tq1A3zY2spVk1euKgrv0gq5do5gbJEVGMO
	 WMRaeB96/Sl1kNjSEzAPr8uFTysUNhWV2aPA2/2tSW1cEuLLoPyU1jkOl3GVzTmXj
	 X6LPd45VHmXeP7auXy9/507o+BH1ZGKl84gd06DVJyz5+nV+EmGaaF0flHJ+CxtWm
	 nFNwPUTZ8gIayiNwXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1rYBmy0sby-002loV; Fri, 16
 Feb 2024 13:03:46 +0100
Message-ID: <62122744-7e88-4aa3-b9cf-82442021a7ee@web.de>
Date: Fri, 16 Feb 2024 13:03:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH v2] cocci: Add rules to find str_plural()
 replacements
Content-Language: en-GB
To: Kees Cook <keescook@chromium.org>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20240215194834.it.509-kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 linux-hardening@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240215194834.it.509-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D9mtTTzD8XRjj8XwO7mhylIMnIpadtQOenzv/X33J1JYqJb03k/
 ASyTFeVi4vMiWUZtCoYWzlKw/yTyYGFU/+tSa1T83EFba38fW9HtYwTMQvffze2lS9IB4HQ
 jsYbLSJ+wHikYjEIEDEsaFFBn2x55hozrXlvpiaBENmn8vLxBOuKXENb/E0IsVGGu4k2RQS
 ttJoeGvmO3n1jDnz2vfdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8xgo3VmYz+w=;FlPFNDyHCzlGUJiM10MhB47BzGj
 2ZBWwhJcYnppUsTo8B04HahvjicV9oO/yMLQNdayXmXMfkj2JDr1/xibYY8E8JdMojQVjqmi1
 hZRoE17E4kuO8SKqhdF6X5vXr01BaQo2hWBn8vXgt1jR18dadHmpSuUmdQsfrFdZWL3zFcd1D
 LTc53NcGdjqtJ+YZYGEOXmXoqQEOLKZhnUYekWUOY0ktQlejpyB0gq1dmqJHLinu2Fxm5756G
 lNzt+kZa0s4CY2RgPZMwMZeltuuwNKkvqWZtU0mV9NIRFAZ/9+Au6wz14Wb5PIJ1tMfaQ20zS
 UkNXjT7xWmxkbykE6hP7SfaZb+y5e4KyEU3h1O7pMHGwgvPwls536GgyFMHL99OZq0FYcexsV
 PPXcraLxUqCzGJvUZK4PVbc0ZpyjUhowIhsRSmxlDMWdmImSzKiOgMT8B+ExQ+55xAyb2Urew
 CpaG+spHqDhwNzAW/1G3mJlD8zDFf3NGWwUWrcIaktPp7SQ1kr7FVl13rvGYQGIW/RQtchKTL
 gscMLGaHPjtwVJuDOx0B+/GQ6N57na+IGeRUsxQQLMPAevLkbILgfrIE7lnPCHa/JU0BTPHFW
 x0Xr7qwn69MLxDzmqgNNymAa9gXgukj+PrnemiPd90bGLmVNeqwYZoQwHNrW3ZJflv0usPoP4
 kmY6TbyTLH9nFtQfGBeUKSTVboHWz0JaPt8WQBY/A1rD5dM8cKFKK6DXyTaDxNZvu5ZOhbOwz
 qqEwCeZEdtaVT/erUcwbAJGeRuaM3mx5BcivkONa7tRIXxwFFlILwQhwLICL4Iaw9d2dGfA0q
 0SvGk8XXB9J5LS4vedoTam7ZyBbVODSV12nC6T5rklJdw=

> Add rules for finding places where str_plural() can be used.
=E2=80=A6
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -0,0 +1,41 @@
=E2=80=A6
> +/// Find places to use string_choices.h's various helpers.
> +//
> +// Confidence: Medium
> +// Options: --no-includes --include-headers
> +virtual patch
> +virtual context
> +virtual report

Would you like to support another operation mode?

virtual context, patch, report, org

Regards,
Markus

