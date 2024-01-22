Return-Path: <linux-kernel+bounces-33876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45949836FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB01C26326
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC164F8B1;
	Mon, 22 Jan 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Srjqd5bS"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6F4F8A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946128; cv=none; b=ShvJjPXaIVW3huA9h3RcHZAUPjuxECSM4TY9Q1fQxzw5NrPM/rsTkNs/mPuzaRXIUdRN7MIfPK2xB2uqbxOaMNgMyX/m4DQzBaVn3JPFxjntZKJ+jagod1QDAitHrWbd75UdOXlSetzgKydRUN/mUmmV4P94EnOvHobc7SlZI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946128; c=relaxed/simple;
	bh=Z+Opmu1Rt4tCX5MVhj54+D8/vXKM22/2IAw30+KabVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE8C3w6XDmHSwo/QBqZHRWbYb36lbNYm7HAuubG/2o2qqmpPAQQRUhOhqKY7pvedPLN7xKB7cfqd++dsY+PsNkC7YWr6ADjZPhMDBJ0C4j+MtmW6ZFKE5P4t/dDW2vMVGExRkDJsWTKzX+JcbLjtkIamP7F4MJ/b6BlW6/qKROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Srjqd5bS; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id Rjf7rN0sJAxAkRyWNruiSv; Mon, 22 Jan 2024 17:55:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RyW5ryhXOfPByRyW5rmW9P; Mon, 22 Jan 2024 17:55:25 +0000
X-Authority-Analysis: v=2.4 cv=T+af8tGQ c=1 sm=1 tr=0 ts=65aeac0d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=X4DcxGvjouP_kjswVi4A:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PEtLt9oS/A4lBJWHGJooEwE2XUDT6cLyAvihhnF+I0U=; b=Srjqd5bS66K1VHZzHNR/VDn6bM
	O8nGJMCIpPXXVK488IbkEG9R2qSOwCWKT9JU3A3h18UdGkIq8XUMQ6lkg3eiOTpd8inE4i+f0D8dM
	KUcduplO/sJ7N0akRnvqZUOF4w3yC/dOGye1Gdpj8uXyiz7dC+m35NJtKo9pnWThUKPE2Fm9bl0v6
	BayhLprpkTBS3Qu4ejIcSgxHxmqGjEjTB7BcF6fmdGKMkDlyfr6etzH5CT9B7WVW47WtkYSKexQc+
	vQ8LtzDbvIzWDADrv9JHZfS9o/UXq2mPbnFULxQWtDiDBxz+1KQ0h8DGSxSGOKGYwH8BBdELMfyyu
	gY1xQGNg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37538 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRyW3-001MU8-0k;
	Mon, 22 Jan 2024 11:55:23 -0600
Message-ID: <cd7e4133-5589-43b0-bc47-815b1bc53f9b@embeddedor.com>
Date: Mon, 22 Jan 2024 11:55:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: qat - use kcalloc_node() instead of
 kzalloc_node()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Tero Kristo <tero.kristo@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: qat-linux@intel.com, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240121164043.11222-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240121164043.11222-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rRyW3-001MU8-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:37538
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI4k951azhU4L7Xqg0pAUbI/8m5NpvoSzs2Uzphv7V7bA3WKICq1NFfQ/3YnNLEqMYfY3PSyWykAcXech/3SqEav6InLc0Rg2wyh7qeGvpkJbFIJFI1z
 9TjSNEDnKP2bQ0xCyXI5mJrI11J8JQSiy4+TDKW9uK/nZa3uFdZnzCttLZ/Q7FcKrNDGn9C+SfENl5sinyBiRt0I+H71FI6PrZtIo5Nqp+98C+QcM8fM9+NX



On 1/21/24 10:40, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc_node() function instead of the
> argument count * size in the kzalloc_node() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/crypto/intel/qat/qat_common/adf_isr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
> index 3557a0d6dea2..a13d9885d60f 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
> +++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
> @@ -272,7 +272,7 @@ static int adf_isr_alloc_msix_vectors_data(struct adf_accel_dev *accel_dev)
>   	if (!accel_dev->pf.vf_info)
>   		msix_num_entries += hw_data->num_banks;
> 
> -	irqs = kzalloc_node(msix_num_entries * sizeof(*irqs),
> +	irqs = kcalloc_node(msix_num_entries, sizeof(*irqs),
>   			    GFP_KERNEL, dev_to_node(&GET_DEV(accel_dev)));
>   	if (!irqs)
>   		return -ENOMEM;
> --
> 2.25.1
> 

