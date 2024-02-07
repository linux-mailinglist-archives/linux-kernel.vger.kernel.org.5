Return-Path: <linux-kernel+bounces-56830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035DC84CFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B51C251CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749282D63;
	Wed,  7 Feb 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UX2PxqdQ"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EF8286F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327400; cv=none; b=CK08CH9pbVrpPblUluxMkA/631qbhWguG0of7c+3LnmyJFY7fRGQhwr/lKuUgOK9RD2SZfrBTzoK+O+qYmBF1CszBM3DFy1p/UhR6ji45enIDDxbSqD3qrCN5bBbnsIXLHm88PxbqbjJRh4LFD0pKfbNwf6L5qNORa4jqsqrbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327400; c=relaxed/simple;
	bh=XP1a3fCz0YXFwKIKZmNuyM849qeRjhahOnaQzlZzHtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIrlPWw88/I5CC6uNRH7tnvPlp3VpyuwKnOJyM4/elO4eU0/RwAXdoclLbEQoxa6XkIhT1EKo8l6LmgFTrwE268j/lrVcXsVOgnp9GgvYX3a0aV+No5nbHcNrnksW1ANHfxJkbaT6JpYPD4B0YCV0V6OWuAOlsa/FQSkb3PUA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=UX2PxqdQ; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id XcqirqO6QAxAkXlqerUSUL; Wed, 07 Feb 2024 17:36:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Xlqdrsa9yMzWfXlqdrxHYT; Wed, 07 Feb 2024 17:36:36 +0000
X-Authority-Analysis: v=2.4 cv=ZY6+NdVA c=1 sm=1 tr=0 ts=65c3bfa4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=vaJtXVxTAAAA:8 a=QyXUC8HyAAAA:8
 a=KS6gg5_tAAAA:8 a=i0EeH86SAAAA:8 a=MFyMvekAxcSTD17lGysA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=hZ4L7c2QG0rhM108vGPe:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PZ2oDsLBOJm/i+XFyMAaPXYbvyF91hMZOi6uU3qYFdc=; b=UX2PxqdQ5BBPMg/3khmZdjJ4Um
	NOWwiO7PK9xBXUv5hOtXKrTTLQUM28hKwbgXNsMPb4h51r+Zr7422MP7LT1vo6vZoyJcwpdzYCAMl
	8GT2SLnPTiR/xzdbzkkCQ0uRXpMN9KJLKdYW5RnBGkOXbgfgLQAVZGYrK0K56YJdulzFdnOlSsunI
	/RQfo7EmFo+sYvT2o+bacvfZzh0lH0wa+LIjP0QHpudcINYpV+qhsgCxudgTNEq9EwBRi+Yh9b5w3
	nfdJy2ZSRxe413GQjAZLftxKOZvwTzyD1r5WvU51xkPE4elV809ptzQTsyqUNPmUIXGc90SbgUCT8
	Zbj4fn1A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:35144 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rXlqb-001R9E-1Q;
	Wed, 07 Feb 2024 11:36:33 -0600
Message-ID: <032a2332-7acb-4d56-93bd-0ff9272290fa@embeddedor.com>
Date: Wed, 7 Feb 2024 11:36:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mwifiex: Refactor 1-element array into flexible
 array in struct mwifiex_ie_types_chan_list_param_set
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 Johannes Berg <johannes.berg@intel.com>, zuoqilin <zuoqilin@yulong.com>,
 Ruan Jinjie <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 David Lin <yu-hao.lin@nxp.com>, Lukas Wunner <lukas@wunner.de>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240207103024.make.423-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240207103024.make.423-kees@kernel.org>
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
X-Exim-ID: 1rXlqb-001R9E-1Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:35144
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK1oS0MT7/cHibUrL/27G+zySb8SVEs6m3aB/8CJRA+u2VI8CJ/HHgQHlobk6FbXy6/CR+P/AybBkTeIsL6KLcsAv2/LQYotbbrwFxrznmYlUGwbsyZJ
 pNxsId1KniQjUUKmQ1H8vNV0t5ETr32o2xcEOhKrJmPk1SGJ9seG422dVpQgIDpO8i/t0zQAMZndQov9WOf07SKQr/U1sQpid9oOTg2Uji1jAOocfOOoWE0J



On 2/7/24 04:30, Kees Cook wrote:
> struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
> as a flexible array, so convert it into one so that it doesn't trip
> the array bounds sanitizer[1]. Only a few places were using sizeof()
> on the whole struct, so adjust those to follow the calculation pattern
> to avoid including the trailing single element.
> 
> Examining binary output differences doesn't appear to show any literal
> size values changing, though it is obfuscated a bit by the compiler
> adjusting register usage and stack spill slots, etc.
> 
> Link: https://github.com/KSPP/linux/issues/51 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: zuoqilin <zuoqilin@yulong.com>
> Cc: Ruan Jinjie <ruanjinjie@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

