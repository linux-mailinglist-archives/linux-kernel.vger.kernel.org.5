Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6B7C61F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjJLAmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJLAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:42:19 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79E9D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:42:17 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c4f1f0774dso291925a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697071337; x=1697676137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HROiGerXCp7dKWDka6Cts8IThrvnCOQZH316FLylP9s=;
        b=mv3j8ECf0LuFqZAwVutqO5ciFYbeh7hxwRBs0WTcsgMqxB/afvPx9nuDHOia9uxwIJ
         /nA3kc6KBTfXBNXywcP4XQOppwq7+HCBRoL3jzAgAr/0XeiFyj53jTTM1ze3RpVDMUsJ
         9YRUtd+406rEuK4K2nfTmgkr+pSnTPSPouLIe2d/4PgDYlp3t2pvTqP5+7omF6yjg6Xq
         fd2DTvbtCpsOk1VM8yyhGx0Tak4V6GjbFFbVseUrQPN659rNUrb/rWrjlKeTkzOMg9ZB
         DfMSeSUutm5gc0RmxSN7GndV9wSKvZKmCx5Wyol6uVDg/3D7bYRwq4YCmTHCGg4sbYWv
         T7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697071337; x=1697676137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HROiGerXCp7dKWDka6Cts8IThrvnCOQZH316FLylP9s=;
        b=TD2zg82iwsHnm7ReuIBUXwTOUjjDWrdK357z736hJnHwT140dVoHoCOGp9ubyHSask
         HfIDePpPtNIjWvjttwqjvc099kpvT3gkUlztqqQGXh7JnR8BCFEF9WefTgHhW0QPWB4L
         yNlPBJe9GiBfrmrH6TubeLMb5x6o5Q3rjqyi2Ght8doC768gerrjw+qLrcKvPgYCxope
         r/ek/8JEncmGOULUL3mpAuYXXkju+oFMK5AV8mLEEZY1584Pe/BSSrIocYySd5gOJuai
         da0fSySlS/Kk1Tb8fb72UrZmUdzXZn3KQ0BxnFgk+klAtMfN6a8uPeOajReEjRGcgVWG
         v/Ow==
X-Gm-Message-State: AOJu0YxF6x+2UMLY0BNfN0D6PlmXKgA4l5FBqEQPbVnaw/Lx54N+zkFJ
        Ly5nJWMwZGAp1kRKES46ye2U6qpPsdEUr8aiIndne171
X-Google-Smtp-Source: AGHT+IHU5Tb+Z6qb+tVqOD0jFEh3Lf0ZIvxMQMouBSqlv0YSvG5Xsrkz4ihhBx56+rYYmxWcSNXQBw==
X-Received: by 2002:a9d:73d5:0:b0:6b9:8ea6:fbc2 with SMTP id m21-20020a9d73d5000000b006b98ea6fbc2mr24450462otk.27.1697071336824;
        Wed, 11 Oct 2023 17:42:16 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7905a000000b0068fc48fcaa8sm10710779pfo.155.2023.10.11.17.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 17:42:16 -0700 (PDT)
Message-ID: <e8d290d0-643c-4a41-8dfa-c56a98a8a02d@google.com>
Date:   Wed, 11 Oct 2023 17:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Content-Language: en-US
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230930184821.310143-1-arakesh@google.com>
 <20231012002451.254737-1-arakesh@google.com>
 <20231012002451.254737-3-arakesh@google.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <20231012002451.254737-3-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 17:24, Avichal Rakesh wrote:
> Currently, the uvc gadget driver allocates all uvc_requests as one array
> and deallocates them all when the video stream stops. This includes
> de-allocating all the usb_requests associated with those uvc_requests.
> This can lead to use-after-free issues if any of those de-allocated
> usb_requests were still owned by the usb controller.
> 
> This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
> flag to uvc_video to track when frames and requests should be flowing.
> When disabling the video stream, the flag is tripped and, instead
> of de-allocating all uvc_requests and usb_requests, the gadget
> driver only de-allocates those usb_requests that are currently
> owned by it (as present in req_free). Other usb_requests are left
> untouched until their completion handler is called which takes care
> of freeing the usb_request and its corresponding uvc_request.
> 
> Now that uvc_video does not depends on uvc->state, this patch removes
> unnecessary upates to uvc->state that were made to accomodate uvc_video
> logic. This should ensure that uvc gadget driver never accidentally
> de-allocates a usb_request that it doesn't own.
> 
> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v1 -> v2: Rebased to ToT, and fixed deadlock reported in
>           https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/
> v2 -> v3: Fix email threading goof-up
> v3 -> v4: re-rebase to ToT & moved to a uvc_video level lock
>           as discussed in
>           https://lore.kernel.org/b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com/
> 
>  drivers/usb/gadget/function/uvc.h       |   1 +
>  drivers/usb/gadget/function/uvc_v4l2.c  |  12 +-
>  drivers/usb/gadget/function/uvc_video.c | 156 +++++++++++++++++++-----
>  3 files changed, 128 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h

Apologies, I realized I forgot to run checkpatch on this patch. Will fix 
the lint issues in the next version. This patch is functionally okay, but 
has 2 minor formatting issues. Feel free to review the patch, and I will
fix the formatting as I am addressing the comments.

- Avi.
