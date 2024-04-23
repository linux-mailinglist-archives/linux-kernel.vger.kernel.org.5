Return-Path: <linux-kernel+bounces-154600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AF8ADE31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C81B1F23D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73AA4AEE5;
	Tue, 23 Apr 2024 07:22:46 +0000 (UTC)
Received: from mail-m24106.xmail.ntesmail.com (mail-m24106.xmail.ntesmail.com [45.195.24.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506F46436;
	Tue, 23 Apr 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856966; cv=none; b=g4X7o+FyWB87oBzh1hcZH4a6hi5eDZPjh4zteOCbgQO3BA6S11nc6PpW0Hkc6ge8OPG3Zm7oAn/NBXIA0/Ou1g7U8EAb1GVNGaEi9hTu9ZG3+XI4Z4j3f0Qppdj+WQk1OzQ5PWY65fZPQtuysGuASkANhdGsJE2NUWujQLaOHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856966; c=relaxed/simple;
	bh=My0JKNecn5jLntC24uRik6kUKfG+CPD7tvnSI+kdIpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz5y5adTw8J7odsXrr2s+EWfbQ5bxCtA+c4ez9dGkQBF26FWsGkoeNuLbV7EQHLFO/vnEZ6gZv/LMJc3StHxCJR1OAcGyG6XzD5v362lDdlQ5kXbLEuMMfvo9G3z43PYXjqvUYdqYlwSZpsbCkHmkfB+Ph8AcbykbUO3Xxw21vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.24.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.181.208] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9B67E56019E;
	Tue, 23 Apr 2024 10:34:34 +0800 (CST)
Message-ID: <7e10353e-9e3e-4bf1-b825-7fe40f34748c@easystack.cn>
Date: Tue, 23 Apr 2024 10:34:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: openvswitch: Check vport netdev name
To: Jakub Kicinski <kuba@kernel.org>
Cc: dev@openvswitch.org, echaudro@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240419061425.132723-1-jun.gu@easystack.cn>
 <20240422173850.2222305f@kernel.org>
Content-Language: en-US
From: Jun Gu <jun.gu@easystack.cn>
In-Reply-To: <20240422173850.2222305f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE4fVhhPSEpMHkNJTRlKT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8f08ce1572023dkunm9b67e56019e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06LBw*CDc9DRM1GEoUM0gC
	PUMKCj9VSlVKTEpIQ0hCTUxOS0NIVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkJKQzcG

My mistake, I'm wondering that I need to submit a new patch or a v5 
version based on this patch?

在 4/23/24 08:38, Jakub Kicinski 写道:
> On Fri, 19 Apr 2024 14:14:25 +0800 Jun Gu wrote:
>>   	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
>> -	if (!vport->dev) {
>> +	/* Ensure that the device exists and that the provided
>> +	 * name is not one of its aliases.
>> +	 */
>> +	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
>>   		err = -ENODEV;
>>   		goto error_free_vport;
>>   	}
> 
> Sorry I applied this before I realised that it's buggy.
> dev_get_by_name() will give you a reference on the device.
> You must free it, so the error handling is different.
> Please follow up ASAP to fix that.
> 

