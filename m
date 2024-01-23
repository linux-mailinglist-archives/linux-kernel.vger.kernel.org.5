Return-Path: <linux-kernel+bounces-34919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BBA838933
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B512833C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4356B89;
	Tue, 23 Jan 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="uIoMOH3a"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F351C33;
	Tue, 23 Jan 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999012; cv=none; b=ZXUZCvSTrkrSW/kwZyqfmGnmcPAB+KKnFzNp8e2+d7nLikEfSLjj0via23ncyVy4Nf/wVfWxPdPb6VKM/Fhug7njEgM8RxFZNJe0+ts6lrcg/aMjivkuZx1BFcB9y8S9l0tzVwG3arjmCVlSI1P6AEN14+GE9kIU7PbMdV37pKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999012; c=relaxed/simple;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nVSFzI6QNN0c8qLCt77EQMPIkg0QdgMfZkVdPQxmyqViHXW5AnRR5ZDUjU1vq+LzbG3yXtHoPnWLSEzVMEQ51KPsMXA0JqegwpbH+FaGaxeCBoqAP3Br0Z5PLNsgOpByDX5EN6+aJyme37OkE4TyTjuLNTd1v56EZnuz2c9ov7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=uIoMOH3a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705999007; x=1706603807; i=rwarsow@gmx.de;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
	b=uIoMOH3a1lw75o7/YyqrkoSYkrwdZmW5EdF5Atver+r5C5jrBP5jcJ6zCfcLeRoK
	 qTnxRChbomXEvC2O374mUI3JHfxGMKCEsHPvrKHfowvzFLNRANR885dzpcrB8uhY1
	 5FMOE4f+O6H5HN2ZlUfPezuhlTS/eEmi7NZZJ3PZQaSLJ9jH0QmzzJVJEJxg15jWN
	 /61VFHKuPw+O0+Iw0gatdEtDhBs7xfCrMu55kUfROWoiLYTmOx9V69eMp+ZkiEVZ3
	 xNd8Cv82WI6lLVb8aeLGMySLa1Y8y6EChVUBaJAnkQeWtwTvsDoHhHO0RCYx9cRF+
	 avrmQ7mkZTrH7NbEug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.246]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1r5wQo0lHN-014PU6; Tue, 23
 Jan 2024 09:36:47 +0100
Message-ID: <82336412-3c43-469e-89c9-86a1014e77a7@gmx.de>
Date: Tue, 23 Jan 2024 09:36:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
Subject: Re: [PATCH 6.7 000/641] 6.7.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jPNyUrqyywUiH7zi0WZeS+Fp2P4SSfX8Vc12JCm0fM7vMwQwzJR
 R4Fadc9MWFkKOEQG7A9fiap9Kch4zPF+kbXU1k4OYLvAfOe4zw4vDFRngCpK/4g6gvxfbPq
 9hnrRLyW0UTXEB2MZniatBubC4Mvi1WlPiFI0yTbJaIFSc8tQQJ43W1TPJSjyBWnEth15QJ
 SaSDFfdmpP7vtPEIr8OAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L4QHpBP5Lyo=;oCbYo+FZtrRHG3KObX//WgzzriY
 tl6pO4hK6qItwLkZSCcyeP1QUbkR/m3bHroWmF7cZGRYBh/pZuoHGU5W6rr8iY5PcS7Ezd8yy
 ngOvJ67AwF2XrywlXsbyCZ61qDogxO7qimmdFEjgrxrool9kQTWddLTo7jowgVp0IjHQYHtB5
 CcazYArotovLjCQTF0bjjPG7CL9Nl3J5kg5I2fAiji2q7KN1IcTk2E28DkblRO8CFlvjClc3H
 VEq6+zUUbm+Ki5482T8xGPnLN47gMuE3ONh/I+eTXEw3X6VZGsMfd678YApiA8e+L36t46IH1
 HKmMixsJD0bQ8hutELW5yDQyjboXqIM9rmzChJxAw9ZjFyelw5eB2Eg0OS9fS5WdUl2U0bdyS
 97sfkB/MmeDmbdvwKB3dP4YSCKC3GKvT/yoggub8NidpJN7WtUp8Cm0kYl7yJnDpKnKU61Smm
 REQHfO6vDaUenFw+29hbs+kl2Mvjh5xFfW8EhbNwDTi7h1IaH2KcD5vLkfGzG2K7VI/glONF2
 S/FVHx3JqAwSOOtcfL78rQXzB7lOoOy5Y9jRMExjpQtm8G0ISLOjpH+rJvuYYAarFXCMg70pF
 Z1C+hMKZlI/WUXOcP6TxLeV1Ov6BU8PUkjIp0F4zYMDlC7OKeoW3TaoA2tqfISUlW6TAm2L1E
 FKM7j4+REM780/xBiBWPVJ2KyOR0eLIvlmCK1k182CknMSoGygo3xLPHVTU4U63GcmaieABbo
 P39Iq1ZM2M7b4cThNu6DqhsT0OBluvW+DR4wxKlQkCgeF/qxm0VfaqkP0odBa3BavMW9MRZpg
 m7hzn1/9FiYVIzDNzmbIO3nxzQilon5XO7egdkdRJ64eEKW0GW10u+D/5uWX+vL5iktXMdIj5
 phRL15sIUHZ5auICz8+DxDaHy0WskjSIIc2CsjalzoMdzXR6nNhITqhM9xGzWV9FXiYCUHBur
 CSCdgQ==

Hi Greg

no regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


