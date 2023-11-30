Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52177FF011
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjK3N0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjK3N0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:26:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F910DF;
        Thu, 30 Nov 2023 05:26:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso7919995e9.0;
        Thu, 30 Nov 2023 05:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701350780; x=1701955580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMjMwDQeJ7U3HaJX4ZxhNthwT8vrdAeuzz7BaoFMnjY=;
        b=Wzi6oycK8AbGYZApwENpA4V2KBfFsz2IPvnI5RF+k4pqws5qm75nZN4VYtjPW2gWGh
         12iN5Vly27BfBBNMUGPxJQ9et8qeok8Npo9vFQkuT5Ioms9AKOyeVyk2bFxG1dyz6XPT
         QGbKWaXRKqrMNlMjPltxJJZfbOT0GKK2j2CTgxCNJQgrnWSpV1TlBG/5JHZ8xITabsPX
         ZPEmEmKOdaDCGSbtr99SPKuG+x45De+Eo9rHHByllicn7Te9Xm/TsbOYT+tLFIQP/9xU
         Ioh8MfJ6zmLuh+kpQPUb8f/5dKFQ89R3pg3/txw2KdZU0Ria27hWo/qvXsF3lLam9lqd
         Pzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350780; x=1701955580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMjMwDQeJ7U3HaJX4ZxhNthwT8vrdAeuzz7BaoFMnjY=;
        b=wVmcu5imVzF8BBd4U6CciTZqDv3P7vVcmtR6H+nKU7LXcXVlGnq5d9qvvWJmN/+QnW
         ks3vWgIB1I6R/3Rayv9Y4FhxbrGxhMQe9QC2jrbZSuwIwGKPXe/HCcr8On/xQu3APvyJ
         d2PVcbPhh8BecYu/bNygQv2kmxhCElDNKyCCKc0Mucub3p73B0eVXkSgzzSqGpof0q8Y
         gIIMFtrQj00JxoMcEbnqXx4jxyvYi/LZNsBUYS6eNxNOU51MryeGEF80bBVZoH1khy2l
         MQUhjJHu8GRb5T7Pamt+JrGODq5DhowwKcU6Eo4Lf0cct1CpFW8U98a2z1pj22XP4sn+
         pVxg==
X-Gm-Message-State: AOJu0YzRERyI2oXP2MyZuCkqRIrk+JEPI3daMIhB3eCbzsFA6+ZvRjga
        xC65p+boGRBS7tssqWDvEn8=
X-Google-Smtp-Source: AGHT+IF4VK2RMM99vHoNOTjMS8JYwZng9oa3EJPG40jI+yusE7jKXL9SAsLKU4Q7PP0rLS8URV59NA==
X-Received: by 2002:a05:600c:a04:b0:40b:47f0:66b5 with SMTP id z4-20020a05600c0a0400b0040b47f066b5mr8748485wmp.26.1701350780275;
        Thu, 30 Nov 2023 05:26:20 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b004063cd8105csm5706905wmo.22.2023.11.30.05.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 05:26:19 -0800 (PST)
Message-ID: <1e10c821-1981-4c9c-8243-dc4592bf9102@gmail.com>
Date:   Thu, 30 Nov 2023 14:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-buf: Correct the documentation of
 name and exp_name symbols
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        amd-gfx@lists.freedesktop.org, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
References: <20231122160556.24948-1-Ramesh.Errabolu@amd.com>
 <c5ae3f32-0779-4583-8fe6-92f5dea5ede6@amd.com>
 <CADnq5_OJbURbVzXVypohp7gCjE+ckHkEnDD67H7KTDJZt_e3HA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OJbURbVzXVypohp7gCjE+ckHkEnDD67H7KTDJZt_e3HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.11.23 um 22:18 schrieb Alex Deucher:
> On Wed, Nov 22, 2023 at 1:58 PM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 22.11.23 um 17:05 schrieb Ramesh Errabolu:
>>> Fix the documentation of struct dma_buf members name and exp_name
>>> as to how these members are to be used and accessed.
>>>
>>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> Please apply this to drm-misc.

Done, thanks for the reminder.

Christian.

>
> Alex
>
>>> ---
>>>    include/linux/dma-buf.h | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index 3f31baa3293f..8ff4add71f88 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -343,16 +343,19 @@ struct dma_buf {
>>>        /**
>>>         * @exp_name:
>>>         *
>>> -      * Name of the exporter; useful for debugging. See the
>>> -      * DMA_BUF_SET_NAME IOCTL.
>>> +      * Name of the exporter; useful for debugging. Must not be NULL
>>>         */
>>>        const char *exp_name;
>>>
>>>        /**
>>>         * @name:
>>>         *
>>> -      * Userspace-provided name; useful for accounting and debugging,
>>> -      * protected by dma_resv_lock() on @resv and @name_lock for read access.
>>> +      * Userspace-provided name. Default value is NULL. If not NULL,
>>> +      * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
>>> +      * char. Useful for accounting and debugging. Read/Write accesses
>>> +      * are protected by @name_lock
>>> +      *
>>> +      * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
>>>         */
>>>        const char *name;
>>>
>> _______________________________________________
>> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
>> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

