Return-Path: <linux-kernel+bounces-143039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128D8A3380
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36AE1C20ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29814900F;
	Fri, 12 Apr 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="t2n6MS3Q"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C78149DF7;
	Fri, 12 Apr 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938597; cv=none; b=Eja/Q+9Vtb2xpKAVvWGCSy3iY7z8gJMIksi00WypjOCjExJFZfbMajSSVOcO8YM3bAZqcRG3hzz43NlNntnLn3pcrCu2uaA4JLJhbrGxl/kjzVmQqvSWJ2EBd+NVZDqr15ty41SRkM9MXK09sJK2S1YULzQJ8JVpG+WMrq5aH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938597; c=relaxed/simple;
	bh=H8Ts+fPORPk2Ob90sLzmeh0iBBvTzDDrCOxsmMu0ifw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS+qIMYp+pXMU713kLmQG+TysNmpBSYbej4E1Zfva4xQY/+W2axlN5uYBpjtcUAN6VFCWVkl3MiylwmkZRzc6NaZfrPoI7BE3apJDL8LqJi06zebbAyjF8f1C8u+W9b1Lokr9ayiACqG+eTEHqdNJTneRH5tEeXNFAfZBHAiNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=t2n6MS3Q; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712938579; x=1713543379; i=w_armin@gmx.de;
	bh=fV5LxrZ9sicKZYNtK1OwakvaLfgHSkOsJWQfLLQ6qj8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=t2n6MS3QRzAncGvP9ucdHs4rFukblQs6NX6A0y+74djsII75PW01mILy1Iqxgi0l
	 WpI2XDj50C55Nvfgd5sK874CLqs5E8pKHZc3lYgDQ3NYnd68ctiCzrFndwmwrEOP1
	 yf/27rX0/CvRn9OCY/wd2vLWZZLmx6cmwW6Cw5hbRjTH0zBeHcSwIljywojJBtYq8
	 J2CV5Wn58GTzUa2jQLQVI2qQqun4lcQ0dth7Yuxrr+LtktSJvjTWSIxoTNv0ak2HZ
	 cqhbZ62VwgE62MvWbHpAu/ICgoSN5hYhyVjvrtq47eW5MqcTMGDe+rud9IsmQDMNq
	 KqscBSu2A2cCzc21HA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1sdD741ToP-00iWgx; Fri, 12
 Apr 2024 18:16:19 +0200
Message-ID: <23c89f70-98d3-41a5-927c-ff4f2300ab7e@gmx.de>
Date: Fri, 12 Apr 2024 18:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPICA: Fix memory leak then namespace lookup fails
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 dmantipov@yandex.ru, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240403004718.11902-1-W_Armin@gmx.de>
 <CAJZ5v0i3TAyDERxCm5caud5x5kLbc6J6MKqXXFWecShYe-gCrA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0i3TAyDERxCm5caud5x5kLbc6J6MKqXXFWecShYe-gCrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tj9wE446LKuHlyG8F4jGP0znuiIlFLqdnMAdKcVvr9zI8frC2zq
 jPA41vUM0QadKXLE04LhDEB9jQRtm2SGEXDF+RVEE0X5MOgYB70k5WOE/+r8U1ZYRz21wLt
 7bTKTeEeFnvR2sFH+kAEFsZVej0qeWJNSP32p2m2hObQSSPAouSHwjBVLLVcc5QaFpoKXdh
 +oX3KMxPSG7qCEd9RgjcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XsfWYk+fZUY=;ZZPIPGT2e76V8iqvObNO8Vep1KK
 5mIBaGIYMknE7r+D+ddNwQfTcJrS3eW4ecayXEWYQxXpk68gY3KJ8jrrNfAdFY6OJR+TmCeP0
 r32VJbxnZyJlFxuhxlT1CN16J1kUGbZjHVKQEu+s2a/u1NwQ+KXKrltS8epsD8yoMu6z2r06p
 ekE5K5dcNAlpG0ye3BRf163ksRgO0pYjitUJqsmz/YRKSSXZL/UDMTaNRL6SY0avIYUIlIpc9
 Mu1WVmvGwmi5uxV9Sl4Yr1w2vLW+PgnNiOBKp9RQIpRkZ8843YVD2Sa/yoG1RfCOKvltnDLYu
 nDjebNIc2V7PwUs/361Nd6tQIIn0LNAke7LbbL4TGeqisldD9ygyLFpFpzVWERDDam7aflNuE
 JmyaZaACQauYW8lVB0iuTm+UHIjV8mq6KpeqLyd4WyaNfU/Ke4Zk14JUu20fV/Lz8WB6+dWR0
 KqOsXCsCS3LTd7/uGNSKIBxmmBUX9i2f85lJJLS7tqphXrPk3ZER6MqP339P7Dyz6PRU7ESDw
 AA4YPPfehSPGJsgu44JlT9HyugywG7F2ORsdbXpAV1iMkcZJXtilggitreiFWrawA/gUS0y6e
 lFznKkiXynOZxgICLypxp2pSNhI/JtCBsIzoWB1b6Gwvn5HiaIj1FnslD3dwBg/DSIzh/NBL3
 wbncWZVRuEeyqYextmoaf+AHc0lyLF10xZs+a5ov6ylZL7sDT0NANV4F8rJq1gnAbzINzbGs5
 7StkKPY9qVwktgtOoaSZKEQvIdoiwoRHr2yY+Iac23kOkrJyuBgibqm0cr260Kb2detPkpNVz
 Zwe3p8hcULDlOvBURMhucQ8Yqxbq1E2hz/iS7R+bTA1YU=

