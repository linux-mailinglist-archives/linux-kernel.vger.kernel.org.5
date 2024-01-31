Return-Path: <linux-kernel+bounces-45942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0D843821
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7169FB25CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138A756B8C;
	Wed, 31 Jan 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Hi2dSkbn"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D45788C;
	Wed, 31 Jan 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687027; cv=none; b=tev0TbaGdYh9zoNya802e+1XiN+nXwqwI49LhSiDApgRL+rYZ1b/XZHHSwwwpKl07RtVU/SrLC7qJYFwnDygsPtxSd494mMVHXWwtNu7W7kFHAEpK2jhBYmyWeDNXSyKAw8hjU4UDLDv4bGKUDHWQvKDueHwO39qhpSQD0WwdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687027; c=relaxed/simple;
	bh=3UtEEurfF0DcUrGrZ1swp8W+Hl3SyFmpYaEjxHY/nFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6nkqe/VZBoRS65K4tHpkO6BMc1lxmxApdIOmLfGPdBCv8MA8OJuwpzo2o0xbvX6YKOmJwR9AShl62CS/Q9L0IzSHI8SP9dldFyw4QI6vk8brEKf/pPxg7WlDjhD++PgBeWfTcdSxXa0fsKEw16V+4J2kiwDHuoxcsmLB8o6na4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Hi2dSkbn; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706686983; x=1707291783; i=markus.elfring@web.de;
	bh=3UtEEurfF0DcUrGrZ1swp8W+Hl3SyFmpYaEjxHY/nFM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Hi2dSkbnv9yYiXpDMjayehX07BUp1NW/nccsYAxYCPV5mE6R4t6DmUT/6vxxz+5M
	 pGnC1IpV0RwV4ZgkvrtWqWEMxi1Bhh643Ri3Lv+na+Xf8WyCn/bU0ccCHh8jmskR9
	 WHfhT8QssDTM9Qg9MSn0v1eM4Oy/khfHyjJu1iTTDUe3h4qpKze9R9/337nSEU0UD
	 V/v+lV287r7TThCeCwOzyuPiqOe94OGWfodjSEVA9SLfQL62d6i7m7QSvDemEGyAa
	 IcXp8exYI8v48cyhbKk7zcH2s9dq+n7BhgPa2MghCNpGTg+FQ3XJuouP2PTD8vZcO
	 PkLYx0yQnbbuy4Yw/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1qzCMy0ngF-01871C; Wed, 31
 Jan 2024 08:43:03 +0100
Message-ID: <4cabce20-b5ff-4586-8492-60d2d198a13b@web.de>
Date: Wed, 31 Jan 2024 08:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-fpga@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 linux-doc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Jonathan Corbet <corbet@lwn.net>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
 <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
 <49183574-ea83-4517-8e34-5d6e87ede064@web.de>
 <ZbkAziPCX+RDSgfP@yilunxu-OptiPlex-7050>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZbkAziPCX+RDSgfP@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f1i1yJGnQvsaxMF3ysU2Q3MKc0v1ZqMlnGlCdOdQU92xqESrmLC
 32faYZJASuGhAlIO1E7rIPuiYDDHUMRwWK7t12GSAZGvlacqjnORhc7IGR3zf9OpnD8Cnok
 owulZmVQZGYjwklX5tNvBFEOgQDgpjctV+Kc6aA8vUF8tDuv39SrlXnoyZ2DSDnBYurCaos
 NBRHokiFOULLbfKjHuyug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ABEuiVqcTWA=;1S/Q+gJchbADRcMSwHok6Y9Hd08
 uDJu05/UPgVsiwfgqqdlhtfugE1vcwAK550Z8CzzKwnSzVjL4wRZpj1FMnHT4nZh3NXviP2vj
 oKTgjvTwi9f3E5qCXrz+FpXFjaDB0XkofknRjvMrAVQYZ8XdVTSsJqAhzjLpT3QsuWfyaJsQL
 VXuH0H7SbzuW7FOHQA911Gq9nKGTuBp00AmdBe73DUi9LFOrlBc9MI0SdiKN1JZ5R2gKEW6eP
 MuFfYx2ObubBlRc+1sDxFeKUOExjSwUqzLhrZSFFXJt+ENW/WSFqZlCQmo+b+pDy7TCNvYV6u
 +8V6rIBPQypboe24aZOPbKpC/BGaUTZL/b8mc9GcMKv+OeEyWXUHGhbGGj08ajmUKn9mBQTgS
 ogop3U8YgYpW0UXryh9ZyHRSJANbfEBRU5lnMrsS1HZtteXnywDNCWJBOjpICF2DNiR5rhHhi
 z+VUu+asPEu+Kcq1M2jurGEwU+iPFu1XSuOK8w+sw+BosErPquRELXS/TSUWdSznXihZ0u32T
 ajVFatxSX69Cn1brc6eT101YHVTBN5aILW1p4oQCadDj4JjEKgJGqbXga6DUuWA3vZ0ueOs9H
 mFrdFa1pKZKl1K16g/0fnC2467i/LaF0X+R2arcUfruKKW2wQXHo+DQ8Fr87RRoKGThEMKbWy
 wmbBaXh2W7t2LXW/yVOX7Hv6B0qqm5ibmayV3zaJLvFEs78XkSpy7d7r7/9+B/aRfBFzS0lpW
 VIn2Noib8w3KRbVn0i7K4geUNIOBjdXNjlsX4GGbg2l3OhR5H1iMG7lyo/K8xP5HYZH8mbvaS
 x9bhjxl7izXwZk69Ebu+ZtZoyiOm4oqSD3S5ACWtGGwCTE7sAlr3fco65F5aX/ZKdOPUFw+g1
 qrdsPS5aTlU6K80eypoV152l6hqYFcq8ZJLAAqTshff366m3ahFee4RdQCot9+82q1Wp6WNVt
 bO65kM6EyE/lb7/E/0awB/9IrZ4=

>> There are different preferences involved.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.8-rc2#n109
>
> Ah, I mean you use 13 chars, but 12 chars is better. Also the doc
> doens't seem to enforce 12 chars, but checkpatch warns on that.

Would the specification =E2=80=9Cat least=E2=80=9D become supported at fur=
ther places
for such hash lengths?

Regards,
Markus

