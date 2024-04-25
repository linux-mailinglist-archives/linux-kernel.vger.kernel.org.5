Return-Path: <linux-kernel+bounces-158112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2928B1BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E713D1F25040
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6A6EB53;
	Thu, 25 Apr 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EM9lWjBC"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CB6D1AB;
	Thu, 25 Apr 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029557; cv=none; b=eXtVOz3iOrrMFn+c7eLPRBwuYwnufdKqE0QuqcxEbPx9y8J+BFN8020YZ/k6xJDXpgyz8i1Uf94G1wOUBHzYUG+mfUH1j0IwM3q1wnhFvmI3w3mbRtZ/N0R4tt0HXs8v95Au9KyZWahJYlmZTBz+wjnzWx4hbRQM6NBkZHVUpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029557; c=relaxed/simple;
	bh=CkiPK6tPqwTWT75wFXMOzJWbLEmZiPmM/GP+SAqz6Rg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ju2xhfyUQQcGVuDmFGQrZti2E9111CoSPDeBSK+uYaq3FmgWZv+yU9d44I1HgE7P9zjdwMEfr+niXvlnTr1iEOlwhmjGgMA38wJS3HX+brkTZF9FxkYPEtcR2Y1ymGQtFXkDcan8Y+N2Gddqv8BkN0k7OHeLTWxklBP2O+nmxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EM9lWjBC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714029523; x=1714634323; i=markus.elfring@web.de;
	bh=UG4sKAfbqH7myYcMHGqgIq6lkAMmjpUkaFC72KScITI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EM9lWjBCK2tncZmJ6ss0AUjKryv5ckQ3zFJmosZZMH0dV1Wve5jdAWECUt8b9fTZ
	 q/1YSuw2XxtIvH/At79iHCBSRXhwNIKqo05iESwcZVkb0xqai2OCRQ4IO2gWgOfLd
	 Aa+9WrK5QJMC2S4lPi7Hr+5FGjozkvSwVOHrI6MVKT4CJzLEvKbhngXwBYSaARbb4
	 5BKxXsPtXhNXwEKTvrRnW/SKrXcw2UVjArQ5wgUhRN2hxDrZfSzIcQ8Z3EOHraubR
	 SKW0MQY5y08aqi6HHZn4WGfdwHNnJf0aSXYUfxSu2cP0ufdiG0MrQeRnpwnCgUEq1
	 Oo3nyXh15FexYUh/EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvrs-1s8F613Vre-00RZYm; Thu, 25
 Apr 2024 09:18:43 +0200
Message-ID: <e68e09e0-75f3-43b8-b947-22cc0d1a0dae@web.de>
Date: Thu, 25 Apr 2024 09:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Song Gao <gaosong@loongson.cn>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240424091813.1471440-1-gaosong@loongson.cn>
Subject: Re: [PATCH v3] LoongArch: KVM: Add PMU support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424091813.1471440-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00Jnv0z4yJ3cAcza9B6oPnCQFtB1U6bhddC/nn2ON13kEk8asxJ
 A8n3AEZDTno08y/MUZOejQT3W3Q+sZtxhuInM0aWNc5MJZmvxS4DKqpgcM67HqJBeox83S5
 D+Wgj18GUmiAZXMg0vETLEYHuUqzA4HVDjZ2QaW3nSAemdEZwGAvUlxXggZ07IawQnWhfab
 c/GRv7IXWjghmnvzlJ7Qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:55oR3qD1Jro=;h76wbUubNa2cPLWxoDAUCdSVh/R
 HZV3wZCsGKlbF+GFp5NQCRx9PudSBVq/iBF/mM3cJoE5xK0+II0QYCUSdG9qmqkfdMoYSE2Ks
 /XyMF0mksHOwr0GZ/x0XE/F0HtyBl4ta9PpHyhjNvSLqIZHnFDcDGQTYAqI5x1d/CjYJkJnSF
 VJpWNLYfGweFqKTzftiIExPJ+Lbf2eswnEp+cfKL1YFX/BpL19MRsiNzfvD5oKoCNVf26jpmT
 jVf79c2H+93zqUmtRn8jbfGeLGOCRq6oT5o+31WCEZrIOjFMUtYZmhUWlkIk2RQKLR5CaIm69
 r33ionVKW56gbB4tHvLBTKMkFjceBGF773Fik1uTFCaIq4Zx0XzThgu1LV5kN5D6vLSnEgmEZ
 lkPLiR4pTqSWFtGod/ZA2tEAPwu/uGogFoPdnNITXIGmc/EcoHEbfnvdJ7PKx6yRc4hGza8+M
 OwqPN/5vLJiClKIOyNV6s9oJXTvWXG/c8hFwAlBr1Sli5f/Dmukb0eANOCzLq/3/JUuy/KBAG
 /EV+2vSh6be3MbUqdMld5hvo3kNUP9GyGZZWDW0Pf0eZlBNp90BxIzO0TDq528vwFPHpu64bB
 3lAf3xaST8iBcR2FlsZNk/+VddgupadL4Au5xTulx//fQvffUWJGc2ENX+xWWuRyYEkwuoDy6
 tpEWB/tRnomO1SzEmxcNiOnaElc4cXjG3Xcw2nhiuDV1GublthXK9qxg0cvpSYC9Pm1nDixLT
 vCJULBSOqdSqEAopNbqucg8s1uJeaRNWEaMH1QsTbnYiYH63uXVrG9auv1pOLSxRkV9t44/xo
 0NLbPw6EDuf/Kzs5/Tn2h4liqsOi0pHxlS3eUwLblQ1Zs=

=E2=80=A6
> On KVM side. we save the host PMU CSRs into structure kvm_context.
> If the host supports the PMU feature. When entering guest mode.
> we save the host PMU CSRs and restore the guest PMU CSRs.
=E2=80=A6

I suggest to reconsider the usage of a few dots in such a wording approach=
.


=E2=80=A6
Signed-off-by: Song Gao <gaosong@loongson.cn>

v2->V3:
=E2=80=A6

* Please put your version descriptions behind a marker line.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n713

* How do you think about to avoid the repetition of version identifiers he=
re?


Regards,
Markus

