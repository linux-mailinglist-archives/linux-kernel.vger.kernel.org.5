Return-Path: <linux-kernel+bounces-53977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970184A8AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E9CB231ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B895675D;
	Mon,  5 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="RxCnstMO"
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388A55E6E;
	Mon,  5 Feb 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168480; cv=none; b=gqpIJiSLO6+yWd0XE87hDfKoMTopqBnjuQsaKTHlmuLiVBtDmmLSpAMcSVfuNxRJaL23jxonSN3xiV9H+1Wvm4zyUR2M2CHQ97ELNRZ1OJBwG/9iiwJIm7jvPf9/mBUWUhTQ4iSC5ty9fj+GSyx1xlejBUB63ewr+gequ25mQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168480; c=relaxed/simple;
	bh=agcKveseb9lfBVqx8d6myKsRhGARFKeegN5jrHFVRMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDD8kFlitkMK2EU0IiirhXQKgwFNyt+a1W54+iR8py63IaXxShY2O1qqNWkG5p/ortIRdgqviR3NUttfYO8rmluBCh3/IFpgRHY0+bAbZL+TYh54tfuq18ujX/IPXPlmHb9mr8ly6+8p4OI2ZMja4/JTMMOdhraIkdushBOCRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=RxCnstMO; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=he8yop61Q/oM6FHfZWgijEzftDrOEirDa6XmewAxTv8=; b=RxCnstMO0/bvZ9uTkRL8FIpLcC
	b4YwdcvpXnZC1kqpWGbWJfBU7ERIYN8hTidLVbvVfYrScp1dSfIAneTEc4l7XDR5YnDuw0nJOGxkT
	9bDXJeqWYDc/7VdEchFDhujGfROHtcHPN+J1jBncfQfl4Kvze3X3vhOvhUETUPHq7qWI=;
Received: from [88.117.50.204] (helo=[10.0.0.160])
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rX5ro-0001Io-26;
	Mon, 05 Feb 2024 21:47:00 +0100
Message-ID: <8a6c3c9a-0bff-40a0-aa0b-3032066b8d04@engleder-embedded.com>
Date: Mon, 5 Feb 2024 21:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tsnep: Use devm_platform_get_and_ioremap_resource() in
 tsnep_probe()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <29e9dc0f-5597-4fee-be5c-25a5ab4fe2dc@web.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <29e9dc0f-5597-4fee-be5c-25a5ab4fe2dc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 05.02.24 13:54, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 13:43:14 +0100
> 
> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>

