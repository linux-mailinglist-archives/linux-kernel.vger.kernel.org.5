Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A0771841
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjHGCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHGCVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:21:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581771703
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:21:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so24989885ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691374874; x=1691979674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpfBoE9Y590w/Sf+Dz/Le636FBNjqDAu8TPrvM1o1jQ=;
        b=IsiyqTVDpnFsGxkGGtd9mPI4j9dDCr8HtUmQl/O5Y+/h3Q387L9jARgAMHQx8keKIQ
         jNnF3fs2cPSI2voNKdrnUdH+q0ZUJ73HCLveN3x5CvahdowTzMzrAseNDIc4n1vJLi1X
         cMo8+jLmUZQqHd5GfMA9R4W33GOKcND52FQMgrrkMW03KpymaUotXs5kvVsOqicjzXi9
         4QNB3thQdacEU6Sg4aOnsRjx4Ahf+b+efIVvjM5qPqQw1RLprLmtIZtTrk0pLzN54WUn
         WSTFULU5KwhfEUceEncA7l7Yif6T0sWzsbaswU5VvUO6updvur/kedBQZiCE0cSYf29S
         MJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691374874; x=1691979674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpfBoE9Y590w/Sf+Dz/Le636FBNjqDAu8TPrvM1o1jQ=;
        b=IzlolBYH+1WqXm2SoxMUuPHPOmkVlMebg2MfckDYRccwj1dJ9oXofZ10kKumeP969Y
         1UiSMKEBUEI7xfCpDjqFRfGzdZU78s15dGEu2U+2B0CAPWKicGqqwyu7baFJKXS/YuVa
         USxI62SsyQFmHI8ZaF13LRSobMI3nkkcN4XxbKBCNAaQdMzsaVxLEc9XT7dTrfooC90r
         HU5GE8WTAaCOVvAKwR8nhqvURsenql6EE3d5exrRjVehyDF11Mbb8zuI4/9GuKyYUu+2
         of8MQGpn4AKIqcuK+PDSYWytCCD+WovXhOsIUmH5y7tbg5WlzeSLV7eeW1QWL4JG0H/l
         Xcbw==
X-Gm-Message-State: AOJu0Yyf2TLNByTfxVAHvIto2BT7po2mwjX4/zALoW4abGz7eTOls1sO
        hAxDD8vwFB7zzBCoP75XGkQP/A==
X-Google-Smtp-Source: AGHT+IGXf1jXu+iFSbvQC0e3gpDtxmxqpYliUoFhZtb1FgsrjGnia6rlH1z2J9bd4to0NexKFX7gHg==
X-Received: by 2002:a17:902:a505:b0:1b9:ebf4:5d2 with SMTP id s5-20020a170902a50500b001b9ebf405d2mr6181704plq.33.1691374873796;
        Sun, 06 Aug 2023 19:21:13 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b8:85a:5d8b:9c7a:fbf2? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001bb04755212sm5482892pls.228.2023.08.06.19.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 19:21:13 -0700 (PDT)
Message-ID: <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
Date:   Mon, 7 Aug 2023 10:21:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/4 21:34, Michal Hocko 写道:
> On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> [...]
>>> +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
>>> +		case -EOPNOTSUPP: break; /* No BPF policy */
>>> +		case -EBUSY: goto abort; /* abort search process */
>>> +		case 0: goto next; /* ignore process */
>>> +		default: goto select; /* note the task */
>>> +	}
>>
>> Why we need to change the *points* value if we do not care about oom_badness
>> ? Is it used to record some state? If so, we could record it through bpf
>> map.
> 
> Strictly speaking we do not need to. That would require BPF to keep the
> state internally. Many will do I suppose but we have to keep track of
> the victim so that the oom killer knows what to kill so I thought that
> it doesn't hurt to keep track of an abstract concept of points as well.
> If you think this is not needed then oc->points could be always 0 for
> bpf selected victims. The value is not used anyway in the proposed
> scheme.
> 
> Btw. we will need another hook or metadata for the reporting side of
> things. Generally dump_header() to know what has been the selection
> policy.
> 
OK. Maybe a integer like policy_type is enough to distinguish different 
policies and the default method is zero. Or we can let BPF return a 
string like policy_name.

Which one should I start implementing in next version? Do you have a 
better idea?

Thanks.
