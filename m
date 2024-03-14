Return-Path: <linux-kernel+bounces-103613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07D87C1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02A71F222AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521A1E480;
	Thu, 14 Mar 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eWDcwD/7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A9745C5;
	Thu, 14 Mar 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436456; cv=none; b=WR0RWZJeu8tbx29D9zTaHiuPTLSeJDqKS/t1a2C/NgpU6d/IYPlhbAfh1HHdONIT+/VnjQ+S06mZCK+Zse9v5HR+Q2c7cRUM9AZJEYu+RvLG7GBHTS2Dqn/Y3IevlwfhtQRKieMMXQ3TZRoZ8sxlTmYpsVjZ23yCBhXzfSXgDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436456; c=relaxed/simple;
	bh=sGJvpudGCcVMI/7PyVxRGt3wO6sF72dWKIY18zP13Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzcnkjdx/UUsm9BNo1fkQKJAxD++THyxXwJehECEM0dN5Aggfu8mzN4FCte3tTMJuI8JV/KPh1KY9BqB/zDTEBZeBWt0Z3Bv1UOCYdV8e40XwxYi9WCiwk+oI1qWkR3vsEPcraT7dToFzlMmGTUR0JyBfM0n5leuYt/8HzW1tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eWDcwD/7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710436428; x=1711041228; i=w_armin@gmx.de;
	bh=GYj30k4HHp6bCmgxsUmegwPFMsTQK+HFRzVney4N50M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=eWDcwD/74P2frGSrxDNUBR2nDDZhzUQF01Q2XSVDPTQBvN7kp8JvQeJxP1H03fh0
	 TrDBtkk8uiDJHT/4ELHad9cbhtkZA7/3uuk0lWFLc4r+0OHHNxbwsfck6HYz/ALzF
	 y2+KuSR/eUjMur2P/pDiR7IZutS7NOA0CHhtg5VGsmpnJ3PEYEi8xpG8IHh94/uCC
	 t/VsOZne/t1ZyIWVoKs6NgHy+lxYChoJ1Q3TefY0IUWQZyhw6J9r4+mkawxQu+66v
	 zhXztt6VQFBh8RzK4/n01HCe7D3183kV6ciqGyd0RMFgtVSAJ5bb+9+xxZKLa4kKq
	 RA22CkgvrBnkcOD4lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1qt7bM0srk-00yhP7; Thu, 14
 Mar 2024 18:13:48 +0100
Message-ID: <c8d20e7a-f772-4252-800d-c8379f5805e1@gmx.de>
Date: Thu, 14 Mar 2024 18:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add Dell G5 5505 to DMI table
To: tjakobi@math.uni-bielefeld.de, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240310220710.896230-1-tjakobi@math.uni-bielefeld.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240310220710.896230-1-tjakobi@math.uni-bielefeld.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uhzFzLDV43vewGrhapfK6icS1OcmdsbKjO7Eob59C2R69247Rut
 a6E8XIt8I1naS1Kfw1vKPr2bXeLLzWnAumIRTo5neIu4jDqK6eT6RMDJlI/GO/n+ugIbAEy
 dNDeWEcVnwwT/4TfdbrZ+1ya2tRy3H5IGYN38LCKjveVr1TENpYAOcGaxAgiBMz0yOMsZgW
 /gfahaK/TzpBtLcEYIJfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zn93wV39iMk=;Rk1Bd/43uSiJ3agcGAZaa9ty2cg
 rpyckrHBLVTsyz0NNrhk1eCzYPuZgBErq1cOzInJ/N/MFm36/o1qvtFWkA564FNMIvTVMusrM
 l5tdO8iPJalqZCT+3+Kqk4gYIi75xDHsq2apzxf3myLL1DspccsRo0jOw3b+VyhAnuYP1BJRO
 nfWGUWu1vgeLP/fKqTCBbIRyalb+AQa0MLmM57Q6DYBLEGEJKGL8pIfXgfR64j2GdRjXAqinI
 CFaQKG/vbZXy27LJ6s/qY4557sR/9bMtR+NOKeZ0Cwok5c6w/UQcpC6uYmAeFQTFhDNAVEEr8
 kYPJ+Ha6wYTKa14of/a66kfdDCDQjg+P/Orkg0dgFNJOdtF8h7lN1XTT8mzyh/o6ZNj66Uyxa
 SDpXJQblVEBwsdHV3gF+1A7UYVxD4FjTzAUzHvyzHOEiDiAle3qJLW5QPFL2VJA65rynst6wR
 Jviij8b8bJ9vpEPlwhHhjO0xmUOk28uJLb8wY3svpxIQJZZsZqS7Bk3aoUBMmPW4OgJSMTH3v
 pkLwKOW5r986L7bn4wye/2UKhj6WpRxvNPbb5HE9WmDGkKAz493TqIDVLXSQ6C72Hv2/lLpZw
 4uqsf60IjGsqQUJ9ndVzKrpt2UIPDutU32yPI42fSFioygJjHtEDTRviRQdMsjswz/bihMJv5
 xEHX6z0PVPH1ep4mGCPF0NZxv5WZ/wgTn2fBqrfoijzeG1DUt3RXIXCFYqdDU1xtjShXoVwi9
 lLu2IQujfl+qcaQiOSEubr/DPrSBRwlFKn+pKj+f6cdYxpVpJzn5mLbNBHiNxnPsy4vu/J1IH
 ZNcgqZ2fSfylKZNPejgXTNBCNa/oC03hAwS7H8QzY6KwI=

Am 10.03.24 um 23:07 schrieb tjakobi@math.uni-bielefeld.de:

> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Enables reading the speed of the CPU and GPU fan on the G5.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>   drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 44aaf9b9191d..02405a1dd0a0 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1096,6 +1096,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>   			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5590"),
>   		},
>   	},
> +	{
> +		.ident = "Dell G5 5505",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
> +		},
> +	},
>   	{
>   		.ident = "Dell Inspiron",
>   		.matches = {

Reviewed-by: Armin Wolf <W_Armin@gmx.de>


