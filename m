Return-Path: <linux-kernel+bounces-123777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43F890DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF5B234B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99593225D9;
	Thu, 28 Mar 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="atKXMufQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B1200DE;
	Thu, 28 Mar 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665183; cv=none; b=SNLwoMe4CdUnxW26aHgTRmWab11Sm/02m8kGwVxf4q29yLsrLxEy4W3vGXSGZW2TfpeXGOk5caTh3to3mIjub1DumH2N9+Tx+m+E7SogJlHv7/WLaSiyS7Jc3UH+ep5D3SdrrOHyn23eZy0qbXcUXqh/tVs8gX08emsdOraPbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665183; c=relaxed/simple;
	bh=fPx+OB+31hGK/wR9lOKOA3tAk4NG8KeU1/JiKvILBk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We9wTkHvYy4tmVsl4PitYsIKDhVIvWqZZnAI0UhFVPSnO+y1HYZo7V+qCfurAyvADbizByxiNS7zC+theNok1uCuDrVofENqLWBooiDqi+/KDwCHrY2tcgV727koYcLVt9kmZF3qiFI54McbdG+4VtNdPDE4Phol5hbr5QJPvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=atKXMufQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0mzQFfG2OBTnHVlzK9rEYc2q+n0r/5Ez5GZkbZnpj5c=; b=atKXMufQ+OhfO/PNDfaIqiewDy
	3ZWaRMBRjQEVkNxrCr0pXuX7J67axeZDaLZxargiGYJzVs825+bmUBb7lu+PFKYbBtuOTRbgQ1Ze1
	CQk03jaZ9chbBJs1VEjuiURPRoSp+gjKqwQHJDgaDVALCC5l4nzyUzio0bSe5Lt1PBWTgmy5dAJzm
	lGZy0q8zGAeBut/zbPf+b++rl/AN31HvGaJszs1WpiFthPX6F9FTVeZP7uDB4+bj+EP3FdY/swqJs
	CpZv0Ndw9a0SbF8TAymThwbN1fZzeWgzfbSUsjaGRf8pln7RjScXtRO7IF66RSZSIZ538zbJUSLLB
	IFqhMxNg==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyIv-0000000FxEq-21FA;
	Thu, 28 Mar 2024 22:33:01 +0000
Message-ID: <a9092d50-9c7a-4086-a65a-aacfb095e435@infradead.org>
Date: Thu, 28 Mar 2024 15:33:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi.h: add missing kernel-doc for
 @last_cs_index_mask
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org
References: <20240328043845.28882-1-rdunlap@infradead.org>
 <CAHp75VfuoYoAm-QcVhx3bJcvsGarU88ZdNGwz=mW8sq-mt5pmQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHp75VfuoYoAm-QcVhx3bJcvsGarU88ZdNGwz=mW8sq-mt5pmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/28/24 01:51, Andy Shevchenko wrote:
> On Thu, Mar 28, 2024 at 6:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> kernel-doc complains about last_cs_index_mask not described, so add its
>> decscription.
> 
> description

Fixed in v2.

>> spi.h:778: warning: Function parameter or struct member 'last_cs_index_mask' not described in 'spi_controller'
> 
> Do we need a Fixes tag?

I'll add one.

Thanks.
-- 
#Randy

