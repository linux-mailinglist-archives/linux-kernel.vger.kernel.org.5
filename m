Return-Path: <linux-kernel+bounces-17838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70149825371
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827CC1C23012
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3173A2D602;
	Fri,  5 Jan 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="U6tNp3c1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC32CCD5;
	Fri,  5 Jan 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704458564; x=1705063364; i=linosanfilippo@gmx.de;
	bh=FeFq9f1LEHSJJFeWAk7/qG+nMMyVg8j/quqe2kNS2K8=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:
	 In-Reply-To;
	b=U6tNp3c1qGrUfmwFaWxWdK3m7Z9AxbgDAlMKEP/jP8T+9yDAwSNOH8M8skc68r23
	 vubMOb6KUxUA5pZ7dRVDyvGrJfm6XRJ91QWOUNKccP9j/G33/qNjk7/Hp7tt+skP3
	 OMVAYnnpfRDpeGleh0A9pTCHV8wwJpNp2Q2+KVJlU3BHDCza3kESAtM8hP0lUHP1F
	 UIrsRrvdjW7WQSmQzB9IBq3eBVl/z/CN84kzkEB4gcHnvx4KW65AhLN2mEro6khyr
	 mpBl4z6tQvcFvinBf0CMjnC4Tc44NQSvQsr3FDTNoyKXYfMtpyfyy7Q7PV0UPtxMW
	 T0MEXhd/Cj3OGqQBZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.15.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1qmOma03EG-00ZS1j; Fri, 05
 Jan 2024 13:42:44 +0100
Subject: Re: [PATCH v7 6/7] serial: omap: do not override settings for RS485
 support
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, m.brock@vanmierlo.com, LKML
 <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>,
 Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
 stable@vger.kernel.org
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
 <20240103061818.564-7-l.sanfilippo@kunbus.com>
 <c88034d4-cb5-b64e-7a76-194ef35f28@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <a41ae447-565a-4db3-96ff-30aef6455a7c@gmx.de>
Date: Fri, 5 Jan 2024 13:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c88034d4-cb5-b64e-7a76-194ef35f28@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pchYpIMV93nsbeYzl5wDPqzNit1opOGKWax2b+K7V7kiudOo7Xh
 2XD2YIoFvNvoCM5jJUJINXGblK48tYOxLTRuSyJL8pcV3ci7UXozjlV2Wd9inajSMhUYf9w
 D+xdKApyilZcu/uB6KNXCj2tvU7+a6NCVt/CLRuO8WJGH4M/7ks52EC2ivIY7O7LlaZPKw4
 g9/CTU1ne66xifS1il+Pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T4KpTWouqx0=;OKKxA3jIye+cUL0iCOD9NzRy5pp
 qDkUmW4P62E4SDjw9QRL6nCKpOclFMHVJVj5V9Yul3y+lbLgi/7TJJgPjvclseqD6Ulh4tkFp
 vIG/tjjhAZvHZ74W4fYE9EO9lajkHSwNRSJEKoAOYtUHgrksU88ScnqSry1nXX/q58lPjxP9h
 3RBVt+AHKH+QbEwC3NAqXLn1nm7ACJZC40IMODouBCLobkgViWb+ovitzvgvX76yP4mAAgmEE
 u7R2nUwspNVBHlh6bEJ7ncwwO/jXjTzVvg7XBmGMcxRTpa3OGeSxS9U6jv3pEMMQyhsopeP7Y
 MiM+W77d0mZAo7Z07t4gwp6rrkoMDfZ78gol9N3oF+XzmT6vryg+0hNvAKKA1Z9hwIIz85hht
 N7HO+nyDUYvdI/uus+3WcZCsjfqLWnDd1xbBtg0ImIqznZ2r4Mp3A9mFBaclh3vF2UV0x3Lbu
 BMiews4A1xHsYP/fQlUvhhsrR7XWgyc0HykF4H5T27046fckP1XhuKbAAMjoCjisBNIPRlk0V
 qs1tRe0OthmuB5itOhddTw00KbBy3xvQuECCI5LGPPp9U1mndHrGprV47ltpe1h+NsiWL5jkf
 EzERKiWRCCBhUErBj3dwmGTzZxJO1JWz/nfq94h2CCqnpIObOfmkQphOYJ8eYIn+bvab1uqz9
 r7Q8ppyuhaaelg3SDmSzyXvWEB7H59WgYfeB7uG/MmDrz69hi1MdJQ/S6oyfEzonf87JTq/z8
 h/gglhvyi++W9AmXuo5XZMcdzbb2TxAzzEsPzAbgHZ0afeWakTqHYKA7mU5D2s9o7Xl1nwOeA
 7Rc0TEccqor7kMNv1ey7Ng2gwUH0O16Yp+/eNsWGjyDDpwHInbpSetPHngudF2z4+aXfBotig
 LQIk8Bj/M/O5gOS8RzW2S0yTmQZDRlfdO8V9UFtthmNVF895QKCmnZkiT/9uTjDYsUaR7vO6Q
 VgUStIs+MRWnH8OFoqW9tAE8YKA=

On 03.01.24 at 12:36, Ilpo J=E4rvinen wrote:
> On Wed, 3 Jan 2024, Lino Sanfilippo wrote:
>
>> The drivers RS485 support is deactivated if there is no RTS GPIO availa=
ble.
>> This is done by nullifying the ports rs485_supported struct. After that
>> however the settings in serial_omap_rs485_supported are assigned to the
>> same structure unconditionally, which results in an unintended reactiva=
tion
>> of RS485 support.
>>
>> Fix this by moving the assignment to the beginning of
>> serial_omap_probe_rs485() and thus before uart_get_rs485_mode() gets
>> called.
>
> This doesn't seem to accurately reflect what the problem is (which you
> correctly described in the paragraph above this). The problem doesn't se=
em
> to have anything to do with the placement of uart_get_rs485_mode() call
> but the if (IS_ERR(up->rts_gpiod)) block that clears rs485_supported?
>

Right, this should be "...Fix this by moving the assignment to the beginni=
ng of
serial_omap_probe_rs485() and thus before the check for the RTS GPIO."
I will correct this.


> A future work item that came to my mind while reviewing this: I suppose
> uart_disable_rs485_support() could be added into core which memsets
> rs485_supported and rs485 to zero so this driver could just call it.
>

Yes, and the ar933x driver could use that as well.


Regards,
Lino

