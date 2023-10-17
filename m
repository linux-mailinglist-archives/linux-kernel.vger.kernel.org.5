Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589D7CCEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJQVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:04:22 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075DF0;
        Tue, 17 Oct 2023 14:04:17 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57b811a6ce8so3423408eaf.3;
        Tue, 17 Oct 2023 14:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697576656; x=1698181456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8cJNPTURV0GkUj1cmdUTjReWRSunzyFjmyMjB4isUU=;
        b=mXqWlEl2e3IGJ3A1jtPu0XjRm6PFWDHQ7OY17GUDSleoL4tTGbecy+eItCiwXjSj0v
         8H9QYwfml905PnQE2ZngqBPDSBU6bpHRaCeJkzlJJSpbh8esWcQ+XlOhxHJ/o/Lk3z52
         AIagrwoRj0aMxhwHvyWAEtbD+2G+YSDEYNnqkVi1tDOiKE/eCbEdF0TrHZi0krxtOEBn
         tD1EHbkbspM358CVJ/KTI3kcIDz/UifIZhvTIUHc4IkOCKhrvdLEgVnJ89Txja0APn69
         RbThIQvXd0DGGyd95NnLjJgt5TA2OcrbSexxTXk23CrRStBvwBjuPVTakclqsd4uv7aO
         v/Fg==
X-Gm-Message-State: AOJu0YxWhfcZIGThr2b8TwVkiXcy0wGyb7whKqwu92flnPEqSFMG4s7P
        U8oTwGgsUIbk3iHFZiplOkM=
X-Google-Smtp-Source: AGHT+IEhjprsd07Bq2kKlfmxdIh9p099C5BKB7yLZL8m8Cxf4rOUeLzCwRYLYJsXgpAwNyjcwr35jQ==
X-Received: by 2002:a05:6358:fac9:b0:140:fbfe:d941 with SMTP id ts9-20020a056358fac900b00140fbfed941mr3122490rwb.20.1697576656165;
        Tue, 17 Oct 2023 14:04:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b006bae6eea9d0sm1906785pfq.49.2023.10.17.14.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:04:15 -0700 (PDT)
Message-ID: <128adc0e-3a91-4395-b373-ef77a0882f29@acm.org>
Date:   Tue, 17 Oct 2023 14:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] scsi: Add comment of target_destroy in
 scsi_host_template
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231016020847.1270258-1-haowenchao2@huawei.com>
 <20231016020847.1270258-3-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231016020847.1270258-3-haowenchao2@huawei.com>
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

On 10/15/23 19:08, Wenchao Hao wrote:
> Add comment to tell callback function target_destroy of
> scsi_host_template is called in atomic context.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   include/scsi/scsi_host.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 49f768d0ff37..2e8d77441064 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -245,6 +245,9 @@ struct scsi_host_template {
>   	 * midlayer calls this point so that the driver may deallocate
>   	 * and terminate any references to the target.
>   	 *
> +	 * Note: this callback in called with spin_lock shost->host_lock held,
> +	 * so donot call functions might cause schedule
> +	 *
>   	 * Status: OPTIONAL
>   	 */
>   	void (* target_destroy)(struct scsi_target *);

The above comment can be made shorter and spelling and grammar can be 
improved. How about the following: "This callback is called with the 
host lock held and hence must not sleep."?

Thanks,

Bart.
