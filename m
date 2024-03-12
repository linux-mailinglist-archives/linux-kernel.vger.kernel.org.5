Return-Path: <linux-kernel+bounces-99803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F311A878DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F551C210A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5CB67F;
	Tue, 12 Mar 2024 03:43:11 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4EAD53;
	Tue, 12 Mar 2024 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214990; cv=none; b=BrItZhzpNDpMLCwpVxK2tGxjPUmZJAYZ6JishbRgWeDgDP2rrl7BqZOOeetXaULsbSUD1snVeDdbdJWKLqg+CoYur+JqNwr/MHTX6TPv49z8M/+vZtmagLEgco/T7lTc/mRQNG3GVhc+GJ1Fn7yn/LrK4kMvGxCQToHqTDU14/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214990; c=relaxed/simple;
	bh=6WSjm7CvPPrA7TmhGrbPaQ53sA4F2yuCdRSKCOLEdz8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sHltJxilR7Ttiqov4EiV0tvtQUyBAhzeF0t6fxB2h3er9I0CYOc0iwkud10IJ2ZMbxqK6DuGBGU7GVz3K9TUXYufYdMea21QX/3EiVSU6vwTGsHDqAHTGODDhI5lJLD90fyaxvnWaZ4K2pNyHYouaeH1xTlNjw1mckVsOvX+8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ttztl3RHBz1h21S;
	Tue, 12 Mar 2024 11:40:31 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 664FA14025A;
	Tue, 12 Mar 2024 11:42:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 11:42:56 +0800
Message-ID: <b9b04261-a6e8-4dae-9b41-3b8045811a74@huawei.com>
Date: Tue, 12 Mar 2024 11:42:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
To: Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240309100044.2351166-1-shaojijie@huawei.com>
 <20240309100044.2351166-4-shaojijie@huawei.com>
 <20240312030303.GA1249254@maili.marvell.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240312030303.GA1249254@maili.marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/12 11:03, Ratheesh Kannoth wrote:
> On 2024-03-09 at 15:30:43, Jijie Shao (shaojijie@huawei.com) wrote:
>> +		}
>> +
>> +		pos = scnprintf(buf, HCLGE_MOD_REG_INFO_LEN_MAX, "%s",
>> +				reg_info[i].reg_name);
>> +		if (reg_info[i].has_suffix)
>> +			pos += scnprintf(buf + pos,
>> +					 HCLGE_MOD_REG_INFO_LEN_MAX - pos, "%u",
>> +					 le32_to_cpu(desc->data[0]));
>> +		pos += scnprintf(buf + pos,
>> +				 HCLGE_MOD_REG_INFO_LEN_MAX - pos,
>> +				 ":");
>> +		for (j = 0; j < reg_info[i].group_size; j++) {
>> +			offset = reg_info[i].reg_offset_group[j];
>> +			index = offset % HCLGE_DESC_DATA_LEN;
>> +			bd_idx = offset / HCLGE_DESC_DATA_LEN;
>> +			pos += scnprintf(buf + pos,
>> +					 HCLGE_MOD_REG_INFO_LEN_MAX - pos,
>> +					 " %08x",
>> +					 le32_to_cpu(desc[bd_idx].data[index]));
>> +		}
>> +		buf[pos] = '\0';
> ASFAIK, scnprintf does null terminate the string.

Yeah, you're right. I will send v6 to delete it


