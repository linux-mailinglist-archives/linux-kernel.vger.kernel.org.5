Return-Path: <linux-kernel+bounces-121834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F288EE53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E500A1F3C3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3BF150987;
	Wed, 27 Mar 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="FjoraUmA"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8114EC61
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564465; cv=none; b=eg/+hEALbgtbW1aY6ECyejlS2ROGjrA/ZJniaQ0i+g4oi7r5vuoo/O4CTOS0nfYFb5mKDJGdbvoSXxgZ4IF7eev99pgCApcDrWXL9xkKyJNkaabt3N3XRvJSN+TwQQi6x1sn13JRmoOnYfANcLa92cQV0417Yh42Nmyd1J5R7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564465; c=relaxed/simple;
	bh=aX6QSSGc13nyyDwfQVPqyZNm6X2xKiTyc3AeQGSb5dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXHCvf7W34tpXEpZlCnHpvTfWqbqpjvBJfjhZNJmX/BxF7tNZi3PKZUELLwHrllK+RbQ9eSezpUWQIHFGCJ42mG1QWwWzlLUco5pceCrPVA5XX8Pbdemrf/BGDO0mf163sSKbVIFkVcJesoB8BvizxzWgsjAMnSW3HzYJHwHLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=FjoraUmA; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id p9ZQrcPy1DI6fpY6LrCddf; Wed, 27 Mar 2024 18:34:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pY6Kr09WSybtzpY6KrZCxT; Wed, 27 Mar 2024 18:34:16 +0000
X-Authority-Analysis: v=2.4 cv=RsAOLzmK c=1 sm=1 tr=0 ts=660466a8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=VgmWMAVCFVrwZvelSRUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bAemq08bU+SllrPiEJ0JpMclOr++1EwoQ9PgFhUqrIQ=; b=FjoraUmAwLCGk1O+jFd0gqmn+P
	7APOyFgNMgCER3TdA4CNzBLaZH9JmHFpznBIg5AUCYKwK8owTtWlhsOwoJoiaiOlRlPtgYL7B7lHz
	JM09OMYrKcfN3KWd88XABuMg1LX8MRgqw9RBjN/aK0dVTiQxRpDBiyKC7c9YITdOcQ3p7VJsT/Px6
	sj0oe93KbYhZygr1nQL8uBz+/oiyCKHMAFhY3pecQnwbHl+RHsV7vD14+61yvq1CajQPL0bEo87FD
	yWdX6cTxrCOrq+q5KAjWp0cdxl6dAOQIv+Cw6KJIrvjd5p3NtBVcsy7esi1HGnKDgBFXcK+SXTaJz
	igWUtyDw==;
Received: from [201.172.173.147] (port=36990 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpY6J-003FCt-27;
	Wed, 27 Mar 2024 13:34:15 -0500
Message-ID: <5a6bdbc6-b37e-4c6b-9bff-470fd560663b@embeddedor.com>
Date: Wed, 27 Mar 2024 12:34:14 -0600
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRayuCJ0gQinMvr@neat>
 <3f19627e-4472-4ed1-9e2e-b0b427682910@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <3f19627e-4472-4ed1-9e2e-b0b427682910@quicinc.com>
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
X-Exim-ID: 1rpY6J-003FCt-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:36990
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEZi2166cA5AvxC2wUmO0lRzTcfmHW7O5+SY7ppQdfhRbVnU6JxFmqne7UY7WGUIGG1vK2ryfEN3InH7jPKLUvmpULSuzFUKPjXwCUuxEHbNa9a1EOyu
 PhZTdmvM7QA2BbMof9ssjemuD/Wl9NCM+C7cN64pVGlhxMOSCwaljHEJVm9PfhbnWzU2AvvoXYZHkOdDPJI4vSgKZqeesSL8JUwYYar+Rt6cJuyaCMX3VFaO



On 3/27/24 12:26, Jeff Johnson wrote:
> On 3/27/2024 10:43 AM, Gustavo A. R. Silva wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>   - Annotate one more struct.
>>   - Update Subject line.
>>
>> v1:
>>   - Link: https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
>>
>>   drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
>> index 71bf2ae27a98..38f64524019e 100644
>> --- a/drivers/net/wireless/ath/wil6210/wmi.h
>> +++ b/drivers/net/wireless/ath/wil6210/wmi.h
>> @@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
>>   	struct {
>>   		u8 channel;
>>   		u8 reserved;
>> -	} channel_list[];
>> +	} channel_list[] __counted_by(num_channels);
>>   } __packed;
> 
> does the compiler handle the actual logic where it is modifying num_channels
> concurrently with writing into the array? i.e. this will be writing into
> channel_list[0] when num_channels is 0:

