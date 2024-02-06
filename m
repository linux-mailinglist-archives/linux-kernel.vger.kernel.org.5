Return-Path: <linux-kernel+bounces-55599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09984BEB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54231F25EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575AD1B940;
	Tue,  6 Feb 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ruoixArX"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC511B807
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251566; cv=none; b=Ryvg2QLmlG6HVp9H6z6oHfhE02v29PHpxuzK3ngfJhO4HCd4i8bH4/CjqCcKYLBMpXAOAAdRaIZXDJ8BaIHARFQTFkc/CA0gcwnIZ5ZmMHdnrF78XjbJifp6GdjODBdsuTvVfs3ZnKZcrFp/l2UFCv5qfFMNFTvcxhRsQWmicC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251566; c=relaxed/simple;
	bh=zTX2u1hoRPQcMQPKj5Ece+F9DX0/+16099nKCTz+ggY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVipgzigF6keUbz7hDkA2+YhMh/bpegduign0BL8VMJ71I73jPOOluqYeuvTrsmG7UL02s7vTbJSZPJTVT5Ojo9miv+FBGq7kHqIPpzi2ODekwRcK31TTvl9Stg8waweb/BqJ4GQB1uMAVhlieGgZIqmuvwmyl4Lw6r4jyQh8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ruoixArX; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id XKpur4ydL9gG6XS7SrZC8R; Tue, 06 Feb 2024 20:32:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XS7RrxYAkOmWYXS7Srq4fU; Tue, 06 Feb 2024 20:32:38 +0000
X-Authority-Analysis: v=2.4 cv=T/MvTOKQ c=1 sm=1 tr=0 ts=65c29766
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=vaJtXVxTAAAA:8 a=QyXUC8HyAAAA:8
 a=KS6gg5_tAAAA:8 a=i0EeH86SAAAA:8 a=iqgMOriEywssfaGR4noA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=hZ4L7c2QG0rhM108vGPe:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KbvZVHNUxJAyFSSXDQTy9du7K8PY4t9oyk36I6Z3RzY=; b=ruoixArXBrzejUnF5nEmrIJ+vU
	1CS7vGqxi3ro/tP/pvgZo+u8vJn8wNVLYvoy3cPTEuscmEkqh7Q1W+X4GsnLUwDSUDKn1ChMz+PjO
	7NWcgikxivgr1PKIqATJwqX01o32myrrcxbTH+TUzh4/S3InQZrZViKMnfAV9RzSE/J6DR3NVQLqs
	oazIwd4Duzg8DEooIN+fKc1ujztYdVf+ladzPfq13X9P25OudlLanEnPQIWm+gKFUdBitEfuXNZ4E
	MbXJ9JGdNvE6shyKEeR08L8Vf139px3MPH5Hi5hGbYTe2kCPfnEvwrJEuoKYWG6x27qioiQaWJb9t
	ogA889LQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:51298 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rXS7P-002bZx-0r;
	Tue, 06 Feb 2024 14:32:35 -0600
Message-ID: <fb9ec7de-7c8a-4e94-94c2-eeea6369550e@embeddedor.com>
Date: Tue, 6 Feb 2024 14:32:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mwifiex: Refactor 1-element array into flexible
 array in struct mwifiex_ie_types_chan_list_param_set
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 Johannes Berg <johannes.berg@intel.com>, zuoqilin <zuoqilin@yulong.com>,
 Ruan Jinjie <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Rafael Beims <rafael.beims@toradex.com>, David Lin <yu-hao.lin@nxp.com>,
 Lukas Wunner <lukas@wunner.de>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240206183857.it.362-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240206183857.it.362-kees@kernel.org>
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
X-Exim-ID: 1rXS7P-002bZx-0r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:51298
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCoYbCWXt9S1ozTGSidq+ig6Hp1I8FrS1bL/xliRDwCQd/Ei0XXWA5hHaBw79pIKbdxHdXiA/9UlgQta4cd/0+sMmLsc8m5iDhxED6bl7HGan4Anmnpd
 0KYMJjyoGepZxmYFALM8EsDJfWUe4onzK7/z5T5+MVvR4P+bgwfL1B+KOjefwHX4xJXgdxEPQUENyrvP9McnnhhNdxHINKF2lyL1uSRastJDHHnStGBMdghZ



On 2/6/24 12:39, Kees Cook wrote:
> struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
> as a flexible array, so convert it into one so that it doesn't trip the
> array bounds sanitizer[1]. Only once place was using sizeof() on the
> whole struct (in 11n.c), so adjust it to follow the calculation pattern
> used by scan.c to avoid including the trailing single element.
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
> ---
>   drivers/net/wireless/marvell/mwifiex/11n.c  |  8 +++-----
>   drivers/net/wireless/marvell/mwifiex/fw.h   |  2 +-
>   drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
>   3 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
> index 90e401100898..9ed90da4dfcf 100644
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
This probably still needs a bit more work.

There are a couple more instances of `sizeof()` that should probably be
audited and adjusted:

drivers/net/wireless/marvell/mwifiex/11n.c:414:         *buffer += sizeof(struct mwifiex_ie_types_chan_list_param_set);
drivers/net/wireless/marvell/mwifiex/11n.c:415:         ret_len += sizeof(struct mwifiex_ie_types_chan_list_param_set);

--
Gustavo

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

