Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEF8004A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377729AbjLAHUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbjLAHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:20:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B411724
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:20:41 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d858670630so142477a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701415240; x=1702020040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDasWdCvdIpecxENqyCgimTWujwkKIN82JQqjC/O2NE=;
        b=ekUBJMT7tMfdFNKognBxzTWNdiHtAgQsZYqVX+byzgKqtmtDGOOb70/Dm2LHRb7bpD
         fdaaXiYDkFqln6peG5FzDP2bUdoAMMj1iBZ5zGCIw05tDG5vc1w6rCD20kvPs57IVxIW
         Go5XZXNZ7Iw8OAIdPMOsuu4ZuOktDW1uu+KmrJH9vqE3ZrHEg42LGPudAL8D7WtgmsUx
         CrQgBe8WGB0a8g+w4csZVD1pB/DZJ3v1d06EqHShtDv8D05YvsIeAIII/UvdyBXgu4it
         VPDLfOyP1llKZim58kBrnUlTam+n9IjMa4+oAYhu7DVB2g4QwlCR7nr48tEp2y1ZTMZs
         QrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701415240; x=1702020040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDasWdCvdIpecxENqyCgimTWujwkKIN82JQqjC/O2NE=;
        b=h9auO/CEG4RumyPbW6FsFebGmHfgryl11k0ovyfI+Q/DnqGCBua202DTPO4ka7F1aT
         XY2ERMayBaekaOKfsMDiwINbqMc7RFu08CCafWnKl7NKQhQMJLJ1hmSgRZeEuJMbtidr
         kncIHdTdGqVLsuo+2LnW+WOKzYWm9/IYRlUI+EKuk37GilKz1L5sWOfi1pJ46ByR9qWp
         d/RwCcMvHwipKx5wYNImrcoTY/h8hlzstKtYeZSmzTCFyzg8MPwB21p67f97kmFuA+ET
         t7KRtjySeExnHqZA/FHdtj6fS9/YPtFuW0J1YpqI8sOTbPPW5Iq5yu3J2o9uqpVxVMyZ
         FFBw==
X-Gm-Message-State: AOJu0Yxp3V2bHWpfa2oSTSm5M25BvgN9sbzGeFy3lPxGuqMw5wgQqChA
        3GYbC5HUCyAMVa2d/eyOLFca3A==
X-Google-Smtp-Source: AGHT+IHwC4rwraxxQ83aabjHM4fzVrFrKVH3+OcjTN4otsU93wqGVNfIyo+xtWEiMQa83w1fcfZWnw==
X-Received: by 2002:a9d:750b:0:b0:6c6:4843:2abe with SMTP id r11-20020a9d750b000000b006c648432abemr2219718otk.14.1701415240429;
        Thu, 30 Nov 2023 23:20:40 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id c22-20020a63da16000000b005b92d3cb4c2sm2472797pgh.58.2023.11.30.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:20:39 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:20:36 +0000
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
Subject: Re: [PATCH 17/21] binder: malloc new_buffer outside of locks
Message-ID: <ZWmJRPZRYEtlBQNi@google.com>
References: <20231102185934.773885-18-cmllamas@google.com>
 <20231107090838.260730-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090838.260730-1-aliceryhl@google.com>
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

On Tue, Nov 07, 2023 at 09:08:38AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > Preallocate new_buffer before acquiring the alloc->mutex and hand it
> > down to binder_alloc_new_buf_locked(). The new buffer will be used in
> > the vast majority of requests (measured at 98.2% in field data). The
> > buffer is discarded otherwise. This change is required in preparation
> > for transitioning alloc->mutex into a spinlock in subsequent commits.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> You also need to free the new buffer here:
> 
> 	if (unlikely(!best_fit)) {
> 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
> 				   "%d: binder_alloc_buf size %zd failed, no address space\n",
> 				   alloc->pid, size);
> 		debug_no_space_locked(alloc);
> 		return ERR_PTR(-ENOSPC);
> 	}

Ouch! this is true and there is a second instance that needs the kfree
as well. Thanks for catching it.

--
Carlos Llamas