TLV and one-element arrays are always tricky to transform (into flex arrays),
but (unless I'm missing something that the maintainers might point out) this
looks good to me.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> v3: catch two more cases of changed sizeof (gustavo)
> v2: https://lore.kernel.org/linux-hardening/20240206183857.it.362-kees@kernel.org/
> v1: https://lore.kernel.org/linux-hardening/20240206163501.work.158-kees@kernel.org/
> ---
>   drivers/net/wireless/marvell/mwifiex/11n.c  | 12 +++++-------
>   drivers/net/wireless/marvell/mwifiex/fw.h   |  2 +-
>   drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
>   3 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
> index 90e401100898..c0c635e74bc5 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n.c
> @@ -392,12 +392,10 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
>   
>   		chan_list =
>   			(struct mwifiex_ie_types_chan_list_param_set *) *buffer;
> -		memset(chan_list, 0,
> -		       sizeof(struct mwifiex_ie_types_chan_list_param_set));
> +		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
>   		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
> -		chan_list->header.len = cpu_to_le16(
> -			sizeof(struct mwifiex_ie_types_chan_list_param_set) -
> -			sizeof(struct mwifiex_ie_types_header));
> +		chan_list->header.len =
> +			cpu_to_le16(sizeof(struct mwifiex_chan_scan_param_set));
>   		chan_list->chan_scan_param[0].chan_number =
>   			bss_desc->bcn_ht_oper->primary_chan;
>   		chan_list->chan_scan_param[0].radio_type =
> @@ -411,8 +409,8 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
>   					  (bss_desc->bcn_ht_oper->ht_param &
>   					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
>   
> -		*buffer += sizeof(struct mwifiex_ie_types_chan_list_param_set);
> -		ret_len += sizeof(struct mwifiex_ie_types_chan_list_param_set);
> +		*buffer += struct_size(chan_list, chan_scan_param, 1);
> +		ret_len += struct_size(chan_list, chan_scan_param, 1);
>   	}
>   
>   	if (bss_desc->bcn_bss_co_2040) {
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 62f3c9a52a1d..3adc447b715f 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -770,7 +770,7 @@ struct mwifiex_chan_scan_param_set {
>   
>   struct mwifiex_ie_types_chan_list_param_set {
>   	struct mwifiex_ie_types_header header;
> -	struct mwifiex_chan_scan_param_set chan_scan_param[1];
> +	struct mwifiex_chan_scan_param_set chan_scan_param[];
>   } __packed;
>   
>   struct mwifiex_ie_types_rxba_sync {
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index a2ddac363b10..0326b121747c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -664,15 +664,14 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
>   
>   			/* Copy the current channel TLV to the command being
>   			   prepared */
> -			memcpy(chan_tlv_out->chan_scan_param + tlv_idx,
> +			memcpy(&chan_tlv_out->chan_scan_param[tlv_idx],
>   			       tmp_chan_list,
> -			       sizeof(chan_tlv_out->chan_scan_param));
> +			       sizeof(*chan_tlv_out->chan_scan_param));
>   
>   			/* Increment the TLV header length by the size
>   			   appended */
>   			le16_unaligned_add_cpu(&chan_tlv_out->header.len,
> -					       sizeof(
> -						chan_tlv_out->chan_scan_param));
> +					       sizeof(*chan_tlv_out->chan_scan_param));
>   
>   			/*
>   			 * The tlv buffer length is set to the number of bytes
> @@ -2369,12 +2368,11 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
>   		     chan_idx < MWIFIEX_BG_SCAN_CHAN_MAX &&
>   		     bgscan_cfg_in->chan_list[chan_idx].chan_number;
>   		     chan_idx++) {
> -			temp_chan = chan_list_tlv->chan_scan_param + chan_idx;
> +			temp_chan = &chan_list_tlv->chan_scan_param[chan_idx];
>   
>   			/* Increment the TLV header length by size appended */
>   			le16_unaligned_add_cpu(&chan_list_tlv->header.len,
> -					       sizeof(
> -					       chan_list_tlv->chan_scan_param));
> +					       sizeof(*chan_list_tlv->chan_scan_param));
>   
>   			temp_chan->chan_number =
>   				bgscan_cfg_in->chan_list[chan_idx].chan_number;
> @@ -2413,7 +2411,7 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
>   							   chan_scan_param);
>   		le16_unaligned_add_cpu(&chan_list_tlv->header.len,
>   				       chan_num *
> -			     sizeof(chan_list_tlv->chan_scan_param[0]));
> +			     sizeof(*chan_list_tlv->chan_scan_param));
>   	}
>   
>   	tlv_pos += (sizeof(chan_list_tlv->header)

