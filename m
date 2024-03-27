Return-Path: <linux-kernel+bounces-121860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B072188EE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87F41C28E54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB6615217A;
	Wed, 27 Mar 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Tf0ipOtp"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6801DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565620; cv=none; b=YT9zVl3AHuaU+ywHvUzoikInDlf93FrfZFyZrUycxil6Mi2miS78zCGOu5d0RgCiqYaPtz28uQOF2Q9T9MLnpeBtwImtbu/GxlFlam6ExeT7mP9om6VxNQEVr5x963WQSXFKs5d7ZIU41Wd8Lw0fwN75v4FkABGhST/SjIgWfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565620; c=relaxed/simple;
	bh=DRriF96XBdtDbA0stDmuq0Ozvtm/4dViy+piu1EqTFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyb76jVpjTyIV+YCkaP1MHMI8DjfR3/9PigchRmYhm/OE5wqMPTejy3jpJryEZcZXCd1MtCYfOXnKb5IaR00l5AvTN/ODfPfJMIcSTLFH9Pj3tECqc79IY+I+zl+TWLRLs6kjn43ghHoHaKHxfnoFimQXzzEc/31gL56rtX7U6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Tf0ipOtp; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id pWKmrLIP1tf2QpYP4r3qnS; Wed, 27 Mar 2024 18:53:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYP3r3ux0iDnepYP3rbxj4; Wed, 27 Mar 2024 18:53:37 +0000
X-Authority-Analysis: v=2.4 cv=Cd4O5qrl c=1 sm=1 tr=0 ts=66046b31
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gdIFR+CqW2Hj2dXzDKpIE02t+3L7EdU4qxKK93B9/Fo=; b=Tf0ipOtpi0jeAMo4neqo5oMZiS
	ATSJyTc5sBz7hKoQdpI8on6+u7RfGRaI8vKMNAKx9ceiayArBeevctN7FVjjs6ls5K4ktPWNGCMjm
	Fq6Nd8R63PrT6CZC9bzR4cVyUs1qe14QkX8fsg9/4RND+GG/1vGWHLB/17yFZXcTlV4D8Jme1UssB
	J3z/Ukd0wr3JkRgkDf9yzX0CXWofYVCqWPwLXIZpWXat3J/pPrTY4ZJKLGlfo1Pcuw26KaX6H1ykU
	zaRsPG6fURPbfDEcePieD07SDhCFdVdImb6qph1AamMkZwYh0GLtMuote+aUg4pgrkdQG0onCuoKn
	Ne4umHSQ==;
Received: from [201.172.173.147] (port=36948 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYP2-003XoZ-2f;
	Wed, 27 Mar 2024 13:53:36 -0500
Message-ID: <d34e1ab7-bed6-4721-98fc-0288eb314de6@embeddedor.com>
Date: Wed, 27 Mar 2024 12:53:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: wil6210: Annotate a couple of structs with
 __counted_by()
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRayuCJ0gQinMvr@neat>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZgRayuCJ0gQinMvr@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYP2-003XoZ-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:36948
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAVIvOzfmw0nMyunQg7q6342oy0dqknmM5dNXafbDcceXvuzr6ka2aH3SRoLIeP1odfo44UTOjbM9twHRaR+90foojXbCS5T+gT5cOJ90IY7oJ0VzE6e
 5fpNWZLUvli4Dzp7/KO+kgssLk8/mItXSO6k36YV8UCnAcOtDuis1xhMP02begZ6XeCalQQmZkCLZ/Mm3Ldt396UBZe1E9iRhAwbPVuWnWYQMUdMhnPNIF34

Hi all,

Please, drop this.

The following patches replaces it:

https://lore.kernel.org/linux-hardening/ZgRqjGShTl3y5FFB@neat/

Thanks
--
Gustavo

On 3/27/24 11:43, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Annotate one more struct.
>   - Update Subject line.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
> 
>   drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
> index 71bf2ae27a98..38f64524019e 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.h
> +++ b/drivers/net/wireless/ath/wil6210/wmi.h
> @@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
>   	struct {
>   		u8 channel;
>   		u8 reserved;
> -	} channel_list[];
> +	} channel_list[] __counted_by(num_channels);
>   } __packed;
>   
>   #define WMI_MAX_PNO_SSID_NUM	(16)
> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>   	u8 rssi_hyst;
>   	u8 reserved[12];
>   	u8 rssi_thresholds_list_size;
> -	s8 rssi_thresholds_list[];
> +	s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>   } __packed;
>   
>   /* wmi_link_monitor_event_type */

