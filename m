Return-Path: <linux-kernel+bounces-142783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313C8A300A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF8B21D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6958593A;
	Fri, 12 Apr 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6LIhXDv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7B84DF6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930459; cv=none; b=SgVar9bKTKo495LEY+WBfGOlGg3BdyLPz4fI/IVIzC+R9wKqUN1OeelKV0dSxKtDHuaar0RQvduhMfIdm1BkqrxDdTnyxV0hzQch01rqaor7uwmIl1tUAeIORBhkCbCVLRAyNy0ZQxS94ayniHkrIp6SnVkBq55SUbhLFmzjap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930459; c=relaxed/simple;
	bh=k0kciFhHeMWk6cCqz4yeQgIFE/QGdu9G7p+hyuSYGGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KclMkT0f5Szs8yW29PDqp7/6DvEgiQGaiUKdsacjFb3O74Qq/SuB33EAVAUQ2KbPf5ngrzGMTPPywVIQ+rTc8uOGtE80kTlNoaG9oQ5Houo1TexJpuYKzuPemtJNTlHr5BESRJRu4XP6erqAozUxBg2f87secQdpKyhotQ/tllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6LIhXDv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343b7c015a8so632788f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712930456; x=1713535256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axxv3exRUNlpWxgacDRk640x3V7VFxrh3mk8vTHKsfE=;
        b=n6LIhXDv7YSOQoll9IdxttDwEhVHaIS4W0GrpZXQoPfajnP07pQ6lqVq9ON9sNub74
         T8SO/h9BSfp2NtYy9iCE9CLnO63DlC3mx+6Jq3+zlg6CtCBOh0FhcCOTyi+xKzfryBYr
         xd7oj7zpuX3OCQRokhWYR2z45ywxAKKhfKKN37jR9ytmO9cbrjxVM5iOVCoaD+OIjyVJ
         yv1gH84BDFXYPzTrEVeVaOMc01gPB1vGrYNmC5LPI3tLVobg5AbEYFJPwnEj8xrC595b
         flp/FWQz20SCml7EZGSLvdR/RzIwLoiLXGV2Tb33Vr1/cMyI3JjG4Iyss4w1LYuTzlNe
         L9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930456; x=1713535256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axxv3exRUNlpWxgacDRk640x3V7VFxrh3mk8vTHKsfE=;
        b=uQknnMsMiMjzbXmAe+UvApyRtqXIazrin+yVdHJ1xGQ8td4Kg/ovxR+DqQyjTVuAgm
         /pFe2tFXw34FpnKf6sfyrlrgwgWa1KKpP1dH1jAE5XqCH/5X76XhGBCj+BTsuZ0jgMW7
         Kl5trouh7otRdCqW85KxM0q/N8jRpAxh0ya9tmXsR6NeldXGcW328VkvP9gKfWTbpPFA
         iqMpV0tb7z7/5nWy6kDOPbYCymKtS5sOq80BmvhTagjctww2XagFQvJYbbqLYpXG132A
         H9Gju/9P/Njild79u3bsBh8YlwO07fSrTqC8d7NTdYnKMgye6bBvH2AyHUH2EN1JwRxL
         HgiA==
X-Gm-Message-State: AOJu0YxZheMIPXlGraze3VN4NqRyBzwlKL0w5tPXcoUniHyTMmKv5wy+
	BI3Xg9Erbnfu3zmjcKyqTNur7qGVDc8CS+BGFIqiJtCQBZhuitue+6Rj2VpLGjU=
X-Google-Smtp-Source: AGHT+IEC6OpeGC8GDPHDIg/HVT8gkVYiCxPQDyj+ORFfpgsNhYncGtGGbl2esbOLAccSKfM+0rXqrQ==
X-Received: by 2002:adf:e9d0:0:b0:343:9292:b28f with SMTP id l16-20020adfe9d0000000b003439292b28fmr1680227wrn.54.1712930456222;
        Fri, 12 Apr 2024 07:00:56 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b003445bb2362esm4326402wru.65.2024.04.12.07.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:00:54 -0700 (PDT)
Message-ID: <14726a74-d54a-432d-a547-3b07ac97d413@linaro.org>
Date: Fri, 12 Apr 2024 15:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-4-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-4-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 14:44, Michael Walle wrote:
> The evervision FRAM devices are the only user of the NO_FR flag. Drop
> the global flag and instead use a manufacturer fixup for the evervision
> flashes to drop the fast read support.
> 

Don't we want to get rid of FRAMs from SPI NOR? Why the dance then?

