Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898397880E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjHYHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbjHYHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:31:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3751FF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:31:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so551490b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692948714; x=1693553514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiQOGxXFGUPadpc3ed3CgeK4NAC12/4bCMS3K6h81pM=;
        b=iRCFZNbEWZfFKcMeBQ6pfGwdVRWuL5CPlnpRtNiUzL5g7WqPPM0qTpuBnKjlXyWaxF
         T3CYV3tm2UevZ2+WJ6DFQ7aNZKte0Kb6jU/Iz8wfY3dEAIEinBKartPB3Sk+T1odMZwQ
         xJkXuLZtwiZNBglfNDaxVqYnpSLDB3eK49Q8tQH5xvDv6ILDFNd8VriOXn2sQeOz+PzL
         YEAUWtMwK6sJC/7dwM+kbpHFao786m8skXnJHY5dDUui1FtDyLntUWuTq0MmFGRpvcMY
         +b7iLlCd/MFZFbGKmxmuP/MAEJx5NRW6dHKUw8x/hVcnJx2d7g+Jp2xNxbnqDJlYNRjz
         WhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948714; x=1693553514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiQOGxXFGUPadpc3ed3CgeK4NAC12/4bCMS3K6h81pM=;
        b=aP+ZXt27Stc6X2K80lV1xxexxLLFWy01EaqhMBYrCaEPk6pAaNrPOSvCCbvaxyYReo
         ZWo5DIRemb/8+zCeinezduiDZmP6MI65stfbFzMoOhuc35lbOMs02lB/6ja5Z+TI9Gvp
         eIuOEpSQ01fy4smawBWvZp3mYi1i0KYIfEbdiK8GPWPwkPMn1OSywhT/ZPdnhQbcGi8D
         gK3TXPiCS/NZK96dCktnVgU+jIBboVVwKBLjdJbLwZjDiQlbhz3jcA+DOn6NCmbCMpOD
         qFd5qRlTh+HN+JIQh1NZ5dYZt9yJvEuV9Ak9+Ll7VpHIRlh6cmQgcgiSgiVXJyHhmrki
         N7wQ==
X-Gm-Message-State: AOJu0YwhZ5a0bnzYADRsf5WcMnDffFKtWip7YN1oCrtE1DdqeHIlGFwo
        G+29/vup3O7gHhepxCR1E80Pk4RQK8KswQ==
X-Google-Smtp-Source: AGHT+IEN6mqPdb2qyiiiW9/fUq6WKL1AVoYLzs0KPpHJ76AJPkjxfT/NlaSwPZULQHWlBaVwuxq4cQ==
X-Received: by 2002:a05:6a20:7d8b:b0:14c:7020:d614 with SMTP id v11-20020a056a207d8b00b0014c7020d614mr1407892pzj.49.1692948713765;
        Fri, 25 Aug 2023 00:31:53 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001b5656b0bf9sm931901plg.286.2023.08.25.00.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:31:53 -0700 (PDT)
Message-ID: <ca7199a4-5628-425f-8f0b-8e8123b431b8@gmail.com>
Date:   Fri, 25 Aug 2023 15:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: Use folio_migratetype() instead of
 get_pageblock_migratetype()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vern Hao <vernhao@tencent.com>
References: <20230825040848.1542-1-user@VERNHAO-MC1>
 <aa5d199b-ea12-90f3-91fb-468d74a6f934@redhat.com>
From:   Vern Hao <haoxing990@gmail.com>
In-Reply-To: <aa5d199b-ea12-90f3-91fb-468d74a6f934@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/25 15:12, David Hildenbrand 写道:
> On 25.08.23 06:08, Vern Hao wrote:
>> From: Vern Hao <vernhao@tencent.com>
>>
>> In skip_cma(), we can use folio_migratetype() to replace 
>> get_pageblock_migratetype().
>>
>> Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
>
> Why did you think "Fixes" was a good idea?
>
The skip_cma() contains the folio argument, and the folio_migratetype()  
is already implemented in the kernel, so I think it's fine to keep it 
consistent.


Thanks!

