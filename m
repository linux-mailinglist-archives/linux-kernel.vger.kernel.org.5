Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA87AB42A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjIVOxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjIVOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:53:16 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD21AD;
        Fri, 22 Sep 2023 07:53:10 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c451541f23so18777655ad.2;
        Fri, 22 Sep 2023 07:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394390; x=1695999190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ2DQQsTYbmNxZeLx7w+/PCwlM9kvekCBTcVZGvkVac=;
        b=qOsNskEaokb1k9x2ysPWd2V7qyzRYnPXPU/Orkpw0a1Ozd9jJ5Q99z16puor1F4/5K
         UxGi1nRd0hMWqubkK6TeWDV7q5ihbBWJEI1Tu1653x9h7xmUPyAqojFq3KeFTN3oQaM7
         0LKE1D8YqGedICo1W4eAguj4LUo+RC8h/z8Y7SJ05DouOUt74CA76LeK96GWY2maVdCd
         SmNOPNEVNrjdQyV6IiA9MZlPkno/hXCEaJSaST9JQ7EsAFJX3GgZVRG9+tpnmbouIC+u
         8dy7NY5aA/M++A4IJWg0uZTrV8Bg6yTAGVpZNG4pba38SIYCaYNgsQkjc9snd0jxhJMU
         kR9Q==
X-Gm-Message-State: AOJu0Yxx15lW1cVYubnKgCLnTxBuFTfRM7/NttdOPKC1X2Q2zgqps6lt
        h/Os7mQEUM37v6UpbDiTjso=
X-Google-Smtp-Source: AGHT+IHBq5h9MN47esxaeHKfEi686Sgby/W56O3YGSavaqYK3JX9lQPtdg2ounbnFHhePd+876u7Kw==
X-Received: by 2002:a17:903:44a:b0:1c4:e69:42c3 with SMTP id iw10-20020a170903044a00b001c40e6942c3mr7655057plb.43.1695394389911;
        Fri, 22 Sep 2023 07:53:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:70e9:c86f:4352:fcc? ([2620:15c:211:201:70e9:c86f:4352:fcc])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b001b53c8659fesm3546667plb.30.2023.09.22.07.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:53:09 -0700 (PDT)
Message-ID: <9567a78a-baf8-432b-b279-cfc56d370a1d@acm.org>
Date:   Fri, 22 Sep 2023 07:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: Add comment of target_destroy in
 scsi_host_template
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
 <20230922093842.2646157-3-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230922093842.2646157-3-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 02:38, Wenchao Hao wrote:
> Add comment to tell callback function target_destroy of
> scsi_host_template is called in atomic context.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   include/scsi/scsi_host.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 49f768d0ff37..a72248fa5adf 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -245,6 +245,9 @@ struct scsi_host_template {
>   	 * midlayer calls this point so that the driver may deallocate
>   	 * and terminate any references to the target.
>   	 *
> +	 * Note: this callback in called with spin_lock held, so donot
> +	 * call functions might cause schedule
> +	 *

This comment should mention which spinlock is held.

Thanks,

Bart.

