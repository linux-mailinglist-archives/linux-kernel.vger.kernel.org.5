Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6337F175F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjKTPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjKTPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:33:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D73B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3570594b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700494410; x=1701099210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/vkPNph5u5OOrRSn6FR5rf84/Y5x7U2iw601QDwn1w=;
        b=aZdT4nG3nvtH4hK5HbpH/8dFyeH4vzz7mKT3IuUwrCXWFtDxiZq25X/8UNdVxq2ZM1
         aDTsbkN4J3U00zRJwKv4akimkV6+37zdwvANSSGDyNsjUupOdT9FZyJqqk9C/DNAuC/W
         7UODD+2NpIS3ifS1e0Qh+tlPENT28R0QXknGwMAx3BbC60M1fBoGKLt5WAOgTK3jPRDx
         d2Qcpz2zg8EVd/tQR0CO93BtJrqO1laIzOEuxlIs775FzSQ0afBB9hWAEbTyR1p8x8K0
         nhIaqyybEMNJ+YnF5/kqtJlXxTArpSR7Xaeq4WRyS+jOR05e7+/TL+AlvKIzs8l8vTsC
         +qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494410; x=1701099210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/vkPNph5u5OOrRSn6FR5rf84/Y5x7U2iw601QDwn1w=;
        b=XN97bJxvTEUGl4GsPbFQw6PwHrG3ja4b7aDJp4S3eL6+Ov9HqV+AIcPbReJsz2DYHZ
         Vvs9XbjIsQWxQ2tssuc3sPB12l9A3GkHlNU1+3kbeZGcYDhBgHDIqQ/0bUpX2KpSMRJ0
         ocKiPwnCVmkwbGmT03SSn7IcpOkajlzkCRxFpX2XZLHt+EX0+Y69pVA9QKUEEY9e9LVW
         zkHrWU+BpCRINXjPYNcKs3n7CByx0LY5pSWhuAziGFjV5YG/+oMCd4ogBjDrttfRpd+o
         oYb5pLfQ5oiApjoAAOk0UJAJCBRycI/rOPPoTOUJWT2gEmTsijzkjHhem98Zjy0d9j4W
         8gkw==
X-Gm-Message-State: AOJu0YzppfsIMiCkloZhbbtVRLR7DW4oRKmxDYnFvGNG9HzEDtOcWgr3
        hjl+MY+xsh2HpSNuCfhgiTe38Q==
X-Google-Smtp-Source: AGHT+IEaOg3mR+ohRZuseHeSMp/v9lZVJmrM5ClJ/D9paZFo3jQd/TqgotiBGO5yQ4v6OMwgefFCIA==
X-Received: by 2002:a05:6a20:8e10:b0:187:f6b3:3ca5 with SMTP id y16-20020a056a208e1000b00187f6b33ca5mr6106464pzj.52.1700494407205;
        Mon, 20 Nov 2023 07:33:27 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b006cbb3512266sm1195791pfo.1.2023.11.20.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:33:26 -0800 (PST)
Message-ID: <5e9c5ecb-c3c7-4e5f-ae9e-ff688f4c2e2f@mojatatu.com>
Date:   Mon, 20 Nov 2023 12:33:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
To:     Simon Horman <horms@kernel.org>
Cc:     Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117093110.1842011-1-chentao@kylinos.cn>
 <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
 <20231120100417.GM186930@vergenet.net>
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231120100417.GM186930@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 07:04, Simon Horman wrote:
> On Fri, Nov 17, 2023 at 09:06:45AM -0300, Pedro Tammela wrote:
>> On 17/11/2023 06:31, Kunwu Chan wrote:
>>> net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
>>> net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
>>> net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
>>>
>>> Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>    net/sched/cls_api.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>>> index 1976bd163986..f73f39f61f66 100644
>>> --- a/net/sched/cls_api.c
>>> +++ b/net/sched/cls_api.c
>>> @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
>>>    		goto errout;
>>>    	}
>>>    	tp->classify = tp->ops->classify;
>>> -	tp->protocol = protocol;
>>> +	tp->protocol = cpu_to_be16(protocol);
>>>    	tp->prio = prio;
>>>    	tp->chain = chain;
>>>    	spin_lock_init(&tp->lock);
>> I don't believe there's something to fix here either
> 
> Hi Pedro and Kunwu,
> 
> I suspect that updating the byte order of protocol isn't correct
> here - else I'd assume we would have seen a user-visible bug on
> little-endian systems buy now.
> 
> But nonetheless I think there is a problem, which is that the appropriate
> types aren't being used, which means the tooling isn't helping us wrt any
> bugs that might subsequently be added or already lurking. So I think an
> appropriate question is, what is the endien and width of protocol, and how
> can we use an appropriate type throughout the call-path?

Agreed and I'm all in for improving any tooling integration.
I believe a better patch would be to have protocol as a be16 since it's 
creation everywhere. I looked quickly and it will be a "viral" change, 
meaning a couple of places will require a one line change.
