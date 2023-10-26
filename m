Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79567D8617
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbjJZPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJZPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:38:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD81A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:37:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so237997b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698334679; x=1698939479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/ia5iYg44wnoHJ0oC/4cmxCohdGQUTHKCQk0kzxu1E=;
        b=VQIIFYzev/4OHuT+U/kvGBbK3bMyqfeTMbd+NXVoi+7/3LQveG/lIXJrRSDqKbqG41
         XrT1JkO+4mXEQUHlZuGcGyDH2UEgJLFFj+kVv/88Hi4Q/+XL66r8PlR3biygLeIsQHcv
         PqF+EzSQ36QulfGfc2/d7IVu5Vu9N52eMaBCxba7WXMLci6XYyDx4UCyb7GK6DMWX73N
         MFXo2H99CbgzBxErHCl96GIVu5gYrGlHdntmCjpHMYHKjfSxNDi4i/DHsCd+kkU1xZvm
         UMQPWsLNQ70tHy7ngsjD8GZWRSCga/RcEknfhUKNcxS4RzzuPXFNV5fE3fZneDLjCL8G
         i+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334679; x=1698939479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/ia5iYg44wnoHJ0oC/4cmxCohdGQUTHKCQk0kzxu1E=;
        b=PYR0NwKK3/ntYbmCOFljnS3Rk5F3SXg3FdxYq1xjl+ulkuPDBaUEwOLJjX0dwFOApF
         Vor78r/I0sU82kd8Ng3BH6QOCmMCv7hvb8dG//Z8/SCtcy6zm0gEXj9ZFUHZWqY8Zf2h
         o+gwJBdlAqsn839mZCjcLu4MvOGMu6o0jeFvhDBFYGDLIMcj7HX+pfigCSTWKD+61pF7
         fw2qk0JGx62gNOVq1UFtgcHmxm4pucDFpbM+4269SptGLnGmjfZvMD+q5eSGFHh7YxWa
         ClD1tGrjBBznNGgjA0uqnxot/zyLTy1BYzIqNDlc5fL3lznQgNhswV0dF/g+9KEsu9/K
         y2wQ==
X-Gm-Message-State: AOJu0YwYxi8bFaLOp+fp6Jdc3fw1HmTHmy4qGS7QtURo/V/xLJqkWGCR
        QjXRdnAH9ahOLIsfl/ugAAz+kJJX1qpFULyP
X-Google-Smtp-Source: AGHT+IEaRvLkf3/LMGsV72caU8fFwJj6ExnROiLmtyAk1A4YB3+0Or2lY9aHpqEzfCqnW39PlEMlBA==
X-Received: by 2002:a62:b518:0:b0:690:c79c:1912 with SMTP id y24-20020a62b518000000b00690c79c1912mr18392426pfe.0.1698334678676;
        Thu, 26 Oct 2023 08:37:58 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm11399447pfp.47.2023.10.26.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 08:37:58 -0700 (PDT)
Message-ID: <dc028fd0-b188-435e-9dc3-f5de53dd9686@gmail.com>
Date:   Thu, 26 Oct 2023 21:07:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
 <20231026091222-mutt-send-email-mst@kernel.org>
 <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
 <20231026110925-mutt-send-email-mst@kernel.org>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231026110925-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 20:47, Michael S. Tsirkin wrote:
> On Thu, Oct 26, 2023 at 04:06:24PM +0200, Mateusz Guzik wrote:
>> On 10/26/23, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
>>>> This patch fixes the warning about directly dereferencing a pointer
>>>> tagged with __rcu annotation.
>>>>
>>>> Dereferencing the pointers tagged with __rcu directly should
>>>> always be avoided according to the docs. There is a rcu helper
>>>> functions rcu_dereference(...) to use when dereferencing a __rcu
>>>> pointer. This functions returns the non __rcu tagged pointer which
>>>> can be dereferenced just like a normal pointers.
>>>>
>>>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>>>
>>> Well yes but these need to be called under rcu_read_lock.
>>> Who does it here?
>>> If no one then maybe you found an actual bug and we need to
>>> fix it not paper over it.
>>>
>>
>> There is no bug here.
>>
>> p is the newly created thread, ->real_cred was initialized just prior
>> to this code and there is nobody to whack the creds from under it.
>>
>> Second bit in the patch changes one real_parent deref, but leaves 2
>> others just above it. Once more no bug since the entire thing happens
>> under tasklist_lock, but the patch should either sort all these cases
>> or none.
Sparse reported 3 similar dereferencing warning this patch contains 2 
fixes for 2, but yeah I should fixed all 3 of them.
>>
>> I think it would help if the submitter had shown warnings they see.
The warning message :- warning: dereference of noderef expression
> 
> Yes, and this must be tested under lockdep, which I think would
> spit out warnings for this patch.
Not sure, but I tested this with sparse (make C=2) and after the above 
changes I dont get the warning.
> 
> What should be used here I'm not sure. IIUC rcu_dereference_protected(p, 1)
> is discouraged now?
> 
Not sure but I read that, rcu_dereference should be prefered when 
reading and rcu_dereference_protected should when writing.

