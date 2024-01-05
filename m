Return-Path: <linux-kernel+bounces-18297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D479825B14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318151F2456F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979C35F1E;
	Fri,  5 Jan 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sFrkJbmS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0935F0D;
	Fri,  5 Jan 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704482482; x=1705087282; i=markus.elfring@web.de;
	bh=HUSZWsUiGQOC/YkUR9iqXdqwdp4kixzaBeZcE5ri/Gw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=sFrkJbmSup7D/LvjP3hYO2WjT4up6gCpjH2vXExnVY0ydzcCiTYkCAFKMVVWXi8j
	 MrXtEbRtJd2hyzBqOwnWRDm2K00YIJQU1k02yHufR1EuuieO0MGBYUdln95ceBN6d
	 V9PMtwfAOzuXP8BmFcdhoH4jjIyxG44hfqsVyVsq1fctqgKPpmAaHtsqK9lgL7HHv
	 pAAiNwRH4wSoLAB2NxCCHdecOxrhjp0mpQA2ymo+JdSmS27AoUn2JULH8YPhGK6fk
	 56iT0+OoXY3dqRSjAmOfAgmT3otYFV0TWrUJ1QBYNnjS678seErytdGsNWT509NEF
	 7QJkmKbfmBdOcV3Pjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9vi-1rg8aG29tK-00Y4pr; Fri, 05
 Jan 2024 20:21:22 +0100
Message-ID: <34068514-27e5-4faf-9b82-2a25bdce9321@web.de>
Date: Fri, 5 Jan 2024 20:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd: Adjustments for three function
 implementations
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BEoYkau02QTSNEGbr+lcjHZLdsk00FLyCbaxSUukTKrCYX15Hr
 J/M0C0rCpFuqzOWWas0eRRHRRo6pz2a0sVdU5glBU5fHOxUsaAQiiJ8oycLsVI+KmBX+V3V
 3IgW3hUvw972A1pyu8KyvOfdI0J9j552K4rahvu9wJEQAr2Q7ivnaZsdXraHkLemcN6y7/C
 PC3hJ3gE78VaioUesvBKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6EmgwCH2oOE=;tO9aap8qByf+p7NbHIm8z1VCpLP
 VEInKE3iDL9hkz52w+6uel79EqVXEPE6JARy3lDjJQWO1SZxsEV/Hp3Ti5NBcnCuI3aYYmf9Z
 Y+cysq3iYMXzwAA5w8KlkhDtkQ4X12yfZvwL+AVCcBC+AQFKwUHUoHFIfDFQ5OAURoTxTS9+d
 jxgi+oFqgOXIBUq7flQEc+9Zt4tq+BNJrU4qzcy5q6SgS8jhSHWqbP6GnRXSY6Waa+tXvtK19
 X3ToL58H5kJdLNQW0aJCofLoHQJh2RSsE6jKaONyGpSQ3OtovztcpDG2f4Zng/hHo80knDRm7
 jkaqsXMLHcqKpssa9Yv4EHa6wKaSebq3Y8WVNFe09iR9soLXDnSXOwMP0pezWUTJEjBGntSSq
 2Eh0PgRQS9ZuBKbjRPH1fKuYKw3LH2jp5EC036m3nCHw0YRX0FYeDjuv38JhsNB6Cf5v+KIV0
 tmBJw5SNQdfVOVdlDNlLOpsP7fElP6563rXAAsYo3AC+KO3nB8D5ziAz3rV05f7VokncFr0V5
 1q7YzlzXUc7CNX2trDyjjUr5uvjibK6d8OycPmGbVRiKettQ2JSMDYcT9ETgIsAKCUWp5IeTt
 9la+Ema3KZHHyrwqi0LPdP8cePtgDTD/jUWbaL0Wyl8xXM8N9iVm0uXofwURX5IU8PMNw5Mjk
 oqbk8j6mXM5ivnYepjPoVE3ibnjhPniiLWmJeo/EdY2+0kCqiNq1yilZSR/Wb9gnWrm8+5uVH
 f8k5L57VL1aQP5JJ/1ptrIKFPaQmCZcPH2VN8K9pf7BOq06Zb4zLhDuHbbSk4V73q1HAX7+2B
 aFZR8oSvWcJK+QJm6P+7uqjrmF4DYIAGGeXBayljRSBcW3OSI6umck/8z5dUjf1sbfnzFtbXh
 x/Dk4BdxeAFgZbGrh8uEsL+yg/zk9FqDxK5CRa6uawOWDZzmWfEVf3HQ5IHFxZ5CASP915Vx7
 hdhrRQ==

> Date: Tue, 11 Apr 2023 14:36:36 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (5)
>   amdgpu: Move a variable assignment behind a null pointer check in amdg=
pu_ras_interrupt_dispatch()
>   display: Move three variable assignments behind condition checks in tr=
igger_hotplug()
>   display: Delete three unnecessary variable initialisations in trigger_=
hotplug()
>   display: Delete a redundant statement in trigger_hotplug()
>   display: Move an expression into a return statement in dcn201_link_enc=
oder_create()
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  3 ++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 ++++++++++---------
>  .../amd/display/dc/dcn201/dcn201_resource.c   |  4 +---
>  3 files changed, 13 insertions(+), 13 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/2258ce64-2a14-6778-8319-b342b06a1f33@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00034.html

Regards,
Markus

