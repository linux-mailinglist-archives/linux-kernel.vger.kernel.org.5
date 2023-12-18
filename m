Return-Path: <linux-kernel+bounces-3994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F149281766D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921991F250AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C43D556;
	Mon, 18 Dec 2023 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="n5cqUAHy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC43D57D;
	Mon, 18 Dec 2023 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702915007; x=1703519807; i=rwarsow@gmx.de;
	bh=VUAgalJo6l3NW0AO6ROoScbPspEfKIlzpzWkSvc/f3Y=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=n5cqUAHyvaUfggHwS8LOV6nuftVokmkUXBqAAoXqjHO0cU/N8+cjgTYaqKwU7qMH
	 77pWgBZqS67sZCthMkfpZwNva/DVojdXyGE7Jg6gAJN5lHhKA8ZgwHBOGoYpJheCr
	 5E4yedTFDJ7+cle14vXQ4VfnTGNUq/KbP3N+O5E6IVxMrvVELcbjqjIIWDNX7lR5Y
	 KpvBl79Km0RqzLgxJzQoc0CJtXBIcgLreSD0MD9kiLwqrgCVxIR341YtAiPY61Mp4
	 hB6pKggEcuTNpNAyc2vTHAEIIF2mYr6cr2Px044vMI+Hp7K8MvvvBvkwHASAe0hwS
	 A5R8P+2L7V/jWxWZZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1qqL5G0mvN-00jYU7; Mon, 18
 Dec 2023 16:56:47 +0100
Message-ID: <10e85703-5eb2-44a8-81b8-dc9dec102833@gmx.de>
Date: Mon, 18 Dec 2023 16:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:H5DLEfnojbYinGpYGsDDqe096Clyx9aNq8MqnNImWS+nialr+qC
 QGcSnxU3a2KpEa+LdpzVoYSJe4dQbKvHAIKyvWOAMMYFpm6UCGzQtsn+BGlojVytKBkDNcY
 f+fL8SzRlsNTFM3u4wdtk/Webr62G3Dv6Io9EIsTCLGv6vLSKO0KT61eA4JekML7JIMqCPf
 qIN7KIw9i9JoE/NWzHqzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LvLkXBV7ZpA=;1W0+zbWxsrLH0Ub6LaI0plit/jh
 vuyTVPQPfYUWu1WpZE73BaKy3l9fJstwwn4LpEkTsHrKyVJ9Tq99sBr8hSOwi2budyfSzpRc4
 gGpeP1yETwjL7Sbl5SHcUh7WMpBi8lKKBSb+xmymwnnmw4kUsrEf+QxoZRdzYcS9ybwgi8Bpi
 Bapm/rrNjxcqVb8r7YiQ53PEJx7jVNZF9RS/5RuWqrp/h73oYKfEGVxtf2aR5lVzSQ2gprROW
 SS5yM76Bt9z6Vpp6FTdRV8VrlJnTOOsx63/xnPbg1UsaXWrjeTNrev1Ff+GyoG2+lcBW5jtdN
 SXV+FUXqF+oUDWREbHOlotib6eYjIrBSgnN5LLXnRgVSEa6DutMIkrbNFUY2EiWAf+073WTVY
 fuTJqxD89WFgQmUTajNF1y5EGQjyi4G8QBt5ULF5H6fGOf0WMP3lxlCQI0ydYIquMgl7jQKv4
 X1xooXzEgtJK9wXO3+gV4QrO0xw2R06FbO6Yr5/vH5n9lUCh2mdV7Pr9/skJfAdNskqqLIt0V
 Es+yfK6ignoI4gEEXGOyLap3D55jM+qGzuQO3HXveAAGlYE01kIq7oPOKb9fQHilOQUR/ouyZ
 vxoJ8HM7josmFBmqrtloGd+JvErk4ZnoN+lTwH5vagC244OgSRiyJ38P8emwU17IGvLXKndPf
 61eEQXI4N6Czi0EqoP+i36j+4vBJUIP5QpGcaEX2EgOSKfNm0/GrZ9CpYI2e5g7b/RuvdtYSx
 FXXpISYA7RyMnGEg39/GsqrUmv2fNE57FYBrvveN82gRRDq5mMPRsNUDvS6O02it3C9X9JKfp
 aLw3mf4ANxP4uRfQQypSuTrWdJs7YiYZwJZv65CjN0TDAYSZZ3zpH4eUKsNIlMGP2cuD9ugND
 3KXAxglqug+ykHvMfgL7gHK7t0jgzM6WMP9ZvNkh0KkPh/XeGy1DKhvdIqYC2aMZGtKXweiAe
 FwkqxQ==

Hi Greg

6.6.8-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