I'm actually about to send this patch:

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index dbe4b3478f03..836b49954171 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -892,10 +892,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
         struct wil6210_priv *wil = wiphy_to_wil(wiphy);
         struct wireless_dev *wdev = request->wdev;
         struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
-       struct {
-               struct wmi_start_scan_cmd cmd;
-               u16 chnl[4];
-       } __packed cmd;
+       DEFINE_FLEX(struct wmi_start_scan_cmd, cmd,
+                   channel_list, num_channels, 4);
         uint i, n;
         int rc;

@@ -977,9 +975,9 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
         vif->scan_request = request;
         mod_timer(&vif->scan_timer, jiffies + WIL6210_SCAN_TO);

-       memset(&cmd, 0, sizeof(cmd));
-       cmd.cmd.scan_type = WMI_ACTIVE_SCAN;
-       cmd.cmd.num_channels = 0;
+       memset(cmd, 0, sizeof(*cmd));
+       cmd->scan_type = WMI_ACTIVE_SCAN;
+       cmd->num_channels = 0;
         n = min(request->n_channels, 4U);
         for (i = 0; i < n; i++) {
                 int ch = request->channels[i]->hw_value;
@@ -991,7 +989,8 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
                         continue;
                 }
                 /* 0-based channel indexes */
-               cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;
+               cmd->num_channels++;
+               cmd->channel_list[cmd->num_channels - 1].channel = ch - 1;
                 wil_dbg_misc(wil, "Scan for ch %d  : %d MHz\n", ch,
                              request->channels[i]->center_freq);
         }
@@ -1007,16 +1006,15 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
         if (rc)
                 goto out_restore;

-       if (wil->discovery_mode && cmd.cmd.scan_type == WMI_ACTIVE_SCAN) {
-               cmd.cmd.discovery_mode = 1;
+       if (wil->discovery_mode && cmd->scan_type == WMI_ACTIVE_SCAN) {
+               cmd->discovery_mode = 1;
                 wil_dbg_misc(wil, "active scan with discovery_mode=1\n");
         }

         if (vif->mid == 0)
                 wil->radio_wdev = wdev;
         rc = wmi_send(wil, WMI_START_SCAN_CMDID, vif->mid,
-                     &cmd, sizeof(cmd.cmd) +
-                     cmd.cmd.num_channels * sizeof(cmd.cmd.channel_list[0]));
+                     cmd, struct_size(cmd, channel_list, cmd->num_channels));

  out_restore:
         if (rc) {



--
Gustavo

> 
> 		cmd.cmd.channel_list[cmd.cmd.num_channels++].channel = ch - 1;
> 
> if that will cause a bounds check failure then suggest you change the logic so
> that it updates num_channels before writing into channel_list
> 
>>   
>>   #define WMI_MAX_PNO_SSID_NUM	(16)
>> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>>   	u8 rssi_hyst;
>>   	u8 reserved[12];
>>   	u8 rssi_thresholds_list_size;
>> -	s8 rssi_thresholds_list[];
>> +	s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>>   } __packed;
> 
> this looks ok to me, although I think there is another issue associated with
> this, namely the way the code populates the rssi_thresholds_list is by
> defining a separate anonymous struct:
> 	struct {
> 		struct wmi_set_link_monitor_cmd cmd;
> 		s8 rssi_thold;
> 	} __packed cmd = {
> 		.cmd = {
> 			.rssi_hyst = rssi_hyst,
> 			.rssi_thresholds_list_size = 1,
> 		},
> 		.rssi_thold = rssi_thold,
> 	};
> 
> I would expect gcc and clang to both complain about that s8 rssi_thold comes
> after a flexible array (even though its purpose is to be the value of
> rssi_thresholds_list[0])
> 
> /jeff
> 
> 
>>   
>>   /* wmi_link_monitor_event_type */
> 
> 

