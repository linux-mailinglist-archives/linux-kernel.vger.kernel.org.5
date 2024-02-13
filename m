Return-Path: <linux-kernel+bounces-64125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8053853A57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E84B22248
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2063D5;
	Tue, 13 Feb 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g5T3In1K"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2010A1F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850595; cv=none; b=ZcJk2MIhnTL8hJaRyxMOYpBx5rQ0X7bWOveny3xWG3e3M2KhHjHv4ltXo7/tm0uZUWj3CE/EpYxsX/X6G7vthMi1RjEJczwPzeOdNCoLGDcql8P9mujGUfLqAZ97Qax2Gq+L3m6nN4Fy1bzV/kC/mcaUuW7V/kGFEGQwiC1w28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850595; c=relaxed/simple;
	bh=zKFRORcGW84Mo6dIsuc+uuw5aJ3Ah63nrU11poy0X+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkUEMSzAs4Zi/GqhtQ5+IQxN0apVJmZdh5Xsgr9vCkj/OAowrsKNF8XrmNfE6czoVetSl6TG8NduPsU+MFCzhqWuHI1a/nhDA0GHSICHl3jz21uoU+ytcusVM57RlWEulogk9IYe+XVQjjqr4n30dpQj2N7AXX5CxGcD47KNf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g5T3In1K; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a8900bb93so34273231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707850592; x=1708455392; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QunmobgMZ1Ogdo0966bJ3kfnHc85ijltK+bOh9xQpAM=;
        b=g5T3In1KiCUcxln00QYgFwJWTgbz8WW9POPlZEU6pW9XgMO5ma7km6rzbPsqY13X2z
         4etAXnxnycmtRzHTHZGItATkI2Jcmw7gxszAUhSahzHn16jl7MviYM8EHr/I45gSmZqF
         9CRJOsdnBMhp+pXuoQJaPCRY8eLefTuZg62Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850592; x=1708455392;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QunmobgMZ1Ogdo0966bJ3kfnHc85ijltK+bOh9xQpAM=;
        b=DCH8vTYRqNC+/cviQiF5P+fz4Ttab56ict0/YhGa5Ge1QLTBBSaGqNjvtB9j6sU8+o
         CDbReaQKpYekQEoIEFop7pRBhHLHL/p48MxtLtIYZ7+8WxCYfMFJL2QTYWR07HRFKjNs
         NpCd083gEO6FF9TFhWnYt/hQF3vj/uMUQ1aE0UUtYenTWVRn+rhXxkAo9AUxRreUQMOu
         X8kZeDYNvSu8+ibWd+/DX9n02B7+LQp8U2jH8kZ8PrEybtCg7k7xNN54iolZl3Yr/ms9
         lhWVuqqJokRxe0SZ2UOL6UluIIMX81yUtWv9a8BngRdLZhhLRqff+RC53hu7pCOA9n3R
         c1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVZG5p7S8U/xsKAGBpMErJLmh+T+yaxC1b7aydzNFyp29l3yC2Tq30OBaJDJaSLwfVESqabzmoKeRgjxTR+hOIgRuShNywlUMxkt3yd
X-Gm-Message-State: AOJu0YxpixT9tYr23HhetolMi2EZFfqKU9EnZWPyAMjO68rstyjOByP9
	2aMpTt21H48NQqdIMGmimilfNPq+F1dgGFsqJREdRUYX51dlZjzXe7cgQUotoA==
X-Google-Smtp-Source: AGHT+IFcLz6j6qh6cJdFKmQ2iojEoOsNLQlEdK3iUPg/B/BnnGA3gCc98PzIFb9EI+FzMUa895Hu2g==
X-Received: by 2002:a05:622a:188e:b0:42c:1cc:24ca with SMTP id v14-20020a05622a188e00b0042c01cc24camr208319qtc.61.1707850592337;
        Tue, 13 Feb 2024 10:56:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViBaT99ZdxVR2+qaQiw0/oJmKxr3LVhnOhW5FYI8Lh/m4rHAxCtO6vbvwKtH71wEjPx7hHfwCtt6ClSCs7oVhCsglgNCpTTEOInnTKKa35qAMhBNEFOkKY4mCkybAI4I/v/+0tVz6W5CwBdlnVw0Ih/Gx2/d02vRzTcOf5y7RH96NpO9dlahHaWLNettKC7Iz+bdg3yn1wi/n4azfHNwbmjLvnEuOHQBxqhjw/HjPkOTH0nmdnn5U8KcXd3w2lG2NzMj5XUCp/PtvJlAM+4/QHic8K8SGD
Received: from [10.69.74.12] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b0042c70c153f6sm1339294qtx.91.2024.02.13.10.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:56:31 -0800 (PST)
Message-ID: <3ced7d6b-0f7c-468c-81be-198a604a0efe@broadcom.com>
Date: Tue, 13 Feb 2024 10:56:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: Handle RX buffer allocation failure
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240213173339.3438713-1-florian.fainelli@broadcom.com>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20240213173339.3438713-1-florian.fainelli@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e88c8a061147f323"

--000000000000e88c8a061147f323
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/13/24 9:33 AM, Florian Fainelli wrote:
> The buffer_pg variable needs to hold an order-5 allocation (32 x
> PAGE_SIZE) which, under memory pressure may fail to be allocated. Deal
> with that error condition properly to avoid doing a NULL pointer
> de-reference in the subsequent call to dma_map_page().
> 
> In addition, the err_reclaim_tx error label in bcmasp_netif_init() needs
> to ensure that the TX NAPI object is properly deleted, otherwise
> unregister_netdev() will spin forever attempting to test and clear
> the NAPI_STATE_HASHED bit.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

> ---
>   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index 53e542881255..f59557b0cd51 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -684,6 +684,8 @@ static int bcmasp_init_rx(struct bcmasp_intf *intf)
>   
>   	intf->rx_buf_order = get_order(RING_BUFFER_SIZE);
>   	buffer_pg = alloc_pages(GFP_KERNEL, intf->rx_buf_order);
> +	if (!buffer_pg)
> +		return -ENOMEM;
>   
>   	dma = dma_map_page(kdev, buffer_pg, 0, RING_BUFFER_SIZE,
>   			   DMA_FROM_DEVICE);
> @@ -1092,6 +1094,7 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
>   	return 0;
>   
>   err_reclaim_tx:
> +	netif_napi_del(&intf->tx_napi);
>   	bcmasp_reclaim_free_all_tx(intf);
>   err_phy_disconnect:
>   	if (phydev)

--000000000000e88c8a061147f323
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDcSU6qz4qCAGLSg61UGzMxJPqXpiczTMaLc
Hi6AuBKRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIxMzE4
NTYzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQArxW/VosFvQbiI/3/ZKx0ClvFoBdFqenrqpk7oTAPMl72U6dDYkAFJ
+n8O1YO9QCHsfq6EQAs3AAgUR6hOIV+mb3p1RP6nhLTbX9Mhywv9Ooy/i26WohKpkqJj0hRzBBNZ
PQ8lvfCeHOZzfhMs9g9g3P19vHusOzx4F5wshaZurQMmPoZcEPdLxcDUNTjZpDqm1OVBQJBXtrge
XnyCF2h9mC9ETfI84lwCEhkBwgjk9STcEMt2zuNowd34fIBLP44OxOmlegGz99H0vxqObYudOAbK
xPrIIxiHRYMVQTJW7ASTJHT4eibuRIZdTEIPv4DQCuGLTSzPUECXjYBWCaP6
--000000000000e88c8a061147f323--

