Return-Path: <linux-kernel+bounces-162109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6BB8B5602
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A16EB21196
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2563BBFE;
	Mon, 29 Apr 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LDCCpnXM"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFA219F0;
	Mon, 29 Apr 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388813; cv=none; b=cVbhYz4bX0jaDJ0vjSBXGZi6zVX5XxEscS/5RH6Gsc3f5CN/PWSiktkLHsT+qr4fqyMy+EHcg2xxb8rVC/+FLx6mpH68Iu8vbdepb3WI9yw1scw9UGhT7VSnB2vvgMyP1HrGpB2ZvNl3AlIye83IJc/ohPIemS9aIXtiywjRogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388813; c=relaxed/simple;
	bh=3tEp9q/1yf7xpsJVCXvXPeASotv9K8cDx+uA5HvDVVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC325ki9MI4MkoKHIXOwYafgrci+uhhUtpllaaHv3eYy7KirR909WWcr7s8TeMkOg48hqynvgiS5RanMLrqU1u2hs9/7jTdZkaDSlIobkNa8DkGBQK1Md5wK8n4k0e/Pm9AouVLMDe1nfOjwHLRR26iFEwk/d+KYxQFQzP4YU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LDCCpnXM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714388775; x=1714993575; i=markus.elfring@web.de;
	bh=j7Jh2WN3fbBl/ho79XdKnwxS8so4WW729pW8a1BlAxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LDCCpnXMNqydr6o3IrrwNLKVVbfhuK941RwJOy4YGMI9UsgaJZrMT85N8hiWGzUr
	 JNREVMQ7sqnWeYMN0kVf6BQg0iBJwuDoOijG9N4vXP1I5RhpA8ah17UKu4DWB+yg3
	 UT6GKrZLRHIYnYyDQpu5zDVr4Sje+4yRotKHX04PDblavKAV1hdayo+qTy5GLdFcq
	 PxCrZ5Wx9TnyRBkZTYBYzlPQZ3AFxxmQY+3THnj77KipnMBWg+QC4JT6ZpsI1382o
	 KgXDmybS/BZyA7Pre3vu+wisYw3U+iT5hWNqCvhpZmNn/Z3v3wVxbvVIWUp+fCNcW
	 sAYXQuv6E1yRPf/klg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1sCp2f0HLS-00WcWc; Mon, 29
 Apr 2024 13:06:15 +0200
Message-ID: <fc50313c-8f76-4f7c-a133-a75dc9f1fe1d@web.de>
Date: Mon, 29 Apr 2024 13:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] LoongArch: KVM: Add PMU support
To: Song Gao <gaosong@loongson.cn>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240429093401.2612430-1-gaosong@loongson.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429093401.2612430-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sL+ukFwoO7kLQzP5s3Yi3g6zcnIUBFqGchFmEorF0lNkazt1bnF
 j9S5bXu+auFMZBuQy+vRzioGxzTJ+RCiFPO3+ywVqhRhbtN/RrBkRp+qt3wRHX2+2jbqUrj
 5MMy5JhV8W7TiGURvyEm7TnKlHiFr6d5SvW4qNtBz+Z7Qqor6R35AC9pUs9n4g7Z8DUuCcQ
 9KHShxUY43m+KMxW4dwlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hVQyejERArM=;PEyuS8MnGoX8blCUw1HY9psEe95
 ucHx47L3GsCPkxaQcBNYXl59nVOMHpIyEwlKs1Wdm04e2LOag1k10lYHffHx7JZ5qRHa5H87O
 xo+GsWyBblebXeKfdE4bjnIDlrKCpGroZzzs4H5k4MMAN3QSVLLKxBpjyp859xXnMlR0XPrCG
 iC0koX8E928LNADPajNp9xSxDgKnqmIrLYiH80fMeLqJykkD5AqSefycGh4bxy0J59l396dmZ
 fi5Au2+DY5izmoKrTT133J/0enJjEjYeYTY8fJ/tpM2rSAcE2eNYBbHjoynVsLlAtQrhnEZBv
 oXyLvsgqUVw2prka7wAAdZxscQ2uDbAMAlgvkdxcGX7quEqVLlwScV9ioA7T5Mfq9+upxWXJS
 csDp6VxmQAxA8lSLY37g7BrOPCO1og/KicpsI7DxkNKVVDYxeVQIReV9DNPZYKpvKx+NRI8ub
 BmdRZw9djWbB78obijWiFygQN6UULVJ8xuc6KSENrKnwaPHHpyXLxpfby2UY7/z2Vd01biJeo
 UlpQXcxhOg1XzGocFseZH19YTbC2n1afdQYLYtmi0SO2A9IVOK5nC+/ddfTuTRu+ry8x1eHbS
 2AQSjMkVMcydr3NSqn1g2++onqe0f2nO2W7KIfl1xLzidVy+vEJyRsrqWAl5YnAs1GI4lCcaT
 ZkLzNUi7wVF/BCqEWcnD+E/Fl773LnIto0CrHsD79PmH8bEt1WDgG2pgTu81Zp0XKf2965PsH
 vmbA6WpgxlpLJdSz0aKoc1TVKIYiTCaaxpnf3gxBN66OkWyIMyYXbXwW7UYDaVSwj1pIzBd85
 JAHKJbs1f/eO+8JD/vD/KB7gUTNUXBIc8Z8ESxgC9aHjo=

=E2=80=A6
> On KVM side. we save the host PMU CSRs into structure kvm_context.
> If the host supports the PMU feature. When entering guest mode.
> we save the host PMU CSRs and restore the guest PMU CSRs. When exiting
> guest mode, we save the guest PMU CSRs and restore the host PMU CSRs.
=E2=80=A6

I suggest to reconsider the usage of a few dots in such a wording approach
once more.


>   - Link to V1: https://lore.kernel.org/all/20240410095812.2943706-1-gao=
song@loongson.cn/
>
> ---

You may omit a duplicate marker line.

Regards,
Markus

