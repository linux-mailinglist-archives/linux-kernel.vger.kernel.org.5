Return-Path: <linux-kernel+bounces-149689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE278A9493
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776321F22AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A378276;
	Thu, 18 Apr 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZuvLafE6"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462041A8F;
	Thu, 18 Apr 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427428; cv=none; b=a+bfdYRhNdOeJl7f1AAEjtRJZH8hfna5lrI7qSn5POCTSK+J8+BF7C8rWKpyvmY8mQ/kTYb5him6dzaAilvSAXaw7yitimAN6XhXD9bCU2FcPY1mTn9V1k18yEys7BVs3TD99IpSwMWsMizRzq6fYIWFIlyH7pCtvc8vQHLNCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427428; c=relaxed/simple;
	bh=dn1VO7viEgZ4LDDcok3HMC0OL5AUmtyZDWLo64Dkul0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efr1M8acezV9rvORKO1oopz7kc/QRXxpfYjGzULvFL3lOT3WvqvCrWyg/yTmBTAm7pF7nijToLKhXoBq1g8cv33KqakBe4fHLWMxnHNsU0rcmxLV/Tjqtl0OqrKOFqAnT0Jh47ou+bJk605a+nHO/U//TTSpEja1vJcCA5LycZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZuvLafE6; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713427399; x=1714032199; i=markus.elfring@web.de;
	bh=dn1VO7viEgZ4LDDcok3HMC0OL5AUmtyZDWLo64Dkul0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZuvLafE6eFCkQLxSqrdhFO8iX/0R4L6hhJ1pxizfjg4T34+fHCasQ4gW57BadqNS
	 13V7RL19HGP/NNg2vajTFwIxfH3zajxgtjxjq+uWHHpGjD5ibxu85Q/sT0+3Uyccw
	 Y/mrYeGBxDgvqj/MPUwVQI48rXwQtOhKpvpK3Aumiz5T4ZUlTvRI7oEReyZ/Vsa/5
	 76LiE+RHTayx/aPdgQEt4xCa/R4G3FsxAIsv3PKnmpgrwvh5pRjIGIkbfAFddsNIU
	 gbiBOYRmhMRi8na2Fa7olZqYEYcQYcV4IQ9h2/+h0h1qtxl6w/Bzq9v2ww9ifMzpH
	 WXo3sm2zPSgQ1fhXPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1rvSwQ2LnN-00FOuD; Thu, 18
 Apr 2024 10:03:19 +0200
Message-ID: <2e2078e1-9a29-4bac-ab22-8f82199e9e14@web.de>
Date: Thu, 18 Apr 2024 10:02:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: bcmasp: Patch review challenges
To: Simon Horman <horms@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
 <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
 <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
 <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
 <20240417161933.GA2320920@kernel.org>
 <3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>
 <20240417203430.GB3935777@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240417203430.GB3935777@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lsJcvgvXFrg7UgLN5XFxyC1tZvrAOsSGuAX2rB09jVoGO1fAhAh
 zyCuWPXmw7fdk6sjRo3Gn5LfAVwmRIvaBuzzRN3iveCNCtWCBnG4eCZw+195tX831Epm6x6
 i/kNp4Qlg7Q+uvE5ehl3/761hV7miLeMcUUkH8PjHrlb6JxxMdkHKlHTKO7uCDpyLcy64ZB
 rxJusUKyfX9ssm70Nft7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yAIWmufHDr4=;1ab9tlrDq8iO7fChUuBobeRxyxE
 LyAvEIGg0bqF3/cRsxG023m7NVvf6FCLuttIFalyd8knENUqcSicgRYoBrJ1jnR49lLJ780nP
 9/40SBV3J8va2XNetmiBLvX7sHStz04glgIUn5AuINFoyHxeKbBAvtr2Zk4MOcPOFBJks9v5e
 vH92dufw5DrL6tl2KsrgDswS+SvWNVxlxQk6Kh4xMEdHwBp+yZ2ZoGwvsay4sD3rqhWAVrVFk
 sm21cwvP2I+HHBVrrCyQGDt0q6kDJaG+fMTu6uNjveKAmwm9ych3ZawQkfP0tRQ5aTw5bjiXI
 Fq1wCjjJC0yxQbFW8U9v/pmg2qp1VMgtkOx2cUB0x8zRBqjW1f65Rjr0AvZk+j88xU5RTIaAS
 D2ZOwOvC6Dp1M6p7xLvWbpk8AJ4GmNzP/jaLbvRJaQ0yy/L/B7SJPHIAzOAM0ZmArA3S7N9qP
 Am8Twcc9qRWWdvqy90NT0hXbKGSSbRct/8iGVMKuoLNAaQ+f/J18Y+eGwXUj/0uT/QyMlM5yF
 j7ELWqXjyxF0u2M/D3l8emi5TwjgYtWeqxYRuf0o3Ei8orKHEZILhuZOtOOfyo2URv7zvrQV+
 y1jx/wKANqrmAJq57egt2BshQKlzz4N3ebfjBXpZgGbJ6fdHlFujhzvKFL9KeR8BQS/EkMwmY
 af/wIIsMLW/F30V4cI5cM3iX6bVNeTvbYtsEt8KocvUlIohQ2gFlMFuIhhQHX+vkAs1WE/+Ul
 B/km1njBM79Y/k7LGEs7ywm83EmgAlwZXOThreXmW89RotQkgo0RU5cMNloYD86G0CK+dEzNx
 XfuiMAY+perzgThN/Sm+Xjlw9OTI5b5QOCcnDNjnSxav4=

> On reflection, my previous email was inappropriate.

I find such a response interesting.


> I do have reservations about the review provided by Markus,

Which factors are influencing this view?


> but should not reacted as I did. I apologise to every for that.

Will clarification opportunities become more constructive accordingly?

Regards,
Markus

