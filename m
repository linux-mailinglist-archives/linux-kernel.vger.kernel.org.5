Return-Path: <linux-kernel+bounces-95329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A6874C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B991F22CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8385275;
	Thu,  7 Mar 2024 10:27:49 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437C82D83
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807269; cv=none; b=Iliz614pyiUQiPBmc4E6Ea8fKKGGZOJ2YhqbsHNe0ny+28wDo5wcw1F0D80YNtMiOI/W2cWQcet5+j+G6Fosg/l+IAEliQJt+fIQkqOm8fZZZbumqYfZhLtyAI8gvXDQoYgD6nJ4fijE69e7POzyswfaXmHF2kYlFg07cS9azE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807269; c=relaxed/simple;
	bh=1b3cD1JzLzwXiFYhzW4TsWqoyMmImq6wp8ZpuvR6V0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3mfp1GP1PQKxCmRSP7MXR0O6jlieyCGImns/WhefaXJpqw1jm6W0vIBCkZizcAOJAWbGIUFu39SHq8c3vb9A2EtLPd8v+7LA2M318sh6GtkY9WLOpxbFAQnjrd2pANOhkuuBtdrhWaqdUjsyWbR4Ub7mm5qQRMWvnM2zEaAuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso301673e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807265; x=1710412065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1b3cD1JzLzwXiFYhzW4TsWqoyMmImq6wp8ZpuvR6V0k=;
        b=oqfxbq00KON44Q5S3YoTEqw8mo8d/zMyMIOgmj4ERU01H3RPRvj9yNz8GbnkUGwvRM
         um/PK/j+UAeE1PqlmGHTIplP5bZXK6Xh1NdCaOSg5n9myoLHGvUMSsQri05CDUEpD10D
         1REA7bEyb6EQb/GrsdRmfwABvqPoZf23eezVb/o2y9rrbnGBzy+xWSJwSOYt9kJRvILA
         4Q71II1ohrSzbgYJR1e5IebGpxyU1JiL/jJQRj3l9inV8kefwDIfdSVICMbAui9lviGB
         jTakg7x2Nce2lUrK/Z+srDuyLSJy5VUhDdcfuAUaZlqGsqtGnqIPwaftSITHWH/HqOME
         l2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA/gc1VKWcukK6LOp6SuNbmnghpwxQblduecfiFm7c10uzJsNBVvpM8vM0t8MzjOvw7VRPFPHbyJz4sM/DgHqf2VNCsNMuOeAv0hxY
X-Gm-Message-State: AOJu0YwwfS1EWatiN/5fWOIefvUbnN2b9uohT0VmzSG7nI9ZKJaiWMvC
	0fFKeE9iFm6NCIUftV+NgA//pvuU4gfScG+hQ43N1nIkExlxxNok
X-Google-Smtp-Source: AGHT+IFgps20vqDI6X9001WLlcmXvxNG4XMdRKTXA56bfHc/jYT/w42AHA0Bzl9WrYACFz6oS3wHDA==
X-Received: by 2002:a2e:7407:0:b0:2d3:364c:2620 with SMTP id p7-20020a2e7407000000b002d3364c2620mr3590171ljc.1.1709807265309;
        Thu, 07 Mar 2024 02:27:45 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033df46f70dbsm20672235wrb.9.2024.03.07.02.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:27:45 -0800 (PST)
Message-ID: <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
Date: Thu, 7 Mar 2024 12:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/2024 15:24, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.
>
> This crash wasn't observed with blktests nvme/041 until now because the
> retry loop was usually trying for several times (e.g. with defaults
> 600s) and the test would trigger the cleanup itself. Though we the
> recent change not retrying to use invalid credentials the crash can be
> easily triggered.
>
> The simplest way to control the life time of nvmf_ctrl_options is by
> using ref counting.

Why do we need a refcount for an object that has the same exact lifetime
as the ctrl itself? It just feels like unneeded complication.

