Return-Path: <linux-kernel+bounces-2781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641B8161BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0560AB21E9A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED8481AE;
	Sun, 17 Dec 2023 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Yg9gl2IB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CB47F79;
	Sun, 17 Dec 2023 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702840677; x=1703445477; i=wahrenst@gmx.net;
	bh=AX4lHlgq9JKPdeXZfLkm/inQf0LnPS5SF4KW6q3dgqA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Yg9gl2IBB1viC+JMtA9JmlTG1mFV8nvY9oj+JIoCNsXOfkqyWfN423jzH5ueIEYm
	 q31Xl9GUOegIxT0DUCYEeXbB4CmwwSrOI9ojQgocDfFSRBdRXaaL8v/jZW5feXqJW
	 RBPorYEaYcQPL2MOXUGBNWSbW+RVMy3cG2tz1HaZCFp128hhuH3DNnjnTHbVWzGck
	 WZIxQ6nTxumoPwR1NFjR41nOq8EMlcL+T3LhgJQGX8dGDWeiq5GR984RnWTjcXKyi
	 yGcXg31zy9XEh78WMFdicUHAn5iyYzrUSECKKJl91K9ddAgx8RL06C6jkgzazK/ew
	 m1OT/qmb9dqaX0aJjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1rZUPr39uQ-00oCNL; Sun, 17
 Dec 2023 20:17:57 +0100
Message-ID: <8cdac20c-e860-4157-95c0-6e8250e50af5@gmx.net>
Date: Sun, 17 Dec 2023 20:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12 net-next] qca_spi: Improve SPI IRQ handling
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231214150944.55808-1-wahrenst@gmx.net>
 <20231214150944.55808-3-wahrenst@gmx.net>
 <c5b81005-e309-46df-b534-b24814d10006@lunn.ch>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c5b81005-e309-46df-b534-b24814d10006@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UXnUwy0WzBMA+K4ONhel7DRkYSdrQRvn8Xuv0Gub1b3Cdkw1sFM
 lMSU3RLgb2/EVL2MHnz3MyLZCmTO2sajE5WVQgqPmlQjxHBboCss3BH+SnCe4NKcl6tTZ1m
 W13mwNEtNiDlHbWMEYClfcTly5JxFgyn1WiIB1J9guHkg75rvl2630gogL2harmW2pwFgBB
 pGSBmfQlnjGMpWT9KQGxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WcVz3KETitU=;L8+8O7zSHtFOlkkjZnUzw3Fkmk8
 43BzEzHCqA7lcNX4ft/Zd7MhDzPJo4qSq/eohocB9PmxHLsRI56anjSHDEnuR5SU9Leo3wBSm
 slYDRaObO+c0UxFCYZGFPOJg+DsMwIrW1blsL9CxNlUPXQfsXsSDwBOe7QK4QRDLVwI1l27k0
 7W3YLE5XBkynNAka8RjyNkt3bbNNufoTRkCPa91ul2isNmJU6cI7U90ao7jLw5yR/s8TRkETt
 DEU6tK0Ewc697/slEAyf+3OAfvgUy5JkFwvPj9vYJU2BWc0ZWsFF9J/8ELCBHbljt4YADwQgn
 NgUELadviZMoFHPqmmz3ut5GrcM4kBZilRVbV+S6r5WsIeRHKmCCAla6prHRhJqA4HRop/XEX
 tn7GISx5uFordIMVM39/fni2O5MbkK+NoeKXiTCKFsSBjwJ0N6THUkw0cGlmjg9LLne1FW1Xv
 UyR71mK1YxjMgD4O6a3yUCe8y5GZaxzbye/LEbSyKoY2XqneVM24WeWcyIck6V8893E8RI8Vk
 1QmapkhyPt2ejhRyg8vMO9HWEduO5L1CyHws7KrNkW4Bd7sgZ+ZJxVHpeCAwuCp/oZ/yCbpHu
 xd7667mDXNJ1TnDH+HEDKR9LpFpkgD6lGPUH3/yBly/14SecN+4MiVV1lRZc2/kyj6A7b53Wf
 rjnAll0nDaN6dutQN9UHVNtZhFkCusXS0bx4k4I9XCocOmF9GNBaqQvhxxXBZQn0nFVKgzTX4
 oZiPYIHTEvCm2pMNYayjbQfWXWc7J2wkdMw7EYPX53SFL8Lhn8Jwf0RCeS2YoV1D1UxniUMbV
 tUNAOQWmoYhtcXtvahj2G11F7GCA4YWbGD0LbFo9VIw1pemBHe/lkcV4ALU03D1axsR3po7qG
 FSLB6X569wsHsoFdCm9OIIRb5yDz2jot32XnyhUB5OqfPQlpfHs1Uh1tkEUb3GQjMsTqEgs3T
 uYXd3w==

Hi Andrew,

Am 17.12.23 um 19:14 schrieb Andrew Lunn:
> On Thu, Dec 14, 2023 at 04:09:34PM +0100, Stefan Wahren wrote:
>> The functions qcaspi_netdev_open/close are responsible of request &
>> free of the SPI interrupt, which wasn't the best choice because
>> allocation problems are discovered not during probe. So let us split
>> IRQ allocation & enabling, so we can take advantage of a device
>> managed IRQ.
> Could you replace the kernel thread with a threaded interrupt handler?
the kernel thread is responsible for receiving, transmitting and reset
handling (there is no GPIO reset in this driver) which must be
synchronized along the same SPI interface. The interrupt just signalize
a chip reset or a received packet is available.

Could you please elaborate this request more in detail:
What is the problem with the kernel thread?
Why should i use the threaded interrupt as a replacement instead of e.g.
workqueue?

Please don't get me wrong, but i need to convince my employer for such a
big rewrite.

Regards

>
>        Andrew


