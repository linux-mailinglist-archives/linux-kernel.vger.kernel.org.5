Return-Path: <linux-kernel+bounces-142942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941D8A3259
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05D8B272E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1CB84A37;
	Fri, 12 Apr 2024 15:23:36 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622591487D4;
	Fri, 12 Apr 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935415; cv=none; b=a6NRL4ZvBalnmoda+EVqDDMs5jfCt2yqKUb/ABFOTiqLUh2wvydxO4lRRAiEg5zl4b4FyXZ+R8PfKH5zKj3fTD0/at2xqgCsSi1ZTRdH32ji/xhFjVnjt6+h09AlT7A3TKyewRmnKQPPx7Ko5wj0VqaZhz6jpjZbcqMG/Ip4UHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935415; c=relaxed/simple;
	bh=Hi/FiNC3DhECPgS5kKcA4W0JM1chEQDgYt+hMHq/ID0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbx4ap/+ys6Co5pkKvOz8rtUS7LNG/YRX5LXJnLyITaHucHNdFNUwa4zhYDrwdBq73moNt+dTWPs2Ej/jnZbNNobTveFHZE0PcSQmpkdIla0c93TF7xoneK3ZmEvLmNjwyLzZ7n484yA0UxJwPahqEdvefzftFh1IoXCripCVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id C212AFFE4E;
	Fri, 12 Apr 2024 15:23:29 +0000 (UTC)
Message-ID: <aaddc12e-3fe4-474c-964b-6c0d6481dafa@enpas.org>
Date: Sat, 13 Apr 2024 00:23:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] HID: playstation: DS4: Don't fail on calibration
 data request
Content-Language: en-US
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Roderick Colenbrander <roderick.colenbrander@sony.com>
References: <d0e5bb97-3e18-44ac-89b0-503cfe16417f@moroto.mountain>
 <07848795-14e3-4020-9e60-e3221ff6ef80@enpas.org>
 <4e486902-9238-48db-b0b2-2abce4f3b812@enpas.org>
 <nycvar.YFH.7.76.2404121700540.5680@cbobk.fhfr.pm>
From: Max Staudt <max@enpas.org>
In-Reply-To: <nycvar.YFH.7.76.2404121700540.5680@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/24 00:01, Jiri Kosina wrote:
> Max,
> 
> please send a followup one with proper Fixes: tag. We're generally not
> rebasing the tree.

Instead of rebasing, I was wondering whether you were intending to revert the faulty patch first :)

Thanks, will do!



Max


