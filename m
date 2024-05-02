Return-Path: <linux-kernel+bounces-166877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C78BA141
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095D81C21531
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7AC181309;
	Thu,  2 May 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Xu2xQqpE"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7661802BE;
	Thu,  2 May 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680095; cv=none; b=m/V8HIFnGFc2AlzjL0VJm3nlTWDP1N2jA9VZRvUsYnh30u5uBTPhtTAY0Q0j3NdDO3AiKHTEyV9fEq0ofHt4kQqNS8vygK/G5pH2M29CrpZy4itqs4EjBbScV85igkgQzEgzf2/0EUTBMRvVoxmPjJm7zXPUvbrgPCLM/o5QNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680095; c=relaxed/simple;
	bh=EM9PQ0+jpznznKXXf9DM0GjqB6Lbm2/vk2ex+XeL0sw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MKeic+HqBM5lLz0EO88zKiODorer3hP1E+X/iP8oafc2wR1LNd8ZYe82G/GNLXKaQ/b8gL4YhT5DVdvTDMChSqaB7kJBdAG/kwmeOP1Z88u2emzAUQnas5G70UmjtSrX18c+2kPOD2uq1voBD2ERvNsaSz2wyUEPkeHuU9ohjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Xu2xQqpE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714680065; x=1715284865; i=markus.elfring@web.de;
	bh=EM9PQ0+jpznznKXXf9DM0GjqB6Lbm2/vk2ex+XeL0sw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xu2xQqpEWCvUFCbbW0roNkMalj80dV3TYsg0xyiKFP/JnQYofxDKQ4Nkv/iFpcaT
	 /+N5UUT1wn+5rhDlk2emkj3qhf283y/kN0cja5LFmNGISFk0cxGgKisrZPDKHWcxG
	 7PNZaEW+4D/krASG8hil4VBsfQX01qZoyhrY/LhKuM1cwUQRh1Vhf9yaitPo7bHHt
	 OE5hWg4w+VcRseB/2UNCZOSbxiBkGmuvlP2+YsKHEZlXIxbQ6b9dUnYG0lMH9u63H
	 JbuK7Bay9IYV8R7YrJJUazCE64+fZLgQ1N7RJBpO/97yS7Zy/FT8TfWpm5d6WwZbk
	 DuoGw3mFmW1zX6UZSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1sqBGl3q8p-01319C; Thu, 02
 May 2024 22:01:04 +0200
Message-ID: <068b6038-d784-451b-b43b-41b94c24fb29@web.de>
Date: Thu, 2 May 2024 22:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?J=C3=B6rg_Reuter?=
 <jreuter@yaina.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Lars Kellogg-Stedman <lars@oddbit.com>
References: <cover.1714660565.git.duoming@zju.edu.cn>
Subject: Re: [PATCH net 0/2] ax25: fix reference counting issue of ax25_dev
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cover.1714660565.git.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mvbvX8/mivlMFaAOxEjDeoSrVy3J7goo3lJNTbo3VA2LZdwh5O0
 6y0nBDxB48mgLVjPdzWMBrmCgLJ9yDEl3HLkYS2IepAhtnMLc2ocQogu9oPp3mkTwgtCJdo
 KdkG6PTkS7YPrP4x/RCmQgs2lRfW9rnm7hZlniNr5pfSv3+B6AoanvPUDF9WZFVECuyQQqe
 tFVP0+JVRPUK8LiqtFHEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JBpLSAZ04ic=;LgKLxYkfMEg6PdZW/tP4hxW9kYL
 miSii5dpI48R17cNPTXQswm4nIUlSIs/JFJHlBlaAKj3Bc8VEdHH1JJZ+S1x5tFBDdOhbuOhG
 s+pAUetGdKFCSbIjrtzzMsxYaAfiAuEsQh+enKuObKstyVyd1Aveb9sPa0MvDICxCIqVv2G4i
 FpuYkU8O7jGbpwzAs+QmKkINKkdsxH3KfVnJ89Wr7bRHf9x9/vL+UTFLJKSxpqqcJwplli4Wb
 E3Y0yyq0SODl2LEX5F3v97mGoUE48GadH5R4VcQHwjmmHos9QakEa3J4Bfbh40Xfjma6gLkMB
 oETiO1zqIiUxkL3F7ZTtWMs9gybsIaCBORiK5QcCUCz87IqpedMJDMnDLWs5/RIb5wpJ2v0fh
 2oLktCqJG6loroEazfLkIw52J0sbwZKcaQ5n1iHd42z8f4fOfIW5zcQcE4qpto6lzJq44MkZK
 CUwmNCwbPSZRCYuJG+P/F7ggtWm7uvyGWgZkYAAaNjmphFBgZq8BlBQFrgEwwYc8AbMKfKIT6
 dsP6XXpnx0anbsFnhPi3nnlDQ5AccCPB5z6nxIUS8HnFLJ6xX63I1NPHIQ6R1E60rNFKMPhiA
 L32auVtE2AixCKZVWJLIAFEoeLevPu6ex2dPb1bNKnkWGCsicIR0je9NXofgH2zdAlUitFjFk
 zx+YaCBl6TrfPnOBIZj0xsjDRj+1W8S/5vIItMV2tkwKM/NTBCN+57IJ4izF4xE8rJbNeFFEg
 0ezIxXlEmaC7IXlWzPc7aM2AP9DHcxTriq/yAMv603EBkLLA8533w0B7KUAIwmFEmnWGLKviK
 DIKr28TIKwCZgdDfwuDCPchNyxHm53cwq5PsLH2UmmTf0=

> The first patch changes kfree in ax25_dev_free to ax25_dev_free,

I find this description confusing.
Would you like to refer to a ax25_dev_put() call?


> because the ax25_dev is managed by reference counting.

How do you think about to link also to previous change approaches?

Regards,
Markus

