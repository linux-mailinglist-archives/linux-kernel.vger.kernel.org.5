Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571168004E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjLAHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjLAHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:42:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752C10F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:42:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d03fb57b69so2281475ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701416536; x=1702021336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMrAYYzrWfFqh4fNNuKb3F38D26qUC2MU8NejQTdI4k=;
        b=lXLSBvJ+AI7QU0Pee3+0r3XcKZQh/1mWqRH/c2hH4jZuWNvGit0yyinfMmUsDH5Sk9
         El5rpQ4cRryZ92fDo4/MjmPqWH/p6gLUof48icjgd5G16myaT74gmHmnnsWhYtDrblne
         UODBlNxu7FI8hvYarkCHT0xtSBQMCy5EaICfnpLrR1Jnt+dytW95Un7t7rSha0hk4GwL
         FU+KNIUvvQi6vkPvs2r+dIr5d2xnn93yNFmQLYyNLgEOg+ISRG/kR0lu+Lgo1nKRJEwN
         DlD1YOCVyje2R6fdtfzaiTqt1RanTksKcpM29Ab2PseFD5vC4SWuH9C/AebFwYJoquYz
         MchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416536; x=1702021336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMrAYYzrWfFqh4fNNuKb3F38D26qUC2MU8NejQTdI4k=;
        b=T+Al3m/QOFUIpPMiQW2QphR2k88yF7DLj1qrPgwYxtEatZeV93wd+gEjikwxWgP3oY
         EV1SIzEoEMTkg74iOAxluWQcGdwKZLKl+OwaE7u0VH/C7LX9/A8LeqnzQjZPtXklnh/e
         O41iRIjsUDq9oMgX+5HxB1remGG7QJq2ncySxUPpW8n1KnuCzfaqc1noAdQuz0CjzkUs
         LdDS/FEluDc0upKdXhP7pJJCL6Ny3N1nwq7fWSqHPFQcNStLYof7tNNRplIsUGxMkgPF
         9DKKB2AH4cAbAP8ULXfb6mehx4oO91olyUIftLI2gyZzpHtohkeG+Z3SmwevNS8EBpCu
         7UwQ==
X-Gm-Message-State: AOJu0YyMkNbLKkssdKDdhq8AuC1/I/mpiv14ZSqAbqOBbZoMqJe9Qsgd
        hEIQyLaDykHpISn094k0kmSPMgDhXUuTiet+38k1sg==
X-Google-Smtp-Source: AGHT+IEd2G64EJy8ULwySVlIZc/zkEvdEtqdIRxqgNETkJbF4uPb9QySy3x60KTlHg8rDy7R3p6BVg==
X-Received: by 2002:a17:902:d4d1:b0:1cf:aeca:8a28 with SMTP id o17-20020a170902d4d100b001cfaeca8a28mr23919713plg.60.1701416535629;
        Thu, 30 Nov 2023 23:42:15 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001c9c8d761a3sm2643049plg.131.2023.11.30.23.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:42:15 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:42:11 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 20/21] binder: reverse locking order in shrinker callback
Message-ID: <ZWmOU4qayU7hZVQt@google.com>
References: <20231102185934.773885-21-cmllamas@google.com>
 <20231107090846.261721-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090846.261721-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:46AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> This reverses the order so that __free_page is called before
> zap_page_range_single. Is that okay?

It is not OK. Userspace would still have access to the page between
__free_page() and zap_page() calls. This is bad, so thanks for catching
this.

> Another option would be to do something along these lines:
> 
>     page_to_free = page->page_ptr;
>     page->page_ptr = NULL;
> 
>     [snip]
> 
>     mmap_read_unlock(mm);
>     mmput_async(mm);
>     __free_page(page_to_free);
> 
> This way you wouldn't reverse the order. Also, you reduce the amount of
> time you spend holding the mmap read lock, since the page is freed
> without holding the lock.
> 

Thanks, I've added this approach to v2.

--
Carlos Llamas
