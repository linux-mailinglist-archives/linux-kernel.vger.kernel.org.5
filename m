Return-Path: <linux-kernel+bounces-166341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BE8B9944
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B3D1C20B68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B28004E;
	Thu,  2 May 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qrNyE+n6"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D78002E;
	Thu,  2 May 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646499; cv=none; b=CpsORReql2cG2GPIagrAx5T26gEHa4vviBZKXd9ALF18yhkL1ieNI3oPVzrA7wtnn3o11aXvWhbnk3/DrvyiSWcq0OcvuhknIZP2UZ2KKX9I8Hm9igqtHnNy5Dx/Y+7Gb0+MI2ZuS3s6sqP5Gez0g2you/sCCs10cXx/pjQys/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646499; c=relaxed/simple;
	bh=CV2wtbkzE8Y3B81hMOY4be2ADXpu61Py3qMbxiAQcYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl0EZ4jg2ROEz9cXWWXEFDxS4ts0iyCBWEb7cwDU8KVz2GX0YB2bg0OGCCAnI22BlXQw+T0ln8FwN/IfJ/OFKsZJSfLFKTDx0SrIKnQkrTeuWlV+1Z2ZKAs/Rap1Lw/AVqpicaEF/W4sK9rC2wUtNNfJUAuDFGo6Vz2Stt1v8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qrNyE+n6; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714646466; x=1715251266; i=markus.elfring@web.de;
	bh=CV2wtbkzE8Y3B81hMOY4be2ADXpu61Py3qMbxiAQcYE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qrNyE+n6bzmNcM4GotOsI7AQLr8mIoM5KHNtXeDlljv2a+MrxwV/litOSHBhgz9r
	 IatcozJgfw2bY1DsqGjc5IijxI/fiIuBezyiRO12D7Uf6BQqXjDOJGC2ibEohflC1
	 IRixXNI+vZCgHkgLeps3VZ3vW18xFLC8xNdHF9dALJ9mPJP1HpRPSd9afJSYf/W7N
	 M4WnOgwi2PKfpYOntE9fln1ihOFFmRDtQqrs1Ec9DXMf5pU6Kbht4NlqcHxJ6zqhi
	 I9Ri8K+ja1unWtLcsbfl2RvBNMyGPA1hX5AgAlHkWGefRjej3RDJm6ggXGc5XGjpb
	 M3F9F+S/8DC33NjBfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1s4OcN0Lyj-00HEd4; Thu, 02
 May 2024 12:41:06 +0200
Message-ID: <6f1fbc13-af76-4e24-a788-b5c2a52aa519@web.de>
Date: Thu, 2 May 2024 12:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mfd: axp20x: convert to use maple tree register cache
To: Lee Jones <lee@kernel.org>, wangkaiyuan@inspur.com,
 kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240429024547.27724-1-wangkaiyuan@inspur.com>
 <a7db79ae-71a4-4d73-a7a3-7bd19f8e57ba@web.de>
 <20240502093316.GI5338@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240502093316.GI5338@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a9phrvGIvGnKucv9fbnDFnYvdyIe+o8E6QCueFncNLhqS4VUlZ6
 HvuNh6FFD8dkHx8gRuBTfuv6RcWnJDTxx1USXb5o57MnSR/e/HabdjvvIiuYlG6BRnJtGp3
 fzJ6fs6UPJjDkq+7kGkz10GxhOW2Bwn10fAAUWh9FZwjlnL4DyjQdhWptpW5CTMKzZbHrK3
 LxMreKwaAATPlxVZr+PEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7cl7PQjaUrE=;vIel+TKL9PJNH4MedUOaBSzH+5+
 cJkThgf3RfHXjEpxonE32RsrsuYIGeTgikKxiHOOFdZ4oioOPldg7XvlJVEDlzs7AN3CsPldz
 qYL3R5gv8X+A/l0WaxZ1L4Li4NJV2vw0f3EUrCLBize3C5hM6/5U0SFQBalh/P3Fa7I+OEOuR
 gXJiuJwMZyot/3SMlc7Li2sDuwzoyAAfECUlvZQ12yrkaZqNSij9gQ5/CwF8EVTkVGdYk/qvj
 uHmVXIPaoY+tG/df2w8zSWaEKOkhZ32CLx4Dw77QNx6iQNd5V8LraXf5mjLf2layoFh/wgum+
 1hYvJdN+Tor3MJ3WCMhJoM73TwYSMgN9pU0gkCyo3o63UmymjnwpJL7+qIniFhDJTsE4iyXaG
 rqq4ZjAVClOSuy3rkyxFTYsyQDMIp3V8rJ9fvNth15GvtAdyYExbDf3Y4CuwWyWYx/zOxwwd/
 FNAxLE0vBsJxhQe9iOepFCfyO8tezJmAXMEixmIHwRlsku3P4yPT55U0I8ljip/eb3b1dcqY+
 giDMvWisxGJYh4DJCqvdDq+1tdGzEL7xuRpu++RAGDvtXrZLx6XDz3P5SGFBcDQzKvzSKAPZQ
 K4ivkhe39ycSoTfmRGljdnhH30OV1Fh+2HM9y6Zk/6tYrJuiwHcDyI6+U3gQdSWtYNik3J9wd
 WNUkrxVPW40dvQBKHCs6liAzCamPvMxXR3Doy2B/219xwRubUAv2vW7Ya2cMoAUFrvVNNDPZD
 tEIt/z89Odlp5e6d38bCAExuER5oJ/kQBxdNRnWLIGmxko3hzNDjO6/9fRQyFTGlVIh+2HBrp
 EftXtrc63snuRZFVFwMSsDLjxdnw3jcINB4M8iEceCQsc=

>>> The maple tree register cache is based on a much more modern data stru=
cture
>>> than the rbtree cache and makes optimisation choices which are probabl=
y
>>> more appropriate for modern systems than those made by the rbtree cach=
e.
>>
>> Please choose another imperative wording for an improved change descrip=
tion.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n94
>
> This review comment is seldom helpful.

* Does such a feedback indicate a questionable communication conflict?

* Are you still looking for a better wording suggestion?


> You may as well stop using it.

Should patch reviewers and further contributors care more for the complian=
ce
with known development processes?

Regards,
Markus

