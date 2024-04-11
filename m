Return-Path: <linux-kernel+bounces-139850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82D8A0868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5642D281CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D113CFAD;
	Thu, 11 Apr 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T6mAtzEW"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213F13BAD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816622; cv=none; b=qzxaeN/8NdZg99s1rtARciGZqM90BZVl+/NNjtEUe2q3zuTS21cteCtddENrl7QNWLJshUGeLhMAGTEOtOJihJ/sE7VS3gcLgm6cNPA5WaLCeIYLYEpkRYyrwJaE5C7rxzRaguNzrez6NBi0XjVYeohzYeLM7W79jxnHTnYVx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816622; c=relaxed/simple;
	bh=pTWLQpW9RVU2IjRukXzUGYvxyE+olS3ZH5i76ahO8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg2pVJWc7D16iF6sCLbs1z/dsbNrsQjZms+44FCg1DehUIFJpMBicu7h0/rnenU3NBhhfcorhNj45RETNkTC0a5mOhEHtmDB0brtJ3pJSkksYBMCInggYK4Rj8HOYQrRiFaK6JkjVVm+Z96vvtalX+zrYJNWP1eI6jT+jG6Gtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T6mAtzEW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so80529071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712816617; x=1713421417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lZTFJACV3+JbwVwRwvE8FlPJbh+9wi0aUKAYU88cAc=;
        b=T6mAtzEWsvSFJVelBAO7GMLtShyCwYgw93Sd4XzMlA7pTPehBzOzvgGmGoujqOsfaY
         DcXLdd5Xp/rVL0SfK2aJjjtyxFFXDkV/77t6VqrpFXzgQ9lgkE0Czj18Mh1Ky+lsMHaC
         Ps03teF3bWvkeoWB6c5dzJVHbif5V5xg9i3b+v+EJUcKIo8f1bKQMAoeqFT8Gs16hT43
         6aqQIsmm3I5/fV1PnSMWFV3d0SUVeU9fKcCsr4/DEGl4EyebTqInsDJC8xIpVuvkb4PX
         QTkx7ppU71r8Z/zTyl+TP6tcEsyvIZgzm9lfcJ/ANh0jAVg5ZbzOT2cSe1JCGJ/udZKJ
         1Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816617; x=1713421417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lZTFJACV3+JbwVwRwvE8FlPJbh+9wi0aUKAYU88cAc=;
        b=b2+ow9+d1hRQZhwrSYY81nuuAB/nmuWMwHf4+IhIndF0cnCxOwo1N8gVjrl8zQBdgd
         7j+20DAX4skLBMgVGQHzLoeoroWFsJxdXvoVdQnJD4PTlTZ/ps20BwbwQWLO0fgAHkdH
         xiW6kZcNXvPZQ2XIxF1VZ7niLDf1EnZUMHa0eZfskmIoEf9gklPL6ahFt1HXq1/EazgG
         g6HmXMtUeBYY9+A8hPcpEZU2nRuylgSPV5bBuEuQKgZglxNWda03iBGrQYCuRUtQSKl0
         MhnP8qYofsVKhMqaIwXtUNTZWP8OTzsFGb07k425eTBQlwk3AFBlSDsCJNp2myqcQ4lm
         qC3w==
X-Forwarded-Encrypted: i=1; AJvYcCUL89JgDNjRv5ruZQjOz5ZOy1Crbgng2BPQrmNi062KqHHCzwWCqcg46tBQMU+wth2iRubw9Kkycox8vDeqUxPB9m8P7/PT9Q/vbSIe
X-Gm-Message-State: AOJu0YwZwdeSl99rhCOzbbYGeqlAm0+XiZO8hP51X9gUuNlZNEcAtYsb
	6xpqwn2PldpZ2EXISOuUrBjUO62Zz/+hlxN8Tgmng4FMQSPcruQm1UTqN+A3mUA=
X-Google-Smtp-Source: AGHT+IFkIcdj47hwnqrwRBDPoFbtpCm6hEqmTe7HSx9TotuKs4UPXIr2bhVJ1LAxUHsvGfGv5Jcuqg==
X-Received: by 2002:a2e:a413:0:b0:2d6:a5f6:c8d3 with SMTP id p19-20020a2ea413000000b002d6a5f6c8d3mr2822772ljn.27.1712816617380;
        Wed, 10 Apr 2024 23:23:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b00417e3695371sm70793wmr.33.2024.04.10.23.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:23:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:23:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, rkannoth@marvell.com, shenjian15@huawei.com,
	wangjie125@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
Message-ID: <ZheB58bjmkFzIEbG@nanopsycho>
References: <20240410125354.2177067-1-shaojijie@huawei.com>
 <20240410125354.2177067-5-shaojijie@huawei.com>
 <ZhapUja4xXiJe4Q2@nanopsycho>
 <16347737-f0ac-4710-85ee-189abed59d6b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16347737-f0ac-4710-85ee-189abed59d6b@huawei.com>

Thu, Apr 11, 2024 at 03:05:53AM CEST, shaojijie@huawei.com wrote:
>
>on 2024/4/10 22:59, Jiri Pirko wrote:
>> Wed, Apr 10, 2024 at 02:53:54PM CEST, shaojijie@huawei.com wrote:
>> > From: Hao Chen <chenhao418@huawei.com>
>> > 
>> > Add support to query scc version by devlink info for device V3.
>> > 
>> > Signed-off-by: Hao Chen <chenhao418@huawei.com>
>> > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> > ---
>> > Documentation/networking/devlink/hns3.rst     |  3 ++
>> > drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
>> > .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
>> > .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
>> > .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
>> > .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
>> > .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
>> > 7 files changed, 82 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>> > index 4562a6e4782f..e19dea8ef924 100644
>> > --- a/Documentation/networking/devlink/hns3.rst
>> > +++ b/Documentation/networking/devlink/hns3.rst
>> > @@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>> >     * - ``fw``
>> >       - running
>> >       - Used to represent the firmware version.
>> > +   * - ``fw.scc``
>> What's scc? I don't see it described anywhere.
>
>diff --git a/Documentation/networking/devlink/hns3.rst b/Documentation/networking/devlink/hns3.rst
>index 4562a6e4782f..e19dea8ef924 100644
>--- a/Documentation/networking/devlink/hns3.rst
>+++ b/Documentation/networking/devlink/hns3.rst
>@@ -23,3 +23,6 @@ The ``hns3`` driver reports the following versions
>    * - ``fw``
>      - running
>      - Used to represent the firmware version.
>+   * - ``fw.scc``
>+     - running
>+     - Used to represent the soft congestion control firmware version.
>
>scc means "soft congestion control"

I guess this is something specific to your device, isn't it? Can't you
please extend the description a bit more?

Thanks!

>

