Return-Path: <linux-kernel+bounces-2143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C675F815887
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B8E1F25A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65A14A91;
	Sat, 16 Dec 2023 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JIQ5jIFq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234E1427B;
	Sat, 16 Dec 2023 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702718778; x=1703323578; i=wahrenst@gmx.net;
	bh=gfYciJ2AEdIgDiTmCWiWaoharmtLugzOfLflyfvVBs8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JIQ5jIFqeSpiAJOUhXiSZPVLYmjHCd0lkOXbkq3EznZ3CEc+RO9swyeUB6NdTILo
	 Xf1omLUsFd2pFtqUzeFNmeL+z6Sa5YEuCxE61SQiVQWhvplg87/82cQ8Yvp2VHELG
	 PSaDA4gK0ux6PoUyWpNeEz3JQSu85NhnieE3CoDmcYhUDlvE3fU8ZMyIUhGCAlkTk
	 In0RYrdN/JPklhQaQ2EiBeZX3JG4ah8HT5V3jKr4/kHTUWCVGd1ywUUuVHd8vd4Hw
	 br/c7XZ4OWLxsTbF1v+qEyHqRH6iGuJOpygGm64W5dlFb8VGRUBW0gsHhuAHnKjbB
	 iCQy0LP19Mp5Hvg3qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1rd0Er0RcB-00lGki; Sat, 16
 Dec 2023 10:26:18 +0100
Message-ID: <58b48448-2a6b-41bf-8b04-fdff3391aecd@gmx.net>
Date: Sat, 16 Dec 2023 10:26:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12 net-next] qca_spi: collection of improvements
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231214150944.55808-1-wahrenst@gmx.net>
 <20231215182518.081559ea@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231215182518.081559ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M2q3R/2uiIc6vknGORc7HkL4znYPM48XdZ3gipX/3ai/dYcfE5q
 MPTUnYV3kgIatWZf/KAoYC98ZuElgH1K9OrOrQhv7tTgu5cekXqzqmq9xcaW9XAyv+FmfAX
 goEQfifVjMlYB7+jChW4ujUe6AcyQvFYABT/ev6nG+zyCoAn2oaxtdh+1JKlOaMF9DoKKl0
 CwV96PMC00zOZXY4aBP4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6n220bydgKY=;dFzdhSai7pV06as8WXYsdnG7q/D
 rELGuywfF3LtHTpj0N66f66YUaOTB8j5uGnRX/l7+tpYRH6FQt2tRoruWQVl9huVAmrkPJ2En
 7BcEZZr/s3crYSlDALYSClaLKRXlJ4MG/r3/NFDBi65tLf64gdO5m7xTwghMd1Pj/UIOT4JyQ
 HOlv2qQr+9GO6HGK82PCCNfdmLd1rcviwM5dC2CbbE0tGwm6EMQ9IavtwKw9M2X40exjp+DMC
 /pk38VGli6Mkg7QXsBJ+ndzgHAzESUzFXvHcSRyi3sUPlMcB4e6LZepWMaC40qZa3JQa2e9hd
 c4vPNmrJdyIz2aJxoOvZTIqdoAeW0HVdfrRfot3Ts5/Lqkl0sWQDJFVrpcpENRomRl4TKwehx
 mk9Fk88mVo48q+mzpgUHhjE/GAbVo7BngYso46I1Cbeb4/Hod9SksgsNl79YSIxPXTu9tQ4oV
 sutIljBtgIgB7mm7xpLBniN+A1lrWJv9MoLJ6XKWddofrb6mrd1moZutX9GwjnLiuoaAlnqLj
 q7r/3a/VkaOehV5EjwcgYg47u0P+brant0NO18JktAkDyjLj1wsoqf3oVtSHENEBeIrZe6TQa
 q6k/VOoYbgVmsyFMadFWNo5TZlWH1h6MYgLjCVmzu/IGbU4TuNm15luePbXLYrGt/hJ/gIQ9Z
 oxAP68DUsAxJdrY5N3LG8PCVpDPQjadIpGySO3cE1kFZObJn7zqk/EqS/japNhM7HnlXVLkRc
 LTLj7DWfZ7VZzjsAFlJGLJ/0vxjNQ57fx6JTjtflDGQx9Gvvc1m8sxRcePmVgCZSDtafc+5oQ
 tqBw+LeCjWfLoXVBtVeZKqccOZSXPIaMpUm/NFCO2Y0xwu8Kx2Yp1XnwUVFcFRW7iryZ+lRP5
 LX78l+rCBzhGRTxm1V96uicyLZ2eOB6r5bLypcuAmHCq0i42Qhz9snEtlPDOj8Qtxv8dQqWBw
 5geu8Fz4CSUvQgANz5Xo/k0yo1g=

Hi Jakub,

Am 16.12.23 um 03:25 schrieb Jakub Kicinski:
> On Thu, 14 Dec 2023 16:09:32 +0100 Stefan Wahren wrote:
>> This series contains a wild collection of improvements for the
>> qca_spi driver. This is a follow-up series to the recent bugfixes.
> The fixes are now in net-next, and looks like this series
> no longer applied, please rebase & repost.
let me explain. This series shouldn't replace the already applied
bugfixes. Before i submitted the bugfix patches, i prepared all these
patches. Since the bugfixes had a much higher prio, i decided to split
my patches into a bugfix and improvement series. The bugfixes has been
applied and this series is the improvement part which based on current
net-next including the bugfix series. Sorry for not making this clear.
Patch 1 & 2 in this series is the initially intended rework, which is
also considered valuable by Paolo.

