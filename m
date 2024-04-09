Return-Path: <linux-kernel+bounces-137443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C771A89E236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832812878F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835615697E;
	Tue,  9 Apr 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="R4MTHzzT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88715665B;
	Tue,  9 Apr 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686205; cv=none; b=B4NyP6C36ZjBbXgM4WQLh8qTxedMr37ACWg7N5r9k3ky2ki+6gSkcg0R4pYkzyIB8eUfqCyIv8tP/jiaeI5HPsio0rovU7k1HgmqXXdANXpC4tipN4a/TRrIlhNLxM/bOl/vtxXtYay9LGy+Mv1f+gtE6ovn82caCeupeRYATeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686205; c=relaxed/simple;
	bh=GWZMNv/jp14YM5KipnCUWg6RYgfSYcRiFQqZSRxASho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZVtc7zXejJzD6RApA++JNnf7DOhUvxzkTxxP9HiHHzfMuBxMejEj8lPl+FAk7DUORPB/tbOnf/1VUweldYLHnbt+/H8oggFwif6IZPHKsJeYI3/kyxV/La+zzyozPN3MyhfuGEvKxN3WpLg36cs+m4Ws2RWZzv+EpiQqAqBsJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b=R4MTHzzT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712686169; x=1713290969; i=svenjoac@gmx.de;
	bh=B1Gs2gI4M4O38Do9MzvVjCBuAgBbEJZ0/QWS9rcgkQI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=R4MTHzzTFqgqWm8n4CjPgP5QaBJYtcKXtYqhYIgq3TAQyaVE1m9IJN7/yAW1+GT/
	 P8qMGg1aTEGVeJuO/YYKgmK+q6IhmpXVchyS2urqc8bME2H15FKyCTTM1DEw3fbNe
	 0E9JDl2xqMFqdy/1GqKXJ3vHy9FLd0ABVwWo7DadbbXoXpxXQQnAnL/PfZKIAz76Z
	 534SQrVMRp+A69rnzZLQVlC9ki4ydc3rX3QTcKMEePgtEgQkK/kOdCZV7e76WCkxq
	 XXD/Jl3ALt19EB23iYsF61E7l/m/9Qt3uy6JPVozJhaBRFJlPrOriraLUP/USfoAe
	 O9kvx6LKEX4MCQS6DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.81.120]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTRMi-1sLrS10Cwm-00TlCf; Tue, 09 Apr 2024 20:09:29 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id B07B680119; Tue, 09 Apr 2024 20:09:26 +0200 (CEST)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com,  broonie@kernel.org
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
In-Reply-To: <20240408125256.218368873@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Mon, 8 Apr 2024 14:56:54 +0200")
References: <20240408125256.218368873@linuxfoundation.org>
Date: Tue, 09 Apr 2024 20:09:26 +0200
Message-ID: <87h6ga4dd5.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:vL3vQt9Kk7zU9G9u353BTGfpG3FcgCdgMal5QikDGdQ/TIK7B6Y
 qYNnCdQcPbxzdYMWidnlfEKgoz5Ss63nlM4OUlsIj77oLhXeaHhw7EGCL1gicRZHy3VQVrG
 YXesvfvTkE/+fv0dN9iqnlBd11PoUBNWxSOsbotRk9NepHcT5kqk2R1UiZ+WQ4G6d2CMw4+
 DPWDVivTIIkveS5HywT0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B7si3eCXGUo=;T1DtpOEuBV7WOHPFyReILsyI+Fg
 5+YkKuPmyS7Mnp1Fbvo86yRDqrYX2vZMxQIEw5niq21k9KtN+zU2Gdb4n4RZ1XcJdXXG/5nYA
 b4iadaFmTO1R+xr85tgR3qkxZAdpdYvz3vPgI0ZRybZREtXMOuxaOUGcQdphpUhx0KvAHhnkW
 tMig7CiZPw3ND7yJh/wL5fyqkIDAHxiJ/z6IRInZUs07G1QMscuU4pyPGSDh5bcUx0+oBRLz0
 2ID0oYlpu6NvUghFaFW/FGntjIL7cPo8hVYvSU2SeHo5q+IxPTAVJ+tMEhwAwX60mgNRDrTwI
 uXVMNdFTZvh3CiCX38e2ZZKUr7LTJrYWVSKGYpb7AooL+RjAGQF2oBTRRxSDQYvRa4HI6MnMX
 uP06dRSaCVECFxzzg8De778R63UvUT3/Vg42SSf15EY0Cfmlkn9pGySqUcvOQTAEswmV+c8L2
 0iQLbbTvCf/O+jklW5VVQ56+aNG9yxcwSryF+zzx2qay8+bIm8V50r/+Dq85bVt8FA7fTpISy
 tZFLZp/nGlDcRoJyerPPX1Y3k1LbkQbMkCMPPio2qLxUjjwmNbgpWuE1xENv6UAwWaKoD93Rs
 3LWpI8KOh4Wn1KbvPJIYe5Mxcrtnhk5kK6Sa3c4TKCVb104OsSs7tjM3cpHq3TZrx0+7mt3V4
 wX+Idqn8prOlieyaozF1HwzFoGw7s2hha6pMPb2Hty/K7Xr5q6NYIU7674XwVdpNOKye6dj3h
 /+6pTkCwV0Jry9c61xkUpSC9XHFn8AoY+M7S+ncBdjSDbDgV0kBHT7Fy7QI/e3sT7kBTVPqST
 sHZFHdu2f9CxGD3G1YnS/7fFkjeJ9Tpmj+GnUBVBm4FlA=

On 2024-04-08 14:56 +0200, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Works fine for me on x86_64.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

