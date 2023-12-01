Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E037800482
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377719AbjLAHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377715AbjLAHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:15:51 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7B172B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:15:56 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7ad501cb1f9so54406839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701414956; x=1702019756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HB8/JLE5Q+CEbaRXphWzwNtE755/m5oShsWpn9WkzhE=;
        b=NWhYcC+rySdW4BbgYF+hXJ+x2HbVgvEH4U/PPpimXUdnVrGxfxH2HIyFy7mOJHCJfd
         +iKfzrrzlUV6Zvb3hMTENG8trI1d+jPR5CAxE9Lj6jRsIbAk6gjhLqBpsH0A0yEIA+IR
         OsldK3VvDEKT33LqLy5cQoumlLiNxqPptf/XgPPFJwoz4c297h0UedWzHdBHP98H7L16
         zNUIt+0anLxS891nX/ylcC+UYEeE2hnlqBhT9jrJepaQjKka7m6ITGvv3F/7xhi/G41Y
         iHPt2KsfNcc6TduUkzjqz2EU5zQk6+cV3gkUyGKbbGxniybOvZljdSrErDNW4ERLvm0t
         cxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414956; x=1702019756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB8/JLE5Q+CEbaRXphWzwNtE755/m5oShsWpn9WkzhE=;
        b=cwKNisbHeXdahvosupmtrumemwHefz8jne5RZs6ZJrkvZgDWlw4CKsQsSELY+zzEj3
         j9jIcR3s+0UFha4QS9f7DMExBZgXZPgqdxE9mqtj8cZs+Spr5x09nhEIyPVjB9dSddEK
         MJgR+ZtLwSyezlmbPpt7I/sVyXvCAhfSsdUsNm+4guJ8vyrB9I1A9+mPTaxiTvUtErcT
         xgzPfFegPajnbBKtTt1ckss5gsYBGcXRKezAnW1Wz8DaT+mKwZ7Q/N5QDI1BWNdo+SfX
         V9X1hIoPLUQswy9QvggqoZCxBqcGg6gt7Vw0YhNRJgNhWjgdKV5B4ton6g8yJ33mWUR9
         H+Gg==
X-Gm-Message-State: AOJu0YxspDH0Y+iJqU2MULoQLGEf5RvrOoTi5PSZWlwX1pi57wwhbZf5
        TBc9hK/kUSQpmiVeYHqNTgpBYw==
X-Google-Smtp-Source: AGHT+IFTewBEQyQQDcb7KJjg7GuDtl2CVJ9HNBJiRFFLouQbJ73tVl4kWVnTrYS01WUQcmrbbaatcQ==
X-Received: by 2002:a05:6e02:156c:b0:35c:b8d7:937d with SMTP id k12-20020a056e02156c00b0035cb8d7937dmr21704723ilu.9.1701414955732;
        Thu, 30 Nov 2023 23:15:55 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j64-20020a638b43000000b0059d6f5196fasm2401871pge.78.2023.11.30.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:15:55 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:15:51 +0000
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
Subject: Re: [PATCH 14/21] binder: do not add pages to LRU in release path
Message-ID: <ZWmIJ4vmjBOICFDJ@google.com>
References: <20231102185934.773885-15-cmllamas@google.com>
 <20231107090829.259753-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090829.259753-1-aliceryhl@google.com>
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

On Tue, Nov 07, 2023 at 09:08:29AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > In binder_alloc_deferred_release() pages are added to the LRU list via
> > binder_free_buf_locked(). However, this is pointless because these pages
> > are kfree'd immediately afterwards. Add an option to skip the LRU list.
> 
> They aren't freed with kfree, buf with __free_page.
>  
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> The change itself looks correct, so I'll give my tag for this:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> But I'm wondering whether process cleanup really is so performance
> intensive to justify the added complexity of this?

So, this was needed on an earlier version of the patchset and I was
hoping that it would also help with an issue reported here:
https://lore.kernel.org/all/ZSHmtLqtNZRAtaZ0@google.com/

However, I do agree that it is unecessary at this stage so I've decided
to drop it from v2.

Thanks,
--
Carlos Llamas
