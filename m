Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F077D842F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJZOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:06:27 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBB1AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:06:25 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5842c251d7cso501602eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698329185; x=1698933985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMRxjMTQXFHxvjWDVcH9G5p0ViyU6pIVUwK8NakCdi0=;
        b=jBzMffS2SXoqPoGI5venuKKLdOrrptwmhxx8qHKTJgRLGW0Pvleb5lIhFFDkzN3+u0
         IMzYahCaDT8z6pxdkoBbOIGO4oFOVz9y7L6Evfw0JP05+nUsikzWIWHSEJTmH/3iOHwT
         j3YkVDnkCQTAVVHrgxECV8gO6tk3KFyHF5qIbPE+md7u+1dtTq4HPoY2roUz7RSuB30Z
         UW5i7ha5CbPmZjfNW3P/04dOu+MzFRagoLUyGH8js1Mjc7NFnGtXSw2YVodVdjC0d3/i
         vvINZuXFmTzZa9L83JvJA4Z06nusO+xcldCTAocsoxFTvzfzPFnVN67ViW2TshWSYyy1
         CdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698329185; x=1698933985;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMRxjMTQXFHxvjWDVcH9G5p0ViyU6pIVUwK8NakCdi0=;
        b=KVZuCEgd32rUasC6kkij7FfadHBT/NA98O2aEwxwDD+Tly05UqwmT1LhAfJG8vLZ6S
         yOce/p1m7de+O/E36nGGjeW1DtpeRKuJtG1uXbCdK0TS5V167EoVxljBMXO/YSnCQ2tR
         vsLdWtckm9ZtQ5lO0yYxjPAwSeVkCXQrzALVMy7uTRcQwDjqmehkj8G6rgH8V7mCDX99
         /3JlRgE9O4ZVdLIW0CY8fY3aHe1IFXpW1nznRd4IxOj3jnKQpFGaX4W7xsB3Gyb8NA08
         dauUR8OWlWK3wtPORrskyaKtbofGxjd6MxRdnc17W5NA83jUDmVDsBmo5UKX7N7TN91L
         2LtA==
X-Gm-Message-State: AOJu0YwsXpfH6qrGGijqHs0kTTeCYbFgTNcC4A2ErGoqUTuDOF9qeB6V
        GTcxARlQywdkoIud6fUXb07Ct5ADivN0CthBYS0=
X-Google-Smtp-Source: AGHT+IE1c/OWGyPB9wSaQzk/Qw4Xv1uL4Qn/G7AzjRVRiOt0TZxkG7xyXaqVYkBrH/T6W1zcQOocGLF5py8thdnmhrk=
X-Received: by 2002:a4a:bb0f:0:b0:581:d922:e7f3 with SMTP id
 f15-20020a4abb0f000000b00581d922e7f3mr18533862oop.9.1698329184995; Thu, 26
 Oct 2023 07:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6fcb:0:b0:4f0:1250:dd51 with HTTP; Thu, 26 Oct 2023
 07:06:24 -0700 (PDT)
In-Reply-To: <20231026091222-mutt-send-email-mst@kernel.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com> <20231026091222-mutt-send-email-mst@kernel.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 26 Oct 2023 16:06:24 +0200
Message-ID: <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
>> This patch fixes the warning about directly dereferencing a pointer
>> tagged with __rcu annotation.
>>
>> Dereferencing the pointers tagged with __rcu directly should
>> always be avoided according to the docs. There is a rcu helper
>> functions rcu_dereference(...) to use when dereferencing a __rcu
>> pointer. This functions returns the non __rcu tagged pointer which
>> can be dereferenced just like a normal pointers.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>
> Well yes but these need to be called under rcu_read_lock.
> Who does it here?
> If no one then maybe you found an actual bug and we need to
> fix it not paper over it.
>

There is no bug here.

p is the newly created thread, ->real_cred was initialized just prior
to this code and there is nobody to whack the creds from under it.

Second bit in the patch changes one real_parent deref, but leaves 2
others just above it. Once more no bug since the entire thing happens
under tasklist_lock, but the patch should either sort all these cases
or none.

I think it would help if the submitter had shown warnings they see.

-- 
Mateusz Guzik <mjguzik gmail.com>