Am 08.04.24 um 16:29 schrieb Rafael J. Wysocki:

> On Wed, Apr 3, 2024 at 2:47=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> When acpi_ps_get_next_namepath() fails due to a namespace lookup
>> failure, the acpi_parse_object is not freed before returning the
>> error code, causing a memory leak.
>>
>> Fix this by freeing the acpi_parse_object when encountering an
>> error.
>>
>> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Because ACPICA is an external project supplying code to the Linux
> kernel, the way to change the ACPICA code in the kernel is to submit a
> pull request to the upstream ACPICA project on GitHub and once that PR
> has been merged, submit a Linux patch corresponding to it including
> the Link: tag pointing to the PR in question and the git ID of the
> corresponding upstream ACPICA commit.
>
> However, note that upstream ACPICA commits are automatically included
> into the Linux kernel source code every time the upstream ACPICA
> project makes a release, so it is not necessary to send the
> corresponding Linux patches for them unless in the cases when timing
> matters.

I submitted a PR to upstream ACPICA and the changes where accepted.

Dmitry, do you think that this memory leak is critical? If not, then i thi=
nk
we can wait till the next ACPICA release.

Thanks,
Armin Wolf

>> ---
>>   drivers/acpi/acpica/psargs.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.=
c
>> index 422c074ed289..7debfd5ce0d8 100644
>> --- a/drivers/acpi/acpica/psargs.c
>> +++ b/drivers/acpi/acpica/psargs.c
>> @@ -820,6 +820,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_=
state,
>>                              acpi_ps_get_next_namepath(walk_state, pars=
er_state,
>>                                                        arg,
>>                                                        ACPI_NOT_METHOD_=
CALL);
>> +                       if (ACPI_FAILURE(status)) {
>> +                               acpi_ps_free_op(arg);
>> +                               return_ACPI_STATUS(status);
>> +                       }
>>                  } else {
>>                          /* Single complex argument, nothing returned *=
/
>>
>> @@ -854,6 +858,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_=
state,
>>                              acpi_ps_get_next_namepath(walk_state, pars=
er_state,
>>                                                        arg,
>>                                                        ACPI_POSSIBLE_ME=
THOD_CALL);
>> +                       if (ACPI_FAILURE(status)) {
>> +                               acpi_ps_free_op(arg);
>> +                               return_ACPI_STATUS(status);
>> +                       }
>>
>>                          if (arg->common.aml_opcode =3D=3D AML_INT_METH=
ODCALL_OP) {
>>
>> --
>> 2.39.2
>>
>>

