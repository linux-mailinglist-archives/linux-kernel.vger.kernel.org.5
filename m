Return-Path: <linux-kernel+bounces-119542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B188CA30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D961F81E49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA8A4500D;
	Tue, 26 Mar 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kK8daU+p"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308401F60A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472650; cv=none; b=VZh56yUOTpkeWAWkDvxJNXyzpfsenmZy/PjWkYKiQSD+tkCF2SBDWqzNndccfSNwG6pRi6QpWuohztY9R95TAIar/FkVY8MmB5EyBWaetTcf2Ybi1gvg1eMknpECum3+7DlhR8bUQQGsYrUmlQ7KLzLzDkYdD74Y7mEwlrTSkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472650; c=relaxed/simple;
	bh=Yz0WYqolMnvLJC5i8aR7bo15fCEbWsCkVWmWBYrTGZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvExbRI14MszJJ9IonJlmbyJECAW6d4vEcRB2ctWInnwiEDIjjXOwrVFJrlGKRQIEc7hbCf5iHWvozeg3LfML6vlqQVctZChZBns11SL7WHEAKgt4Fu/BZivqsGxMeHjBonL0iUDdR60s0Yjg6kCv98fHMNJ2UQnYaHHOEW6eMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=kK8daU+p; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id ocSirtgU0uh6spADWrjzW7; Tue, 26 Mar 2024 17:04:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pADKrI6iXELAWpADKrirNq; Tue, 26 Mar 2024 17:03:54 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=6602fffa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=lPTLYKuCpi3VH0QkE-kA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NrE7Vt2pNurTp9Y0mAxOJgCgwBMGZJicbQxramXY6P8=; b=kK8daU+pLWX9/an16K0GdT02OK
	kgUgx85xu2TUmkImlc0GpPPyoWXw5stddVx3gGeQAfszsoL+Qj1Po3jKsm3UAVLseRTNJ3AF7fIFQ
	mdQUTfh3yEb/6RgkoV5EnzXTrRTVvDmY7m52TVhBWbUvXgwR/aa0xyXfsyP9QYsNs/fTXRk1T2M96
	9314CyobTBVyp2HOtWljrGglwQQrYZK2vfUnZ2wU6XF158Xhp2Kc4x4SC8yrnTnW1jc+b4zbBkLAM
	fz6cXS9SC6uNyG+CSlr1sj5yqHy4CIt0+kos2zb2j+xnF+cQONUPLhtvZjDYCGOhEeKRsezL0Pa+9
	d3+8erhQ==;
Received: from [201.172.173.147] (port=44416 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpADC-001bkE-0E;
	Tue, 26 Mar 2024 12:03:46 -0500
Message-ID: <de9a1396-7793-4420-8d3e-1c634059cfe0@embeddedor.com>
Date: Tue, 26 Mar 2024 11:03:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] idpf: sprinkle __counted_by{,_le}() in the
 virtchnl2 header
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
 <20240326164116.645718-4-aleksander.lobakin@intel.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240326164116.645718-4-aleksander.lobakin@intel.com>
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
X-Exim-ID: 1rpADC-001bkE-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:44416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOzoMfQdiCmWzhJlqLhaK2K94p+L57XSKNpwa6NIcgXqG+C6PzckqCQ3H2V134jDTqcitmV/gUDvQZD1gcyE6q2gQjF7fUttkrSb5N3kV9HAbBlQgtcX
 A8CnT1lhAKP/SRIyKgpGf96OqFyZvcunFYs6UYi986rQvEOoz77PF7tXStjdBSYN0MzutsKBfAe5SmkfqU+qXJ9W4lFo8UO9m26ngqYSjRtpyJV6NWZmVcRd



On 3/26/24 10:41, Alexander Lobakin wrote:
> Both virtchnl2.h and its consumer idpf_virtchnl.c are very error-prone.
> There are 10 structures with flexible arrays at the end, but 9 of them
> has flex member counter in Little Endian.
> Make the code a bit more robust by applying __counted_by_le() to those
> 9. LE platforms is the main target for this driver, so they would
> receive additional protection.
> While we're here, add __counted_by() to virtchnl2_ptype::proto_id, as
> its counter is `u8` regardless of the Endianness.
> Compile test on x86_64 (LE) didn't reveal any new issues after applying
> the attributes.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

