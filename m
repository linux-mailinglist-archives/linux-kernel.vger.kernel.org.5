Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01EF7E9DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjKMNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjKMNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:52:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39DD71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:51:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507be298d2aso5890154e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699883518; x=1700488318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JwnpTav/UWDGi+9Qj0ID7d5E6A/wZkBtycg+sKmIRk=;
        b=BXzEI+Y0V0Ne+HVLkkQ51XgFq0d4LrPBIypEhDaVztVvLqLHRc4bZx1N1099zcH4CP
         75JeoE2t9Av9iE/1vp83D72m9o0vbyI9KfWLznMff02VtU8POHlmso7hsrhHBkZOwZws
         Xbgc3QSSWOSd6Wz3OsVawRWwcn1OmlRg6Rb9K9tLg7vzTXY5p2PWwr0GAtQervUdFeaS
         67WVnEpw7GhE+zcZuz6rJlDU0v2uwXwC8WSkMucJu6X49TQrCxEpm29eh1ZzwYi8Z93j
         I+czsICi6xh/bWBMjtSixNKsRPMh/Ja5PYnc52qoJ0ejupxjzgWxQO2DsTp185LKiul/
         aBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883518; x=1700488318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JwnpTav/UWDGi+9Qj0ID7d5E6A/wZkBtycg+sKmIRk=;
        b=WAp9/tdLih+qlCLQmYHhvvrHutd8C5wzY8m0j4nkiz6jkyOkE5UisGBJlzKgH4pqG3
         zH1bD78lk52S+zJ1BxwsD+VzC9ajf4C39CbmbmUEEITnrTGclX/vNttDVFoqZ1dLzqJu
         CLH0cwR0qMQotYbw0zacxnQvpAaYRp8rR45YxJDawVIgDJL78mTpLqU/ROj7eRQlUYTj
         GEqWHQ/l+IZ46EBI6qDIGz4wsWxCZRIr5MRQ2T5rQBUUPsN04+QCpvCxl/eQopPCJU5M
         6ydJcod5p+Mo/T/acKjTFK5ll1c/B95NLXBFThXyFROkhPPlAqtMcUggXuhUoI1N13sc
         wdfw==
X-Gm-Message-State: AOJu0Yz3jPL+f/vPu54J11vswLZgpZuPiHzlE+LpluEltShHeAv/z8xR
        2uX2qG0sHCOZ+amhZKcIOTXe+DkOAgY=
X-Google-Smtp-Source: AGHT+IFv0uWlgXZcytYlL2U+zbig+zZeYsk4Fm4X4XPq4fCBTaoCxu4F+vbhvbrNq2lIm2g0JeXb1g==
X-Received: by 2002:a19:6d03:0:b0:509:43cc:18b with SMTP id i3-20020a196d03000000b0050943cc018bmr4409477lfc.30.1699883517610;
        Mon, 13 Nov 2023 05:51:57 -0800 (PST)
Received: from [10.17.77.191] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p11-20020a056402074b00b0053da3a9847csm3736181edy.42.2023.11.13.05.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 05:51:57 -0800 (PST)
Message-ID: <f1480f64-86ae-4f7a-909e-7afe3275cddb@gmail.com>
Date:   Mon, 13 Nov 2023 15:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] xen/events: fix delayed eoi list handling
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-2-jgross@suse.com>
Content-Language: en-US
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
In-Reply-To: <20231016062831.20630-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.10.23 09:28, Juergen Gross wrote:


Hello Juergen

> When delaying eoi handling of events, the related elements are queued
> into the percpu lateeoi list. In case the list isn't empty, the
> elements should be sorted by the time when eoi handling is to happen.
> 
> Unfortunately a new element will never be queued at the start of the
> list, even if it has a handling time lower than all other list
> elements.
> 
> Fix that by handling that case the same way as for an empty list.
> 
> Fixes: e99502f76271 ("xen/events: defer eoi in case of excessive number of events")
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

> ---
>   drivers/xen/events/events_base.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 1b2136fe0fa5..0e458b1c0c8c 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -601,7 +601,9 @@ static void lateeoi_list_add(struct irq_info *info)
>   
>   	spin_lock_irqsave(&eoi->eoi_list_lock, flags);
>   
> -	if (list_empty(&eoi->eoi_list)) {
> +	elem = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
> +					eoi_list);
> +	if (!elem || info->eoi_time < elem->eoi_time) {
>   		list_add(&info->eoi_list, &eoi->eoi_list);
>   		mod_delayed_work_on(info->eoi_cpu, system_wq,
>   				    &eoi->delayed, delay);
