Return-Path: <linux-kernel+bounces-162150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E08B56B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0170F1F23D42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F146B8B;
	Mon, 29 Apr 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vDhViy4i"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995744C6B;
	Mon, 29 Apr 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390300; cv=none; b=Cf4ktxzGG0G9S+oivuSljMXiDkX6eq0GmLJdguiGzL9w1ylwYzWCXDiHFx/Zta0lPyoebGNFKKJ0Mj0n4bFxgpc6OeHeCkXS95HM20wSClRjL/EoHfscyxdEoD73lOZf6oEBGAmMDr17DjqoFS19cvL9qLlxnIwW7O3y/5QJ30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390300; c=relaxed/simple;
	bh=0uLfgTMcNbd+pdeUouC2Y0xOddmRRcjPQZY/ZRdLJmQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KCq6G8/WqGQx6aNwq6jRFmHYhTgF2NobQDbdP0FixSpnVoki4UBEIfziyNXdsI7BN6si7dMHngXwIM9oMM3Fbcc7i1foBKADJpQwjxy6qhsQ3ckAvq/DyAlO8isgD4lhBurq7IfLLsfSBM+T58qubP8bZirspYwFVcKr5Yn1YZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vDhViy4i; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714390278; x=1714995078; i=markus.elfring@web.de;
	bh=mp94rsiMqyk5KJpEbmeyEviB3UAF09TrKYhrCegkeSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vDhViy4irgbJd9dZh9MZYJVlL3mLYnYd1s1fYEH2ridVSb4sIylCmcmyy+h5ZU+q
	 oKw615tp8FN/NVHsI/QOOHPNk0TeAzo7pW/2EL2QGn1L8sAwz5AesJOmf0jkTkv1T
	 EtVBLw9gPSezJee/+HvdpuE+WBLYIGhjiwdt9Qnd3XkhJTKyOmx4XcR/F5gLHDHTV
	 H7iV2KV3anSpfZCKbTiWxWsFFIiTMlnZXg0gwkgm3lpPehtfAs1LxMFJ0bnXfXhtM
	 RZ0AGwUrJHHXElnG2kqX/a4fTUbBqXL/4aaLqfc6PlU/BnkmlZV2iUY8UmBmonBnj
	 F1+oe2wiqwOmhf6JRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1snErk37rO-015JnL; Mon, 29
 Apr 2024 13:31:18 +0200
Message-ID: <eb15ab0a-e416-4ae9-98bb-610fdc04492c@web.de>
Date: Mon, 29 Apr 2024 13:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bard Liao <bard.liao@intel.com>,
 Vinod Koul <vinod.koul@linaro.org>
References: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: fix usages of device_get_named_child_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzU0WiIB2IobPNhDkD5pLC0dmfIgrwhxgRWcFvNuulnDfeLtDFO
 kjPAAeOQPdMizy8LFpSRF0+Lo5CPHGjffnEngcief7ELEQzLWk3ZUckmESZp3/Q5wUUXeIS
 bInyKTrmmaopfqLG+y5OJC5OZdWsm95w0R3X03NQ/I44G7ebBF3sRujrF+AqO/8YqxnmiK1
 kX2riS1pMpemm38gqNE8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c8GE1h8qdHE=;VvLBTWnInpeRHE/89SbHNIXQ+eG
 GcJSp6rzdek4ag5G/VInqebJFNI45zC40MyuHoeDRZbROtt5CJW8RUL8/gEEHmEtxdCbPWwRO
 g41YqhN8k8QmKygQhCLarb7X3jYveI7TBA6Ke+CBz2Eq24jHENJKU6RDu8V0/RcVYdp6N5egY
 LRMSpn96iybJEEgnynNdOLj0QGghw0V+CRPX0qZ7Fll3a8Ut03ErsSRvOioI3kh342tyoqjTn
 zI4xgcypA47CrOO5JEWFXwPLyru247ZIUoQPfmUsxq2ucZjx7qBBxm2bIlc+OWcLJoydPfQpp
 4BggJd5S8qwEI78aYN6I+PDh3bpwQyd6DWdMAWCHRUEHMQhoBsjLpaF0L4oQXQwXtr72gumJK
 kT0KtJZceTrpZDIDCPdIvA78FhzHcKAWj/ua1K2zSUoy/4p50P+K9cRi6aqiI4vp3+TmjJ0K4
 6VrGfbbpXKmhMjAWggCbOD8Op+XJyptHFE89MlVhNjdm8yAIURa8EKXue4oTNk9zqlyHz7RUK
 uld87BjG5fJQ9CmK24siwsZYGrukMuwDqJeNJ40OzA5pUs1hA5wgtFQQbgufm6yWfjmy67q6Q
 pdFvsrQ8K4do0dAcBufkdfSaKa4EshT5o4Vu3LhZ+A8iBpvds6CvoxO6qYuyzO5zzUlaoNatJ
 hdFV+7iN8LpQAoyVywMHeyuBGpVEVsUM3eCvAz2eXSMHD0GAY5JzfxB7YWCJHEibwlu8ARwyI
 +kDum47ykBhCRMc2sHIO7cVeqhwRtHDJ7WwbBFzgL4eftg6spzF8zzN/AKAYfMTvJkxsaUbMz
 2xZ298IaXjjJi9HMeAqTi7rRc0Px/fFsk4lXLjMKjjPpw=

=E2=80=A6
> Add fwnode_handle_put() to avoid leaked references.

                          calls?

Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/drivers/soundwire/mipi_disco.c
=E2=80=A6
> @@ -236,8 +244,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *sla=
ve,
>  						       dpn[i].num_channels,
>  						       sizeof(*dpn[i].channels),
>  						 GFP_KERNEL);
> -			if (!dpn[i].channels)
> +			if (!dpn[i].channels) {
> +				fwnode_handle_put(node);
>  				return -ENOMEM;
> +			}
>
>  			fwnode_property_read_u32_array(node,
>  					"mipi-sdw-channel-number-list",
> @@ -251,8 +261,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *sla=
ve,
>  					dpn[i].num_ch_combinations,
>  					sizeof(*dpn[i].ch_combinations),
>  					GFP_KERNEL);
> -			if (!dpn[i].ch_combinations)
> +			if (!dpn[i].ch_combinations) {
> +				fwnode_handle_put(node);
>  				return -ENOMEM;
> +			}
>
>  			fwnode_property_read_u32_array(node,
>  					"mipi-sdw-channel-combination-list",
=E2=80=A6

* Would you like to complete the exception handling by using goto chains?

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus

