Return-Path: <linux-kernel+bounces-146940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FD8A6D49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5A51C22337
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8712CDB6;
	Tue, 16 Apr 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BV+rQywq"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA012CD8E;
	Tue, 16 Apr 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276346; cv=none; b=AXj6+yPFvBdCz6Bs6S6plVJDU3PriQVY6mrHCxoJf22qFMSzaa40330MCoW2aZUD2VgbOCDesUz8TXUHuKzWjRm9Zwg5ePuIbFWmTdXiZNbWFx0p+J9n0fCPoSoni1ZKjxuCQA0FKmxP+BQX5Q2ZyZHdqr0pUfRITjrlj0GA8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276346; c=relaxed/simple;
	bh=ICGpHm/MlVMTN5tT+yT0ALzoCJj/Nv+iChNyAF6Crfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0zeLrz7sYwAgFaliwKn242b5UXZCGg+8zu3QIOlOhOh+mTR3mj4tLGXUrMzDQ+AOt8IM2KG7Bz9w8ziGB+1ljve8g03pY/UuJP4ruCYFSoNHiJKVPvm33L5i9xrPnLkzQYo+Y76rvD82yfNw2QNVpbvUDsgL+S27oQFD0B2uAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BV+rQywq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713276319; x=1713881119; i=markus.elfring@web.de;
	bh=ICGpHm/MlVMTN5tT+yT0ALzoCJj/Nv+iChNyAF6Crfg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BV+rQywqAIdxBH0umDEn8bvGjPmvmzSqAzrxbTbKpM3uXumbe6gcX7CTQWSP5t56
	 1YTSUpLCG0Qkdr5GcTCA8zLZjfpbU6p4mrszRpAZvRYSM9VOYa6+aaGMthQCEfzq1
	 koDp5MNSqr1caICyB/lrzzdxDhdd6AJ66FSmF9Sah7Ukq0q7UR81HR0MRBd8WNzEo
	 gIMMx8Kym/SaK6vj41JHkIPZEe3fEg9mr9PWEQUO6ZymdHSNcktb0sNgMLO2yy5v4
	 RT5Wsby/gtVRlr/I9x7umdiBOZyMHWo/x4B5pcT0C+O7S02wDDOY0ze6WRgX8a/UW
	 Gd/U5HLtEwtpoYY2xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1sJwDz34d2-00Tmq6; Tue, 16
 Apr 2024 16:05:19 +0200
Message-ID: <d5304d62-0472-4d04-8727-9e9c88eb0533@web.de>
Date: Tue, 16 Apr 2024 16:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for map_paste_region()?
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORHzTV9JjHAw4zTbjE/EZ77vq6Kp7tJZyO1LnF5YwH3Wm4B8mFK
 9CDJOEyKMNgNsdIz/BIs81MLc1apFVK4NmG3Y3ATeJNBaNil7jjERn3Fa5wqGOqCl1KyLRz
 1VhgPaKUTJApamxerdglA5aKQf9MO0QMuQ4vq3mqg8TxdzwYK6lbYLIy5HkG2L7U1m1IqfH
 DufMlLVpDYZJHAnW7MGgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8bmhXE821EU=;0UoJ/5dv4u3lZzMfraFWbbkbMm4
 yeLO+yOeHL8YDFVOoNZgpij7RieJG+s7gkXK8aVZl/ACsMiPzoWF6m9Q6p4yZIYALncj1ACJr
 b/jCDP5O7arA/0kWG1R9vkkk+gJJgnU4PdAAtF05ygVx2jVuAFLupnLWpWIs0Pz3Ao1rSp8kK
 +dhuc3Avvp3hGe0AVp8cWXSPE7MOs7Ena1oB+RQuqcVNmNOHGhfMb1l1FVxNr7wya02Cqyb7+
 tHblnwm2E4tKis7qlwrWw/ykWxA7kK2DdLkFBMSKdI47fVaVe1HQ0Q4QUxSmPEHmkfmsCEEiV
 rARvo0HpbOeLpB0vDIICHwyNXizQosGq7K6VTECIL6CWWqgfs2CAVnWbDkJyA+SYscuxwqZmp
 khLfnIKB47aF5iKpcA0/QKUv7cD1L+m6khtXn+2Ku0A6pAiiabNBg6u7DpevsGtIrwtJsnayT
 X0EN0pXxEKg9zWZUXbKEDtD+N5WszzdTahq3di3KRZM6xyO4XTJrzb2MGzQpFzLJuR3VT8MqS
 k7kOszx53xL+KRmWWHPShcZCA+CXucKeJ45bPcQmmYIOgN4Lrb8nG06tr/CJj0W+4sn2HJt7m
 Lb6LxrVFzUuEMV6X8npgq3XiT+TpFx81Ub+gGIW1hRtRuorQ6s4vcrYGM8bvDb5jaDcVnCOb0
 82Gpb0XwbudgMefEwunIqKhZhjhCN4CAHXStzYnZbDVjrlTD67B1YnQC8bQM8wsxBNKJ58Orm
 S4/VaoolUyjHNln2SBzYY905yLLKLXGztuakPb0Oe82JLKIADcaOrKFiA7AQhBHJ6Zp9ZCmS9
 f0GMV4Ue3Od0b5P/OxGxRmcyWbD9US4g/kmJvGmMjsI5E=

> Looking at that function, I however see a missing region release when
> ioremap_cache() fails.

Under which circumstances will the exception handling be completed also fo=
r
the implementation of the function =E2=80=9Cmap_paste_region=E2=80=9D?
https://elixir.bootlin.com/linux/v6.9-rc4/source/arch/powerpc/platforms/po=
wernv/vas-window.c#L67

Regards,
Markus

