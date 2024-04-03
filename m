Return-Path: <linux-kernel+bounces-129089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1089649F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6712834A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CE286A6;
	Wed,  3 Apr 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U5njhQ60"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448016426;
	Wed,  3 Apr 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126149; cv=none; b=tsUzcS3GelzEh0o5tIeXyoKXkdZTuN4bMtK017/cXsR44G+OPjsB0TNXqJ8VCq3lSTIjrJ4XXDSKrjGS892bk8by4MLvtAl/tJxFIEj3h/lRXoFNB4gHoj9W1yJI2TPMaEE5g4mdw3RjNBnd4g3h9TfZ7omADW2aG1Aw1fP9KbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126149; c=relaxed/simple;
	bh=K8UzjhHydr2Hb6RuF1ir1fFhF5U29UMEjP8cwaNN7cI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ac8iOs+ZSHNYSYVaTP8/IuiE/OZ1WpCAE8tBoAFo4dE+CVJHL5QC1k9TbY/zs+EMj30eeP43VTMEEJCIR++765jKkBgH8Gwt06dbq1zG6XjvLI0Xwxiko7Lw3dGi4YT6a3ZajPlkqbnxPTN9JT8etULtHre1wMehm8h/u+exlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U5njhQ60; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712126138; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=Wso2cV7BV2xvQ8GUpk+yA1IZcHOWCxmjH1vPoD4/ztM=;
	b=U5njhQ60vkw5rsirdIP3ybpog+59yIQkzMdioAZUU8vhoyoXwyDY56zFbyCY7r1IvSatKwuxQ9oHwiHH4uP+nSE6xFVf/yPkp0q9r0wg3L7GMwQcgTNXDfLhAofQ8jgwgViK7qHSRoMhD42Iz0BolZilAAzSqxdXly1r0o4jri0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W3qcjlv_1712126124;
Received: from 30.221.129.220(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3qcjlv_1712126124)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 14:35:37 +0800
Message-ID: <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
Date: Wed, 3 Apr 2024 14:35:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
In-Reply-To: <20240324135522.108564-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/24 21:55, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.

> Change log:
> 
> RFC v5->RFC v4:
> - Patch #2: minor changes in description of config SMC_LO and comments.
> - Patch #10: minor changes in comments and if(smc_ism_support_dmb_nocopy())
>    check in smcd_cdc_msg_send().
> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids() and SMC_LO_CHID
>    to SMC_LO_RESERVED_CHID.
> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
> - Some expression changes in commit logs.
> 

Hi, Jan. Do you have any comments on this version and should I post a new
patch series without 'RFC'? Thank you.

