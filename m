Return-Path: <linux-kernel+bounces-140371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D48A1376
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E80B2199C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954114C5BE;
	Thu, 11 Apr 2024 11:45:09 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC114A0AE;
	Thu, 11 Apr 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835909; cv=none; b=O5QBp94iR7qGC/sJ7a7rs0RT2jmdRB+8BUkIjoiHpVSrFqngAUdY/27V7r+onFcHefd0XZrc8q7JrKvYKVMhEd/QLjV0Eo5v5aZ0svqGJWO8b5IHXKYn3a37BMkLCZz1XbY/QL7hWjEaO/MJY+5sPrrEPfviXh4KodEIX5Zf2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835909; c=relaxed/simple;
	bh=XRFBR7q3J3br3yr1FBOa62Y1C7spuDVeCqnhCIGgb4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c10YGWOgdGyQhk373Ed98zW+J4AuAiApTOMfJlGzVNTuxZ1n8VdHSsi87G6WPY8nGACzHDVWhLCt5hXx5K/UA9X7Ffg7Bmk3lVGYKD8ufqPG3y9295996k+A5w5scVGN1snwFyLl+QbzJ/eC65Tp+QhjtJ90pob1TOqJ7hdOdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VFd8h3qZhz1R5XY;
	Thu, 11 Apr 2024 19:42:12 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BE0C140E9F;
	Thu, 11 Apr 2024 19:44:57 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 19:44:56 +0800
Message-ID: <cedafaa6-5507-41d3-bd1e-a8964b8630ba@huawei.com>
Date: Thu, 11 Apr 2024 19:44:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: fix typo in reference to BCACHEFS_DEBUG
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Lukas Bulwahn <lbulwahn@redhat.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>,
	<linux-bcachefs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
 <a2683fad-07db-4857-9ebf-7adf31a09e50@huawei.com>
 <b6d90387-7892-4c28-9855-ae35faacfe9c@moroto.mountain>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <b6d90387-7892-4c28-9855-ae35faacfe9c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Thanks, I got it!

On 2024/4/11 18:21, Dan Carpenter wrote:
> On Thu, Apr 11, 2024 at 05:21:05PM +0800, Hongbo Li wrote:
>> Also, I am curious why such spelling errors cannot be detected at the
>> compilation stage.
>>
> 
> The IS_ENABLED() macro is testing whether the define exists or not.
> In this case both "CONFIG_BCACHEFS_DEBUG" and "CONFIG_BCACHEFS_DEBU" do
> not exist for this config.
> 
> Lukas's scripts make a list of macros we expect to exist and then checks
> against the list.
> 
> regards,
> dan carpenter
> 

