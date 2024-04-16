Return-Path: <linux-kernel+bounces-147191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F48A70C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C5E1C21560
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF6136E0C;
	Tue, 16 Apr 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PqsFQpc8"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D313698D;
	Tue, 16 Apr 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283099; cv=none; b=DhH2NdzD+y/Uryn0bwb8REObzmx+03pTe/fX3cPJKIlq3ALpC/52EFfhrNcf4whR1rHkb7JrOMQ98jsk5JHugCftX23mo8zQzleZZ1ipDF+6hwM+zyFvsJkrbgNE2uLaEfWNYmVa4V/huaEDCAtlIconPatADvelX2YPdghnwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283099; c=relaxed/simple;
	bh=nllEtvvs6NqH5k5GLLTv3RLRUZlAuaXj2VxYKEvp3tQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dvHtkXYKRwMpdob7SfRgd0Bzdg2qPP7Pe+XGeGX7t4f1pPDPqGWsXgaGnMLppBwoV4WfKYRJo0A3hXcbwdlPn2QyxY4O0fb+n1zW5BouAVmY2gqxWc9UP+y+8xF6yolxEIs/Jh268DC976iwTeO4PecoBG7U2H6fuQxiLRsbaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PqsFQpc8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713283065; x=1713887865; i=markus.elfring@web.de;
	bh=nllEtvvs6NqH5k5GLLTv3RLRUZlAuaXj2VxYKEvp3tQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PqsFQpc86gZnr20gXM0/CJH7lVBimxXIBRX8EskPX++2UUrD8+/3lDvtgYLPahLk
	 FIF6KdHEOTrUTt9+UR0SUWv883QxV3d2STeApsWdWfG2mS0IwP+NxEUWKAzs9B+IE
	 9IX3JTP+5+NEYn6VTfiwX4u1uRl+0845Rixknl+wNbnfA4CTq7sC0QQWOf40q3cdt
	 ti0qNhF9FiEiJp9r8PrmDziND6XYHrQtIf6YC1399lFHisgsAVeuejkSZvFbnk1RR
	 gbCApXWzzotEOwg/v5c/JQiuUcTV4IOhrv6+6fw/w9aPOItUbe8Qb8gAAU49BIbCJ
	 IaIT61ZxYTQ5g/hEmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnvf-1sCUca0uxV-00K5DT; Tue, 16
 Apr 2024 17:57:45 +0200
Message-ID: <bf870914-3845-4d2a-b7cf-d7f9ef28e0b9@web.de>
Date: Tue, 16 Apr 2024 17:57:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zheng Yejian <zhengyejian1@huawei.com>,
 linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240416112459.1444612-1-zhengyejian1@huawei.com>
Subject: Re: [PATCH v2] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240416112459.1444612-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FFYeLD5kLXfbghX3LoP20kT5Jkoa52aNgyc4iVwSdKGw/0O7uyU
 qwv41NCR+Leot8428I/N1AGO/pXqoDpGaGutf3arxyq2WNvT//+LZxsdqEHovX0tzgxaM4t
 JGUclvFoGfsardn6fRzjqkh1Vj55sv0iYc1pXSEbWgqvFVd8ePKsMxbMomBQEx1ArU9vk0B
 Wluy8K0lUz00e6SMe4rJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1fbYECY+dng=;+1DYhBjlCdbR2Vf5//lqiN4Yw3R
 gNcEV/8sH0uXm44607oje8/jq9JLdXYw4Xe95o1zObM+k+7+0qaztqAGjgIychDdbU3x22SVo
 irESF06Lp4g/5+5RNK79CExkXtcXgZcUezK/62FDoRmI6d2W0J9QQRXKYta7wYbiqWZ3oSlYl
 FAzozpHm5bOnkhUGgZ1Un2yBujACqHbvhXSqY5UOLyF3oszp8PGdxj+F6+bx1Vr7jPzcdeNyi
 npHhH2KIHpfwCujIDx+uLJdAvPWLleA35IhjlydlWNBzl4UtY39BBT63gTUfV49Ir+9AgY9j9
 9UgG+hI3AjoBGjc3keSsS7a8xhmxT2ZJ3yut5gI6Rr1TzeSqm/n1Sk4/weli/ujGgMokrd1kc
 XscO/DNqhvXHSKRyQdcwjdA0Ww/DYPZE4k9hba/0H6uPf+1VMF41XZugCHLMFq1Q4moxoDcAl
 HGGY+KAdh73GUDeadhB9smvRhMBpg8S5yXCEXnzu+QFMh+BJEcWQL+TFpWVL3Moz2b9pFYP+n
 KaMBJYrRmHcOcBW6+GT1slz0ze0vr6ThTvykO6y/welS9yT2kM2T2H3tQKGhC3qW3r28xweYl
 2VQAJi/deb+TRNcURXJJ7vVbywo/tDW53wI4wN+3C90/eV9mr3GhceMNU4NY/FsnnX+ucXlqk
 ADGb+GVVmq5KAvcSfMzAcTgMsT6KHoBxQmlPwxYc6l3tJH6D6AXuI0Yc0EH927vWLIqFO/ubb
 B2ug/kiuhb3HjPxAYMyVs9WMjHk+fJ0rs9qxo0UNdeUx1/5h2WHuwLN5toOGr2GmJLuygsTr9
 G0f+3yWUUE0x99PN+ETGwDaTfYddLkaVplER19FeRlQQs=

=E2=80=A6
> To fix it, we hold rcu lock as lookuping ftrace record, and call
> synchronize_rcu() before freeing any ftrace pages.

I suggest to convert this description into an imperative wording.

Regards,
Markus

