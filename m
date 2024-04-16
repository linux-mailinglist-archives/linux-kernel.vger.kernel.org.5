Return-Path: <linux-kernel+bounces-146745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450C8A6A35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958F31C20F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548E12AAC4;
	Tue, 16 Apr 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u3473ZzD"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2C129A7C;
	Tue, 16 Apr 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269107; cv=none; b=D4anYAt6+BCZIn4XvBlykaAwt5sau3s89DGe1E7NhTG61SIdRECXgJIt9KauIpAQtuRnQPXMqUc7Xk5ntmdSwFbMwgPSzgTRUv2IP2fzijSifAMTeDa83wQP1h6dlH4FQRZp7N6orc+KW72yiwIYZHu0ZoKpbqbrJepK3yk/ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269107; c=relaxed/simple;
	bh=kHsLvfc4BetUwiE9Mnz+NVw5bFbjtuXqHSLYEyhUmz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jn6dqJg7oPWBsweNZEBGjWH6NFunW2rE60kBCu1u1nAvoAyrie6yJu4mRPNXQxG64rbnpWHxXT3XmMdYdW6u94bAW5N3d8B7WHMqF0H0yUeghiRyiuBPC0tDl1/1bCSNG0eQhexi7HVZtprJKyPtu3nmXayq+W3sL5Ob7CKApYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u3473ZzD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713269081; x=1713873881; i=markus.elfring@web.de;
	bh=sw6GZmEfJHOtxMwjc0tAhb+KXK5KwEfpIepkP/GZl2g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u3473ZzDDh+t+me2dt3F26eXQEJbXRMHgJIvA1x0hmPmrMaXX71ZZhD9cCNTr7Qv
	 SOws0lVeGYrFZMK69g+te0jPbWW7IyucPnCt1HHn3XAwR7CKbUcLj3nhaaBfwG8P1
	 fBaHtU/3CRJnGy8MFDNagvL7Eh9ut9NLLD0zvhyD9wlIJbcJmYb6id4an6a0fbHIZ
	 YMG0uA3goAupPaBlR+mpwC24ranx+557ADZWd/Tlbg8wtmReF+O0A/mF2G5THQbLR
	 OYFavdpt55nvuHgn+T9lvG/6m7GkdK5mFfNei4JhSRq2iiLfk252qggUgYH+3klZ9
	 Q5RkD631nk1w6rNkmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1rxESE3P82-00H38p; Tue, 16
 Apr 2024 14:04:40 +0200
Message-ID: <d3818747-cb02-409f-99a0-7e8c1338b859@web.de>
Date: Tue, 16 Apr 2024 14:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87plupbm0c.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKTayE+y3pYrRCZmB87Ixt/657oQ3H2YB0/2sGYhXb1MTtV8tUe
 /Ie+mZa7KKHvaoOkIUKwfc6FAzADz0rFlB5qsj3hUrVYvoigUOWDTZoWRRVyYoMTf8Z8Xed
 dOdN4nUMvdSGDJpS1cuy9DRYnuL237JWBZD1/wbwZoPnfILPLxJQ1hDa9dB3tLMeuG7A4Aq
 bOyXnIhDAh4k3xNmJdezw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IYZhPlxcEOk=;o0SPT7r47DuqadD0lHVbClQmafX
 syjPCHer6jwHsnHQD8mIuxQ1xu4M0n3AI3EEXltIPvH5L2gC8P9V3eEXB/WCilC/+xchxGEOO
 8d8ITp7Keo/un3qIEvnhvSSN9TutGH5wm1jgR197fDLbWKVbQTSKXIuWrMSeJYt4YmAuQrAjI
 Gbb+wnL9kdKylA7XDdzCeJyWUnCWl9XxFAktDKdvK4cIvOG8x7uyekdf8SENCC09ALY7EDHNH
 edPJathkI1o11h2ZC2uDx5mXYtCFMkgSfmGjJXSasH9GU44Ks9ttbZy3ZC/T1f17tH4Drqnvq
 GDAj5TenV2O+YbU8zLNMzQwhRZOg26/Bgf52+89jBNa5+qHmlKhYSGaZ15m9LYM3UVQwyahHo
 rqm+sioDTGuJZlZ45T4adETk36opLhzWnRBwpkT/3iR4jpcmouEl3DQ0QoE6frf/Yw1A6us33
 PmHMJr11BkbM/SSxQtyFd84DIq1DILkvF7NG241PXqb/+FyoI8x9Ych7pKwUjuxwrkk/K1N+8
 e0ebv01F4oZaf6bQEl9rgW2cNZ3qLhxkO27ArjOKUZ1+IyRMlsTlWovAQpvf3Sj0ARaHHpZpt
 1km6aoZU1pfegEGP2BHbUqS5x8T52KBDc1CL8wE0WrT8PIvAoe3nmrbUil03CoHzBJFIEA/l+
 en4L+ooMpScTSesV3tQXR5HRXa6+N/KedT6li+lRpgqJpO9/8Jvc5B8auv6YJOvytteQ38MAM
 pKPMyO1roLTNmq5zVzKVgyw3riae8jfi9vCH7J/MkBCUaCGWNX/FOxXnlg+S/DOSDd9/OshPO
 VsPdQI9aM3+AsqCipnHonD6TyhL/16e5yMLJnfz0JlY9A=

>>>   One function call less in vas_window_alloc() after error detection
>>
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-4=
18c-b00c-8e6474f12612@web.de/
>
> It introduced a new goto and label to avoid a kfree(NULL) call, but
> kfree() explicitly accepts NULL and handles it. So it complicates the
> source code for no gain.

I proposed to avoid such a redundant function call for the affected
exception handling.


>>>   Return directly after a failed kasprintf() in map_paste_region()
>>
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4=
e98-b602-4c5120556b09@web.de/
>
> Basically the same reasoning. And it also changes the function from
> having two return paths (success and error), to three.

See also a corresponding advice once more from the section =E2=80=9C7) Cen=
tralized exiting of functions=E2=80=9D:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9-rc4#n532

Regards,
Markus

