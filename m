Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B837D669C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjJYJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjJYJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:20:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D654132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so4777729a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698225603; x=1698830403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9LKvzwQ+kJJuy6F8sbzPBJK3ry5j/OSwVPg23+fo4o=;
        b=IcaldLvkVDGaOtNo/OYfg/78rpVL13J0ZcBeqYR3u1G79aRK+Uz5lmZnkHlh8HTu5F
         VYHVsdfFgBgz4hId659tyYcoH3O+OcFY/ED3l6DVWi1WcrabgUeHxD5Az8CfPpTtL+zG
         ZM3DoH5Rqq5ZteqVIXDav6hKsXmukSywzs08TRulWaTbHcR2ooLewjkzU6lb3qUrTw7R
         7m9WfdvYZjuzSUBez4oSk1t9wnTKwp90SehOccwcYdI/Vjy9S23CJH7QXIT9JPz9Ccni
         hOOmjfna4RJjHZSKkYYCHwrHGm8kBzYeHpHJD+rJyDJsOOw5aFS7sdipn7Mde9ptP6UV
         d1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225603; x=1698830403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9LKvzwQ+kJJuy6F8sbzPBJK3ry5j/OSwVPg23+fo4o=;
        b=Z3imtsrMYPmEFNafEVScmgzJXkSrrLZPeQ1mSFqh9xHVpa3KbnICQIGIM8hYssqQvJ
         WAAIBpUCBkrT1xGRxgu9HL6QJ3YPox6N/yjw363kwEAA1YrRKXRd+Ojo9tfbTBA7wSkl
         tqyR6KDmBYyrD/V03FmJofNzna9xxOVNbSxP0BTn7pnHNa41tNTU+QbHBSO9Xy2I1W05
         hug6j4b8iii/N7FfvUCuibSPqUnVlIm28IO1K/4OMuJyGySCiBDP9FrfHK75X6aLV10D
         dwRIDOqDczMJYn8woFH8JxwaPqz28tJjliB6nflDAx+r0GLGbzGnd56Y+fB6nQYpDIpe
         p6og==
X-Gm-Message-State: AOJu0YzUyUJDcrD1xZJYgC07BSGTDE2mJOFEzWi4BXstPpiW1aGWNaUv
        UdV1zxGZw1pOEBU/MKW46cNWoQ==
X-Google-Smtp-Source: AGHT+IHfihGh9DaKro3ttnwboXUO0qkrr6LAJueCDPbd8CHiqmm6Eh/dzGrB6zYpq63P8X2rWNeq6A==
X-Received: by 2002:a17:90a:d24d:b0:274:c284:c83c with SMTP id o13-20020a17090ad24d00b00274c284c83cmr13222743pjw.48.1698225603087;
        Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
Received: from [10.71.178.184] ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a498c00b00278ff752eacsm8133414pjh.50.2023.10.25.02.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:20:02 -0700 (PDT)
Message-ID: <bf7d4005-d32c-42d9-a748-a7c421130be6@bytedance.com>
Date:   Wed, 25 Oct 2023 17:19:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        mst@redhat.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
 <20231024083258.65750-4-zhangpeng.00@bytedance.com>
 <ZTfw1nw15wijNnCB@casper.infradead.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZTfw1nw15wijNnCB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/25 00:29, Matthew Wilcox 写道:
> On Tue, Oct 24, 2023 at 04:32:51PM +0800, Peng Zhang wrote:
>> +++ b/lib/maple_tree.c
>> @@ -4,6 +4,10 @@
>>    * Copyright (c) 2018-2022 Oracle Corporation
>>    * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>>    *	    Matthew Wilcox <willy@infradead.org>
>> + *
>> + * Implementation of algorithm for duplicating Maple Tree
> 
> I thought you agreed that line made no sense, and you were just going to
> drop it?  just add your copyright, right under ours.
I'm sorry, I misunderstood your meaning last time. I will make
corrections in the next version. Are you saying that only the
following two lines are needed? This still needs to be confirmed
with Liam.
> 
>> + * Copyright (c) 2023 ByteDance
>> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
> 
