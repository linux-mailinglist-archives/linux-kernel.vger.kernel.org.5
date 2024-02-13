Return-Path: <linux-kernel+bounces-63165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD131852BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B1DB24F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8262260B;
	Tue, 13 Feb 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ffnhq5ea"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310D22625;
	Tue, 13 Feb 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814656; cv=none; b=BV8e8zMlHZGApCno39zCVjVAFc2NSYWRH+vw7ORwwOk1+jg1UmEXNmRbv+yORILXqsQOZ3hVZrNvmM55WcjReRotIJXJtj4s+/oDzJCQiiWwfcv/JfzfRJqa7qig3IxYH7TOfzUB4EjchktU8x/sDycdVq6xR8y5obAxuQAzQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814656; c=relaxed/simple;
	bh=8hcEDI+1fFHAzHnAO9Tad+flYn4kPs+ybb5BLAKvRlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myPWVLuzNzN8XXbtyr+3TKrXwzCpt8QCFDvbltRZ5u5zekrkXZLi0Vv4TK+pvx0YN9mb+Dul2cQxxDorDX//We1U9gkAAV9tg2PQq5Fph4P7AFJLF+RfitwcL88v7TmOcIikOof7nUKqKil7F+b8Px3+hoZRFtmPsAYvfoimKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ffnhq5ea; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707814642; x=1708419442; i=wahrenst@gmx.net;
	bh=8hcEDI+1fFHAzHnAO9Tad+flYn4kPs+ybb5BLAKvRlc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ffnhq5eaTjVfDJ+24RJY8pSezOCcfem7ev3VTXABvMFUlAoIM+T13Nb8w/fuVxUm
	 /RrqbyltUiSM/gypeQq1lBsF8HMtBosCdz+f02xqXE1Mo/Qu7t0yCIuenQCx7Vub2
	 RNdoDZBcWWDx2W7XPvFzgPS+RS6y+Knw1iyIyGSwNiDgd+KkQNnaMAwe8wXzH9fV2
	 ac7bcTkleUgx38kKw1+DIg8KcJHr/3va/JtwjARljokp3k5+KeEy564mJif/fBHef
	 oisrJFcqVhHY/yCJv8enEcwPmkO5vv+1YxhFGfXa2lt69San3nb6XdCiQSDZRh1qV
	 k9SKR2Jv4sEAX8DiVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1rLsLi3odn-00MstZ; Tue, 13
 Feb 2024 09:57:22 +0100
Message-ID: <d50150e4-79d7-4f1c-b221-a0503e6a0899@gmx.net>
Date: Tue, 13 Feb 2024 09:57:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] dt-bindings: lcdif: Do not require power-domains
 for i.MX6ULL
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-8-sre@kernel.org>
 <a8b55331-a8c3-457e-83e0-2aa361ed23c6@gmx.net>
 <khwsxrpj5fgxl7ukiur2tdyy7a6d6h6zryc5z2h7o6f7k3b32p@cjqsmdbocfpe>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <khwsxrpj5fgxl7ukiur2tdyy7a6d6h6zryc5z2h7o6f7k3b32p@cjqsmdbocfpe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L76oI2eGAIugc0iZ9AyZhLxWiz0qcSr63A98X9bSTQkO2dY5s0R
 Xyh110e2ZmkKC9DKQ3JgdNwFkI0LGqnwRH40dVC78K8IgOOOFwySbPz9t/H9W0O5boXO3QP
 kBZh+zCvymePZnsuy/CFgE9yrsI+UgYt7Tbt0iF2ivq9OTapAa2duBnUekE4GxGVHvRuxgz
 b4v1y35XORDdeECHRKmxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:upZr6uS7dWI=;oN9M6RraHij6ziKV8tXX0xqoh6C
 j2Uho8Kn6t5q7GjRdMGYzRhN2n1m+cAnrkaM0aNaK+Svhnphpw6PW9Ez163ziYOy+7IMnWYPI
 0LsO2Tys3w0yjjDWLeL2F6ab9x95HQhVj24QciKjqx52jT/uteyPEcKhqFpqEYjrob4DGbWrs
 9AncnxkUEGgvj6KsGp9/gmkEY3UKzzP43Fgul83uAMLNA1iboinRWD7k9S53CXQoBtSfHmAwR
 8szEavwbIgG0JH6KztPO3sbfL7ya4yG00BX4jOHo4WwFvnQK8YIglFldPI4pqMwGke8R7Lfe8
 kNUKqkrz3OzO8S9S09rDYZb7a74uceiFtlcy48HVCJHeakVt3jR1KSEfb9qmXNvsSRHuBBUaM
 yfdGd+sVnPZB0knw5w2L16JI28SVk5ltYO6MYsgbpRKh7BbbpIHNPJtez0D3k+EoW2leSxXZr
 OsrpReSWNe/yWijZs6cxcYnNoZ472oonF06mM/zLdK6B4U8ISfnIDcWxFeMBLqVZBlqF2+TDn
 19unguarYtDBFF2ftjhau2Z1mtEr9C38iKiepUSEzE/4aIOKDrdNkgBGtqeixePyoVyzCy9sO
 WsGWdOp8+4cbT8UzlBYBT3tuIoMLw5OFCCm5rxofgI/RQjZGsJDqhEP72RhFCZYU72tMbNAXJ
 Ikdfx1RfcD422zZ+6uu9oYgv/cyFT1hNmvn/xrG9ZijZvxesqMBe/dqwNP82tTEnOWmBvCNjF
 KZrf2h2Zorf2gbfzMJoiLRoZ/G6xu2jiFGF8W0qfq3IEyAQt1QQxgkumsXCxGfaC0QEKjEM8b
 zX/XsRp+RR9tFGbEmLsXBWrgwBZT2P+8gYODNiodgZiuQ=

Hi Sebastian,

Am 13.02.24 um 00:10 schrieb Sebastian Reichel:
> Hi Stefan,
>
> On Mon, Feb 12, 2024 at 08:20:35PM +0100, Stefan Wahren wrote:
>> Am 10.02.24 um 02:18 schrieb Sebastian Reichel:
>>> i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
>>> but has only very lightweight DISPLAY power domain. Its DISPLAY
>>> power domain is not supported by the binding / Linux kernel at
>>> the moment. Since the current setup is working, let's remove the
>>> power-domain from being required for that platform to fix the warning
>>> printed by CHECK_DTBS=3Dy.
>> i'm not sure this is a good idea. In case i.MX6UL(L) is different from
>> i.MX6SX here, then it should have a different compatible.
> It already has. The i.MX6UL(L) compatible looks like this:
>
> compatible =3D "fsl,imx6ul-lcdif", "fsl,imx6sx-lcdif"
>
> So the i.MX6SX one is just a fallback compatible. But the current
> requirement for power-domains affects i.MX6UL(L), since it says
> the compatible only needs to contain "fsl,imx6sx-lcdif" somewhere
> to make power-domains mandatory.
thanks, i misunderstood the commit message. I thought this was a
i.MX6UL(L) specific issue and the i.MX6SX is slightly different. In the
past the fallback compatible was sometimes abused.

So everything makes sense now.
> Note, that the kernel driver does not use "fsl,imx6ul-lcdif", so
> the hardware itself is indeed compatible.
>
> -- Sebastian
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


