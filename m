Return-Path: <linux-kernel+bounces-7338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11B81A600
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF821F2460D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFF47A4F;
	Wed, 20 Dec 2023 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSJPh4sZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFA4777E;
	Wed, 20 Dec 2023 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so64270545e9.0;
        Wed, 20 Dec 2023 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092172; x=1703696972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyCAaP8IxJaE3c11ERdD/kDIRtUxWzH+hq3aJA4DCaU=;
        b=kSJPh4sZXcDHeWx6x2Vg7tpqJIhDo9qczzOK3bPRYOG/I23QZz+Ke0hts1QArjAQTs
         v/4EXmAd7YrjdNTMDubarvu5ETcPXRPcUmiqX/dA1d/5LkcStWwvpDEVqDADwku7/1P3
         CT8lGH3CoJ66Yk6K4R55FzaYGomg3Bd8cGhJhvh4BpZXLfnotNXBVfbqXSmRoZMPAPs4
         MbqKu0VjmOfZtxQfESIK91u3sE063AbJJoTUFGecAM12EH7M84Se0ciajCi85vMdkqOT
         QjHAuSukyhliQO2db+gSRgjfd9x2xTQ/Npl4A0r5//Al7pPalANl4/LdsauWQY+XX7PC
         8OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092172; x=1703696972;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyCAaP8IxJaE3c11ERdD/kDIRtUxWzH+hq3aJA4DCaU=;
        b=i7C4GmRyzKMeYtTRHo4rM2bsqSmlr0ADpT71J/ljmPCo9me6/49vIb01ToPLsyhZtZ
         rGAsbQFk1UMTyAsy1Qiyt2fXEew4QsfDFCBTP9v8/5UCaOwGZQoqgYS496kCs80zDnR3
         1F/mcbFTYILBXMPCv3BlJndDr3nto7TdBMzh3z7SVu7AL0HwG9mMimIeAHqU2q0lXgM9
         pGm6eGXqL4o5WvPnrhj8qBVzWxYRIJmjo7Zbmf2rjyJjixtZbMzvzF4Bm+o4zNlBuPIw
         DyXQptpn7K+5ARkVijan2mT7L0oYPaY2bfsFAnc3VvrOoelaY7M2adgXrPrrWy7Zox2T
         SjQg==
X-Gm-Message-State: AOJu0YyqkfB/4rxf3Nz4iastgai2LBL5750scqdXCEHYdmMJ/lw951Nf
	EkKQ8fEFy+ecQbH/VbNQ6NlUFqBHPiE=
X-Google-Smtp-Source: AGHT+IHPJOpK1WI2zFHCI54nXyugDE5IwGVKg1QWWylEk5Dv4LxEzp/VzmGafSqtZEltfOpCHgIRzQ==
X-Received: by 2002:a05:600c:997:b0:40d:3a27:2af2 with SMTP id w23-20020a05600c099700b0040d3a272af2mr1072wmp.177.1703092171842;
        Wed, 20 Dec 2023 09:09:31 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040d1774b4e4sm243807wmo.42.2023.12.20.09.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 09:09:31 -0800 (PST)
Subject: Re: [PATCH] sfc: fix a double-free bug in efx_probe_filters
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20231214152247.3482788-1-alexious@zju.edu.cn>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a25c5e5a-a131-649b-bc07-9e6c72108ac0@gmail.com>
Date: Wed, 20 Dec 2023 17:09:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214152247.3482788-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 14/12/2023 15:22, Zhipeng Lu wrote:
> In efx_probe_filters, the channel->rps_flow_id is freed in a
> efx_for_each_channel marco  when success equals to 0.
> However, after the following call chain:
> 
> efx_probe_filters
>   |-> ef100_net_open
>         |-> ef100_net_stop
>               |-> efx_remove_filters
> 
> The channel->rps_flow_id is freed again in the efx_for_each_channel of
> efx_remove_filters, triggering a double-free bug.
> 
> Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Subject line should probably say [PATCH net] to specify the tree.
Modulo that, and Simon's correction to the commit message,

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

