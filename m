Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1407ECAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjKOTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjKOTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:03:02 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE4FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:02:58 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-779f81223ebso14303085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700074977; x=1700679777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9d36DgDA/QnAQZv1ro4N/h/3SVClD6IwxuT6wl51PpY=;
        b=z6X/8eGv/YxFzkiqGhZmpAqWKDPptFNLOWUdTgYUM2EFCTDFeskMboG8N/ZZv+A07h
         X8BQrLcsgmMWCZ/C6amxeiI8ZP/2KM97kDwQSuCp2+cCcLL+PoGFBNd/mw+awljS3ZT+
         JycpfJBDyj6Y42g4rjFSi0HcNorP02msL90UqPMXRpNIatGRMQWFqWX5W79ZUm6dFV6p
         GUPWpBR1KefIzTcz/pg7PLhr/bj3LEt8DUFF1j7yoLWKTdfA3/MNPS9Kkqiz6Gu+Q71i
         vbEsC3EoTpRYxDdyBPNFO1Z/pZjT1cclZKgNqOwt3nrj9SCM8uqpqf0o0m0LlcyvQSoz
         /ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074977; x=1700679777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d36DgDA/QnAQZv1ro4N/h/3SVClD6IwxuT6wl51PpY=;
        b=mGq5779dluKjV+F1aKfP25Z+jsJJS8nhb4ZyIM2DZMkdRjBgtpccjBS09zmElPcjY4
         BjfzKobPVmbbz+ecfWSdKJIlfpm6fGYX3VeASzsAPOG/kEnnYzRINciaR1JPTKskneRu
         oKcyyrexyiwoAxdFeZwBF/x5jCmZQpw3BS3HG9TWQto/KEzUayYFPRxp0dy1q8O89fQt
         EHTxbszw0MOxlLBolMMigmUjYZH0J90vrt74s5qRFA4V9ITD969wqvPtV6Wnk9LyboXb
         zmlTZsLkr+kO4N/3STH4bsQrvuM5v4IRlBJRb+jhLbcuJVurb70Y5zFzldyhoUNwt/kD
         pJEA==
X-Gm-Message-State: AOJu0YxI6O+jVxmRK56948AKkUxVkDF+9p0qJE3HKC3D8T53eDBPdQcV
        Evgkf7/ZFnWlZ2Om8oUKaoQRjg==
X-Google-Smtp-Source: AGHT+IEmwI3zsU+N7Y9wDWBzMpkZy6Dlt8+xg9yGPk6MWx4AZjw028icWgoGlLfdNUZwuP81kwUdyg==
X-Received: by 2002:a05:620a:1a0f:b0:767:e04f:48c8 with SMTP id bk15-20020a05620a1a0f00b00767e04f48c8mr6978457qkb.7.1700074977218;
        Wed, 15 Nov 2023 11:02:57 -0800 (PST)
Received: from ?IPV6:2600:380:9174:8ba6:574e:42be:c115:95f1? ([2600:380:9174:8ba6:574e:42be:c115:95f1])
        by smtp.gmail.com with ESMTPSA id rg8-20020a05620a8ec800b00765ab6d3e81sm3652407qkn.122.2023.11.15.11.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:02:56 -0800 (PST)
Message-ID: <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
Date:   Wed, 15 Nov 2023 12:02:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Content-Language: en-US
To:     Yuanyuan Zhong <yzhong@purestorage.com>, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
References: <20231115185439.2616073-1-yzhong@purestorage.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231115185439.2616073-1-yzhong@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 11:54 AM, Yuanyuan Zhong wrote:
> The head->effects stores a pointer to the controller's Command Sets
> Supported and Effects log. When the namespace head is shared by multiple
> controllers, if the particular controller is removed, dereferencing
> head->effects causes use-after-free:
> 
> [  227.820066] ==================================================================
> [  227.820069] BUG: KFENCE: use-after-free read in nvme_command_effects+0x1f/0x90 [nvme_core]
> 
> [  227.820091] Use-after-free read at 0x00000000c02dadcf (in kfence-#0):
> [  227.820094]  nvme_command_effects+0x1f/0x90 [nvme_core]
> [  227.820107]  nvme_passthru_start+0x19/0x80 [nvme_core]
> [  227.820121]  nvme_submit_user_cmd+0xc7/0x170 [nvme_core]
> [  227.820136]  nvme_user_cmd.constprop.16+0x152/0x1d0 [nvme_core]
> [  227.820149]  nvme_ns_head_ioctl+0x92/0x140 [nvme_core]
> [  227.820162]  blkdev_ioctl+0x1c5/0x280
> [  227.820169]  __x64_sys_ioctl+0x93/0xd0
> [  227.820174]  do_syscall_64+0x45/0xf0
> [  227.820177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> [  227.820182] kfence-#0: 0x000000000fac1d5d-0x00000000a28a73c3, size=4096, cache=kmalloc-4k
> 
> [  227.820185] allocated by task 2559 on cpu 3 at 188.703118s:
> [  227.820233]  __kmem_cache_alloc_node+0x3c9/0x410
> [  227.820236]  kmalloc_trace+0x2a/0xa0
> [  227.820238]  nvme_get_effects_log+0x68/0xd0 [nvme_core]
> [  227.820251]  nvme_init_identify+0x5ef/0x640 [nvme_core]
> [  227.820263]  nvme_init_ctrl_finish+0x8d/0x250 [nvme_core]
> [  227.820275]  nvme_tcp_setup_ctrl+0x1ce/0x710 [nvme_tcp]
> [  227.820281]  nvme_tcp_create_ctrl+0x359/0x450 [nvme_tcp]
> [  227.820286]  nvmf_dev_write+0x203/0x3b0 [nvme_fabrics]
> [  227.820292]  vfs_write+0xd2/0x3d0
> [  227.820294]  ksys_write+0x5d/0xd0
> [  227.820297]  do_syscall_64+0x45/0xf0
> [  227.820298]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> [  227.820302] freed by task 2521 on cpu 28 at 220.115945s:
> [  227.820329]  nvme_free_ctrl+0xa6/0x260 [nvme_core]
> [  227.820342]  device_release+0x37/0x90
> [  227.820345]  kobject_release+0x57/0x120
> [  227.820347]  nvme_sysfs_delete+0x39/0x50 [nvme_core]
> [  227.820360]  kernfs_fop_write_iter+0x144/0x1e0
> [  227.820362]  vfs_write+0x25f/0x3d0
> [  227.820364]  ksys_write+0x5d/0xd0
> [  227.820366]  do_syscall_64+0x45/0xf0
> [  227.820368]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Fix this by removing head->effects. Use the Commands Supported and Effects log
> in ctrl->cels directly.
> 
> Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
> Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Reviewed-by: Hamilton Coutinho <hcoutinho@purestorage.com>
> ---
>  drivers/nvme/host/core.c | 17 ++++++++---------
>  drivers/nvme/host/nvme.h |  1 -
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88b54cdcbd68..14fdc2de3a75 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1085,7 +1085,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>  	u32 effects = 0;
>  
>  	if (ns) {
> -		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
> +		struct nvme_effects_log	*cel = xa_load(&ctrl->cels, ns->head->ids.csi);
> +
> +		effects = le32_to_cpu(cel->iocs[opcode]);
>  		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
>  			dev_warn_once(ctrl->device,
>  				"IO command:%02x has unusual effects:%08x\n",

This is in the hot path for passthrough, can't we simply reload
->effects when we need?

-- 
Jens Axboe

