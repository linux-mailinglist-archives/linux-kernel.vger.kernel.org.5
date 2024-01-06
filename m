Return-Path: <linux-kernel+bounces-18724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04E8261D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FF71C20FAA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A53101CA;
	Sat,  6 Jan 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Q4MtuX3d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A3F9EC;
	Sat,  6 Jan 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704578697; x=1705183497; i=w_armin@gmx.de;
	bh=o4ZQiy7T7H4VBO5ZGkKv7nQ22efRB5aoihpH8d8Yz38=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Q4MtuX3dl/H80xW206xG6/TCGUhLgba8lKHeiV9JhoM+vJlKVl7IPSPlnYA5wa/y
	 ke5ZlBBLpHlNvnRiLrSeHbkj0/+JSX4O/bEfza1dYhvVKAMJJ2oST6xzbLeLGH+Zj
	 4R+7uFJzqp22D6yxlGwVztUGhholcxoGRb36RjxNVQFsDF0IEhGKkOSFySQySkgNs
	 qmi8EI2aTTVtIL1v9Ivijrur4myHHoBmnl/7sCqkAPJspjjm+dyPM3Y+pWtfuRPui
	 pG8w8JoNqeIaJ7fs/BLyXxyvmzf5cJv4vPW7YhC5pCLb8u934Eax97dY6OicZL/98
	 RYOlVTjct0RQapp7kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1rmKOO07wv-00QgbU; Sat, 06
 Jan 2024 23:04:57 +0100
Message-ID: <19a31d3b-d13a-4665-9c84-55cdabfad3f8@gmx.de>
Date: Sat, 6 Jan 2024 23:04:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Fix wmi_dev_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <9c81251b-bc87-4ca3-bb86-843dc85e5145@moroto.mountain>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9c81251b-bc87-4ca3-bb86-843dc85e5145@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B8SoiBX+mZ4LtbySoEE/uBop4v8l4OqMxX2eaFDkW+m/x8FlVrb
 YCTKxF7+mqW/Vzk9EDB23XU2oULmtbKqR2AU0a6XM11o1GIspuUjYg/7CTh3MvouNBfmIqu
 /C1msjReMLlAvfy4AqErYhTrQ8RoUGc3ITLyHs4ss+xA1wpBIowO/i1236NXpqI+3KgUocm
 ENhjzYG3BkPRFXdddOWxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YJ4U83dyBas=;dgFjxe4YCjjQb4bQt9JeYp/f9dE
 xddwpD9ChpBK2R5BNb7JVmmHptRc1/iMsgirraZ4zInkpnnhp4Y+sgwpr9Yrp20rKQzlV49ow
 tBEwtM3uthN2yLERg2WbIt53IPY+GPYnLiPfEhVeTBm408fkASPEadKh38hkMJihtR9v0deD5
 cf+fXCRzN7yBcbtyerGeLO1VWvoxeYCSH7epmpCUeJe7iZ42y5kT4yYE3G1Pk/W45dogYgv8K
 JSH9TiBtsG2+wLtdk0whWPD+xH2kT9UNu08xEcYxCzcney2E3TbH3xlXiwJnikDVQVPPcldQW
 20x8eP1FSlGLBx8AttM9ySikO5DE0ZUTPfIB8RKX/bdWPw7bSoYyj8bvHdcVDdbx+2uhWtotj
 HP5U7NjHUXWWTEEf8SIT1j19SDIbWZOnlHS4oGb9OZ6dXUlimxhRCdepVk95mdzhQisQPPRSQ
 9d3yfZ/pIRdnrbTBtm6ZIbfLBCrPEwEg85zw8EYyjQpTQ/Tqlj7ulTm7uywEmO2JlZnllBPX/
 3fM35dL+uHS4TgqSs0Ke/hlLInmMH3OJGwouzPSshZ7hIHBXKQw6a3NfRI1zzX+De4M33kc5+
 Qdo0hTIjt158S9G1SUh/fsYJk0hLLCQg3TgRPZjZpdKUcMXFYJ1qGkN5AQTU8GQDKQXQWV/Hc
 f5k6kiPuHDkvH8vZ67s+qvqLhnJkk8wAnP63wUpLWwXF/djZHVJcuVBWNohYwcWfgD0NnQ5qz
 n5NYCXatPasSJmWJE1zMmtjg9GWaUOxpLQoP23A1zMCjSjP/vBmjvyVI7RR1PzS1oseQ5zWFf
 BYJZ2lyiDD1ATLfu4lOV8VROwnfFSWXmL5sYVeFabb+zVRq1dFwBg7Fu8NksNVNelPH5fmnVb
 UVppvZhnOlcpDfk6icuvlTCmld2mTQSSEyKQ1C25v04qFkd+cCwlsDKGBcgMEhsKECx17lzWu
 7ktdQY8LH5ZDEMmMYZE0iq581Ro=

Am 05.01.24 um 14:47 schrieb Dan Carpenter:

> This has a reversed if statement so it accidentally disables the wmi
> method before returning.

Good catch, you are absolutely right!
And on top of that it also breaks WMI event drivers since the WMI_PROBED
flag will not be set when the driver successfully probes and instead will
be set when the driver fails to probe.

For the patch:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thanks,
Armin Wolf

>
> Fixes: 704af3a40747 ("platform/x86: wmi: Remove chardev interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/platform/x86/wmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 157f1ce8ac0a..e6f6fa2fd080 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -868,7 +868,7 @@ static int wmi_dev_probe(struct device *dev)
>   	if (wdriver->probe) {
>   		ret =3D wdriver->probe(dev_to_wdev(dev),
>   				find_guid_context(wblock, wdriver));
> -		if (!ret) {
> +		if (ret) {
>   			if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
>   				dev_warn(dev, "Failed to disable device\n");
>

