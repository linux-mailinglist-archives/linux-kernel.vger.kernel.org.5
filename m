Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476187CE5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJRSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjJRSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:04:01 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F81F7;
        Wed, 18 Oct 2023 11:03:59 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d23f1e3b8so5401427a91.1;
        Wed, 18 Oct 2023 11:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652239; x=1698257039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGtc16Y54tmWQFTxFEcgYXLtPtjRRt1opEDzmPQ+grk=;
        b=mtJM6o5IxekjyZZ5UAcC3XdW79rBmkZ35I1ebKqJkK4mH6qx18/Rrpb8R7iR0qHcQP
         aw9924WQJdNX92tYfWc7RNPsBshvH3tzmBlwuGh6FcC0nmPcUJGHX2ZCtkgp3TlINMYn
         +l936SOyb+A2zvL6GTYHhYro4e/A6eT/reVyo07I1ITp/mZq8Zsb242rf4ED0yUwjHWE
         yHo6DREhS081NYBnzCeGZRcwLSIESAYE9LvNOLBex88dk2smyhlOVkpKvj5V0eB9ktZq
         LymsfKXHDcN3a3YZ3dmTY0O+POr0w00wMuqGFSDecm6uaYc7ZR5RquAERbmX9UPeQ1l6
         rNoQ==
X-Gm-Message-State: AOJu0YzpuozOLDf6hQZHYeBeMjX6m8fjVzQe8M043+vUpbwnCokBQ25Y
        jkpDRgXYZrNMTCOgdhifups=
X-Google-Smtp-Source: AGHT+IHBZen8NuJBjUyXzP4wyLUkGCxjZKoIfweH87/oZFHLl0wtZq8JN0hRLWyUZhi3dwbPbCgphg==
X-Received: by 2002:a17:90b:a43:b0:27d:4283:b8a2 with SMTP id gw3-20020a17090b0a4300b0027d4283b8a2mr5836706pjb.14.1697652239038;
        Wed, 18 Oct 2023 11:03:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a191800b00279479e9105sm240995pjg.2.2023.10.18.11.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:03:58 -0700 (PDT)
Message-ID: <58513668-33ae-4375-92cd-96a4d9a4a67f@acm.org>
Date:   Wed, 18 Oct 2023 11:03:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] scsi: Add comment of target_destroy in
 scsi_host_template
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
References: <20231018113746.1940197-1-haowenchao2@huawei.com>
 <20231018113746.1940197-3-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231018113746.1940197-3-haowenchao2@huawei.com>
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

On 10/18/23 04:37, Wenchao Hao wrote:
> Add comment to tell callback function target_destroy of
> scsi_host_template must not sleep.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   include/scsi/scsi_host.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 49f768d0ff37..2c61dd30d766 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -245,6 +245,9 @@ struct scsi_host_template {
>   	 * midlayer calls this point so that the driver may deallocate
>   	 * and terminate any references to the target.
>   	 *
> +	 * Note: This callback is called with the host lock held and hence
> +	 * must not sleep.
> +	 *
>   	 * Status: OPTIONAL
>   	 */
>   	void (* target_destroy)(struct scsi_target *);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
