Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3EE7E646A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjKIHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:38:19 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6024173E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:38:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da819902678so613673276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 23:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699515497; x=1700120297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+iBiX1bOHvpJxojh5UIDm67CaHAWofg3Cpxz0o8uBI=;
        b=fYPYZfLHL6GuBCWQf5BPl0mbCsvtDb3uvj6+2u2EZRsBS5jihzDOmohPIJvRYNdMqT
         XoInDYK5/V/j0eTwU44x0yOAswvbXEUM8KtVWh+AJK21Qzu/LVCq72UrsWYgtwPoypJH
         yKRbmcYGnvx/R1IBoZCqJ/d/GCx97SYHaTlVzYP7gHvY55kaJa8FHEauBVDI/ALhCeLU
         RG/NtPm11lssCKoaS+GiWfDbmdLbvK4hVuaL8JeSCPOtrhUNXZSPNWxzNEU3KJc2SX0q
         CP2J0td4+uyrmGlGhSLd9uayyg8h3zXsbxTE+vyUj/cEtQtqInH45Ed/ORwRjAcXIcvS
         CK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699515497; x=1700120297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+iBiX1bOHvpJxojh5UIDm67CaHAWofg3Cpxz0o8uBI=;
        b=tpw9h8+oukMzFKu0hALnQh1xsKeXmeQ92X3ZwTa+xIahp7gqM30gDW9sk6x1F6+5Kt
         6nRbBtZ+KtlJo/zLHczXrMuii8JERD5Lm6cDx7Ol3jnNjdlK8DSdtAsd83WQHW6DEytg
         0Pt9/M2jBqn7t6WTCbwrgq1Nvl7TU+F6VtBI+zU+kkWNa8/VRpkTxKoi7AeylBRmHx3N
         kozolcedituc5Ibis5H6FgCvlbKkeqNRj221ZTOkNNLtP+8xGl6KgH0OD0OOebwad4T0
         pEIpVlAoaN2yP+H9bUivnQ63bAD2KH/0dVFLZeR5lHaTgbfKXJ8s2CicunLxqshyZg5Y
         wXcg==
X-Gm-Message-State: AOJu0Ywm4+nVFY1TyJKU5etJmlW1Hfk4g6FV/cDrXCRIwHXU/hY6cPab
        Vp2UB2ENDstVnyQW1cFBfIRsPg==
X-Google-Smtp-Source: AGHT+IENeTFbvsV4rkNBL5EgZoWoA+GPw7TiC5tkteseh8Q/+O7c8ydKT+7nJwKRQk1ScyNJLwjtRg==
X-Received: by 2002:a25:d0cc:0:b0:da0:4213:7c5a with SMTP id h195-20020a25d0cc000000b00da042137c5amr4254654ybg.2.1699515496612;
        Wed, 08 Nov 2023 23:38:16 -0800 (PST)
Received: from ?IPV6:2601:645:8100:1350:6ce3:194:86ca:9c36? ([2601:645:8100:1350:6ce3:194:86ca:9c36])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b006be7d407a11sm10367708pff.178.2023.11.08.23.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 23:38:16 -0800 (PST)
Message-ID: <6ee5bf0d-415e-4042-b857-ff041d666295@google.com>
Date:   Wed, 8 Nov 2023 23:38:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] usb:gadget:uvc Do not use worker thread to pump isoc
 usb requests
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.scally@ideasonboard.com, stern@rowland.harvard.edu,
        laurent.pinchart@ideasonboard.com, m.grzeschik@pengutronix.de,
        Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231103071353.1577383-1-jchowdhary@google.com>
 <20231109021251.542558-1-jchowdhary@google.com>
 <2023110953-tavern-underwent-63e7@gregkh>
From:   Jayant Chowdhary <jchowdhary@google.com>
In-Reply-To: <2023110953-tavern-underwent-63e7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 21:29, Greg KH wrote:
> On Thu, Nov 09, 2023 at 02:12:50AM +0000, Jayant Chowdhary wrote:
>> When we use an async work queue to perform the function of pumping
>> usb requests to the usb controller, it is possible that amongst other
>> factors, thread scheduling affects at what cadence we're able to pump
>> requests. This could mean isoc usb requests miss their uframes - resulting
>> in video stream flickers on the host device.
>>
>> To avoid this, we make the async_wq thread only produce isoc usb_requests
>> with uvc buffers encoded into them. The process of queueing to the
>> endpoint is done by the uvc_video_complete() handler. In case no
>> usb_requests are ready with encoded information, we just queue a zero
>> length request to the endpoint from the complete handler.
>>
>> For bulk endpoints the async_wq thread still queues usb requests to the
>> endpoint.
>>
>> Change-Id: I8a33cbf83fb2f04376826185079f8b25404fe761
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>> Suggested-by: Avichal Rakesh <arakesh@google.com>
>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>  Based on top of
>>  https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
>>  v1->v2: Added self Signed-Off-by and addressed review comments
>>  v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
>> 	 for isoc transfers.
>>  v3->v4: Address review comments around code style.
>>  v4->v5: Update comments. Remove 0 length request queueing from async_wq
>> 	 thread since it is already done by the complete handler.
> You forgot to run checkpatch.pl :(

My apologies, I sent out v6 with checkpatch.pl fixed.

Thanks

