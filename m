Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063DD7F0699
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKSNxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:53:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3885083
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:53:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc921a4632so31381085ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700402019; x=1701006819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKKLS+w0ex8qV597KBVIuYVHQ6+SkzFRNWt3xyBrGms=;
        b=KRTUx4f8nogt6torPwxGCHWD4/k6K47ib9GAolyuodt4lUXOsHJWjSXTXBKpkjNKdf
         BPbebv1k14/NYAfUapKQ9kdOEEWjFWpHRp40gWMJa44ajPyw9muLgVtFWz2uybGW2IeQ
         tUTTI5w/QIvUTwbKfQF+CXRxkR3cLnHh9/VBX5UPP8WLQHOkzpFwHWNKEt9VwY9bMrG4
         BTYg9fuca2d/4t/ehsUqPLG5euy1CwEd0wpvbT18cJ6NLjoSjcyjkdpucMnNl7kSAxA5
         +govsLqytz27/n3Mj1lc7ML6SwQH/uYd87dnADfy5AN9LicizF2rpyazxyZhnK8IdoBg
         zk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700402019; x=1701006819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKKLS+w0ex8qV597KBVIuYVHQ6+SkzFRNWt3xyBrGms=;
        b=ZiS5k+RpQcfZzb9vzVC1ZiZjyGZBLa2lePPZ9CX+81srJzaiHucyCDOEz16C9qXD6F
         okQZgr7RH6q1kPgQMa0cvA2i07WY94T/LOS6UGBS4+0jLgHOeYRY+jUJJqrEg91B6+WY
         whnEbCtwugc9EOCIahmKgiY09SxjPsJWt1/+HJqCTavzW5oCy7FPn/YXu7s+x6UDX0wh
         7HzGvL/aQUxPIP7EEmitk7A98u9VwVGY0pnyeV128zaVokvkWaKhY67WwWB+j2KY2jjf
         sWoqZs3h26A2UPL8WGLl5XblOEdVs0nFvayapYPtybzgxOCwrrjMzwAOwEJMDIGThv4u
         wuXQ==
X-Gm-Message-State: AOJu0YygfTO1cDbLbzeJa0U2yzXLsFZ/+FD6glChp3waSGQevHL57fOD
        WWrXHUPT+0AOdb/m+wSS/Zg=
X-Google-Smtp-Source: AGHT+IHriLxPDpGKhWAjBZMWDVWsozrin31cIWjg7jAzFtJ80MgWjLRxNJXU2ldtCC5/2LJ3VhQf8w==
X-Received: by 2002:a17:903:495:b0:1c9:ff46:163d with SMTP id jj21-20020a170903049500b001c9ff46163dmr5386849plb.38.1700402019602;
        Sun, 19 Nov 2023 05:53:39 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ee0400b001c55db80b14sm4372776plb.221.2023.11.19.05.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 05:53:39 -0800 (PST)
Message-ID: <af2d08ab-54c3-4066-9c28-18e96de8643a@gmail.com>
Date:   Sun, 19 Nov 2023 20:53:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Radeon regression in 6.6 kernel
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Airlie <airlied@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <ZVoMklvIVClr_IIH@archie.me>
 <9195ca1f-1d72-4616-8bdf-62f9f5c636b9@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9195ca1f-1d72-4616-8bdf-62f9f5c636b9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
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

On 11/19/23 20:48, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 19.11.23 14:24, Bagas Sanjaya wrote:
>> Hi Dave,
>>
>> AFAIK commit c07bf1636f0005 ("MAINTAINERS: Update the GPU Scheduler email")
>> doesn't seem to do with this regression as it doesn't change any amdgpu code
>> that may introduce the regression.
> 
> Bagas, sorry for being blunt here, I know you mean well. But I feel the
> need to say the following in the open, as this otherwise falls back on
> me and regression tracking.
> 
> Stating the above is not very helpful, as Dave for sure will know.
> Telling Phillip that he likely can skip that commit might have been
> something different. But I guess even for most users that are able to do
> a bisection it's obvious and maybe not worth pointing out.
> 

I was scratching my itch then when replying. Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

