Return-Path: <linux-kernel+bounces-141775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF78A2345
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F821F22F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E75C96;
	Fri, 12 Apr 2024 01:35:36 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF64431;
	Fri, 12 Apr 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885736; cv=none; b=iImAzs9F9jrCOGNu+4qbC86w95SFrkpp+0cY8FWEbMvzSk8eoBpS9j3FBcFq5b4lBthHjwjYyrl0rBMFllmFuunW9ylnTxcHglz2TNVVC8ZP1EJ/iR04W2h2v0gYZ2Maw6IT+KvPaNi/IRz8oBpmUufedVeE3CRVF9gsQqiTG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885736; c=relaxed/simple;
	bh=qxII8WXen4/Mu9o7FqjOw5w+uDJbWmKmhBggUKDsnOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OcQ5D30wElTRQSNRjSueX/fcBTMX4vneGIYGnXv6AfZ6zyNhO0Nlqq/te3i8SugRw1iVWUvpfzVTHy9z/csOrAjCg5HXQjioMPPtgjaRXUflpHp72lETkrT46Q965tATa7KVKQ3z8v4xBlLghUpQuC+MpAyGaa2HTuFDoGQaZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFzdF4fFhz1S5LN;
	Fri, 12 Apr 2024 09:34:41 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D3581400C9;
	Fri, 12 Apr 2024 09:35:29 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 09:35:29 +0800
Message-ID: <d0aaa23d-ec01-43da-9c06-4a667225afc3@huawei.com>
Date: Fri, 12 Apr 2024 09:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: fix typo in reference to BCACHEFS_DEBUG
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: Lukas Bulwahn <lbulwahn@redhat.com>, Brian Foster <bfoster@redhat.com>,
	<linux-bcachefs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
 <a2683fad-07db-4857-9ebf-7adf31a09e50@huawei.com>
 <w76yialze3mzjmhcdt5guelmsw5ezady4zpn6m7lszluc4u4vg@s3eosgrvhj7w>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <w76yialze3mzjmhcdt5guelmsw5ezady4zpn6m7lszluc4u4vg@s3eosgrvhj7w>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Thanks, got it. And I found many similar cases in other kernel modules. 
Also, the janitors project seems quite interesting.

On 2024/4/12 1:31, Kent Overstreet wrote:
> On Thu, Apr 11, 2024 at 05:21:05PM +0800, Hongbo Li wrote:
>> Also, I am curious why such spelling errors cannot be detected at the
>> compilation stage.
> 
> code coverage analysis would catch this. I'm one patch away from fully
> automated code coverage.

