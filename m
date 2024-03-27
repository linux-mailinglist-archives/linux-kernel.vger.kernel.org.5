Return-Path: <linux-kernel+bounces-121841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B472B88EE65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A129FDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234C15099A;
	Wed, 27 Mar 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nxDsV4CO"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179F14D28C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564799; cv=none; b=aeUcTtdqYrvFOCztF2renEp6aSTQX7QZoWsNjRpeU4OLDsSZ5Bmt8cEop2563Dc3fhAnV5PVL3Uvfzsk19+DpYWq/aK30EugJ0qAX7FJPwPTNM/lrCB8bilE5EVn0oSEyLooucxfTSUPetjRLhlbAT3A4TKl6KhiKwZvW8sCdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564799; c=relaxed/simple;
	bh=wWGHjeDpZavQDjtU7nfyce/8Gzr5lFSubbp9E1BsPb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZbVdNqPI7gMOyfYojiA9u9MU02Ae1AsG6f8tK/CLlaCfEUM9EPYmZyy0Ih1BJ9C0lLSEqHptW80jS8b2/GhVixuQubxYiyD+1RDcj+RfuvU+rN3rcw3dRsY+CnJRtQogk3wDSHLxINbIAN5bYKbmeVEpsHzAiO+SvkrpwhKUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nxDsV4CO; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id pWKlrzz3sQr4SpYBpriOG6; Wed, 27 Mar 2024 18:39:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYBnr3dmdiDnepYBorbllG; Wed, 27 Mar 2024 18:39:56 +0000
X-Authority-Analysis: v=2.4 cv=Cd4O5qrl c=1 sm=1 tr=0 ts=660467fc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=v8LEnFnaCG9JqxBWnZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhDtWBwKqrP+NfoVTgkUPYrjUuTaeWvHamIeomR7TP8=; b=nxDsV4COKwzy/QvEUoQXdXPYYa
	B2ZhbypKNVqUDaJzVjIe4F6zqVBrrfR2TVf5cRu5p2foSZh9qpfii0BAUzyoXr21OnTzhVCJCACW5
	/RpePPrhJwvz7DstKvZfD9oqJh38oK7Lpa6yulSGhmEiKhwmXTmNvvss3uWswDiCcFSNW2EcSNHbJ
	fyCFs2YIaFBX4ELZklgIoekEV9bzy7GgKT49bm0qF9uHU3GhygN1YolFobABcHKSdZgC4qLYzQ5nd
	5BA6s9z+w/E2OCqBusMSSQEVBjToo+3IJEkUMqw168R1CuKZTe1cijlv57+GqnuKil0fh3PUm8SqR
	e5qTmU1w==;
Received: from [201.172.173.147] (port=49700 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYBn-003LDL-1K;
	Wed, 27 Mar 2024 13:39:55 -0500
Message-ID: <4e1261a7-25a9-4193-a9e9-9bc137893f08@embeddedor.com>
Date: Wed, 27 Mar 2024 12:39:54 -0600
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
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRayuCJ0gQinMvr@neat>
 <3f19627e-4472-4ed1-9e2e-b0b427682910@quicinc.com>
 <5a6bdbc6-b37e-4c6b-9bff-470fd560663b@embeddedor.com>
In-Reply-To: <5a6bdbc6-b37e-4c6b-9bff-470fd560663b@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYBn-003LDL-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:49700
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFxXe9VsPKLGHCrxLbJiyjrSoH1ztG8e57vzOmoOAj7lOMVSHbf4cBY6We6+c/oUcIcvbXW1EOs4vk+xmSXcEvvbWbEWtwhYLyQsgO2PXagnlntl+Btm
 wJWPTQvs4EkfCLrnsWFiGnanrXRB1/4DeWVi1XI5dBFEABZg2e3LqgR/FAAigUeZ7ADDOakgYwBRCubh+y44BHHQynMLl6O/VYOcqjMgBmgiMqrAZDWzM25K


>>>   #define WMI_MAX_PNO_SSID_NUM    (16)
>>> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>>>       u8 rssi_hyst;
>>>       u8 reserved[12];
>>>       u8 rssi_thresholds_list_size;
>>> -    s8 rssi_thresholds_list[];
>>> +    s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>>>   } __packed;
>>
>> this looks ok to me, although I think there is another issue associated with
>> this, namely the way the code populates the rssi_thresholds_list is by
>> defining a separate anonymous struct:
>>     struct {
>>         struct wmi_set_link_monitor_cmd cmd;
>>         s8 rssi_thold;
>>     } __packed cmd = {
>>         .cmd = {
>>             .rssi_hyst = rssi_hyst,
>>             .rssi_thresholds_list_size = 1,
>>         },
>>         .rssi_thold = rssi_thold,
>>     };
>>
>> I would expect gcc and clang to both complain about that s8 rssi_thold comes
>> after a flexible array (even though its purpose is to be the value of
>> rssi_thresholds_list[0])
>>

I will merge these two patches together:

https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
https://lore.kernel.org/linux-hardening/ZgOEoCWguq3n1OqQ@neat/

and send these changes together with the DEFINE_FLEX() transformation
in drivers/net/wireless/ath/wil6210/cfg80211.c

diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 71bf2ae27a98..38f64524019e 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
       struct {
           u8 channel;
           u8 reserved;
-    } channel_list[];
+    } channel_list[] __counted_by(num_channels);
   } __packed;

Thanks
--
Gustavo

