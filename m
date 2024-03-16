Return-Path: <linux-kernel+bounces-105276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34087DB47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7389BB21799
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FB1BF2B;
	Sat, 16 Mar 2024 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wevPgso2"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48414F7F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615657; cv=none; b=FirGBN0PqJ9i7pKxg9ITOBjcIv0RH6/sWNowtb9mJWinYb5mBe0aMyL1PYnmXs4gMPJQsiSzPIW3PdZ1itFxemXqhIOPZdVXe419PKo5EuGH8bipSdsJQ7QMeFQxCrORBHbB9W2EbOFVY9LyLC0B9C12XgTSoeKavfeDrRSPYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615657; c=relaxed/simple;
	bh=UaBIRXmICBdYqq7e7oTf77ZP4e7SfSf7lVmL7cq9gOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5eNe9kFFTVtxAdfGk/TVjoPMnB8nG/2IeeMK397FWLhkYqYnylIPX1/2DUnFyPBQo5khJidUZ9RPIGXLaxxO/bhZ1KJCFQ+NtcHVSXDD29G0M8ZIQppATCc9OqmHjsfrpXu5YCpEq/b1MCQfNm3hFnlU/2oyAQwiGfwFUPV5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wevPgso2; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id lXQLrbUBPHXmAlZFXr2vjy; Sat, 16 Mar 2024 18:59:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lZFWrZKSFc1LslZFWrPzKs; Sat, 16 Mar 2024 18:59:18 +0000
X-Authority-Analysis: v=2.4 cv=IbKBW3qa c=1 sm=1 tr=0 ts=65f5ec06
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=GHxNDdVd_46DcYOc0x4A:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eI2igFSMoMgGwV+GQ0CiFXFR47TjD/v6V+k+ICTNe+0=; b=wevPgso2IGgJVqRnHCsH+jTtht
	/fvVibwPPB5J/OH88rwhaoNKg33NtVSE8ox40WAypeiCafMWiIyhS1rx7J8Ei0hvkzVMyXv5DeyOR
	REN45azO0qHulKDe4hZo/UPzdWYMBj4cGYZ+5T4GyOe+qIpIrw5bqyfnBLznToKXaeN0D5XZQhwx8
	sUqVn0YmekN09fFLK+jzjnsHhtX8Sm2QFhnLMeUfoZJyPyUZsmkj9BjOFs7MXNGiVvpRhWLd+4vGR
	m2NalmLLO7oMdTt/TOccHpMQAEH8GQqDjK52HOKmZ/y/Lr6kgbQ7zk46G4lwN+KPHIi6U48GywcYD
	M+8tc3Cg==;
Received: from [201.172.174.229] (port=41890 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rlZFV-001MV9-1q;
	Sat, 16 Mar 2024 13:59:17 -0500
Message-ID: <cfc4c4c0-83f8-437c-8146-6b86968db67b@embeddedor.com>
Date: Sat, 16 Mar 2024 12:59:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mwl8k: Avoid overlapping composite structs that contain
 flex-arrays
To: Erick Archer <erick.archer@gmx.com>, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240316150712.4633-1-erick.archer@gmx.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240316150712.4633-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rlZFV-001MV9-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:41890
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAIqLavpHE10KXIH776uS8fWT4TCw8tyXfugAuoB3bY0P/TaXlqmmehHystDCnOGjESQhJ2egQqvNsdfpiqRTznF2VfQHKX1aUlzZbXUXBbBnR063vp6
 c66Ye0SBgnP2hqMtG6pUq6hcWXgKzPQK1PcSeaJG8oHYsYfVLuKmfBYyNiAVbfF4e/bcVQuTnOIcTtTQ+o/w/+PX0H9hJWr3RSnuqWMp6nKK7ntBdKzZCwq+


[..]

> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi everyone,
> 
> This patch is based on my understanding of the code. Any comments would
> be greatly appreciated.

Thanks for looking into this. :)

I'm currently in the process of trying a general solution for all these
composite structures without having to use two separate structs, avoid too
much code churn, and continue allowing for __counted_by() annotations at
the same time.

I'll be sending a bunch of patches once the merge window closes. So, for
now, I think it's wise to wait for those patches.

More comments below.

[..]

> diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
> index ce8fea76dbb2..57de32ba4efc 100644
> --- a/drivers/net/wireless/marvell/mwl8k.c
> +++ b/drivers/net/wireless/marvell/mwl8k.c
> @@ -586,13 +586,17 @@ static int mwl8k_request_firmware(struct mwl8k_priv *priv, char *fw_image,
>   	return 0;
>   }
> 
> -struct mwl8k_cmd_pkt {
> +struct mwl8k_cmd_pkt_hdr {
>   	__le16	code;
>   	__le16	length;
>   	__u8	seq_num;
>   	__u8	macid;
>   	__le16	result;
> -	char	payload[];
> +} __packed;
> +
> +struct mwl8k_cmd_pkt {
> +	struct mwl8k_cmd_pkt_hdr header;
> +	char payload[];
>   } __packed;

One of the problems with this is that `struct mwl8k_cmd_pkt` is candidate for a
`__counted_by()` annotation:

@@ -592,7 +592,7 @@ struct mwl8k_cmd_pkt {
         __u8    seq_num;
         __u8    macid;
         __le16  result;
-       char    payload[];
+       char    payload[] __counted_by(length);
  } __packed;

and with the changes you propose, that is not possible anymore because the counter
member must be at the same level or in an anonymous struct also at the same level
as `payload`.

Thanks
--
Gustavo


