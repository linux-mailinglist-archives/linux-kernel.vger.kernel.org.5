Return-Path: <linux-kernel+bounces-33315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE283684F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27391F22378
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614847A5D;
	Mon, 22 Jan 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HnG7bf5S"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280B47A4F;
	Mon, 22 Jan 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935826; cv=none; b=qLy7JSQmGkWLOKbCdcKlIgYikrT05DgOG1v4lxT+5nVhdu4nEUIG6qsJJE8HgWWrOgFLu1Jy3nu/uouEkF0WfNyDsxFb66Vfnn6xFnr3ukOH+o/SdXHEpMeOvXsvvfHlhGq1Xm4wrpk/XxRvK5RCwxIj70MAfRlTHCYSp9+wX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935826; c=relaxed/simple;
	bh=w9qcGRm3k3dRPApvtefoIrN7IWNH34s+22CXvM9oD7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceEippalf9qhoI0u4E2WhwetweNrNB0F1xiAG2z9pJJ5fQQRslpSfOKFDB+H2DLnNfRtRW33PHZ8CTwiDOZAiVo6TRxYaWjQdRFc1LzZdstGxD2Odyocs1r1CiQiSzAoU7hTPQXMiVq2m1oNC/86a/TvBJd22/jXgHbZIraaqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HnG7bf5S; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705935811; x=1706540611; i=w_armin@gmx.de;
	bh=w9qcGRm3k3dRPApvtefoIrN7IWNH34s+22CXvM9oD7E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HnG7bf5S5Htlodp10Hl2TcpjvqTMqx0ObltHJwq0wgbLvIh0irNUzx4V8J2gxjVe
	 Nl53LhzEKJautFtiyqPlrE9Vu85UAqcAYatBI9m6FZSf5SSytRZhD2vAd/pFxK5xW
	 RYxtvKm3JDM8mlQ/ZrbDkzMxz5uFed+X3c9c5sfhSTcccteqbTUoIKWItWPW2TNt/
	 FlIfB9erQdK+LIa4HCdDOqVJBFcH20G//I2wbvsJYFXdbc06abErFNLG90gSDvJPk
	 xV0+SvGLpDrMbiCOPyfcEapaO7ssuwC1LoJrnTGJZdFg9hGGrYBhqDzbQzgtVMFtu
	 HALVOPaRkVwiqJCVIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ygY-1rUhWf2LSA-006Ajh; Mon, 22
 Jan 2024 16:03:31 +0100
Message-ID: <f07b3156-2bc8-49bf-bc08-e40209b89cf1@gmx.de>
Date: Mon, 22 Jan 2024 16:03:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: wmi: Use ACPI device name in netlink
 event
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240121200824.2778-1-W_Armin@gmx.de>
 <1862d74a-7b15-48e3-896b-30dda835f28f@redhat.com>
 <61d23b7d-8e47-acf8-f3b7-bea1544ca8fa@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <61d23b7d-8e47-acf8-f3b7-bea1544ca8fa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNokfSfev7AxOxn4X/3r/omPlSnbHBhz+z+QiVP5TheG2XSue2O
 PsW0HkJWBCXpGbqpNZVGpztm/fTdJwFKlXTsqzTUFgHmvI5nTR3mYarBSSF+vJLkWq1tE9b
 sfTwzO1Tn5kCJOEWcnt1DZO6mnmtgF8kHt5jL1PCDQEweDrG98c+nIBD+GwIEpTkuBgcnGt
 Ba41VKmrUvr/z/U3Bwucg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uzzXGColSwA=;qAvjNBl7mztBL/qSZTLRwwG2Tq4
 JmuWPwbRlg9MODRmKmLZ6QGnuKk6fgus4e3Co3IKYS3h37BCjyiohKfZB/QNxU3WMtgF50x+d
 awVTluCHJ5uObjxCq3oLTjMuLLoYEdlVr4e9vZh/tRhoH3kGagWy5eKJFll7kRm60ozBD1Wgf
 OTfEHfuDEk3hrqRX3bEzjB2BevLoOOmw9R7IkZ4IvDLRL6gi1LaITGmzcRlLNDRAAjaeYjqc3
 Vkp3gU+orJu5wSXeYpEz+NiUXmHwz+cReaXgF0JGek2Ro+y56G1wsmmbIy0zhi72lsuJ1PRAW
 EfPd+7HcU/7kjgmp8+DYtXxvBerDawM4GPhZjQUgQ1BcifCA6iRpVmi9pc44aVuJBjtoZBrw2
 hV6QPWPDVBgT3NVR8vDFOTT91SJIfSdgacW57+ZV8GqDnOon6jQbpxQhFsKGRz4Qhwoh7XHHP
 Ba8X/qbGl3SOJv5cuXDsESHF0OLo8oE/R14hNms+rJ+8G3mwIRS2SVzUxwQzxOc9lYgIzeMGm
 E798wT8d/paOT3czwyf/9FBdVE+3JVq2PmRUIRGDYEbenPQJRnm6NS4JnQ6zu3T16Qz7c2Yu4
 Y0kclbZjsto/hakI22dD3ly9Wu2LrykyH1N6D817XEQRz2u5J5ST6s4RUIU65WvbfiiAJmslq
 4uGriTZiVBWupK7/KFvOeDQwcI2gc63kRbAW99QVUdCrfpmRNnqBc1UiDt0Kd03wsNuYAVqlS
 ldHhypmt5V3bVQNb/49VLYpuoZxiBOhQSzoqELLXY20s/RvNh6/VUm3GVMot7rFbbaX8kGNy1
 ef4SsFvOzabcgmuXhiY0XP92Y0/RqqSrjvtk/Lm6AtqzIXz6hPhUhcGyWbA1qELmvxIeL/3kf
 pe7JAP8TqEkUdnqskLQL+hwP5z11vm++Ydo7qt8vtPBm/vaPYhPOsdlMyVF3dNNPRZiGkovDT
 AJBp51EUHBh8lnwqQsbqZSWqYLg=

Am 22.01.24 um 13:47 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 22 Jan 2024, Hans de Goede wrote:
>> On 1/21/24 21:08, Armin Wolf wrote:
>>> The device name inside the ACPI netlink event is limited to
>>> 15 characters, so the WMI device name will get truncated.
>>>
>>> This can be observed with kacpimon when receiving an event
>>> from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":
>>>
>>> 	netlink:  9DBB5994-A997- 000000d0 00000000
>>>
>>> Fix this by using the shorter device name from the ACPI
>>> bus device instead. This still allows users to uniquely
>>> identify the WMI device by using the notify id (0xd0).
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> Changes since v1:
>>> - use acpi_dev_name() helper function
>> I'm a bit divided on this patch. I agree the new way of doing
>> things is better, but technically this is a bit of a userspace API
>> break.
>>
>> I guess we could hope that nothing depends on the old netlink API
>> format / name but I'm not sure we can rely on that ...
>>
>> Ilpo, Andy do you have any opinion on this ?
> Hi Armin,
>
> Have you tried to conduct debian code search to find the code using this=
?
>
I did, but i found nothing.

I am also preparing to properly initialize the device_class field in anoth=
er patch,
and this also has the potential of breaking userspace if some users create=
d custom
acpid configs to listen to those events.

I think we can revert those changes anytime if someones turns out to be ac=
tually depending
on them.

Armin Wolf


