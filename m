Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A37EA0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjKMQAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:00:51 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD710EA;
        Mon, 13 Nov 2023 08:00:48 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f03db0a410so2712070fac.1;
        Mon, 13 Nov 2023 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699891248; x=1700496048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCI3L64udzOVkgrvNBBuRjNKAjsQ4eF01P+K65TkA5w=;
        b=RFSyHFH6XvoyfWOo/ITvLF/POfuQH3Srb7MtMR7jga6WOEDAriy/kOZBXw7cepgABn
         dBUmkpAjR14pm7xbU0TBSnW062nW7Kp44fwbji1vaty5SR0+2JbGfEoJSjZPOKOLsmNy
         LRSNt8qUcBRgEDe9xMnfsNTjseGniKstpHwPhdvjHZmoI+iXFXnTTTYgqcb1YYHLdQVs
         doeX4qsMjfChp1bMMtpxsPBUtf1Yr/Y24U8qU3To/So93zYqno9EHmgw4jnkTH74HinD
         3wiNcRxyfDBaJeCtjO7uaXRy7QbNwuozP89Pb1UmQ+WAPIbEQT0z+A4FkstXEX0zvq6M
         2/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891248; x=1700496048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCI3L64udzOVkgrvNBBuRjNKAjsQ4eF01P+K65TkA5w=;
        b=TfpOoydVMYW3TqEljlD/q/10ZFrMZo9PoXR2s63z8VffUdGxZO9Dv0vfqsv71xsMk6
         pTwL4TgFjcX0ecKaocn5yJX0T2/1yjSWxi9aaXjfx4scPPkgrSHCfcv5by2eH5MgkXns
         g0rID1hsGLpPwSy321huFedDpDfj+xy7wAEr/esvGGLbivViW5TdUyzlnebaeGIOxZ7Y
         96kfN6l9yalsMyeEPmCoe9Bblyl4M9apeb9X++V7pFKH1eNyX0543R4mCo+z9iZ34fZr
         2nRKpCQNuxBAOHjrLri6GPdOIWrSsXxZTLZ27ygD5Dve42aiBTxyuentjHvrZlHeljqB
         m1UA==
X-Gm-Message-State: AOJu0YzvKId4UsfqYjj1JKEHXVborRJkN8hQq4ztMhfdosY+bGi1SAxV
        bDxuna7HS2eziUSTFCKGZDU=
X-Google-Smtp-Source: AGHT+IH86Lvw+64cQ2bSyDXafINYo5kfidT2s9w5HvzhHpRJmHju1T6JxeDyWMwovvWP9+KLbWvwuA==
X-Received: by 2002:a05:6870:f815:b0:1e9:b0be:d004 with SMTP id fr21-20020a056870f81500b001e9b0bed004mr8685638oab.47.1699891247803;
        Mon, 13 Nov 2023 08:00:47 -0800 (PST)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id b187-20020a6334c4000000b0056b27af8715sm4213931pga.43.2023.11.13.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 08:00:47 -0800 (PST)
Message-ID: <fdcc6a76-f724-422f-904a-eb980c4b458a@gmail.com>
Date:   Tue, 14 Nov 2023 00:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error
 handle
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
Content-Language: en-US
From:   Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <20231016020314.1269636-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 10:03 AM, Wenchao Hao wrote:
> I am testing SCSI error handle with my previous scsi_debug error
> injection patches, and found some issues when removing device and
> error handler happened together.
> 
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().
> 

Friendly ping...

> Three issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 3. IO requeued to request_queue would be hang after error handle
> 
> V3:
>   - Update patch description
>   - Update comments of functions added
> 
> V2:
>   - Fix IO hang by run all devices' queue after error handler
>   - Do not modify shost_for_each_device() directly but add a new
>     helper to iterate devices but do not skip devices in removing
> 
> Wenchao Hao (4):
>   scsi: core: Add new helper to iterate all devices of host
>   scsi: scsi_error: Fix wrong statistic when print error info
>   scsi: scsi_error: Fix device reset is not triggered
>   scsi: scsi_core: Fix IO hang when device removing
> 
>  drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
>  drivers/scsi/scsi_error.c  |  4 ++--
>  drivers/scsi/scsi_lib.c    |  2 +-
>  include/scsi/scsi_device.h | 25 ++++++++++++++++++---
>  4 files changed, 57 insertions(+), 20 deletions(-)
> 

