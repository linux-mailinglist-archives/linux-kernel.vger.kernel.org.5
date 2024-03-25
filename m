Return-Path: <linux-kernel+bounces-117879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8318388B0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44E71C3EC83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518E3EA7B;
	Mon, 25 Mar 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RlmY6apG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517910940;
	Mon, 25 Mar 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396931; cv=none; b=GDuww+WIdeVZaf+RRJq+1MzimsImPC+qMi3XrbbQCl+ahA3dxMu/wp7asXxEMzfAQgHvgyex7Teo95Rn5Ln4Eoanrm8OV408OEQyGGlXtWFgtXkk5fNaxnRr8miEHj9wu6uadx2yrmshdwKpd4XJJ4vw34tyZn7iwCMQei7PAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396931; c=relaxed/simple;
	bh=009pprbVflcZ0sjcpaw6nGfyrhZrOZSY1rzqbZbtUH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhtPaGVT51tBHSRW2G/RfMBwzq44p0BaJ4Q4Yrre6BVAqWlWJgFZq1+eH/pKoLS/BIOLE37ldGDv3LqZqloEk74z5ozutGFyyV6cOl+RxSZnxvzQgEVyG6M6Nd2m3qKkzoAmrDuYdniD+semq4KsBOWx/fXfhqQkveyrPNYX9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RlmY6apG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711396893; x=1712001693; i=w_armin@gmx.de;
	bh=I7xdYF/K+6S61x6pD/eYYW1ufs3VInyCcEDUxWcOQZQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RlmY6apG2Pb0OAvZG97KfZITfyEUbxyWkDN6yzT6UC1uHHcMAfk/C0z7qf34Z6IJ
	 3f36f3d2Y8VDy4jP72bGIgr+hFWISLj+YKystPhB20iMmgMbN1l8nwAKKP5hfCBt9
	 pb5SvZoOXzngv2GqAFD6RyBOKZnCbEVqI/QCFJFh6c2orCDf0XPbYMSGTJ0obkGpc
	 BjjBE5bs0GLfdw0ekCWZHgcCD0RAhkbDZVtCH5xDzDwneGP/AeVhqurRcBxwHkWle
	 uXUxEg7Ke3YMIj5EHVsbF6RvJY6gsO+X+cDleGBhWdxRPgTgYmKuPmdxvYVhmZ79I
	 Np/LI9KtE5qfHAu1fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1s4o110054-00G4zt; Mon, 25
 Mar 2024 21:01:33 +0100
Message-ID: <b9a8c258-94d4-4c09-8211-31466cdfca7b@gmx.de>
Date: Mon, 25 Mar 2024 21:01:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: Add ACPI quickstart button driver
To: Hans de Goede <hdegoede@redhat.com>, dennisn@dennisn.mooo.com,
 lkml@vorpal.se, ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131111641.4418-1-W_Armin@gmx.de>
 <c1b08bbb-ad57-4f41-9b7b-40a6aeb3da9b@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <c1b08bbb-ad57-4f41-9b7b-40a6aeb3da9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GNHzVl4jHoqeqTOsszHiSw52oCyqw/C/vlRxqHgdwjDAjPDs19P
 /MPCkFMgseVRFtemXk1xrUSknCB2LyWPGgDhZOwq2tqupfjhYCxeQzEOohUSsW+OiZ9Sg6q
 adiRdVx+vzotKo4oxJa4ZPt7quInqcF5fAFDWxv24BE0F2VHWLDPMxOBPfVZtQlFaD4C0hx
 cH5u/vqufpaPLeCmXT30Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VVggtnWfhlA=;9csI6wvmgHmZnfVAKKe4OyBqGX3
 0ode2c97zmCcRXW5YuU/Z849v4ExT57EQ2vj3HfCr+335zgKxeC2XHReIGJl3dFHuFdcIUthi
 5b3KvE9MPuBuoOTxVLE2ImoGuPOQ8rDpihfbkjsNqCNXehIGCxIUPKcuCIA1eXvgsEgAvDKNu
 nojdA/dXy7JWqD8hbCB3vYpUfxCBAx7CthM4ITmO40cu/P8jjyKS71VgqbsnzJ6EFhTP6TEH0
 iHndBleszoLd+KzcUlzWqYEp7GL4bhVnL8PU8ENyA1Q29GFmEoIK+fWP0zYzLl4DHe3ICoyp6
 r+2K3bozDVdV+t+Ak6RD0pYLG2sB10vPVeL8cV4ianloIJBhoGLOFEktwCoVSMFH4/obnztZT
 L7hkmhBsJ2lWQ4n/zY0wXQfOlgZedbpdg2SsRYtg3YKV9NdjtdI+87moBzV19KUA1a8c6iOjo
 JQUo95a/GQncumRCOlxsLX8/iQvThhwVDORJuVwItfrcWdwWZ1bFjsa8ByIubF10TCzSC7O+y
 lF3dB/jPxto2KjFxXeM5JFQ91njVoeWpX+6UoR0sCX+Wk8IDKEw/TA1XOVWWJdcQFsoizocB5
 F6XPhG57zyvlLiO7tcsUk2sc5nyf3oSqOHfwTUvBnEzXazcZAAs0RjmyeIdF1HVryxP2aRbHY
 YLie+y4aFM6IHwPjneC496zqCf2MVlAJr4BUCzO4E83kAtSHVAWnbGWFecgtWhvzIkDBTW8gX
 IK9b5GomVkJc+th7n1XmydOEOSO9+NJF5YwnMIkW7BjoxizVsN1EnReyWuCtElQbCIRe+gVLr
 aPw0dhqI/fZgFBr8F2vUrKyAVkGBISEU6OP0z43cY5pzc=

Am 24.03.24 um 15:55 schrieb Hans de Goede:

> Hi Armin and Arvid,
>
> On 1/31/24 12:16 PM, Armin Wolf wrote:
>> This patch series adds support for the ACPI PNP0C32 device as
>> proposed in 2022 by Arvid Norlander. The first patch adds support
>> for the device itself, while the second patch was taken from the
>> original series.
>>
>> Both patches are compile-tested only.
> Armin, thank you for creating a new cleaned up driver for the
> quickstart button support.
>
> I have managed to get my hands on a Toshiba Portege Z830 and
> I have successfully tested this series. That is this makes
> the 2 quickstart application and the toggle-touchpad button
> work when the system is running normally.
>
> Neither the quickstart buttons, nor the touchpad-toggle button
> which also uses the PNP0C32 interface, work to wakeup
> the system from sleep though.
>
> I've also review both patches and they look good to me:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> So I plan to merge this series into pdx86/for-next once
> 6.9-rc1 is out.
>
> Regards,
>
> Hans
>
Hi,

great to hear that the driver works. Can you send me the output of "acpidump" on this machine?
Maybe the quickstart buttons have no wake capabilities?

Thanks,
Armin Wolf

>> Armin Wolf (1):
>>    platform/x86: Add ACPI quickstart button (PNP0C32) driver
>>
>> Arvid Norlander (1):
>>    platform/x86: toshiba_acpi: Add quirk for buttons on Z830
>>
>>   MAINTAINERS                         |   6 +
>>   drivers/platform/x86/Kconfig        |  13 ++
>>   drivers/platform/x86/Makefile       |   3 +
>>   drivers/platform/x86/quickstart.c   | 225 ++++++++++++++++++++++++++++
>>   drivers/platform/x86/toshiba_acpi.c |  36 ++++-
>>   5 files changed, 280 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/platform/x86/quickstart.c
>>
>> --
>> 2.39.2
>>
>>
>