LGTM:

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/ethernet/intel/idpf/virtchnl2.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 29419211b3d9..63deb120359c 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -555,7 +555,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_queue_reg_chunk);
>   struct virtchnl2_queue_reg_chunks {
>   	__le16 num_chunks;
>   	u8 pad[6];
> -	struct virtchnl2_queue_reg_chunk chunks[];
> +	struct virtchnl2_queue_reg_chunk chunks[] __counted_by_le(num_chunks);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
>   
> @@ -703,7 +703,7 @@ struct virtchnl2_config_tx_queues {
>   	__le32 vport_id;
>   	__le16 num_qinfo;
>   	u8 pad[10];
> -	struct virtchnl2_txq_info qinfo[];
> +	struct virtchnl2_txq_info qinfo[] __counted_by_le(num_qinfo);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_config_tx_queues);
>   
> @@ -782,7 +782,7 @@ struct virtchnl2_config_rx_queues {
>   	__le32 vport_id;
>   	__le16 num_qinfo;
>   	u8 pad[18];
> -	struct virtchnl2_rxq_info qinfo[];
> +	struct virtchnl2_rxq_info qinfo[] __counted_by_le(num_qinfo);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_config_rx_queues);
>   
> @@ -868,7 +868,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_vector_chunk);
>   struct virtchnl2_vector_chunks {
>   	__le16 num_vchunks;
>   	u8 pad[14];
> -	struct virtchnl2_vector_chunk vchunks[];
> +	struct virtchnl2_vector_chunk vchunks[] __counted_by_le(num_vchunks);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_vector_chunks);
>   
> @@ -912,7 +912,7 @@ struct virtchnl2_rss_lut {
>   	__le16 lut_entries_start;
>   	__le16 lut_entries;
>   	u8 pad[4];
> -	__le32 lut[];
> +	__le32 lut[] __counted_by_le(lut_entries);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(12, virtchnl2_rss_lut);
>   
> @@ -977,7 +977,7 @@ struct virtchnl2_ptype {
>   	u8 ptype_id_8;
>   	u8 proto_id_count;
>   	__le16 pad;
> -	__le16 proto_id[];
> +	__le16 proto_id[] __counted_by(proto_id_count);
>   } __packed __aligned(2);
>   VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
>   
> @@ -1104,7 +1104,7 @@ struct virtchnl2_rss_key {
>   	__le32 vport_id;
>   	__le16 key_len;
>   	u8 pad;
> -	u8 key_flex[];
> +	u8 key_flex[] __counted_by_le(key_len);
>   } __packed;
>   VIRTCHNL2_CHECK_STRUCT_LEN(7, virtchnl2_rss_key);
>   
> @@ -1131,7 +1131,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_queue_chunk);
>   struct virtchnl2_queue_chunks {
>   	__le16 num_chunks;
>   	u8 pad[6];
> -	struct virtchnl2_queue_chunk chunks[];
> +	struct virtchnl2_queue_chunk chunks[] __counted_by_le(num_chunks);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_chunks);
>   
> @@ -1195,7 +1195,7 @@ struct virtchnl2_queue_vector_maps {
>   	__le32 vport_id;
>   	__le16 num_qv_maps;
>   	u8 pad[10];
> -	struct virtchnl2_queue_vector qv_maps[];
> +	struct virtchnl2_queue_vector qv_maps[] __counted_by_le(num_qv_maps);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_queue_vector_maps);
>   
> @@ -1247,7 +1247,7 @@ struct virtchnl2_mac_addr_list {
>   	__le32 vport_id;
>   	__le16 num_mac_addr;
>   	u8 pad[2];
> -	struct virtchnl2_mac_addr mac_addr_list[];
> +	struct virtchnl2_mac_addr mac_addr_list[] __counted_by_le(num_mac_addr);
>   };
>   VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_mac_addr_list);
>   

