Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F57EB2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjKNPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:05:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3503126
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:05:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc2f17ab26so42178025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699974323; x=1700579123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG9lz3Q7V8byQ3pbms3zFQZsFgW+qQ2vsca18euKUKo=;
        b=KC7r38fjLbxCsGe8xaM+fFxwMiOR7rXQFPO2eKOAHia9fRMYLw4/4ZxLW59pjD1IgD
         KMmmkMipfBoJqj/HQDqZO5mxtgPqLRA/+saQslTsaoBqeQ55yWIqhQRmAp09aFWgdKCQ
         AHHlTMMJyWZD0nbZr3z84GdM/e5lWb1mapcz931dMeteNa9VxAGb65/foAnykKyZO/+6
         q0IZSEol2qN2cPNvZC6DFpbB2RyTZjKQq+wKRqXslCl6cUPLnw7jkSKn9M4+63hjbX4B
         KfZmk9z2sEEu84NUUEbbtZNslrvM7/SNVvEtVaMil2dNKD6WiuT1S2GiSDYr7/nE0ECM
         aLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974323; x=1700579123;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG9lz3Q7V8byQ3pbms3zFQZsFgW+qQ2vsca18euKUKo=;
        b=DmmVBnMSdbR5jcjdgUzVqu7qRuwCZk9sIlPlmEh3Aq4xQ1bOoVZay2/POgMNt4/3UM
         MbrsGBNtSp18G1Y7wIiN1/1g+WrB4veavhIHctX7ywrYA6EeWUVrWdgIpgiwbEavmCXP
         mKUD73sJhdoTpgcqYMz5WrLD/7gCs+Xvf0AU52hi8EsdTNSBWh5rHQ2O/uKEXhUocWxl
         IlWh+wZ0SzKfM7uVEGg8OLifXRIZt0eS/6tXjYYAnmOaL2giSqUaV51/jZoPdM4FLlds
         JQ6QKgaRfT24fhRwFIbTXBSqRlJgxtysxz9AAfkfegA07YzJNXYwsk5xFl1Uvx9BP/mU
         Ex4A==
X-Gm-Message-State: AOJu0YzHa42o5lIwPHdd4TeRS7xHi9GatAGedmt9OxKI8sTVWbX3DLCU
        OMrUTjEWrmFx8srpvQXQxrYIAg==
X-Google-Smtp-Source: AGHT+IEnIN5gyz/hEms93r0CqoIg3S5ZdYQSCrRMRRSvX1FVrXZLdluDJR3bBHguvUPLHjv3/6pbjQ==
X-Received: by 2002:a17:902:a401:b0:1cc:5899:112c with SMTP id p1-20020a170902a40100b001cc5899112cmr2290346plq.23.1699974323110;
        Tue, 14 Nov 2023 07:05:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:e60:6e40:5de2:6afc:2f43:5fdc? ([2409:8a28:e60:6e40:5de2:6afc:2f43:5fdc])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b001bc2831e1a8sm5788558plk.80.2023.11.14.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:05:22 -0800 (PST)
Message-ID: <7fdb796f-9301-4898-b038-cc4f546192e2@bytedance.com>
Date:   Tue, 14 Nov 2023 23:05:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
 <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
 <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/14 07:57, Bart Van Assche wrote:
> On 11/13/23 07:05, Chengming Zhou wrote:
>> Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
>> is that request won't fail after blk_mq_start_request().
>>
>> But in null_blk case, the request will fail after blk_mq_start_request(),
>> return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
>> back to the block layer core, they will be queued individually once again.
>> So caused the warning.
> 
> I think it is safe to move the blk_mq_start_request() call under the if-block
> that decides whether or not to requeue a request in null_queue_rq()
> 

Right! And null_handle_throttled() in null_handle_cmd() may also return the
BLK_STS_DEV_RESOURCE, it's also needed to put in null_queue_rq() and before
the blk_mq_start_request().

Then request must return BLK_STS_OK after blk_mq_start_request().

Thanks!
