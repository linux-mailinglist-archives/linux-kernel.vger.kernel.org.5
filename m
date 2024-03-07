Return-Path: <linux-kernel+bounces-95404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85A874D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E0283A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948412A15C;
	Thu,  7 Mar 2024 11:18:55 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3912A153
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810335; cv=none; b=sd5J8L5jXX1QDmvcM1h8mWMnZosbVFXD+PFYHtXnUZ0MUn+FpMo+Zu/+RoUIDakNwJwRccIeyovaUwZsVKt2C33o5twvY1sIfOQJDWF+FgPwktRR5LPOcEI2eId1i/d77HN9ttLvmDz+bJEWpxAWykYxdyLBxMzsBMOWyoGYJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810335; c=relaxed/simple;
	bh=Myr/j16sX+jhXWXpfttbQ2Qc+AcmyBlzUHvht77GW90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofd6Ux/RhinGMmQGmbhQZNYhRWg78MZmD1z9We7ttvkQ799Z4lxeuTuy1fCwFvQeyWfpZinshTE2gvkm41lFrVUwqduhjnsi+IHH6EFL8c+d41vhUSwqR+rAeY05nBa7QC7yH9fnEV3rMSXf3EHBrhLI1Xz6+gzOI49Z5UVcPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412e41cab5aso317135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810332; x=1710415132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Myr/j16sX+jhXWXpfttbQ2Qc+AcmyBlzUHvht77GW90=;
        b=xGwof02wuDWtA1MGR2tozBR6glEWHWFZO+qUz0663cqPefeEmEn8dxZMTuVYBzqcbn
         bJABrjloGszyg/cbQdkl6iaXd09VjBL8ikTEqp1mzRmqj+IBLdV9lKN6RwoSgYo3UArG
         4m+fn08WQpyu7izwmxvKpKbHGmTAEMEloZjJtTbaPhc8hvoPpU38dWhjmsLVTmPUMIEB
         QuJVh8tfW6uF4gW8PxhXVnNhy261YJ+JgZMjWVwhpIxg48sRYvtAs6DywuoHoBGZRhOg
         U4bjsU5auReJFh4c8eQS6ZNQTHclLMLydeBjkbh2mE5FnMKVUu2pCJgncEu/gcrxJSlF
         vZqA==
X-Forwarded-Encrypted: i=1; AJvYcCXkCnidBqmspKoeoPN+ZrlqSVfsP+4vLiMLjRFTqplJoz46Dub+1ZeANhwCo+3D1GHMtERxb5J35KoBnFtBatjn9dphgMmNIUKnI1IM
X-Gm-Message-State: AOJu0YwK8XtLQFkxfIG83+5FH8zNPCjOZCLGYoXZO9HIB/vKiRMiXbsC
	IxUwHyorkzdM6T/dE+ZJf/glk0euY4O4eoFWeGQGEU4bBicPExxl
X-Google-Smtp-Source: AGHT+IHO+G/yvC5zfgZxvDPmYhxxkdHEIeLbgK0HSrrJI8z5OLW3o19N1JccRzhJeqUYkrYjD/dDIg==
X-Received: by 2002:a05:600c:3ba8:b0:412:eb6e:2171 with SMTP id n40-20020a05600c3ba800b00412eb6e2171mr1201171wms.1.1709810331597;
        Thu, 07 Mar 2024 03:18:51 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b00412f83e0c11sm2343940wms.22.2024.03.07.03.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:18:51 -0800 (PST)
Message-ID: <796911a6-c648-4af3-b633-463e03d3aecb@grimberg.me>
Date: Thu, 7 Mar 2024 13:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: he-IL, en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307110657.252120-1-brookxu.cn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240307110657.252120-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/03/2024 13:06, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> We found a issue on production environment while using NVMe
> over RDMA, admin_q reconnect failed forever while remote
> target and network is ok. After dig into it, we found it
> may caused by a ABBA deadlock due to tag allocation. In my
> case, the tag was hold by a keep alive request waiting
> inside admin_q, as we quiesced admin_q while reset ctrl,
> so the request maked as idle and will not process before
> reset success. As fabric_q shares tagset with admin_q,
> while reconnect remote target, we need a tag for connect
> command, but the only one reserved tag was held by keep
> alive command which waiting inside admin_q. As a result,
> we failed to reconnect admin_q forever. In order to fix
> this issue, I think we should keep two reserved tags for
> admin queue.
>
> Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

