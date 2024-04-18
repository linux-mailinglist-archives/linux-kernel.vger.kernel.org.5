Return-Path: <linux-kernel+bounces-149738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4978A9539
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7561F236E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009B158D91;
	Thu, 18 Apr 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G+RdMWjV"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF91586F1;
	Thu, 18 Apr 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429750; cv=none; b=KLmw0x8gxxZobb3GT8L7T7Vur0PyHjUgdzXqVhDepU8294AIBgg82higwQfH3nvxAsv0TAyvgfgCh9Tph6Xs2nYMD24dR0HMXE70kcDbk5i5RIT2voWwntkoGYK5PHEO2G5bNxhW/Ih3M1wu+q1mOP3TIbUjcTEFF7bLfXdlfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429750; c=relaxed/simple;
	bh=u3TI4o1DboTThV82HkDXxVMO7H9IRgERsIlG3S5XOBI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LNKHorH8ARdeEgdUcevpJTBTy5LRTMrELaWVSV55Hbw9I2Twtkp1/QpBzRwvXfEb3ml8UYT177bOw7D0Y0wTx0VDPGw1Pa91bPkSZaK1ETXqNV6G2RebyNqdd6g+PRxCnRmuHKUX7cGjSL0mclM0zpKyN2aJZiCMqzDL//xX4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G+RdMWjV; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713429745; h=Message-ID:Date:MIME-Version:To:Subject:From:Content-Type;
	bh=2cPGrKaaHFkGZF58+Z8CxHjfnvpWB1ov+P+DruBhGUg=;
	b=G+RdMWjVnxhJRXPp4HJ7Q3h2XYOU+DkUzrliGR15vGP2iMxVQK4Qbdlh1xvnVUABjJgebNLEBwPyH9LHo5QVxKFMt5+FKbPU+sp0WR1DKZ0OzHG6YwGn7+eZ2xsm+zcuw3iG0XmcjpuhuMUQWnu/M6Fun0ZG67//y+d0ZlS46Zg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4o6cKv_1713429743;
Received: from 30.221.129.202(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4o6cKv_1713429743)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 16:42:24 +0800
Message-ID: <9f9b0af3-669e-493b-9a26-475115410435@linux.alibaba.com>
Date: Thu, 18 Apr 2024 16:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yazen.ghannam@amd.com
Cc: baolin.wang@linux.alibaba.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org,
 xueshuai@linux.alibaba.com
References: <34fa94f5-359f-f3e7-92ae-fcdc06ff19b8@amd.com>
Subject: Re: [PATCH] x86/mce/amd: init mce severity to handle deferred memory
 failure
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <34fa94f5-359f-f3e7-92ae-fcdc06ff19b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


AMD ATL has merged to upstream, can we merge this patch to process 
deferred error with memory_failure()?

Thanks,
Ruidong

