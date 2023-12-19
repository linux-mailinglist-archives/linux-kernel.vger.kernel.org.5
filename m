Return-Path: <linux-kernel+bounces-5061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F2818624
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4439F1C214DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20153154AD;
	Tue, 19 Dec 2023 11:16:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B117982;
	Tue, 19 Dec 2023 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vyqh1xd_1702984602;
Received: from 30.221.130.243(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vyqh1xd_1702984602)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 19:16:43 +0800
Message-ID: <6fb86598-6114-bc64-2400-543e95fba8a2@linux.alibaba.com>
Date: Tue, 19 Dec 2023 19:16:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v6 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kgraul@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
 <8d118a94-945f-466f-9d34-e0b8a6d8a9e7@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <8d118a94-945f-466f-9d34-e0b8a6d8a9e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/14 00:13, Jan Karcher wrote:
> 
> 
> On 12/12/2023 09:52, Wen Gu wrote:
>> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
>> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
>> OS or hypervisor software, comparable to IBM ISM which is based on platform
>> firmware or hardware.
>>
>> With the introduction of virtual ISM, SMCv2.1 makes some updates:
>>
>> - Introduce feature bitmask to indicate supplemental features.
>> - Reserve a range of CHIDs for virtual ISM.
>> - Support extended GIDs (128 bits) in CLC handshake.
>>
>> So this patch set aims to implement these updates in Linux kernel. And it
>> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
>>
>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 
> FYI I'm currently reviewing this version of the series.
> Hope to give you feedback by the end of tomorrow.
> 
> Thanks for your effort
> - Jan
> 

Thank you very much for your time, Jan. The new version (v7) is updated:
https://lore.kernel.org/netdev/20231219084536.8158-1-guwen@linux.alibaba.com/

