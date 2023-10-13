Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972617C8E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJMUVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMUVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:21:19 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC5B7;
        Fri, 13 Oct 2023 13:21:18 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c9e06f058bso16034995ad.0;
        Fri, 13 Oct 2023 13:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697228478; x=1697833278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ForsDPB0jZ2ImnQnOXHUTEo6P3ZZphz8F61hZrwbJRA=;
        b=Syg5dJ5nOsicTEJ3KSBeUkqacIW+Lrs4kxcgjmp8ho0pLZoD5wWL3bIdCgn+umh8T9
         bLkLuz1FBsT0JG44/c0jJDpGqMGnxXG2tQxzcRFwQAyEb4zcQxHz2xY6qk8sdSiENdrm
         5TPpL6VoSjfFPvW1SB8QuBydrsz7fNnSTSH0V2UjQTwpPZ5/mkr9gkIaqWj5VgtWhHo3
         Eud6/9lTFnbQaPERaozEpXLf6wybYrTCUQTgRsYGF26ytBs2lrxQJU9DLvIh2eyV0G0v
         GRj78eDIBIvoA0pRPGcfWY1/95VJVIRyxz+KXXPeNXer9OMsimmXDrn+dy1zRnSknKtu
         mwHA==
X-Gm-Message-State: AOJu0YwZZbq13pLIyix9EgR93mcW/1RiFENUfhNemFnNhYz4BG+tnhYL
        K2Dl67rnbuLN0kR0sNW/v88=
X-Google-Smtp-Source: AGHT+IHK6Vdj3neWysihmjr6VT1kW5IXWWGbJ0lQ9gb9c+jVMTQ/Rh06taVZ8L/Iz6CXpCcTy5jQHw==
X-Received: by 2002:a17:902:ea02:b0:1c1:fc5c:b31b with SMTP id s2-20020a170902ea0200b001c1fc5cb31bmr1705325plg.9.1697228477673;
        Fri, 13 Oct 2023 13:21:17 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001bdc3768ca5sm4363921plb.254.2023.10.13.13.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 13:21:17 -0700 (PDT)
Message-ID: <2f4eb591-b275-42fd-900e-292d0f87dd9e@acm.org>
Date:   Fri, 13 Oct 2023 13:21:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: blk-ioprio: Bring the doc in line with the
 implementation
Content-Language: en-US
To:     Tang Yizhou <yizhou.tang@shopee.com>, houtao1@huawei.com,
        jack@suse.cz, kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        chunguang.xu@shopee.com
References: <20231012024228.2161283-1-yizhou.tang@shopee.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231012024228.2161283-1-yizhou.tang@shopee.com>
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

On 10/11/23 19:42, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Our system administrator have noted that the names 'rt-to-be' and
> 'all-to-idle' in the I/O priority policies table appeared without
> explanations, leading to confusion. Let's bring these names in line
> with the naming in the 'attribute' section.
> 
> Additionally,
> 1. Correct the interface name to 'io.prio.class'.
> 2. Add a table entry of 'promote-to-rt' for consistency.
> 3. Fix a typo of 'priority'.
> 
> Suggested-by: Yingfu Zhou <yingfu.zhou@shopee.com>
> Reviewed-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
> v2:
> Accept Bart's suggestion and rename the title of the patch.
> Pick up Tao's Reviewed-by tag.

Thank you for having changed the patch subject.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
