Return-Path: <linux-kernel+bounces-53058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678784A02A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92FE1F229CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F63FB14;
	Mon,  5 Feb 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RP60L+uD"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98344C65;
	Mon,  5 Feb 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152576; cv=none; b=F0nhvLDjZAdALJCnJ2z5TxA832EuFWTLv+63Yyxw/JmZ/SQ0d4jCxUjyEloBs1UD4rmE1y+haV7nOlT+PE53U2p38OsZKQZ/G9jd0GccIpuIi+cCxJ1vPbSpIfIfle1pTXaW1D04nayn6myRIPfJGwBlxJjaXFeOjKJwWjHn63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152576; c=relaxed/simple;
	bh=FEtoZVTwX+PACWbp6Frj5Ro7fkXR231I/T5/PExLQM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv0l0Ee6jqku52sQoaTP5QN3EAFIpgUrDfqHOEflkBbnCiy0RbtkbcoSrMmJNwobeJeRiZWDt2rUkKxgj+GdJGxKBqn6Ex/Hyn5SIdRlK5x8vH3hy0iYTOCb9GB5mZDr/kuqquXjqccsEjOmY5xm7aey78IOmkt2MQIlbW9R+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RP60L+uD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707152552; x=1707757352; i=w_armin@gmx.de;
	bh=FEtoZVTwX+PACWbp6Frj5Ro7fkXR231I/T5/PExLQM4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RP60L+uDb/uLFnb+Y5loiofiyIVl4L9DX2f59HvRPMR/IBFHo+0ESMvwsLEUr0yn
	 +FP9WHF2m2f/gKW7DHI5T2okY8Grv/ti2BGu+aVlJ6bWkSZU63S9NmDHGcS2ZG0ze
	 hdsmtdXm79jyhdjebbwddNIdH070nCdgvwNElMHDk6cnfv/ejvPkF/qo1ypD5tXwD
	 ffkvTDigutlP44lhUnwp8inXky8Nzx1MPBVKz7wgmPZJhbr5IgFWwlwwTRVUnf9ng
	 zDV11q46UXPmXyYlk0NyK00za0pKzRb/raQK4ehimJEssKZ1GhY8v6/hSoTPqovUG
	 c/usbIX5woNgnLW02w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1rLpAn1jdx-00OXUk; Mon, 05
 Feb 2024 18:02:32 +0100
Message-ID: <93e93056-d75c-4b12-a161-1e410f3ac354@gmx.de>
Date: Mon, 5 Feb 2024 18:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform: x86: wmi: make wmi_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
 <20240204-bus_cleanup-platform-drivers-x86-v1-1-1f0839b385c6@marliere.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240204-bus_cleanup-platform-drivers-x86-v1-1-1f0839b385c6@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+cVT64lPoE6dBRMF4R5MerrSeiV7gtTVXbm09zwG/JeVBwFSFsy
 mvq8CEHN1GKP5ce3Ye5cjU3pLwtgqHPTJ4rsEe3O5Z4wxP6RJxq+Xj3Edi6evo8ggThkNQ9
 4G3Srd67mIsIEO93HhLkwRF5r7+kAojEfyzcW7GMhO05mS//1Wp0LesWoR4/Btd3kM4T6dW
 Wr2J2cf4xA2/X2mmKhPRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MHFPugB5Jnk=;4B6ZCoPeD6lAfMKPv8cmx6wcsjC
 DwisChEkJqRmA+9kKH5GgptfOFNnSrFgl0Y9t6rMpr9YM9ezS3lKg81y43FrKYEEnWZDTuL2w
 H5G7jvsqQ/zvh2t/17dJsQPKGG8FYL4B7NUVNvuJBHQ1XadtcnueCKdmcTsLzQOTUrJSg55FV
 Lu6ou38z99i4uRfqOcQQZpD4i/DKLsgAeU6PVB5gwqiPh6D+PlUDZxJOzxKljT2tl7tiBYDPx
 SREM/+Luv+JIFZ7cdxnFyCMSDUUwcLdIaHtd4eXFCtJ6oiD6rQ3iBKuIxaKEMGHaP7htr09NI
 4mHLK5DheCGBw+t+8j/dAAC29jYfjkaBe4VN2xljFItadYM3YjeCfboYR43rdmf3fez0uYkSO
 7RIQNfX37eBcdzCYOYC9wkqrlMXssqimbO4HNucxHfKw3ICjkK/XLHxiKkVlJXmi+8cR0ehep
 i29ph+0nXYPmNEdw5QcE5GG/KHYDzQ8wlWp6pYMn+b48lrkPtGy852L6gNbSbA09G8sJUddXs
 iLaXBJgcjNnKhEgCyaTNstLQGIdl6Psc/LsSaKXPKWDTyyQBYxvaBLxeQX5FeGa6fO/dHQuaB
 Kik8RnRDUN/VFHd77YT5W08N7n9LASbry3A3mPZep1MVK4eWmdB8ApnztKqhPSyEpxJV/MYpV
 mXAfjWKrz60eUoh0608dTbZQa0HLW9xqZ2RxluQlrWf+UGTxN8h32RiQJPC5IOn4HLxF0QcEA
 dEOcWE64+iXo10fmB+Vi1L5TtuPl4rgvCp4viPedrBxmsaqr95eilGFRjNSPAIiuDlTfsiX2r
 Io8t//ao1SzV5JO/d5j4gRgF+JEGUGOd1xVYWJAGecMyI=

Am 04.02.24 um 15:40 schrieb Ricardo B. Marliere:

> Now that the driver core can properly handle constant struct bus_type,
> move the wmi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>   drivers/platform/x86/wmi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 7ef1e82dc61c..859dfff515d0 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -219,7 +219,7 @@ static int wmidev_match_guid(struct device *dev, con=
st void *data)
>   	return 0;
>   }
>
> -static struct bus_type wmi_bus_type;
> +static const struct bus_type wmi_bus_type;
>
>   static struct wmi_device *wmi_find_device_by_guid(const char *guid_str=
ing)
>   {
> @@ -899,7 +899,7 @@ static struct class wmi_bus_class =3D {
>   	.name =3D "wmi_bus",
>   };
>
> -static struct bus_type wmi_bus_type =3D {
> +static const struct bus_type wmi_bus_type =3D {
>   	.name =3D "wmi",
>   	.dev_groups =3D wmi_groups,
>   	.match =3D wmi_dev_match,
>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>


