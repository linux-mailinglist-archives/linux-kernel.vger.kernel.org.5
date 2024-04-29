Return-Path: <linux-kernel+bounces-162973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B38B62E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A6FB20B53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FF12BE93;
	Mon, 29 Apr 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rEuAK03c"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A513174D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420259; cv=none; b=ElNCY4aYY6Xi+wRi2zDOhNQLPkMdP2Gfq1HpMUHGUu87oQjMlUXG4JTTa3zpW2ERG1sX2sJfyJ8Ya7+pbCCWdi0p7+svc/CyaY/w+91LjWPYvtRkJUVVu4C6bQOsUmSJl9DQbb6k19sadzgdFZ+7Ggq6RmI1T04TcpvE6pJaZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420259; c=relaxed/simple;
	bh=ajQDmJ0WWFzPXvoP2mmAy+LuxbIewe2/xsExrL6XISQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhSmCv+22C/DwYW8kE5f6c7UaX29JfqzsBfkKY31O9LiILYvyFEqEMR6sXzKHWwtkWKMzEfrSP5nOm1St019JA7EbRmy1Jv0gbTJz3wmmSzkgBVoPlT49aUPHku/Se9gIRu9jw1AMFTBjy6xW86P+QQn/OuC0CqEGzY+SqEe9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=rEuAK03c; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 1Tv5sq1pqjfBA1X1Xsds4M; Mon, 29 Apr 2024 19:50:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1X1WsdkZ6q9rZ1X1WsDJjx; Mon, 29 Apr 2024 19:50:50 +0000
X-Authority-Analysis: v=2.4 cv=b6q04MGx c=1 sm=1 tr=0 ts=662ffa1a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=GnIobxVeLkNF-WZzOA8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2FeBCJhrHyDzm6ziA3QCmTVmkMK5M89ts1JS18ctx0c=; b=rEuAK03cGdyk9JpPDMHFIOHuB3
	yaa5QHKXfz1v4NbbnH5VYAiFdRJe8wZGP6b67svjvwC8epGhVqbsYNbo2zDB9C/gnDE7g1wZCuVYu
	n6ged8xunX4hdg33PLMAOjytXZjcqByYDcHISnCcAG0G/iQp6urAu7YelT5xg803cDDGa0pVWgjxE
	HHwq4XhBERPYHCHZQyH3liUj3xD0XytWpURKR+PGSrKtSu888+wZIYsa9+IYnhsfr8QQ3FBFeSKq9
	W8xWkro+UYkY7lv6P0IEO2tD7pXtKmaFpwPLMeRP9Ay98xo8Rq9lBh/TEv1BXiRia2I59yO2jscy3
	pPZdkjXA==;
Received: from [201.172.173.147] (port=53420 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1s1X1U-003pzP-24;
	Mon, 29 Apr 2024 14:50:48 -0500
Message-ID: <b09450f9-c42f-41f8-a2f6-eea3515eaa2f@embeddedor.com>
Date: Mon, 29 Apr 2024 13:50:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use
 __counted_by() in multiple structs and avoid -Wfamnae warnings
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZiwwPmCvU25YzWek@neat> <202404291110.6159F7EA5@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202404291110.6159F7EA5@keescook>
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
X-Exim-ID: 1s1X1U-003pzP-24
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:53420
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFP/8+CBs2/fNPAfOro1yonjM7wZavYWGFH7cOgHbvIg4u7mupLBd6AqJWFU+qwS5pzLK1bNXz5vdLOrWzmvOUMGs+9s4VbUf7puVoT+RBjShn1DDnmO
 EJkzQ9DrTgjSQpgC7etjzdB41VKgsC2brOdcSIywttLAt3f7n3cTAcUNP3KmXTUFt6PeVDTkVgyRXz4aNmakmLjeq3NW+eK0yoIoaNm3NSAYorxx0uOTmWfS


>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index fe23e862921d..c4c6b8810701 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2026,7 +2026,7 @@ struct hci_cp_le_set_ext_adv_data {
>>   	__u8  operation;
>>   	__u8  frag_pref;
>>   	__u8  length;
>> -	__u8  data[];
>> +	__u8  data[] __counted_by(length);
>>   } __packed;
> 
> I noticed some of the other structs here aren't flexible arrays, so it
> made me go take a look at these ones. I see that the only user of struct
> hci_cp_le_set_ext_adv_data uses a fixed-size array:
> 
>          struct {
>                  struct hci_cp_le_set_ext_adv_data cp;
>                  u8 data[HCI_MAX_EXT_AD_LENGTH];
>          } pdu;
> 
> Let's just change this from a flex array to a fixed-size array?

mmh... not sure about this. It would basically mean reverting this commit:

c9ed0a707730 ("Bluetooth: Fix Set Extended (Scan Response) Data")

--
Gustavo

