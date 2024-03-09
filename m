Return-Path: <linux-kernel+bounces-97791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFC876F72
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E004B20EA5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372736AFE;
	Sat,  9 Mar 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lhWd6mhP"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F42374C2;
	Sat,  9 Mar 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709967484; cv=none; b=byc5gqEESnJ7411+tNCgRkqEfsP6yjkqZIq9ElOgou2BA+ERU5BVlDFQa0elGbinqVx7yGgUsAEws2o/8WUGWJmmxCcWIZpa/uhJfn1vl3bCA5quUKH9NATNAShKET4pCXYlOJE9DlYxNibEBP5+znG9u5ZFtdqeaEtTgIL8vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709967484; c=relaxed/simple;
	bh=raVTJLYBovePc15pim3NUHB9gv1MSvmBUjvjJt/4+tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA6lSvmzveHPY8Dhc6pt8Xdub8wfNVhWX+RYH+qO2g5bEEM2ppdn9wEsdcG2kkCUDyxdYCUPqly78LSo6Muf5Ns9bIRcEBLn8OYSs6Ux8153q+VQ4t5/5DYzGkz1Lnhg54UxalewXDl4DdJ8Ne7ylhxLcrIhni1yzZlziliDENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lhWd6mhP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709967472; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7GHv9Nn9cqN30tZnE0kKtMZjGgh2K78FJqXybMmv6Kc=;
	b=lhWd6mhPVfXLg8c8uGRdYJZPhQ2COjfnkKVNQpDnYc4ef3zzESKztLq4DgZ/7EjveLcaxoiUIEIJtlYM7h7aowI2tuE7pmj0UrvdRRmxmZKD0JNeht2WuqV+0jCCbjQBgGQIFh1lp3xOXjgcr7moiF5D8zqvCMn6MvszZiuCplM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W24RV6B_1709967469;
Received: from 30.13.153.107(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W24RV6B_1709967469)
          by smtp.aliyun-inc.com;
          Sat, 09 Mar 2024 14:57:51 +0800
Message-ID: <dd28db06-22aa-42ef-8e82-f8bb08363933@linux.alibaba.com>
Date: Sat, 9 Mar 2024 14:57:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] net/smc: adapt SMC-D device dump for
 Emulated-ISM
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
 <20240307095536.29648-2-guwen@linux.alibaba.com>
 <1cf8649c-1c09-4076-8910-071cf6b5ea21@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1cf8649c-1c09-4076-8910-071cf6b5ea21@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/8 20:27, Jan Karcher wrote:
> 
> 
> On 07/03/2024 10:55, Wen Gu wrote:
>> The introduction of Emulated-ISM requires adaptation of SMC-D device
>> dump. Software implemented non-PCI device (loopback-ism) should be
>> handled correctly and the CHID reserved for Emulated-ISM should be got
>> from smcd_ops interface instead of PCI information.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ism.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index ac88de2a06a0..b6eca4231913 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
>> @@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>       char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>>       struct smc_pci_dev smc_pci_dev;
>>       struct nlattr *port_attrs;
>> +    struct device *device;
>>       struct nlattr *attrs;
>> -    struct ism_dev *ism;
>>       int use_cnt = 0;
>>       void *nlh;
>> -    ism = smcd->priv;
>>       nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>>                 &smc_gen_nl_family, NLM_F_MULTI,
>>                 SMC_NETLINK_GET_DEV_SMCD);
>> @@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>       if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>>           goto errattr;
>>       memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
>> -    smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
>> +    device = smcd->ops->get_dev(smcd);
>> +    if (device->parent)
>> +        smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
>> +    if (smc_ism_is_emulated(smcd)) {
> 
> net/smc/smc_ism.c: In function ‘smc_nl_handle_smcd_dev’:
> net/smc/smc_ism.c:318:13: error: implicit declaration of function ‘smc_ism_is_emulated’ 
> [-Werror=implicit-function-declaration]
>    318 |         if (smc_ism_is_emulated(smcd)) {
>        |             ^~~~~~~~~~~~~~~~~~~
> 

Hi Jan, the function smc_ism_is_emulated() is introduced by this merged patch:

b27696cd8fcc ("net/smc: change the term virtual ISM to Emulated-ISM")

Could you please check if your code base has this one?

Thanks!

>> +        smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
>> +        if (!device->parent)
>> +            snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
>> +                 "%s", dev_name(device));
>> +    }
>>       if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>>           goto errattr;
>>       if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))

