Return-Path: <linux-kernel+bounces-167264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D3E8BA6B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158D0283071
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EF139CF2;
	Fri,  3 May 2024 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UA4S3TaY"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8151139586;
	Fri,  3 May 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714677; cv=none; b=o15nY1mSzNvRBDhe4at7eDdD3h7Np2cl/wU+GYgyAsc0xIg20xlG1AUuPCNg192b81cIr4aPCt8rVzg5kOgqv+wPuxu3lEAh8M9qt2/gfyu9jDjJdudLqEEqF3fvUTtNupnF2M0518uXLn9C0oSuxliWHokTI2ug9cFu6QhWIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714677; c=relaxed/simple;
	bh=22yr4JE/Jesym0pYV5K2emmGFHkQz07wrwb3qp9PgFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEclMAPT1y0ffXZ1gOV1w9y2mrQET2LyoUyc18wpgr5Sqz1bNiSvZxLDXu6hSIwHl843p0QwK2yMJz4XFkog0rGA4DrL1VTOPbWOb4tLAInefl5vfhMUpDx/JnTL+B7K379hcW5qOdGEcCCarviA7pUN54xUurN2SOsfddz3LPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UA4S3TaY; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714714637; x=1715319437; i=markus.elfring@web.de;
	bh=oOtFA4UEkaQZQ1lTyzIvZngv43cOzODmoGwEEoq2la4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UA4S3TaYm4fRVdRmIks5BAWnJ36HE8fL6gRMNBP1/4h8s2lU6CXaDyZN3lCn0Bxo
	 NVVnv4RIlko/++PSFnDgBojyeWZDMnN+o43ONQhGcCyn80EX1kpGL8MKNRlMhTDuu
	 Hs+ez28oExk9Xl/SdqWxrtmIDd+OkGNmT1oy6HQFffHKVOomXFbDKwJrJcju6zz5B
	 hUJT4qKeI4ofidzSAzpIq1oBPYdKEimln8NY0TWopIQlU0HbmpuMUJaRohxATlO9i
	 5e4zn2kh+4WkbKOhKSxP7jpJFAFcTOCJt37q7/1pM5qFK5Euis4tC94cW8nFf2ggF
	 6GUf6FeqxQo7y8h8ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1svYaA1Y5P-00tWSo; Fri, 03
 May 2024 07:37:17 +0200
Message-ID: <89f07a73-90c6-4a81-9cec-7a1b7d61ea6b@web.de>
Date: Fri, 3 May 2024 07:36:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] ax25: change kfree in ax25_dev_free to
 ax25_dev_free
To: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?J=C3=B6rg_Reuter?=
 <jreuter@yaina.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Lars Kellogg-Stedman <lars@oddbit.com>
References: <cover.1714690906.git.duoming@zju.edu.cn>
 <81bc171fb2246201236c341e9b7d799f509d7dd4.1714690906.git.duoming@zju.edu.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81bc171fb2246201236c341e9b7d799f509d7dd4.1714690906.git.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2G4b2DUHON8LbQ7M64u0z49A9zJHgVDnju2Aqmpy+hZ13onF16L
 sUDbvo4qvAYISGBFqGCsTU3N6O86PdtaaXMeK9RLunLpO9KNAUzZIEQ7xOVPio92bAvq2WW
 q7vlrz8WDaWhSKjM7qGOfl3GyXux1j9nWjNxh1gdpb5f9VwzbvEI8njH8Hsu/lZt+Mbpj8V
 FSFQy3YaJf6NOocuiSYJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ovAlsWP0Fnk=;Hkpc6Yy9FQkb8E3PpAoQFb7as34
 Y5fLGMAzq1qZcLpDOxNRg9Wv5zMb8nCATTX6gNCr17IrLB2o+zFVBWLlRGbWXpUGsbWBhVTAY
 GIF1VqPPp+gVgRnCfbqHFfkoTFhOkzgYjr/ZgOWBXfGmTOs+rQ37O3+A72cRepC5GOpLg04jg
 rCebK03XkioB3Diei/anLqhLBhCO8HdngrWek16fFcwrv8TlGTu6mVP9WrUrtfa+ZCbuysC81
 btJ8n/PynSPb6dHmSaKjh2FDZaMebDlPKUGlD2GnJUPBt9RzpNcgX0p4j9T+OdlhtsRqjHm79
 omn6IaxUyob46islDe4+TopceN9b3MGCSEW8P3svY47pdYa4mO8O0by4WSAjCdCrCHDolficm
 MxTmSFl9srWH4CkVLWMkB6dcdvaZ51scUfScAykEV/Ayi+qWxHiyg+T8vkLpbCQYUhNuDJLPP
 N5mYpKUueQ86VT/Djgi3RhSzyBcRJjHZYmSr/hd7N14sBtENl0KGpRpYrITljKFMky0vetULi
 7M3Jzn8uUAnCEAO+8CU+wkbgInoFpTOE3hqOqgDK3rUwtN6EdBQjZFw1mxm5IqUeWYfTCCviI
 5My6Dq/c99aMM8tsm9Abo6/HlAtnocqhugeP7N6hh7VOfy/53dhE5Vt56pYob2B82MSDf52FA
 wa9CTxlVAebKIP1uabewjuZ4LXuiGbGp3XAImMAxk3FqZ6blRYSwHKSeBQu6FZhTb3ekiAmsp
 efgFDA+8uD+GisXm9T8cMOCYBqFnwQ4FZKtccGyF/AE8hald8Wpfee+NzMDyhHZQShKeJp0HA
 76EhGX8mEHw2H93+4VE1DH37YQPNmLSO6AxxXnkZxRF9p2jW7/6U3xDtf5j2paIVxb

> The ax25_dev is managed by reference counting, so it should not be
> deallocated directly by kfree() in ax25_dev_free(), replace it with
> ax25_dev_put() instead.

You repeated a wording mistake in the summary phrase from a previous cover=
 letter.
Please avoid confusion about desired code replacements.
How do you think about to append parentheses to involved function names?


Would you find the following change description a bit nicer?

   The object =E2=80=9Cax25_dev=E2=80=9D is managed by reference counting.
   Thus it should not be directly released by a kfree() call in ax25_dev_f=
ree().
   Replace it with a ax25_dev_put() call instead.


Would you like to extend patch version descriptions (or changelogs) accord=
ingly?

Regards,
Markus

