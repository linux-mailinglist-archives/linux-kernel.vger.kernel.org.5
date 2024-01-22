Return-Path: <linux-kernel+bounces-34027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD709837210
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485941F2E8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11DC4177A;
	Mon, 22 Jan 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QLmRIspG"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2E4120E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949438; cv=none; b=Loy3g/mELOmv7+Hic6bkCVpMFU4OrzVvsq2JLuZe5D4A7r7TsciWi1o4D22//3cVgT5telb3/81EmLK7rUTOFTilwxm0v6NXPPw/TEaR1yzbkj14h3fqU7DCcfIBVdn6XO6UgB6f5N5rYXD6J7g3YL1IdzBjdn313Im6Ym+5/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949438; c=relaxed/simple;
	bh=3Gm3NFIRJpo+ABNLkRorMvWZBitigOq5T5XT4qLUZPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDOyWI3oATQQmiltvfbkxLeyjQ/bHnVMVAGscby+vEzN0Xs3j1vjhL+A4RANmv4VclIrXVaZec7F5DOLd708/Hj+XHK2Ym467y+imoFRR2wCXhSHb0ldtWTgjvNBOwjY+XG5VbfBCFHWcDKgJ3j53GHvlVCmVUssV54+AF0E+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QLmRIspG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a4516ec5dso4673331cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705949436; x=1706554236; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icGgGwfbwmQlkZbcAF5aP5UwcalxZPKfdUIUyNwsz5M=;
        b=QLmRIspGCLmsNnDpeJJBHToS3z2kAl4YcwfXjL12qoJuyOQpxc2UUTxDmxuRhCwHvG
         iLiZn1GKQL6/oOA5ayCwDS6ndeyBTPwBYrR3xY2Q7QBBDzgqMn4IcXq4t930wzgRBJnQ
         WXXWJP4s72WdTdD1Fg+u1S+8alNE62BMh18zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949436; x=1706554236;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icGgGwfbwmQlkZbcAF5aP5UwcalxZPKfdUIUyNwsz5M=;
        b=LmUN7y0GKUSh/eLd5JJLx9TKUTb0PVhND1o9E4bnH7voeAx6XrXZgVNy3ChVQCtdZf
         irHuEA+8gorMBwhYu2M1F3qE1dnJN2uJ+8vIVpn8GeOFydybQpfcR7Jrkw837BdOc7uL
         Swx0hdr1G1GWLph8UZpLei00xNsqtULySq1k1d9u3cPf/Dm5HHuojnS8cTouoSzwDrJ2
         J8QFNsN/9ii8tXqYmesx8ABIXyzqRgmaar2puYB+1Z1SmHMGbcEfYBtHTuAfsA7jaFJs
         DzI5IzGkb31fMdW3LeGN9c1dsV0yvScCdQUTgJxjM11leNVW9WABoXwEdXXx5o9Z4Mlp
         k8uQ==
X-Gm-Message-State: AOJu0YwjDX6335Ab60343r7o2MQ1dT3IvtmfR9Dp8nWpM4WQfO4ibPbg
	8wF2pBmlgSV/XiGb7JsFBsMAOHEoePhnWGePc8zcuDEA54gphca8lHRU/RL1fA==
X-Google-Smtp-Source: AGHT+IG8KkEjzSNaiLBq9YB78tAcwIVyUIDda1E7x0/5EFD/tamvRmy1FXEplgjgs5LJsGBXnuv90A==
X-Received: by 2002:a05:622a:45:b0:42a:31c9:4b4 with SMTP id y5-20020a05622a004500b0042a31c904b4mr5970552qtw.68.1705949436043;
        Mon, 22 Jan 2024 10:50:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p16-20020ae9f310000000b00783391f2066sm2317962qkg.58.2024.01.22.10.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 10:50:35 -0800 (PST)
