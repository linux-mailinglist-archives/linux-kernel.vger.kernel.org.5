Return-Path: <linux-kernel+bounces-108675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226F880E45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F2D1F22205
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7738FA0;
	Wed, 20 Mar 2024 09:06:36 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723138DF1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925596; cv=none; b=ZXIoINZ0V3hR4jonpgMwM+QG71OLSRsYLLGIr9/THOX2JtRY0zj9kCPR6WwtZcI8gvVDnwT72rDs8s57u6ODA+y8bVjrd3LsaosKWT8TUmCGGVH84I8V/Dk4EXMwQYc45sjq1L0yGjwGf0+eSgkvieN8M/tnKJXBfBjfFK4i1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925596; c=relaxed/simple;
	bh=6yo+qgVl01Qo1BF1UC4nxMuI0iLiXWCwLlUG0wpTjWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt7CHwW9bzLgLxTl+k516PK7PU5VBqw3dSVmBZRih5hQYpNFiqS7mQUk9sB10rYGOpKyye+nTGDwHI5GCSRUbVtnIqlNpY6QQwgyU89FOf8U8ppLOy0RMW8gE/Hy6/EiBOwN126CvLCKk7vzVubz3NVw591QXJieboAdxmteXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso1281563f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925593; x=1711530393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yo+qgVl01Qo1BF1UC4nxMuI0iLiXWCwLlUG0wpTjWA=;
        b=dLRzNpeNXzyfid8oTpsAU/u6WwiLtkDgkhbLOkdO5QEfcvU+c8dGK+n3BE/Stf+jhD
         uBsKudg+1+XyLU0xfzI+rLR39Ojt6mA27pTS30yyRxdy+rvFxu3cvqc747AqKFC/oAFx
         CjQIgJ/brBVOhjQ7O0rU/axshmEeA9xkdmz3o9x0rZuY+n7Y3ZSQ2q7OXaqx8J87OWSB
         etrKp3EVKv2ZPkYTvWrZ/EVr+he6qqMNnLan/G1THxwvwIuhqlr27XW96McQ7O3pr96O
         M7j2nj1JdTM3PlET8iAU13SrSqEx7p4cRo+scsoloCc4Dc8EPxgAgvqLGjE0taRs9AeC
         PzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGP4p9745YtU3U8Rqswwv99KLMBQOWH8OXH3uGLGTERa0+9XOVM0VCcxkIDgI9ky60u3pHpSHq0EBzjVYVxC6/2jFB2+DOyku8I8aQ
X-Gm-Message-State: AOJu0YxFvb/hA0aCwmXTW90TfafLijT40uvBrT1omlmtYCs77XRHxh6I
	2AX+qyszOJZID2X2HZnB/ggc3ynIXd+aJtd7Dc5Xe/925/gtG0tj
X-Google-Smtp-Source: AGHT+IEw9+P2JdVs73otAM3hXGLxpH87fe+1tvU44C8aG9UtPwVZ6tid9SowJLGsDChZTcaXJ3kC/Q==
X-Received: by 2002:adf:c988:0:b0:33d:9e15:12bf with SMTP id f8-20020adfc988000000b0033d9e1512bfmr865963wrh.3.1710925592737;
        Wed, 20 Mar 2024 02:06:32 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e0dd83be1sm14034690wru.91.2024.03.20.02.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:06:32 -0700 (PDT)
Message-ID: <a1ebff42-4ddb-4e17-978c-2f02106a9d90@grimberg.me>
Date: Wed, 20 Mar 2024 11:06:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: he-IL, en-US
To: mengfanhui <mengfanhui@kylinos.cn>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
 <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
 <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2024 4:03, mengfanhui wrote:
> In this scenario. upstream should also appear.

I'd be surprised if it is,

The proposed patch was superseded by:
f165fb89b71f ("nvme-multipath: convert to blk_alloc_disk/blk_cleanup_disk")

Please verify that this exists upstream.

