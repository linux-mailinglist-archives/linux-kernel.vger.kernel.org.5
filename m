Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F043D7E61A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjKIBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjKIBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:00:12 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9C258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:00:10 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b44befac59so1094653b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 17:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699491610; x=1700096410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85crlNpRBk7PCnm2srRrO/tBT8MDdkwM/1UpT6izcog=;
        b=Z6iRT4JHu6+3N+c+fhaLOE5UhbFY5dyt5m14u0VKTRx+ptNSsToHr1UKMneKL4iMzA
         X4zaIACj2GL67DAW+hw1mPAfQ6rLSmLBNI3oHfX3tDCbNrJe8B5lGFGkhFIhMBL4NQHU
         d2h11/Z/WLMRZZYxFyjaVMWH5RrjxJvleWnsW4XmIzQpCYIqEzJ7XaA5MHX9NFibf5Rh
         bFD7urGH3usM2rrbZ4HzRCs/R47qp/5rL13/5ALPckOGDpr0n8kHV3mYIw7sXtkHw1/P
         e07XIfgRWGjjCmih0yxF1L4nrr7WznxhhgR2OkP6Sf0jm+xlUjY9IOoWbfNbyp3KOUtp
         TEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699491610; x=1700096410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85crlNpRBk7PCnm2srRrO/tBT8MDdkwM/1UpT6izcog=;
        b=O4NsBTWZxCCAygztdcaNzylT84cW+9TVukXpREPou6Vx807ilOEkR4sZUaILAHgnuY
         BYB79DdqQbHOWpGaZM6wkyLQrS9JD8icaM3nxpG/p/O4SBLn8lnqQFnnPYlDpr9awDR6
         yY3U20cqMiHYsW572OtR6vxK1Ra95pa+qFB3l595j+Sb7Dz7NLePwfEE25+cYNNQ+UNO
         1Gvu396hdxeliPCkT1WemYmtTyK2TSK85FpUfwmC1ZjT74RFNBXAr0RnInwkB3twLVcj
         IHQJnkhViDXaxq7XB/LmW1k9Lw/T0JuVM695Qsl/oz30jRD+vUSpCkMxnzHoKx8dKa/Q
         K74g==
X-Gm-Message-State: AOJu0YwXhQQImNPnP5dlByXScClaWZJ5hLVvb3o5qJjjR1iYMxlISvza
        NyOIDn4fA+ywygLfHlQnSvAq+Q==
X-Google-Smtp-Source: AGHT+IFZ+A+V9efdpst3RKcmTzNFKjnU6fZAcVh9Gggf3QKcHciEceqFp7u+2xG/6WA0k0W4Mavqug==
X-Received: by 2002:a05:6a20:914b:b0:13f:13cb:bc50 with SMTP id x11-20020a056a20914b00b0013f13cbbc50mr5525792pzc.25.1699491608958;
        Wed, 08 Nov 2023 17:00:08 -0800 (PST)
Received: from [192.168.60.239] (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with ESMTPSA id f29-20020a056a000b1d00b006c03fa6300dsm9528921pfu.117.2023.11.08.17.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 17:00:08 -0800 (PST)
Message-ID: <e29802cf-8387-41d1-a5b1-ab77254cd5cc@google.com>
Date:   Wed, 8 Nov 2023 17:00:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231102201939.4171214-1-arakesh@google.com>
 <20231102201939.4171214-4-arakesh@google.com>
 <93e26d61-49ca-443d-9044-32e73243c3b7@ideasonboard.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <93e26d61-49ca-443d-9044-32e73243c3b7@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 06:15, Dan Scally wrote:
> Hi Avichal
> 
> On 02/11/2023 20:19, Avichal Rakesh wrote:
>> Currently, the uvc gadget driver allocates all uvc_requests as one array
>> and deallocates them all when the video stream stops. This includes
>> de-allocating all the usb_requests associated with those uvc_requests.
>> This can lead to use-after-free issues if any of those de-allocated
>> usb_requests were still owned by the usb controller.
>>
>> This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
>> flag to uvc_video to track when frames and requests should be flowing.
>> When disabling the video stream, the flag is tripped and, instead
>> of de-allocating all uvc_requests and usb_requests, the gadget
>> driver only de-allocates those usb_requests that are currently
>> owned by it (as present in req_free). Other usb_requests are left
>> untouched until their completion handler is called which takes care
>> of freeing the usb_request and its corresponding uvc_request.
>>
>> Now that uvc_video does not depends on uvc->state, this patch removes
>> unnecessary upates to uvc->state that were made to accommodate uvc_video
>> logic. This should ensure that uvc gadget driver never accidentally
>> de-allocates a usb_request that it doesn't own.
>>
>> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
>> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>> ---
> 
> 
> Thanks for the update. Let's leave the locking as it is; I think albeit not strictly necessary on that occasion it certainly is necessary to take the lock to protect the flags elsewhere, and probably better to be consistent with it.
> 
> 
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

Thank you for reviewing, Dan!

Greg, I just sent out v12 with the Reviewed-by tag:
https://lore.kernel.org/all/20231109004104.3467968-1-arakesh@google.com/ 
They should be ready to submit now. Thank you!

Regards,
Avi.

> 
>> <snip>
