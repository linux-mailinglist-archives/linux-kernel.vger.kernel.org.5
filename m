Return-Path: <linux-kernel+bounces-48682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EE845FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1927E2966CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93963064;
	Thu,  1 Feb 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uksK0Oo3"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1212FB03;
	Thu,  1 Feb 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811759; cv=none; b=lDFMN0ch5kYe9PJQxrGHKfEVeZRP3kGJ4qyrQXnTuQkY0U3Sg2IvLcHO2c2iAGjbgzPyb9fpPuiCBqQSwA4SMG4FbPwo8nbbJdAD/KMpzEEjUB1eRYE0FTuUAQNhW9AVJY3O7+6PHcJicreaFuzJrhKzbRqZLQgbgTLjqwDFeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811759; c=relaxed/simple;
	bh=75P+PiyZ7hmvzVmev6Os4atfaZaMVdujAHmGyUGpB8Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Vfus2NmLVMhp99yqGRu9cbDBE5dKb+XXqe0PvVNnNMOsBf/kSLz8mOsvdRXIGxk+KVSGtywptDokKb9o5XWk+ivXa57BhwyL+wz/FfZ+Ur/6vgtpp2NQV2150HdNOJXYDrX5BAFVM18IJA8HM5jrn7SQHHxA6KjGF6SINxRkIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uksK0Oo3; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706811716; x=1707416516; i=markus.elfring@web.de;
	bh=75P+PiyZ7hmvzVmev6Os4atfaZaMVdujAHmGyUGpB8Y=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=uksK0Oo3yuVjhH4hfyACu1PJdt+2P+7Lms9PpsWfq0leDSgF5uVVH7SuSvzLC4xi
	 tDEGLdnV1Hizx/ksx17X4idOFueLUQp0BgSiO4p0smMMpz4RGqv5t0ipQUKJ+lxf5
	 lYZx9NHu0mR+6BkG2k9qGuydLg0WvJ+jD8xkI75AMiiRzKV33NmedfySJaqjq6rAN
	 MVWbKZIAG7uBUhzjvmuUtqHUEeUxSwTOe9d5mKOtQyfWxS1VkYRagg/jCTIMw5zLw
	 5lwNeuKPj2RtFISaXCJIDsZUwCexGBlTqMb63VUss2s8b3En2BRagnLVfTeCjdPUN
	 xlMWm2UIAIROdfq7DA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1rME2o0Vdq-009f7d; Thu, 01
 Feb 2024 19:21:56 +0100
Message-ID: <f15f0df1-92be-4bc9-82a2-1d8fa3275dd7@web.de>
Date: Thu, 1 Feb 2024 19:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] perf: Reconsider an error code selection in bpf_map__fprintf()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cmkOoJ6w0GHniCFLXbNn4qAMPHQQID28NOsh0VbKnt7oG2/4vLY
 N3LSphl5OJ7CYzzBrSPJHzxyk4TbrukdvwhAK1dO3AJRFqwxZ3BeqvE8tQzOyq1lZPzXmNu
 OLARulhDKN0GqoMS6cBGdnj3Cdpib4Dwdl4BezGOOvgUo6UPvh5T+9hsAcmIwaIPAOMIfKv
 CRLkAmBjEFdLsEKk3imOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R/WYptCQz68=;Af7l6S2LLeGwo2+U+rjah1l8f+D
 tU7jQ/yUuY0bVzzQk/a4ndgouHE+8utWOXYL4aDt4GQplhqtqnU4nQKOiYh/5rCbacfYm4gc2
 IzDol4D9leBFHe0/tWopNyHGHcxx6vAS0HPEpPI8MZSkBIo3ZNUNVxVmi+u/jTaQBhoqLMJ+N
 sLSnVmTI3I3powb2d9GN12qnUDGuwsLnvnsQp6myEPZdrIz+AMD4X/mziPqumh1FBc0YgeS4q
 5wSoN4mbgmab2WrmmCaskpSwQLgVY5H6/Gh+TWyqarew8jAQqDX+OeO9Td6tWyCcPXV6tsogb
 qIwqWTtPS2HfOCW4OeU1mXGOusethmW94aKnEYgS/nHwjMlvZLzvsQGR1FYrGHz4DH1j0k8FU
 L6M84isgd1WNHzH/ix7XRQildp2t0+IjRiyt4QD8ora9HockRpFtaMhLDli3PG/qQ0V/yJtz8
 Ob5I0HEe03VGoRX/EFV6SLm3KIVqkou1KIscS8iZF9Omj1ALHJykIGq+aey8CS1fKRq+WDcGf
 cGy0vqbbkPU9uIEv1jkegAXDy/AK5IffWP/xzgjnNHalTxLO9Un4PA5He5VNjC++NwO/swaFw
 paXdR4g8DRUjPROJyeau8dh/rotsfoPlHdv0V6yVzCg6mBOvqGaKJ2eGBCWfRx5rZW6kk4mWi
 zdttA/99o2u4ghPhRM8nF/OOEiHORYFr9wFb37YOCSwnvNgu4CR5NyfxtBP+6aAwt7l3sLumc
 LzFt7fjb9ddgp0XuEyeZA+Egacp8l8XuANOqH9zk1Y9lV/lPFmi7/X4W34iHrBVMjaBAXeChd
 Ne4Pm+i5ALojTKuXTVZ87vFU7u6hrzhZDgsgamlGkB6qM=

Hello,

A null pointer check is performed for the input parameter =E2=80=9Cmap=E2=
=80=9D.
It looks suspicious that the function =E2=80=9CPTR_ERR=E2=80=9D is applied=
 then for
a corresponding return statement.
https://elixir.bootlin.com/linux/v6.8-rc2/source/tools/perf/util/bpf_map.c=
#L29
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/to=
ols/perf/util/bpf_map.c?h=3Dv6.8-rc2&id=3D41bccc98fb7931d63d03f326a746ac4d=
429c1dd3#n29

This issue was detected by using the Coccinelle software.

Would any other error code determination be more appropriate here?

Regards,
Markus

