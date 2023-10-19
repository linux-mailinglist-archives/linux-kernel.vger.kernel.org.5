Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720927D022B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJSTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjJSS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:59:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47493
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:59:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca6809fb8aso36363425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697741997; x=1698346797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekm37LH11q8T0WhtnGFVtk8KCWjLe8MaemYJ1INw3fM=;
        b=lsyk+pk6867O5DE57576y5ohf6qQW7qClkgzBrdwsk26cmTJoqfDTymNbAMkqTpUNx
         4Dmb/c2KIE9clk0coBa/eP9jB0fp4JjZBT5sTrxymny5EHI+t88v2wevgsYjmZLVAe5L
         TLOLvdmGZBXAfxurz4+gaX+ndmCKEGiEobb02C3AOoFQ14fAafe1JQQoPLFFpDVz8a+f
         w7Wq/jHFGK3ArrwVbJ4eEiAzsdcNgW00cJBqakTcy/KjyClGfFfktuxWLpb6JD8megx3
         kbc+a08p/D8xRGEwaAvpnsTsXwDtEMW1YrCOO0nUGDhqTX4SMNk2lTGOjOnhdgAoUbsz
         Xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741997; x=1698346797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekm37LH11q8T0WhtnGFVtk8KCWjLe8MaemYJ1INw3fM=;
        b=jnw4kAVNLhj3WXFaldhjOspWiDjXenNVVwGRmSJPcLWB1c1X/g0P3+l3aL0RtsBw8j
         Vxij4wJGCXrOzlGOQenqFDR8jPjBuzeQZZDL0rLS0CbDfmE9UyMGxkwPUCchNom8UwJF
         g6mf96VBxiS6xHKKAI1SQs32ENV4/ZDLzvCBwHXMgQoR5EENimB/Rtvu3KQuXJkDJUmO
         8+HpzaHG33ivgi0N3eZDDdXP5aJ/GhT0RzJHopb3ePINKuuaBiYlmCF2P4vekYB3qVdv
         XwzOdMEyugHNN/KjBG1XLrLqFANbPNYbXwrktc1j1Flr10mzCh2e8JQ/X7K1IN1w83gM
         y2PQ==
X-Gm-Message-State: AOJu0YwpWm0WUJ/sLQxPQLiY+dNeA6tAihi2mTXfHjbqSdvhd7UwdIL6
        lwGXcyyPgY4mYL7P1Db5EVxQ4g==
X-Google-Smtp-Source: AGHT+IGyZiJwz5do3i+LGVcFutBEazlK6wjFdR4H29hIMFAlJGa2HHdn6Wp6zEuz+WWpzYL1d3pl3A==
X-Received: by 2002:a17:902:c942:b0:1c0:9d6f:9d28 with SMTP id i2-20020a170902c94200b001c09d6f9d28mr3577291pla.11.1697741997228;
        Thu, 19 Oct 2023 11:59:57 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001c625acfed0sm52515plb.44.2023.10.19.11.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:59:56 -0700 (PDT)
Message-ID: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
Date:   Thu, 19 Oct 2023 11:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] usb: gadget: uvc: stability fixes on STREAMOFF.
Content-Language: en-US
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, m.grzeschik@pengutronix.de
References: <20230930184821.310143-1-arakesh@google.com>
 <20231019185319.2714000-1-arakesh@google.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <20231019185319.2714000-1-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 11:53, Avichal Rakesh wrote:
> We have been seeing two main stability issues that uvc gadget driver
> runs into when stopping streams:
>  1. Attempting to queue usb_requests to a disabled usb_ep
>  2. use-after-free issue for inflight usb_requests
> 
> The four patches below fix the two issues above. Patch 1/4 fixes the
> first issue, and Patch 2/4 and 4/4 fix the second issue. Patch 3/4
> is only there to make the diff in 4/4 cleaner.
> 
> Avichal Rakesh (4):
>   usb: gadget: uvc: prevent use of disabled endpoint
>   usb: gadget: uvc: Allocate uvc_requests one at a time
>   usb: gadget: uvc: move video disable logic to its own function
>   usb: gadget: uvc: Fix use-after-free for inflight usb_requests
> 
>  drivers/usb/gadget/function/f_uvc.c     |  11 +-
>  drivers/usb/gadget/function/f_uvc.h     |   2 +-
>  drivers/usb/gadget/function/uvc.h       |   6 +-
>  drivers/usb/gadget/function/uvc_v4l2.c  |  12 +-
>  drivers/usb/gadget/function/uvc_video.c | 231 +++++++++++++++++-------
>  5 files changed, 189 insertions(+), 73 deletions(-)
> 
> --
> 2.42.0.758.gaed0368e0e-goog

Dan and Laurent, please go over the patches whenever you get a
chance. I think they're ready to submit as neither Michael 
nor I have seen any use-after-free issues after the patches.

Thank you!
- Avi.

