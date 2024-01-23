Return-Path: <linux-kernel+bounces-35531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E68392A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EA728B897
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FD5FEF1;
	Tue, 23 Jan 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DBYZN7Rc"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA75FDA8;
	Tue, 23 Jan 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023552; cv=none; b=bHFlDZnWG9Y2yLGsTIVyyHDd/Ilb2dWQTvY/snbim0utyPfcCFLdjIFPEEimhc5N52dltYBZc7ox9xZF14dUAhghjwNZK3T4JcOVRUkPer0fGnWbGWpD4hhMpkQ8rUNJOalwlyiJyd4bVbKa+1/nDsC0Gr8oajtUH/dzq7I0RDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023552; c=relaxed/simple;
	bh=NrdH8usZFnM59T9pId74ZzCqpc+6sEvvxs5fvueZZ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WSDIdxwh8Z5XNsl6sjQGcKPq7lENvfCEtCdIZ70fMoxS03iM2Nrj+Vd3RhnAXQLmNXIUVgunQxDCgIwK3S9pk5rpyQGMhIW/C/mqXAVvmjQT2/dD+Aa8w01SbzVi9dhygP/4Xz2kFjHSdmUo4kT2XJNGQ5Xpv8ohCGggQt/TpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DBYZN7Rc; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706023515; x=1706628315; i=markus.elfring@web.de;
	bh=NrdH8usZFnM59T9pId74ZzCqpc+6sEvvxs5fvueZZ2g=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=DBYZN7Rcfyje0uKCJw1Nk1/+ihI8F2ouboXH+gj2fw6UY1ZaZ/EN382FiRRffdOn
	 A5s6Fwl6PDiQJ7waM5BV+AaEfkirV3FQAFB1v/AdZHX8zOcQudqCXll5oU6ciWnvB
	 0yVrpW9wQHboJL+c7C7MO8r4BlYm4S57e8UIwNsjabot9iEwxSiBbSW4xfuWYpers
	 oiyl99OhAiM+zd61bxEc6LEy85bBPACj9Pw1V9eLnTru/lJJf1ivxIFByqtRJTPcP
	 A+y4N6jXCEEfKm/na1L1763rNs0FQ3pNCVPzPN9r5mPnb988dpQGo+73IForTAwVF
	 r2yVSq2JMnIRLnbtFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1r2oBL2FeW-017q97; Tue, 23
 Jan 2024 16:25:15 +0100
Message-ID: <5011cd73-10cb-42fc-8013-0695793580eb@web.de>
Date: Tue, 23 Jan 2024 16:25:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netfilter: nf_tables: Add a null pointer check in two functions
Content-Language: en-GB
To: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Jakub Kicinski <kuba@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>
References: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>
 <Za_QJZhWKoq5wg52@orbyte.nwl.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Za_QJZhWKoq5wg52@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXJcMO2GElsusVPCB2SbHm1IdlNZnFDcX9CaF2xhxJ8kn9DQReW
 oAMtvozwCRXWmNxuqfcsD50uX/Mxoz0Zy13fGUW9IzAF0yVvZOp27UoaXcW2kMYpVk+2Dtn
 cAZdtPNDrwpRfGOp0hXMHVlBxbup3ocFEx+oT0ew3+DTembR/RhAJ+EDBtEolyUe0Za8i2U
 cwwxi1HBiUWT35q2jLGUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LQZUrtu9p+s=;s3yh1KV+4oaKaxNoluWZ/iSTW/+
 bFw4DeIJCs9BZetYTM117fLiTV1WHQzCotP2GpLj13Uhg/O9nD79LncTaBrqYnueeU5DAPof3
 rSgyQtvxz7qlC6tejBqGnPNILfOtMLQcI7R8x5/WpMnQVBxYGo63UsdeZzumABoW6IS/xBmey
 SshRpwGUQfvm0PA3/nTsHcDn4hp9kNp7i0awp9N4dr5j+FOP2/uVrCMBi9RJIYIGyhJ1aAKT1
 uLLFajFk9sHfRQ9MX+xITGXQEQEZWYZ0LBUS338+T/fF3ZIBvwJzWJ2X9r7MnCI/S8EQPqmVC
 q9gNu7V2s5i2DSDJ4E8cFW0RAgQ+zWaO+eGmp0Rd+Ya579dNwD4bxpInQpIGi6/tcsEro0cG+
 illHB+DiOc1vVBTGyRbXOR+vdNeN/jWjB8rmur7Q5Bd2XySwB0pFpMZIOoLSrYDRCBeZMDt7N
 1ClmHkT3CKcXx6lFKjD7ZvSXs0Tfp9yH+IEG3Vvt5DpaVXVwECaZupeWzO5+NKSfeXMNYxiza
 n92SSUdgwPYCvYQo4+Q42e1BOUgm0y40WjeA9ygV1/y7Hzag4ZPuerFfoD4ghB0rOimFonpA3
 xrGC8kauNwWxuGCh/uJR+/oDhiBtSUAVygqgl36LDdMiw0aurwBsh8P/CWhXv8zm8jGNgXsq8
 yjOx5tpQQPrIJly11MQi1omrBRe2K7OUmtMyl3duLc1nfpqBr7FTobKIPGhNrlSqZN4v+mUfD
 /RHBtKl139nj8tidvxBWkt3+Ccubw5AsNnwRrOIWguNT+IS/YNSB7gpGiOpJ0wngIRFKdlNv8
 Txi9uoF+hWpt47J060JtutWEwhw6drMZIpiciqqeSlaMdc/OIY2nNZXdge82x0eak3B8q6AXb
 AkVeSyryZs2/av5QYuAX7IojIBMM2ylpjhtnuUHD7z/hKER51Jt7SQzo2hhYIgnk7Bzeid9zJ
 QsK1aQ==

>> The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was =
passed to
>> a subsequent function call without checking for a null pointer before
>> (according to a memory allocation failure).
>> This issue was detected by using the Coccinelle software.
>
> This is correct and I'm fine with the patch if it avoids ringing alarm
> bells somewhere, yet it doesn't fix an actual issue here since the
> allocated buffer is merely passed to vsnprintf() which detects and
> sanitizes %s args being NULL.

Should null pointer tolerance be better indicated for such use cases
by any additional means?

Regards,
Markus

