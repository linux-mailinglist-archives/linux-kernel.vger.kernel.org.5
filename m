Return-Path: <linux-kernel+bounces-22132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9658299CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C7284989
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA34A98C;
	Wed, 10 Jan 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u3oXSrGq"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E6482E0;
	Wed, 10 Jan 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887119; x=1705491919; i=markus.elfring@web.de;
	bh=nO4zB4EcAAo5LoPaa+ofqegpVkTeHLcDqcmcZocT6mE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=u3oXSrGqMkqB+Fz860SVm583IZDXAo82TtA0+q3MKm1sp7Mpsy9OFLh8bwjc+rdU
	 vUHT7wYN/O+gZVn0C4ndzUf7VLdiM/Ix6VM9O5H9juPlV+oKS4unydvUvtMaj1b9U
	 ZfF1tVzlhYCdvpAefQTkDBunWeu8mwX59g2tlURm8c0NC4qI+8uQ6bCZNP+vBIRSs
	 1prbm19eGB4HkxhOl2oYlVtIcg57OZVeLLaOJiot544mB0HxiyPoSeoOBcHcoNLgr
	 5E4zTa5pUaUxL7N7r+oHTEWK2EbQBemOWcJePTYZCRktkGiCAxCHig+NfPCJbOOtS
	 mskQwOQuFBtMhTFz9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1r0O0B1QA8-00wcIt; Wed, 10
 Jan 2024 12:45:19 +0100
Message-ID: <30a0618f-e115-47a5-89a9-3806c75e604d@web.de>
Date: Wed, 10 Jan 2024 12:45:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf/x86/intel/pt: Adjustments for pt_pmu_hw_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
In-Reply-To: <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9BlZaD60AkKnVzOB54qG8EG/JliLvKzC6Ve1nFkUHR+QCcwGiDZ
 zcVrGWtqV2ap3b9QBhbk+w+quJBKOx/wP73RnVZ6RfU+Ezt/KQWnTJSlEBG6pU6qMXBEQIW
 FAcN1pdTlCdE7AzUOjIBFh18XJU2FlI5M4YXR8Cv/sY5o8VIsW/kyr3L+hmTX3YQw2tpyYK
 aQtS0ZIZxbLHWlJGvquTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O9VFBO7l3do=;GBZDJI70NujW61S/P9XwBCmdHbu
 2bRvmHWf0e0fDratRYKhLsLtTYSwpU8BmXRn7aw9ZbqFEbU2YwOmeOhPyrKoo7tf1gyCrQiDz
 Q2+mFaqsWflYmyAh6qx6hCr6OIfphmokWLPTgYXBrTUqQLzYzw0EgUjlJ2Wtn4EgjvmoI5xBI
 +S/PzvsvyfgTgWBI54KZjd+njBhKy4PQzM2vYwPq3fD9oCcCidLJxLB0PTOk0SfLU6dXQJHjw
 mTtWuyB6fUTUByJsWKLyNkJwOA+HfQuESpeBk6gcrH0pX3CosBYsWrRYOsqjd4y/kELaf/u1A
 nk1IXegYvWcEWxwIzJ2UeBJ1AUB4t/KE6W5B0DbWaq+A/NHcfTRzSJdsS0kR0XZC7h4Xc/fhe
 8pwLnE6JwIRNMHaoACPvntPUSOa+x9pavCXASzqy/+1qsJqPvCG6fB74MaOh3+XNSXlRQxehK
 CQgmrrkMHRrrjdzgeBsbEbh+bqtk7FMRrbGsyR+QXz3JiaK0i/XECay8dFA07eFiR6byODpAq
 orrleJmZw0NuVd7qXdKKgseNzZASQn9RDTfehn2DNbvzcYij+W2KykM8vBAW0J/wdxYGF7iUE
 mkdpmWQwQkNyDzO1/SQ8EAjauyDABOOpqXYPHWMPnkgG0NgCtlt1S5fWWXYYlRIN6VLe5mtQ3
 XTQzWNEadVSJ496aZg51Spho7CA6zSocsD7P5LVCYG9uorJ2sKvnzoZ71aXJMLadEq52c7CHS
 7GhN8wJcuGFAVmcgsh6ZZ/t+L6UvF09EDZxKyVoF2YnQ5yaqeljXtzpO8+Cojr//G6kZtv+Ec
 e82DgdtpvjdPolEK7jZP74n27r8S2BVZgCEzHZiju7xBDxU2H8WVPoXhWOmLcV5+8t02DPM83
 KnETeZdLHyJ9CJvgOhaSZ5msYOYy+0w5eNsEP13uYFW+SkxSxx97++UMAlvmo09eRvrwXCh0G
 WjMMnqAB7iy8HCHBUAbT/pEiFNc=

> Date: Tue, 28 Mar 2023 20:34:32 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Use -ENOMEM directly for a return statement
>   Return directly after a failed kzalloc()
>
>  arch/x86/events/intel/pt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/d9c673f9-2c32-282f-f261-b4d5762409bb@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00101.html

Regards,
Markus

