Return-Path: <linux-kernel+bounces-91027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6D87089E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B0D1C221AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C516214E;
	Mon,  4 Mar 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CflVt1jW"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94590612FF;
	Mon,  4 Mar 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574607; cv=none; b=uBl0Mp5qot0b3l7PO+fAFSoSZA2X6Z4JRKEax7xk1uGXyJZqRksMOk+M7WaMvOFhdw/8PPMyRzc7wLPLeTjRYRMDU220ggzGn9qQPTrKGUmBgKpgKU6XbgmIapEel6VNas/1wTdIutRmughk5KssHptIPXbFxi+nuCUu+168lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574607; c=relaxed/simple;
	bh=7K3bP1+oTQ+p1gZWNk1OVZkWGD2ZtvOsntwZZ5+E8kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odWbaUQJyRP4GVAlgzeEOA7bYTMg12MYYzWjSht0MuEbm8S40ys1TiZRX12gyRzf+3HyDERsdb6o6nfyTDlLfra9fSOm+o+bW/TAx0iMLrLY71ZWmVZGXLb1SEUG/K3EpbQp3Y/Rd4yKBOgsjKm6OmMJrSZTIZF81bGfTBdaw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CflVt1jW; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709574554; x=1710179354; i=markus.elfring@web.de;
	bh=7K3bP1+oTQ+p1gZWNk1OVZkWGD2ZtvOsntwZZ5+E8kw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=CflVt1jWgMV6mfTL5qSrUp61G3mhxbyohnpj2KyHsZv3/puovr5NygeyA6ACfBQd
	 mvP5K8Sk7muKGyMRb8hUwg6Skamz/liyXcBOQqXrKPtlTlBGpOnqaFPIc/joZ+mrD
	 +h28OH3fAFq0Ltsm5qYcrxhjwl+zXEm18jXeVFNFrx8zHzUEX3JjqCzvpbY5SUflE
	 0Simsc2SRZHJjrPhnmnn7dwxpM3mqWwEG6h/U3p+sBLH1ehoqZeBFyk6uY1CG8KDW
	 lYeOzlfw2yDaFwMB7204MSG6z5QjIbLuKkFe9Xz1jgyXkvksg/+YkXTNh0Yiukhku
	 neqQ4dB47fvFYfis9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1rdfnh1i2R-00HCYi; Mon, 04
 Mar 2024 18:49:14 +0100
Message-ID: <ea3b033a-7a50-4276-9839-f6335b754c30@web.de>
Date: Mon, 4 Mar 2024 18:48:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] Input: iqs269a - Use scope-based resource management in
 iqs269_parse_chan()
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>, LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
 <ZeT6UUFNq1ujMW17@google.com> <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
 <ZeYAk830OUpaup5W@nixie71> <ZeYBTUQRAp2u3bXX@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZeYBTUQRAp2u3bXX@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W4V1XEZEso69HFCLMu/ebTwwAh/2Q6Ps1nvxXQYecLV4Ex4Y4tq
 Zf83KIuZFNK7Owqdj48cyayM67viuzP62V4soZSVINueMLayTAwkRLM91eh5Qmk98JNCdi6
 OOqY5dyy0oEsjQPDOVcl0PBbiVzyXw/10vcifUnJxXYoIp/NYbXPjiyrpHeB/HggtHc6KaF
 cCYNMJ6RbXPfgw4yGJ0EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PKqMxeqTb/s=;xhcINlzZEoVtVbkCJ5JeDg5kP6h
 KU9RJoGyHBHBHTnGrX6Mjs9P94H5vTapipJRq14O2WtFN/irotdXmULfASsnimS6WWsVuO+Bc
 AH0lUuB4FvdfNmaqyvB3dXZO3Y5NB1gNYfEpLIAeoel7fl0bNNWvxH8xGsiQcFJ4yTGs9OfuI
 vIe49oTQoUXrjDgIjoWqbSDFtb4U3EgxX8panHo0OZDkIEwVsqzleDiBtoBE2XzIMUAVeTBoL
 VXX9qM26hw2RBM+WPjBwV2EwWa8ZKVP1lHaZTv/0OX1tAqwyqRPJPX1nGY0Vbh34y2jiuvpb+
 vmNsTzF2OZHkBR6FKZjtkv28jMcIMR7owa2jg32HGvn/xIuBwkojO14vE+HP0fAA0A1tpv+lu
 HaZ1dExdoJmtrrREucwIz8K7GGaoLlLNMAL08or0DFWMaRuXafBrlpwbdtF259ePy4hPPBPat
 f1eniLxKcpmwhAqOOINSiUwsetp38FiSoyDO1wbB9xUJfqlIuOigeniInQafapP4T64effSxB
 nEEylcJml141mA3bTm1VU+9R/WjEyZXE66a3e1JXTvdAXqxV7rwHmZm6x6FpLWIiYtswuawJc
 IIpLCoPEi75CDAAiVnR+/CX+bR8C40ia0tTZNvDP+dCc7MLCQ3EwlTMiO7eVywLQw4KRnNmm/
 ckNmYCho2qttMnoBHoS9fNYRfpED3ma622ZpiIWyNxysdm+/QkzKnJ6GT5BaMuYYN7+rY0dqs
 8aS4SvDIi8wvHba/d5vKBmBgYWwsjx4lCQZjfk/xDeCx8mgide6xtQ/ybrsYYWyTcahYrcQ9w
 0CGup+Lxhs0q1sHNL/dF9fw1quFn7DiPrkW9nHPEJYuAE=

> The extra curly braces are absolutely not needed. The for loop's body
> already defines scope, __cleanup()s should be called at the end of the b=
ody.

I present an other development opinion here.
I got the impression that the required scope should be smaller for
the adjusted local variable =E2=80=9Cev_node=E2=80=9D (according to the pr=
evious function implementation).

Otherwise:
How do you think about to move any source code part from the loop
into a separate function?

Regards,
Markus

