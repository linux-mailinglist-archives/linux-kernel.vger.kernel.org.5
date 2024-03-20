Return-Path: <linux-kernel+bounces-108275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9668808A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77484282BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E2EBE;
	Wed, 20 Mar 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jQKvwGNZ"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C01629
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895337; cv=none; b=rziuW+D92r7Wa5o0mqK+L0XSu3ttCMLslv0Ta4+yqPLY9PdWQ3fNWmUC1VH0ESbltc24X1NsHorYA6FqbuSvVNomUa9d710Bn/3bqBxaYP8L3qwNwUM1mwOKEiuk4jwFzn7EUSRFvmUA2fLWCSDce2gL6rHIFzLL7DMf++UEePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895337; c=relaxed/simple;
	bh=eDCCyrEIxjjXZjmAOHkJjwnDrF9aFnzlqxo6rUPKKHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6N6hZVVku6s+4x+xcs7IjJgH6bee/vfCLl+9HB1OLtJRqj2IP/rD9fEnwxComNDm9NnxlCfTdPxXRQGWffrzMq37b/o7pV6Mqx3xCWQB1F0aA9VdHDZSTAWyPvDmgw7ke2biai0TKbOPih9m6Kcb5n6DLgPBOluz8Dsg5ffgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jQKvwGNZ; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id mRchrhru6DI6fmk23rrCSg; Wed, 20 Mar 2024 00:42:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mk22rblQbELAWmk22rrHvy; Wed, 20 Mar 2024 00:42:14 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=65fa30e6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=9MzSDiJ5aBsJ5ggNAYYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C0e07c7tUncIYZeoirLLjhFyd9DWTwguNB6M2w9ToKU=; b=jQKvwGNZ137+7vtiHui2rYOKmH
	IgMmALF64IXqM6Z2nVNyKnAcL+hVI3EWGatWtCNanCTX61DCV9PXSVFo9SoLFMrKHF7XKzWq8LKuZ
	+IwONtjEoxW+zyTHi1Ig8e6Ja++CqLtVMVh6Q9tW3KIOdY35h0SW/a9Sj1P1E4mRgBA8aw/pjJukf
	Y1A869t84U3xD4fFrpSmtZrxx0wju/JBoblRK2I+QvHaE4+8/5cPvJcdvPw20n7E9czzLdNp2AP8p
	r0KpuT6KDH28Dld990MzI5+fZ/PfdZ1JYGQuVuQbUebFHjAnybKPWB0HHCre86GkV76epczsO8gpr
	7bq/2Udg==;
Received: from [201.172.174.229] (port=43928 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmk21-003lXB-2i;
	Tue, 19 Mar 2024 19:42:13 -0500
Message-ID: <483362b8-ea79-4036-89eb-d6ab737e1e96@embeddedor.com>
Date: Tue, 19 Mar 2024 18:42:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wireless: ti: Can we just remove this flexible array?
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
References: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
 <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
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
X-Exim-ID: 1rmk21-003lXB-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:43928
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEhw1ON5olA1pOlgdx3LjAX1+5yCZY/ciBe6YgDWx3sOsgb7anAx+s/5m3eYCROmerRlanUUcSq3j0XCqRMJsKaca8NCcwlzTiwT6Wx9NtB0b18J4yHp
 8iDU5nztkgpzf77NeW5txEBQPCZUJXsWLQHXwbpXHyymfF/zAYDN92xrnj6N0mb38vYI6BKU8952eQztptNXT86IkibY9QUcuepSWph8PLtKNdVzEpQmtT83



On 3/19/24 16:54, Jeff Johnson wrote:
> On 3/19/2024 2:59 PM, Gustavo A. R. Silva wrote:
>> Hi!
>>
>> `struct wl1271_cmd_header` is currently embedded in multiple other
>> structs, and it's causing many `-Wflex-array-member-not-at-end` warnings.
>>
>> Has this flexible-array member been used in the past or is it intended
>> for future use?
>>
>> Otherwise, I think we could just remove it.
>>
>> diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
>> index f2609d5b6bf7..4c2f2608ef3b 100644
>> --- a/drivers/net/wireless/ti/wlcore/cmd.h
>> +++ b/drivers/net/wireless/ti/wlcore/cmd.h
>> @@ -208,8 +208,6 @@ enum cmd_templ {
>>    struct wl1271_cmd_header {
>>           __le16 id;
>>           __le16 status;
>> -       /* payload */
>> -       u8 data[];
>>    } __packed;
> 
> I'd think you should just remove it
> 

Yep, I think I'm actually going to remove a few more:

diff --git a/drivers/net/wireless/ti/wl1251/cmd.h b/drivers/net/wireless/ti/wl1251/cmd.h
index e5874186f9d7..39159201b97e 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.h
+++ b/drivers/net/wireless/ti/wl1251/cmd.h
@@ -89,8 +89,6 @@ enum wl1251_commands {
  struct wl1251_cmd_header {
         u16 id;
         u16 status;
-       /* payload */
-       u8 data[];
  } __packed;

  struct  wl1251_command {
diff --git a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
index 7e28fe435b43..3d5b0df5b231 100644
--- a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
@@ -65,7 +65,6 @@ struct ieee80211_header {
         u8 sa[ETH_ALEN];
         u8 bssid[ETH_ALEN];
         __le16 seq_ctl;
-       u8 payload[];
  } __packed;

  struct wl12xx_ie_header {
diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index f2609d5b6bf7..4c2f2608ef3b 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -208,8 +208,6 @@ enum cmd_templ {
  struct wl1271_cmd_header {
         __le16 id;
         __le16 status;
-       /* payload */
-       u8 data[];
  } __packed;

  #define WL1271_CMD_MAX_PARAMS 572
diff --git a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
index 1dd7ecc11f86..602915c4da26 100644
--- a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
@@ -66,7 +66,6 @@ struct ieee80211_header {
         u8 sa[ETH_ALEN];
         u8 bssid[ETH_ALEN];
         __le16 seq_ctl;
-       u8 payload[];
  } __packed;

  struct wl12xx_ie_header {

--
Gustavo

