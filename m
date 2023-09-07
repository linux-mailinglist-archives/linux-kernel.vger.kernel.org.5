Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B5797ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjIGWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIGWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:47:51 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23B1BC9;
        Thu,  7 Sep 2023 15:47:47 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1147768a12.2;
        Thu, 07 Sep 2023 15:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694126867; x=1694731667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afNbBamuZdo2zLKNzsLtYHGce/YhiaDsLl+WBnkhFxw=;
        b=u24/8sev9PfYsWJjQEBEz4WbmBg/xw4hv2PHYLgu8v0dvEWTlB3O1wafTwr2jx7Khv
         3dZWyR9EB0PJYU3R8HrLKwToJoD+RPwFp7JdHmbMt5pxXtoH6c5Mcolf/ZJ6/qT66m/G
         zfSn4Li59HNgjJG22dLK6A3B8PxH2/KmVCES+qbu082kzX33uXWIsAX7R2Xzlp63+elf
         WLHwGPZt9qeEYOqlBq2i/martVFQJED3oF2nTCfG3K7eBWzn+FeflicZc6vpmUqKpX3J
         bt1gjd161wTY2L+nbQ6HihFMnZEQkuC3K2QG+06wwWlUsrkjbE3ScMrAfcMIAUu/UuLB
         Yk4w==
X-Gm-Message-State: AOJu0Yys/M3KWgDtAUrvyvMegIsDMhg99ZQO3hFmWcFC/1Gyj5ocZt1F
        Yb1QFHn/jNE0mxnAJ4B/eb4=
X-Google-Smtp-Source: AGHT+IE9ppCtWNAu+NwWpVctlXW9PrmJOvZdpjrabhlffM2HTvU8EeCotrWifmrz+wV1JfKH4O4WUg==
X-Received: by 2002:a17:903:1c1:b0:1bd:fa80:103d with SMTP id e1-20020a17090301c100b001bdfa80103dmr1177011plh.25.1694126866890;
        Thu, 07 Sep 2023 15:47:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:dc9c:fbbb:e496:d46e? ([2620:15c:211:201:dc9c:fbbb:e496:d46e])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902f7d600b001bf5c12e9fesm248483plw.125.2023.09.07.15.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 15:47:46 -0700 (PDT)
Message-ID: <e2c7f484-0fd5-43e0-b27a-41f1b23c6932@acm.org>
Date:   Thu, 7 Sep 2023 15:47:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] scsi: ufs: core: Simplify bool conversion
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230907005413.100804-1-yang.lee@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230907005413.100804-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 17:54, Yang Li wrote:
> ./drivers/ufs/core/ufshcd.c:2307:26-31: WARNING: conversion to bool not needed here
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index c2df07545f96..04bbe38ffd87 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2304,7 +2304,7 @@ static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>   	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
>   				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
>   				    REG_CONTROLLER_STATUS);
> -	return ret == 0 ? true : false;
> +	return ret == 0;
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
