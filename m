Return-Path: <linux-kernel+bounces-73997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4585CEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D651C22CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FB36B08;
	Wed, 21 Feb 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kO4ElkYI"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233A23C9;
	Wed, 21 Feb 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485701; cv=none; b=npTWN85PGJJ3eQYyJsZeBXPLq0wlRj1SPf1ZRKYwR20o9WBFjjptdRadJqYZcqxPIdLDmGMIgpLmKOusvL49FCktld+Ypz7sdyRf8/mjar9TccirhcNQ/nO+HWs38yp+sG1oUo641GshGJfoVT1GAVmC8whJoqGt2OQ8TC2HNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485701; c=relaxed/simple;
	bh=2MBUqFLjaJBHziRjULDNPWqkvMpoalF4kCD87la9pzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXOuvq00g4NeL6hW/9N2dfFdG+aTBX5gjnysBGr4t0cbz7sWvP5vG+vziiqvoabMpFVjOn7DwiojUEmaqQ5WJsutosnZeEXN29Vd5dUTSvyAwfj334PSr+H9PGQRBWOxSS124rDmp85iwscXhbrcXGO44R+qIufcO7WUqxxEXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kO4ElkYI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708485687; x=1709090487; i=w_armin@gmx.de;
	bh=2MBUqFLjaJBHziRjULDNPWqkvMpoalF4kCD87la9pzc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kO4ElkYI16QRrobe7NlodMFSItw7p9ZnHFsOpcnL9bLM8QBAB8lwkwziRxgS3yqm
	 P9rETrog2n5TyqWuRqlD90JzvlQ/efJLZlUU0uidGI5XZgkewrdeS4DN0Gr/1i4R3
	 niLsbH8YKZ+QIT80ljLUKu1zv4H01ym9ArgmjTAVYjCMRp4JAf/qv+JzJptLq6gnI
	 NhVRBN6bfxLU9Hr4903nIMrRcNTPsctkb6/MilGjf+L4z68n0RDLws9ESROtwl/ZY
	 mLQt/y4X+DDe5quIphNBX3aRrHlfVmsqvzwaR2+AVjVoHAxYwXa2FerC0o1Lj3AAI
	 YSdIAfQCq2KSDDZuGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1qqHna4Aam-014B4w; Wed, 21
 Feb 2024 04:21:27 +0100
Message-ID: <1dbec6ed-8af0-4433-8b6c-98759a21a287@gmx.de>
Date: Wed, 21 Feb 2024 04:21:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] platform/x86: wmi: Check if event data is not NULL
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240219115919.16526-1-W_Armin@gmx.de>
 <20240219115919.16526-3-W_Armin@gmx.de>
 <dcb7c031-b920-4774-a1a9-fed8813390d0@gmx.de>
 <954e9d5e-4800-aba9-4678-44584baaea05@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <954e9d5e-4800-aba9-4678-44584baaea05@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJDCiNtGjIZwYIgOeoyL83s0oMW36IbrNO9hEJiY+VDzZYn3oVj
 +1b6SszpMcKzVDfmUguA92vIqvnzHJV9CawGrfDPRbFL0DMB4xqzkhoIEr4en19kme7MCR9
 Otw4RUFpgeRr66aJx7sknJ8s87mRHbRCktbJINvFVvE8crqS3aQYk2LIBMccJblThbLdL7c
 CtuhnpvtSCr6rnBAqOujg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X9jwYBuaVkc=;jCA/AOe8oxAmOXB+hlSBIjF6A0P
 Wl4y/NU+onHc/XKSSUTPzGe7ecAOVtivRrbUORkwa9yaWWT7+clUNIu48mgvuKpFRlC1W+8Ns
 GOmrUhy40DEIY+gLvHE8gl3eSsRyBbUI9OfqLbrL0s0+Kf+rV9Po6uEROy38fT6TzLFF8iRb+
 W/DmHMOqta02P97TGmjEob8epAEZ1RSJl9WM5XT30yndtYQQAo0v1yGmUp/uXCPsDLamOv4Tn
 8JtNjsEFUeWiJM9KXIIOTBC8mQbempkCtEdyEa0+V0tUe6th7sYRE4mZzK3jdG22eSSgsf5X/
 9/Lzs2IT1lHz7u3jPhdMjllxEqazfqqioIIJR/C+M+BOoN9H3JMH19eja1cKtW6eFwgARp5Wd
 ZZ06IMYFldHdI/5GsQCApSolU9JvyP+x7Uat2soNotkYDbu2c6W47bpizzwB1n1IBavjdsOMJ
 mWgVxn9oFxuQH5XdW5ZMEIdV2q4lInGtTgI5byJDf6HOPT/5GY8FOgdKpQs4KheR2oApqUVRL
 ZtXjIrxtEqbrN1nlw6WgvjW/1tdRipEAIXT2Q/B3v6lz8fqNxHVJ7K7cgqmZ31WX8QOJeCkqN
 hZOrp+uoRmci9rzVhvJjOb9uK5SWQHXirF7sR902riasvB1WK1tACE5MX866nYn2gr+QHRgwQ
 /akGilZSCkY3ZcQxMdKBQcfHeL11Fv6k4mkmAO5N3EXd43GKs5gb9nRDK9/eV4b2o7Ua69sr/
 CV+1i6LfpQzftw5thDaC0tcPScHMycbE3QPVzeK6XokLU5hFbEyEucrEZEBhpuhfFHEadfaLk
 rGZuFFXIPaaBxhTXIXIV9Drlw8FeYe+fuSFivRVytFRNc=

Am 20.02.24 um 10:19 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 20 Feb 2024, Armin Wolf wrote:
>
>> Am 19.02.24 um 12:59 schrieb Armin Wolf:
>>
>>> WMI event drivers which do not have no_notify_data set expect
>>> that each WMI event contains valid data. Evaluating _WED however
>>> might return no data, which can cause issues with such drivers.
>>>
>>> Fix this by validating that evaluating _WED did return data.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>    drivers/platform/x86/wmi.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index 8fb90b726f50..d0fe8153f803 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -1210,6 +1210,7 @@ static void wmi_notify_driver(struct wmi_block
>>> *wblock)
>>>    {
>>>    	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
>>>    	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>> +	union acpi_object *obj =3D NULL;
>>>    	acpi_status status;
>>>
>>>    	if (!driver->no_notify_data) {
>>> @@ -1218,12 +1219,18 @@ static void wmi_notify_driver(struct wmi_block
>>> *wblock)
>>>    			dev_warn(&wblock->dev.dev, "Failed to get event
>>> data\n");
>>>    			return;
>>>    		}
>>> +
>>> +		obj =3D data.pointer;
>>> +		if (!obj) {
>>> +			dev_warn(&wblock->dev.dev, "Event contains not event
>>> data\n");
>> I just noticed that this should have been "Event contains no event data=
\n".
>> Should i send
>> another patch?
> Hi Armin,
>
> As I was doing some history manipulation anyway as is, I tweaked it
> directly in the history. While doing the conflict resolution because of
> that small change I realized the wording got corrected in the latter pat=
ch
> anyway so it was quite harmless but it's now correct in both commits in
> review-ilpo branch.
>
Thank you!


