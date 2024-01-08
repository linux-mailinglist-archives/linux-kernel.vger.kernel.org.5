Return-Path: <linux-kernel+bounces-19909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC34827687
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E1A1F23527
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30054BDC;
	Mon,  8 Jan 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jLz2of3V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5946435
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id MrYlrYa51THHuMtaKrbKLq; Mon, 08 Jan 2024 17:38:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MtaJrHSaDtzh2MtaJrbeOO; Mon, 08 Jan 2024 17:38:47 +0000
X-Authority-Analysis: v=2.4 cv=Ra6Dtnhv c=1 sm=1 tr=0 ts=659c3327
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10
 a=ic43B64CF9VcJqpiiBIA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Co6guZYByp4kdojxfU2irqToohe93bbVbLlOGGL1NZw=; b=jLz2of3VyaBSe/9M9xNFKptdMz
	vt9kIpSMNfwwSo4FKv9LHvj5rHV8HnPms9MeP/+kX4BONZRZEs86nxsACg2DN29U5YWHQAE54BNTO
	6QKmb1vsMg55TD7QOb6fw1YFBVkYGkVuBes2QU7vM7sn/HOQQ/jQ8Ii1cyiKRfjAiQYTT/dvS8Qfl
	lNe2dW+e2u0wit2526MRyTUU4cNXydf7ro0jiqLqsyJ5SHaa9tSwgzglhZOQxhGYATAocsV3mpu66
	dJYmrag6HyUOjmZChxqxl9TUF6ZIpKbkJa/mi+JaV6rAehzqYlJQ/sgBKAdsrgGpGcXQfXt85nVwN
	ZVI7aDJA==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:17540 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMtaH-0032b8-0n;
	Mon, 08 Jan 2024 11:38:45 -0600
Message-ID: <eacdc1fe-df5c-472f-9e83-971bbe36e8b5@embeddedor.com>
Date: Mon, 8 Jan 2024 11:38:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
 error27@gmail.com, gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
 <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
 <c9aff51d-918a-49d7-ae31-395cc6a5881b@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c9aff51d-918a-49d7-ae31-395cc6a5881b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rMtaH-0032b8-0n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:17540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJOrcSXfNROQh4hsHqW+pXc84/lQphn/tmyZnYctHPiVCu4fNgKdXcmiXKsCikSM2UjuSQuGxhAEkYN/uKwX5dU81oapiycwaxypvJlBDWzUpXTWPrNY
 fRbKRxIBpc3WRt5N6vFeE5P1TmKNPVubxIrT5fLfc+xSO26Z1tN4HQr7gXP3L8d0Mvokgi58G9lkIqsq7qK/28EJfBhehy7/7X2hYTamAywE1oI4x0L9vtaS



On 1/8/24 11:31, Harshit Mogalapalli wrote:

>> BTW, is this _warning_ really causing a crash?
>>
> 
> I think we can say this can cause a crash in a way, WARN_ONCE() is still a WARNING and we can have systems with panic_on_warn set.
> 

Oh yes! thanks for the clarification. :)

--
Gustavo

