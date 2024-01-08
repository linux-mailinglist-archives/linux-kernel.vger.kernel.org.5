Return-Path: <linux-kernel+bounces-19484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F6826D98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E89628355C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A913FE5A;
	Mon,  8 Jan 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lBOnSMzz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981853FE46;
	Mon,  8 Jan 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704716145; x=1705320945; i=markus.elfring@web.de;
	bh=ftjai2gBCPxKGA6L3Dpqoe1qrerRfyJo5B7ew4NadGg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lBOnSMzzO6p7d7Xo5ePpJsEXEwS6zqWYzEMDguVbRwAoE/qCXAC2IwDkobxku46o
	 PQ14T39Wc14/Dx1p75PfECfQpKzjL+xUBzjhBQIyJS3ybQHkSR8xdvXrSu8s2Foma
	 DxVhvvERW538CDVBMpCAhfx/4YWDQS3as4JT+H4dVUeAczfYeSfUlLnZptqqVRUpG
	 6v9q64vHlvhTMyX1z9uXDhOCms/NTRH1MykwJXaBxjAEP1PgBxH081EHtPcvi52an
	 z/AEUAb5l8e29udWnSdD9t8nqrWgPP1HVOClLADDqJrh2pjwSKNwpxMzRT6ZN5fA9
	 LfKNBcCwNL5rbjNLqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDe2F-1rVqYI0Te3-00AhCL; Mon, 08
 Jan 2024 13:15:45 +0100
Message-ID: <f97521ef-0600-401a-8fdb-9648d576ea4c@web.de>
Date: Mon, 8 Jan 2024 13:15:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/9p: Improve exception handling in v9fs_session_init()
Content-Language: en-GB
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Cc: =?UTF-8?Q?Christian_Sch=C3=B6nebeck?= <linux_oss@crudebyte.com>,
 Latchesar Ionkov <lucho@ionkov.net>, LKML <linux-kernel@vger.kernel.org>
References: <7203d3fc-f1e4-4fb1-8dd3-068b0ec6c752@web.de>
 <ZZvX6sQLkgm0kOTN@codewreck.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZvX6sQLkgm0kOTN@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gl0ACkqWjLQpN7DW1bz4DW6OBTXzylZArZ0ih9Y/aiilrlZgNZe
 XUmANt6EhrcgjAVHNF8zdBBCvqDIQ3YrautoPK5CSjcqYLJlaW4OlTXG0G/ixfn/LQGg5eG
 oj3t57hiuLAB3DnoPPMC09aLGkTHoAqG6O7SZZiTsDXhS8yImSIQ6hDEuB0C0+vInuMQNR4
 j5RRVo3PEA/aJJmmTV0WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c4zC0rRpEzg=;0HOZ/Whp5g4WVRdV8jvuDJ7cskc
 wU2huU4c5dedgcwfj/7o+YTZbN8f6xbNNRiITjBrHKxxnE6GVdTeGLL45yk2a7AIyky+ORej8
 XxOsG0Tbz9fb/Na4c7syYGLjyo4XVlIzavF58rcVg6MoiXioriaDjaiKVGfpntdeVsZCK21IP
 WjReKwsaIUXy2hAtyJDWQkMHMFiNHn70pOzwHMVEHMmmC+RxmBiy0GUV6vgnP7sTWa6NTC7TU
 NOBpKpCXxDLlLR/gOHqphasi75b+9q2jquxo+0SpOgTNsFp+wG4g3QhDydO8PT1HShQ6155+W
 w40tAd6YahtG6NQGduSTdabFE7248fptr7JJMbiZmVKaeAKf1mIB1XtYzDROmdCPMWlPnCQx8
 MJ49XgNVjWC6tWAV5wMxtcWHK6Pf5F7guEXVYMMA8fhGf0gE4U1t08erPNannjZ6bIsJDWqj8
 N7FDH3xq5gamrsO/LIZNFpHIZGdegigvnaNvEQ/famzj7Sqa58X8BT6DbDyR0JjYEwJLntHTV
 lEWoq0KKGUAHEqKek+krvDYY16VFFIv5r/d256pSNF4z3eKdyE8twHPqQtb9rGWWGcE0MFKjw
 bXJejYSfNnINiZsaonf/MbmigYwD8vmLq3LHJiD+bSjhmQD5a8j03UvtkViYwVenR35Xs0l4k
 Und6INeC0QFy4bcCqDMeaQZd0XB6WwOY0ZncPIfxz2VqaX6p08F2eybeBYhB1VYGRz5sbnBbU
 lwm8b1CY+H1qFRoSS3MAmtWZ8hA4XLCKHb2RmK/z9C13b6FC1R8tXa1S+ak/0DUqPN/Dd5nET
 OLcXvaV9iaST+E6bfEksxYINh4AjugubHZyUMtCOoI+bcucioQhAIHtY2viF1srydDiUGdNO1
 Jg/eIrj4jXprZ5y3zkSJk06lsXPmistrI5UAmaf4Y6tcJciLUuwHe3fHEsrMpAAHyLe2A5LF3
 Fa2xcw==

>> The kfree() function was called in up to two cases by
>> the v9fs_session_init() function during error handling
>> even if the passed variable contained a null pointer.
>
> I don't see the problem in calling kfree on null things (especially on
> error path).

Will you become willing to reduce the number of redundant function calls
for improved exception handling?

Regards,
Markus

