Return-Path: <linux-kernel+bounces-121874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C988EED0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4703A29E2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96DA15218B;
	Wed, 27 Mar 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="o6i/ckCN"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210A1514F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566145; cv=none; b=UTKBwo+D8QuYRxf1dIuCgLKaGmaDi7C9KoAm7azEgHU2quyq57fmQbmELJuqa51TD58F+IMrRbAvAUnmZZSnIEJj4fMCypkDGlFeGQhEpdfqVwmeYyk2PyyajrhzRyi9X/qz+f1S3jPv4hp1HYi6wDsypcl3biP8+UvEsjUy8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566145; c=relaxed/simple;
	bh=tY/kYlCKTZM1U9At1f8pcyF1C2M3Gx00Kx1VbgRTDBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hevJJR2k/GXUwcS2AzQzexR2ojrWJbtCfNKpk77O+JCM/j3Im9fLVWLf+J1K3b72iUqif4QMux6slfiScN75LiT8xhA4pv9On6LgzhNPxmSrGP+hkHKl7aqyQ53mlu9w2Ufc3rLOS2gOZDzFxtwRlBh2lSzdQ4v1pk/4IXgpF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=o6i/ckCN; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id pWKlrI1CJl9dRpYXWrjzhF; Wed, 27 Mar 2024 19:02:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYXVrtFv3sT9BpYXVro2Vk; Wed, 27 Mar 2024 19:02:21 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=66046d3d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=ne6NSq1Het56kcJAOLIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eTo6rPqoE3ht4O7ovAkyYWoWGnFdaNMGQPNuK9WIyCE=; b=o6i/ckCNzyuwFrbMgNPhUV/iIK
	3PM/clgmp92OTK7km9UWKK3UqAH4hrt0zx3XEjFdYpYEzsTUFIGpyaKdCQjAVv6bva63+teWqnhJu
	EqhtVByQ8opkoxvV8VUDOJzxjOcK3voxKJIVhB24rVrVtFxXGvPCibvIf57k521jiBgy6fK+jAK3Z
	PuWiqTAcBnkQSx19vahiRxSAxWW/3xnVciMPfGXJ4+N3+kkI0Aai4sfkGZ2AIzdIA5XXRYz/T+dmj
	9I36Qcxjft97TligGxtyiww4umuSa1NyaE7DSpOpi3TMaFp05MzOkMf4UxAgGVTzi3Ly/3IiNP6RB
	IsZNowbw==;
Received: from [201.172.173.147] (port=58918 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYXU-003fPc-23;
	Wed, 27 Mar 2024 14:02:20 -0500
Message-ID: <29be66cd-e752-4c5e-a660-7b668e49ff9e@embeddedor.com>
Date: Wed, 27 Mar 2024 13:02:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: wil6210: Avoid -Wflex-array-member-not-at-end
 warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgOEoCWguq3n1OqQ@neat>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZgOEoCWguq3n1OqQ@neat>
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
X-Exim-ID: 1rpYXU-003fPc-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:58918
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDlG9KzOxS/T3FjuXP9yj4v7hixWDRVPia/0Xs0dmCpU/HaVhYASIR56rdfdoXd2O2uham6qH+XMZaTMxS5k+SNj+zx9xc7PSffA5r50FqvU4T2MwFun
 SJDNUbbDmf0LnoJSGzT0KF0UhPUW87FV4taMIa6051lEaxxxhh4vREIvf5rSuM9IfUUbIqNoioWHo9xL01CGE4mw3fQm8r5240P8P1W+8LtnGHM1jtf7L3QT

Hi all,

Please, drop this.

The following patch replaces it:

https://lore.kernel.org/linux-hardening/ZgRsn72WkHzfCUsa@neat/

Thanks
--
Gustavo

On 3/26/24 20:29, Gustavo A. R. Silva wrote:
> Use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/net/wireless/ath/wil6210/wmi.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
> index 6fdb77d4c59e..cc0ad70f0d01 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.c
> +++ b/drivers/net/wireless/ath/wil6210/wmi.c
> @@ -4014,28 +4014,23 @@ int wmi_set_cqm_rssi_config(struct wil6210_priv *wil,
>   	struct net_device *ndev = wil->main_ndev;
>   	struct wil6210_vif *vif = ndev_to_vif(ndev);
>   	int rc;
> -	struct {
> -		struct wmi_set_link_monitor_cmd cmd;
> -		s8 rssi_thold;
> -	} __packed cmd = {
> -		.cmd = {
> -			.rssi_hyst = rssi_hyst,
> -			.rssi_thresholds_list_size = 1,
> -		},
> -		.rssi_thold = rssi_thold,
> -	};
>   	struct {
>   		struct wmi_cmd_hdr hdr;
>   		struct wmi_set_link_monitor_event evt;
>   	} __packed reply = {
>   		.evt = {.status = WMI_FW_STATUS_FAILURE},
>   	};
> +	DEFINE_FLEX(struct wmi_set_link_monitor_cmd, cmd,
> +		    rssi_thresholds_list, rssi_thresholds_list_size, 1);
> +
> +	cmd->rssi_hyst = rssi_hyst;
> +	cmd->rssi_thresholds_list[0] = rssi_thold;
>   
>   	if (rssi_thold > S8_MAX || rssi_thold < S8_MIN || rssi_hyst > U8_MAX)
>   		return -EINVAL;
>   
> -	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, &cmd,
> -		      sizeof(cmd), WMI_SET_LINK_MONITOR_EVENTID,
> +	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, cmd,
> +		      sizeof(*cmd), WMI_SET_LINK_MONITOR_EVENTID,
>   		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
>   	if (rc) {
>   		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, rc %d\n", rc);

