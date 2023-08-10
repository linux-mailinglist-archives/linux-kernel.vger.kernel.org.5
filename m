Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2B776EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHJEBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHJEBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:01:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DF10E9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:00:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso4880255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691640046; x=1692244846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vbhhkynVQi1160ixmvuJAcj7j/5EEdnNrO+9s/PfI4=;
        b=KGn3PF5b5bR0U2Co5S+eHS/cxml/DczpmGYImARcA5vxpz4B+WCXSdVEaMEqjBD+al
         RmM/KPdnqf5n0N5XoeEmpFpv3/s4wnSJMBQxEduav8QJNIa1bx9+La8wDnfuOob555BK
         MqEiovUmsee168obtO1jF7yA5eg5wUcKA+KrqCBbGE0njU4U2OPGzskcYaHdB9HhbyeE
         QxoASZNGngc3ZdW6LEEdiRTel0I+LYFykzB1cOjg/q7WDeCGkeltGIlvlwyLPWJUndDt
         D0EwQiIt6wv6nCvmUzTwfVrwZvvuulUu/shqc5dx4U2VdR8mIYMUIyezGJu3u7HESfLT
         t9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640046; x=1692244846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vbhhkynVQi1160ixmvuJAcj7j/5EEdnNrO+9s/PfI4=;
        b=Ce7Ugwm0t1gR1or+OpV/ggnkKljdOW7OncQ6K/Ahee/Bf5hCIgtU8vjqtFtIboKrZ+
         Vly0B5CPKY7KyS5JLhkSTv4UBfQ2l486gtdB2iyD+Ns/aRmYS7l6bHfX8BY1UpE8ozNw
         fZkz1mIx8VdChLiWctnuz36y/xEmwHckZrLXb7JYW5++fHn1JsailLm33yQGC7fEqLzh
         V6XaSNxMjWDrLZSwHOpyI+2pg5cWMH8OIoJaVQyeYtKel9o9FrD0LK8WEujYRWGDbiPQ
         KWAEi0wYJixpcWUzKpv/R+mOhZJ+c0S+OgfpVczbAnFTD7kbq89Sl9MF8Lmxpbneg47l
         oeNg==
X-Gm-Message-State: AOJu0YwZTozikO5ic/gJ+WyDEXmOFFxQlcvAvVee6Cx+StqPiUGf2c2X
        gEKdgWudJcvJOJ8pWnEC5H5T7A==
X-Google-Smtp-Source: AGHT+IF+PWJZJea35W0GVtHn3D7PZAzxyX5Y1hHu4pjpTazA2WFJC27UOm34cuZ0eJpIyygwUhSmRw==
X-Received: by 2002:a17:903:234d:b0:1bc:16bc:9f66 with SMTP id c13-20020a170903234d00b001bc16bc9f66mr1487715plh.12.1691640046231;
        Wed, 09 Aug 2023 21:00:46 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm395812plw.42.2023.08.09.21.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 21:00:45 -0700 (PDT)
Message-ID: <fdec0f4c-a65f-df16-b4ee-7cfd977c8d7f@bytedance.com>
Date:   Thu, 10 Aug 2023 12:00:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz> <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz> <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 3:53 PM, Michal Hocko wrote:
> On Tue 08-08-23 14:41:17, Roman Gushchin wrote:
>> It would be also nice to come up with some practical examples of bpf programs.
>> What are meaningful scenarios which can be covered with the proposed approach
>> and are not covered now with oom_score_adj.
> 
> Agreed here as well. This RFC serves purpose of brainstorming on all of
> this.
> 
> There is a fundamental question whether we need BPF for this task in the
> first place. Are there any huge advantages to export the callback and
> allow a kernel module to hook into it?

The ancient oom-killer largely depends on memory usage when choosing
victims, which might not fit the need of modern scenarios. It's common
nowadays that multiple workloads (tenants) with different 'priorities'
run together, and the decisions made by the oom-killer doesn't always
obey the service level agreements.

While the oom_score_adj only adjusts the usage-based decisions, so it
can hardly be translated into 'priority' semantic. How can we properly
configure it given that we don't know how much memory the workloads
will use? It's really hard for a static strategy to deal with dynamic
provision. IMHO the oom_score_adj is just another demon.

Reworking the oom-killer's internal algorithm or patching some random
metrics may satisfy the immediate needs, but for the next 10 years? I
doubt it. So I think we do need the flexibility to bypass the legacy
usage-based algorithm, through bpf or pre-select interfaces.

Regards,
	Abel