Message-ID: <4eff5139-b5ed-46a5-accb-5b2fea9ab212@broadcom.com>
Date: Mon, 22 Jan 2024 10:50:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/22] net: fill in MODULE_DESCRIPTION()s for
 Broadcom bgmac
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 abeni@redhat.com, edumazet@google.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org, weiwan@google.com,
 "open list:BROADCOM BCM4908 ETHERNET DRIVER" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-5-leitao@debian.org>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAyxcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNhZ2UtbWFz
 a0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdwLmNvbXBn
 cG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUbAwAAAAMW
 AgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagBQJk1oG9BQkj4mj6AAoJEIEx
 tcQpvGag13gH/2VKD6nojbJ9TBHLl+lFPIlOBZJ7UeNN8Cqhi9eOuH97r4Qw6pCnUOeoMlBH
 C6Dx8AcEU+OH4ToJ9LoaKIByWtK8nShayHqDc/vVoLasTwvivMAkdhhq6EpjG3WxDfOn8s5b
 Z/omGt/D/O8tg1gWqUziaBCX+JNvrV3aHVfbDKjk7KRfvhj74WMadtH1EOoVef0eB7Osb0GH
 1nbrPZncuC4nqzuayPf0zbzDuV1HpCIiH692Rki4wo/72z7mMJPM9bNsUw1FTM4ALWlhdVgT
 gvolQPmfBPttY44KRBhR3Ipt8r/dMOlshaIW730PU9uoTkORrfGxreOUD3XT4g8omuvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240122184543.2501493-5-leitao@debian.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000294d9d060f8d4e5c"

--000000000000294d9d060f8d4e5c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/24 10:45, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Broadcom iProc GBit driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/broadcom/bcm4908_enet.c    | 1 +
>   drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c | 1 +
>   drivers/net/ethernet/broadcom/bgmac-bcma.c      | 1 +
>   drivers/net/ethernet/broadcom/bgmac-platform.c  | 1 +
>   drivers/net/ethernet/broadcom/bgmac.c           | 1 +
>   5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index 3e7c8671cd11..a6bc5ce70230 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> @@ -793,5 +793,6 @@ static struct platform_driver bcm4908_enet_driver = {
>   };
>   module_platform_driver(bcm4908_enet_driver);
>   
> +MODULE_DESCRIPTION("Broadcom iProc GBit Ethernet driver");

This should be:

Broadcom BCM4908 Gigabit Ethernet driver

>   MODULE_LICENSE("GPL v2");
>   MODULE_DEVICE_TABLE(of, bcm4908_enet_of_match);
> diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c b/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
> index 9b83d5361699..50b8e97a811d 100644
> --- a/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
> +++ b/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
> @@ -260,4 +260,5 @@ void bcma_mdio_mii_unregister(struct mii_bus *mii_bus)
>   EXPORT_SYMBOL_GPL(bcma_mdio_mii_unregister);
>   
>   MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_DESCRIPTION("Broadcom iProc GBit BCMA MDIO helpers");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
> index 6e4f36aaf5db..6c53ea522daf 100644
> --- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
> +++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
> @@ -362,4 +362,5 @@ module_init(bgmac_init)
>   module_exit(bgmac_exit)
>   
>   MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_DESCRIPTION("Broadcom iProc GBit BCMA helpers");

Broadcom iProc GBit BCMA interface driver

>   MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
> index 0b21fd5bd457..5bdd875831f1 100644
> --- a/drivers/net/ethernet/broadcom/bgmac-platform.c
> +++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
> @@ -298,4 +298,5 @@ static struct platform_driver bgmac_enet_driver = {
>   };
>   
>   module_platform_driver(bgmac_enet_driver);
> +MODULE_DESCRIPTION("Broadcom iProc GBit platform");

Broadcom iProc GBit platform interface driver

>   MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 448a1b90de5e..6ffdc4229407 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1626,4 +1626,5 @@ int bgmac_enet_resume(struct bgmac *bgmac)
>   EXPORT_SYMBOL_GPL(bgmac_enet_resume);
>   
>   MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_DESCRIPTION("Broadcom iProc GBit driver");
>   MODULE_LICENSE("GPL");

pw-bot: cr
-- 
Florian


--000000000000294d9d060f8d4e5c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKS/gciKeXJwEc5o
fUE3jIdfu67b9o2B3c4WCMZGxgS7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDEyMjE4NTAzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDFTiWjJRFgU8tnkY6CVYlOV56ZklFsFDfv
ns2v4/EzCAY6f082mzrkElwFKGNZ0Xn2SBnvg+0OMPp4pfHFTRti5XqrV/BMkL4o6DbyDP9IxrQm
LIn6iSVeRk88aH+czBsKaGrDtZMkpWsnCFkOJQr1SZosAWCOmSiQzMGA5OoFTAwar+WiMAoZDPLw
mMaE9LIgKWowo1oUU+X+iXDY7DTFnaST4iWdsCY8z/kXt30sICfVICuKIwfoa6ZpJ8cRWv5rDM2v
uxUVgFZQNMsp6yVVXWRbOq1b4womMPDPhdCFnX2hTd03kk4MdxHlpE2nVltlFP/m6tDE30TPHXIb
g3nW
--000000000000294d9d060f8d4e5c--

