Return-Path: <linux-kernel+bounces-140036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23058A0AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D191F232AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF342EAE5;
	Thu, 11 Apr 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gk3CmgQN"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAB13E048;
	Thu, 11 Apr 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822095; cv=none; b=bieYLRq4cXPPV5pOJOgYFTrULtW8dTKwr+cijkX27jZBeOSyDB/L/TcQtLd0UJr9PWiHJ3t5FvaYy/87wJUZMene2zfl7IaTfTCQn+4nN4pv696KSXTvfD0YGrP3Daa1hw/5dJENiKfA4aJkBUMbeOqiXgnBk6Cqj72ZmmiCLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822095; c=relaxed/simple;
	bh=3GwJ6a+xt5MhjVTAyBxA2Hie1entEBVCmWRnbxhmUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKy0xkFBujAab5Wa02pgCO62lWaLF+PECXLDxVZwu+9FGU3vju+VWh1i3Z3hIQy0PhSSoceUeg7toFqp7dCBFkFKCoWJFtyXAp2586qsiViiHSbIZxZheWElu+bQPi+gTBmdbyWkCDVj7y2riRGAFuZM5nFsP6ENr2iHrlTjK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gk3CmgQN; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712822089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pQMBTYNynPA02Lriyi43s4JReicQAXRUl8F3FYNB6Rg=;
	b=gk3CmgQNvVjiEGhNoozoG0wzkWvtmqcNPsM7N9J2iXEotJRUAOXKO0xI31uYgrq8i/aR3p5mdNUM92Uja4OPjdqAd3S7WFatzkwZOAPzq+xuJj1bmeZBZpmXC7VxdkQzrMEV+U2i667MPqOCVxO+XhLXccKp3Gj0lJbnw+ngycA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4KbUe6_1712822088;
Received: from 30.221.130.77(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4KbUe6_1712822088)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:54:49 +0800
Message-ID: <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
Date: Thu, 11 Apr 2024 15:54:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
 <ZhZacAOVpAXK8lDE@bogus>
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <ZhZacAOVpAXK8lDE@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 17:22, Sudeep Holla 写道:
> On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
>> AEST V2 was published[1], add V2 support based on AEST V1.
>>
> 
> Any changes to ACPICA has to get merged in the external ACPICA project.
> Refer [1] for details from Rafael. You can also refer [2] in the kernel
> docs.
> 

Patch1 is just a fix to follow kernel code style. Patch2 had merged to 
acpica project, PR link can be see in patch2 comment:

   Link: https://github.com/acpica/acpica/commit/ebb4979

