Return-Path: <linux-kernel+bounces-156341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4D8B0183
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3473D2841F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75453156C61;
	Wed, 24 Apr 2024 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GiVXuaHm"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1F156C4F;
	Wed, 24 Apr 2024 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938880; cv=none; b=HfeuPZ1xvMdY5zqDcq2YyN0ppdSetm4ofi9JvL0jMt1Yuw7tVqll4vkpyRTPAnAtOBw6U0mem4oFHlSPAu2WEgmuQkAQvAGbeov5OXu1cu5gnm/iYMwv/KbPpCwt++C7x5QyGwcPHJas4YSYHp/sK4YlKs3S/fV89uQ+M7mi4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938880; c=relaxed/simple;
	bh=Jd6FI6x901LXxbVZ58YQZYnxrAAST8jfAjB6KyEmr5A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s5k7yi3hSV6yxcWXCeOma6EZtZXoZvqLG/Yll7p1PoyIM4wQFXnUcW6G8tHwtONjFaU79CWAqK0ZTemwmUPF8LSSOnCSQWusBjda3CRtAewsjP4jdkI33pkkWcfFayOs2XCKnaZ8yd/zy/Yhw+nVfnzfhV/Iw/1BN1k7HMl9Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GiVXuaHm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713938835; x=1714543635; i=markus.elfring@web.de;
	bh=Jd6FI6x901LXxbVZ58YQZYnxrAAST8jfAjB6KyEmr5A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GiVXuaHmCGvEIbo6HrKtTICQxdYMunna9F3dlqxkiD3oW1ibCN+dwD8j/gaF2OC4
	 9GKUrRqCWp9jbHzcBtJK1tUyJjgxI3ROisUHxR6gTS/7m0VxAfKXn4Y5IdavocaUo
	 +jpk3+Kr4VU3AnGm3YvsXVfPYrbInFxS84h7IBiFK8PIC5Hbr/b3dZiMKlN+FOnjR
	 6o6Z6I/obvUwyKreqWmSl8Ydp68M6AqFimj9PU8JMbe5MFNuvankkFTuR4FqeSGa7
	 Ooh1xV32HJfKNmoxC165bC1/TzVzCbDQC0wrEej9xOL+qq9yuj+RLcCjhLZIb1Xqf
	 JDXuI6tonXctlpoPzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1rwCP90hMq-000ywL; Wed, 24
 Apr 2024 08:07:15 +0200
Message-ID: <1b2b9d87-893e-4bfb-873a-68c5b269f04d@web.de>
Date: Wed, 24 Apr 2024 08:06:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yuxuan Hu <yuxuanhu@buaa.edu.cn>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Si-Jie Bai <sy2239101@buaa.edu.cn>, Yuxuan Hu <20373622@buaa.edu.cn>
References: <20240422080408.1639247-1-20373622@buaa.edu.cn>
Subject: Re: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240422080408.1639247-1-20373622@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T0GOxI3ph3jcg7WrBMBqclEkC4lZekQN+PZLv/AKJt2p8vaCJzo
 IO27y+/52FQYKLn42n1s6i+4wq7rS5SbVNvynI/vfdPRSYqkw5WHhpI6txDd196PE8cqoZs
 9Jj/XFL4W1+t80SK7mpcn1qHg5acVt1BT8DUq/mfYdGmWGpUNye/oeoExHxyaIOxxZ74+DQ
 GQ3z6l+EefRKlHizD+d9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hrYKoWGzCYg=;WQx1GhyRnGRtRRDbANvbS1pLmlK
 lhaz1VfjQqT1epft+hvVTpOw1Anz65I2qESg26NqKVFosEefDDZrBvsURvfYSlAx6daJh/TkP
 u4qRhZBxHH5lqFTISZxJmKFWUfe14ejHmpQCstcbIWQMTUrC1povUXIzJhiXwAOEuE9ajkyZc
 COKC5E2ewP7AD3tolUzfMtuYKmT19PGQYala489AVdT2Ac+KUhxgUd/LnCFHIqumx0SsmvX2G
 gJIMksIkNWo/wyEElMcO7WxqaTNGrjxYe+8wBxoZgdwq6R6X9GnvB9zsvrCG27xB7BVkQempz
 c+RAvGSHMuXvFfFWQw5a+SPTJTWuv/D55V7BUB2RGcfeuTkBLUr4AM3dLs5qE3CwSXNV4RivF
 MD1RFa2Ma6u8VgD1dSVBoUZEn4yvYitE2lWOyBeVUfp+JDIQ7ZCY3pQqn0TyuAO8mNFZ83giC
 Ms/1QfkKFQ5QeYfZTT526vjOKeWlGvvlDhvvIJNtjIA0qkgCfi52bVUV5xRmRGl4A55hOpGHd
 BQtnefidtUQ4LZX9xU1V5/mdtkNvnX8Dc6aBpoVVNixcIHgjB9jS4oR+XmHJzd/spD481BwBQ
 ITD6SlSPt4VFJpOnBU4f0sQY3GcpbR93XWPB9vvwiUs3Wk7hHO+/zM/8ikUWMSTqVOBQuHdq5
 RKmiUiy5DUU85CzHEb7Tydrosl8/aYsyyDrx9Xy9GI+FsWmhI4f4uPHbg0WjS9IB6q7Iwswrl
 jq99ai75On4pMhcMJjwUH5UqSD7r1+i+QPTuwkWzhk3fH1k8YGqv7ukZ2qi0ABTqKl0FH2iHt
 Sp3uixIX+E7qHmUPpi8Byp58WpI3gtVZo6ezY0EiPnsiI=

> Our fuzzing tool found a null-ptr-deref in function pn533_recv_frame
> (/drivers/nfc/pn533/pn533.c) in kernel 6.8.
=E2=80=A6

Can it be nicer to use the term =E2=80=9Cnull pointer dereference=E2=80=9D=
 for the commit message here?

Regards,
Markus

