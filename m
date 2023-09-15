Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236FD7A146A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjIODbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjIODbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:31:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4212120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c336f5b1ffso15058045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694748685; x=1695353485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpWRm2xOvIj7k2faB4bOIBQWQx7RWcYPohu2ZtEfRdI=;
        b=lfpB69hQ+HT7cPnK56ljrqcQBQqiPG7lfKlClk/ftatbtDW/YWsKWpw8A7lJEgoLqj
         HMvm/FQz7Gnh0/Gtrb0Tax1Zuk6d/boGznKWSmBBQEjNi/ahlXxK1fwok7ENOF/q08I0
         KrAVUHKgnvTOO1+FvWKr3O04hURZK92ddlZZSawhZoPMc/w+5zokVC46/hRW812UY918
         BX2SSxMdVC+jPVPMjKbKU8wjHqnSYvl48JvB5GcSziEEbkrkzsoaBPqhoQMNKGiy+E3Z
         jTWwQpNEnQc6aF2kd7Z0i9fg+yW3nWI+LQ2+Yx/mtZ4D9ILms8UX+/CH2JEF5JwR6EzK
         73xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748685; x=1695353485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hpWRm2xOvIj7k2faB4bOIBQWQx7RWcYPohu2ZtEfRdI=;
        b=PfaF9ZaQn3kdllqUtwP0Da4nMSLmhz5vnkAd/1sTQGiuPCs1X0dQfkIYH9KiHP5lnb
         /ZS8cv1bYoAdKl8vLundVoh8Al8JC86kBMlAXH95hXdbLYEllZh5+H8xgVUCK9e7mlVg
         6VBVDQS92kPciJTqERdFA3ZZbL9wcGh3rVebRWSva84LNMsm+gkPO1kt4o8jyXtHxASB
         fHLg6zfDm1vzODCIXmNZqIXBNbrMgWZpsTpn3Qj7nrV5kutw7dCNSvVS+UcoeL0FzZNP
         D9m7xGVsz2yIfECEhct0WqDToYY5UTbVHlDlV9mocbx64GE2SldjEPsGUb9PCbS6geSx
         fpvw==
X-Gm-Message-State: AOJu0YzG9dh2OFhBxFRiDSi8ZU4S+0YnEpxJ7gM8M+mBHGHg6jUzTPW9
        RB60KDiYzFAp/M3ice1r/+W5rwDI0G0Gzws/qjo=
X-Google-Smtp-Source: AGHT+IHkWRJQiv5Qf/cfuGEDWVM5jxQ4hNQK+qCRnUK1ZewV+/2s0bDDBdtvBsWAfFab3l8fsODlRw==
X-Received: by 2002:a17:903:258a:b0:1c4:3956:585e with SMTP id jb10-20020a170903258a00b001c43956585emr70750plb.51.1694748685025;
        Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm2303584plg.60.2023.09.14.20.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 20:31:24 -0700 (PDT)
Message-ID: <513b8479-4c2d-b6c1-2081-15ea0cd0ebeb@bytedance.com>
Date:   Fri, 15 Sep 2023 11:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
To:     Bixuan Cui <cuibixuan@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net> <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
 <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
 <9f6b8aaa-50b1-435b-a525-9a7986f63845@vivo.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <9f6b8aaa-50b1-435b-a525-9a7986f63845@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/15 10:28, Bixuan Cui 写道:
> 
> 
> 在 2023/9/14 20:50, Chuyi Zhou 写道:
>>>
>>> Delete set_oom_policy_name, it makes no sense for users to set policy 
>>> names. 🙂
>>>
>>
>> There can be multiple OOM policy in the system at the same time.
>>
>> If we need to apply different OOM policies to different memcgs based 
>> on different scenarios, we can use this hook(set_oom_policy_name) to 
>> set name to identify which policy in invoked at that time.
>>
>> Just some thoughts.
> Well, I thought the system would only load one OOM policy(set one policy 
> name), which would set the prio of all memcgs.
> 
> What you mean is that multiple bpf.c may be loaded at the system, and 
> each bpf.c sets the different policy for different memcgs?

No. Not multiple bpf_oompolicy.c but multiple OOM Policy in one BPF Program.
