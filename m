Return-Path: <linux-kernel+bounces-164483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331C8B7E17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2FB24BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF417BB0F;
	Tue, 30 Apr 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gVQa55dR"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5717B4EB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496466; cv=none; b=TDJjf8JmwPZnFVPKOPYn4XODW5TZMdVAo+dVky7eccpXl0I3/wYyatUtB4QnQ5nEPnaz/P2DEZNR3fHXeokzyjS2i6qcDMCPCDipFPLx6qLGwSx6u4xvUiBXFPMByhS7IU/YNRatfCJvjRkP+tOXMcZfEGmOuT4VnqexKC2eE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496466; c=relaxed/simple;
	bh=HJyVdz04ncZQQLx3WnEu8v8SZ3Ow/s4vvPahzDI5l+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua72YJU9Ru1GRbr/7Y/X9z3rf9J/0WIm/p1JPbQGIrOr56FzlqvoR99CodgYIjERLb53IGZo9Qt+pKj8bwO1BMhQeIwssxOJtRElKhPLWMnFkkdUbK3Qycp/v2qkgJ9/QzaH9cQRrMStjT8wgqmmHo16qblCqPUCbwEYz7ZIcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gVQa55dR; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b549c06-aedc-4e05-9a48-b53f170b2a08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714496462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJyVdz04ncZQQLx3WnEu8v8SZ3Ow/s4vvPahzDI5l+Y=;
	b=gVQa55dREcaO2BNyRQTyHDmkgaU4B8ovQXxxh1SUXIfqyrYgxBJqOLvU601NOPJfy2w9Az
	YFSOlAvS9NlPxMLl0ZCPeWXKIfdxXk/9XpobZ4hdWDBkGeEQrkfxLut255eWoNnC3By63G
	Dtg0gyiB+rvNpofAivlQAqI69cPrt5o=
Date: Wed, 1 May 2024 01:00:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/panel: ili9341: Remove a superfluous else after
 return
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240429171218.708910-1-sui.jingfeng@linux.dev>
 <86b768d8-19e8-4f87-a250-b428bf78f756@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <86b768d8-19e8-4f87-a250-b428bf78f756@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/30 07:10, Jessica Zhang wrote:
>
>
> On 4/29/2024 10:12 AM, Sui Jingfeng wrote:
>> The else clause after the ruturn clause is not useful.
>
> Hi Sui,
>
> Spelling nit: ruturn --> return
>

Thanks for pointed out, will be fixed.


> Besides that,
>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>
> Thanks,
>
> Jessica Zhang


Thanks, Jessica.


