Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9C7B105C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjI1B3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjI1B3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:29:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A941B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:28:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso10807543b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695864524; x=1696469324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQKk85Afi4z+yWQXqNio3WhLlSbvtWaq2r8uxo++06Q=;
        b=U4El6lVWUu2AeTz6mjX5N07iDhZeN9yKkwvLy8st/ocScdELsaGBzA6YU2dV4N3HH9
         MIcQckOu1odgx+ZJgHuQzsF+PD2tF0Ppy3Y7kR6iCCdRFmzwbf1hGZ/5Vw1sQIgZWQMO
         dg2fyLrIpJsM1sBIWL4HcTlavxafuVB8Y98Ar5iiuK8Yvt6n27WpDGC63XdltA0XnNOM
         McQNb2q5sMcEm9wD0XBtIY9VMoTlC0oMVGQsV0OgHHONF71h9r/5rH3a3WoEQZcVCx8G
         ym8GelJPmK6BBU4VEuQVd/HdBEsxqD8bcI9vS2L50LMU0zQefLGMJgnK9tH2Tl++uCOW
         QiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695864524; x=1696469324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQKk85Afi4z+yWQXqNio3WhLlSbvtWaq2r8uxo++06Q=;
        b=joH9/XzNDo8vkmhzwObSBEz9VXzi25HrvuVVZoQwqQ4mbJ61FCUP4u1XxXpAJV3ZuW
         /5mTLBssKwRvBFg3uxFSedhZ/lst/zPDS4Ic6IVA1Ym2AhExARspb6/bcEO8+IYWeg03
         gx1i9ScEf5HgYPLp78LZBtQOK/XZHJhFFEAiax8Tb0ujuf31qRi4UXaPmME8wweYG0zN
         5rwFO/VF9O96mlyb8WGUfu9Xx6xJRN/sAqNa94DVci9NbggT0zOoqlyfajwCYkRof/Mn
         ekow0+Ukl16wwm6qLnNvvE65jmkl1GD4Y95g0u1X6UomlccP64eAOuiahMp0wj6AZ64z
         gusw==
X-Gm-Message-State: AOJu0YxRIvcO3XnFEGjdXqwKexEqL9nrtrCSvX89Jt9mLuhbxJbZxuAb
        bzdEL7zWXRy85YYSTDL/Xg8QAQ==
X-Google-Smtp-Source: AGHT+IEb77pxF1A4zuog0Pubtnz/Y+v7YIq8Yjvf89gpA0u8AEh8k4dTpPQZEdA3uoZ+glEhfmQuZA==
X-Received: by 2002:a05:6a21:7988:b0:14c:7e3:149b with SMTP id bh8-20020a056a21798800b0014c07e3149bmr2971085pzc.62.1695864524647;
        Wed, 27 Sep 2023 18:28:44 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c61073b064sm7916471plz.69.2023.09.27.18.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 18:28:44 -0700 (PDT)
Message-ID: <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
Date:   Thu, 28 Sep 2023 09:24:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <20230926130521-mutt-send-email-mst@kernel.org>
 <9564c220c8344939880bb805c5b3cac9@huawei.com>
 <20230927152531.061600f0.pasic@linux.ibm.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230927152531.061600f0.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael & Lei,

I volunteer to fix this by workqueue.

I also notice that device drivers use workqueue to handle config-changed 
again and again, what about re-implement __virtio_config_changed() by 
kicking workqueue instead?

By the way, balloon dirvers uses 
spin_lock_irqsave/spin_unlock_irqrestore in config-changed callback, do 
it handle correctly?

On 9/27/23 21:25, Halil Pasic wrote:
> On Wed, 27 Sep 2023 09:24:09 +0000
> "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> 
>>> On a related note, config change callback is also handled incorrectly in this
>>> driver, it takes a mutex from interrupt context.
>>
>> Good catch. Will fix it.
> 
> Thanks Gonglei! Sorry I first misunderstood this as a problem within the
> virtio-ccw driver, but it is actually about virtio-crypto. Thanks for
> fixing this!
> 
> Regards,
> Halil

-- 
zhenwei pi
