Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C375800816
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378237AbjLAKUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378208AbjLAKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:20:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF12DC;
        Fri,  1 Dec 2023 02:20:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so17272955e9.2;
        Fri, 01 Dec 2023 02:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701426053; x=1702030853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcLd+/AJDrWXWUBdneBB4ElCvmlFWT+bhpoV46xZoYY=;
        b=IFDgkbi899dkUMdmFQXO0XXe+bgztgzxvLd+Ec0EQLQoj8zQrEZ+hqk9q7zn0UsS/8
         Vfy+MjD342rXKr7dL8rZ3m7RrUIEpdbUf/ubCC6v6yKn7TYWVb+WhRRRNbsa/9vdFtB2
         wgtbzVF2gmvkOzObSsN9mqw1vfHkVbIFsZdJgVQDVbNb0TPvaK03x80WaRvRAWPMuIEE
         wRC1UtAFzLurwpTE6CBQdQ2kd4yxtUdmm3MPAQImFeNtIHZv64/FDZ9rPbfSOd+4bdtQ
         48aG2+VxyvGrLvbkwD0PtgmD96x626nGS2wqRcwpiDQWIl11RGbrsVlKEo60VK/IURIZ
         d0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426053; x=1702030853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcLd+/AJDrWXWUBdneBB4ElCvmlFWT+bhpoV46xZoYY=;
        b=Wl5c4lNKSl9Ty35PKsMOpp/MMLza1hxzvHNK0WOTEuyKOd5KNibIdr4NKjy/ikfUxb
         khsBZvuU1CstM7Ghcym1d5XQEAlmXqsn4XizO+YSsFGDIjhBlPmofxGfywQ4dD6xe/wj
         5DGzFw2VU6UDfenXmogGPDslSYP4N0u2eBux5wanjEHvQquSN+FHI4Ya3YfnjWaogJYY
         by4xrOleQLJym42859Qyj4iZkagWjUcWOanUVYGKkBhqFxZ8qYLqSAd/BS4hsgQ82JdT
         qEL25bh3NHF1s8ulxz0/75V1Wwd6+dCs6fMlFTFFyAWDUeTi9kA/LCqAxtgjA5KRpGDp
         Fctg==
X-Gm-Message-State: AOJu0Yw9OpVCXbFFqD/3YBu63SkalNjPn72g5PwBKK1fWCW5yHUAzENg
        zTpax5GIO52CA0Jph5OxI4bMlnhJZ5s=
X-Google-Smtp-Source: AGHT+IFsl7DaYoDLb7OVsTU7G6HVRazLXptAuYAzBxtNzAwMVIX10CwGTw5WQUuWgfDsoT3hQ1dEVw==
X-Received: by 2002:a05:600c:3584:b0:40b:5e22:954 with SMTP id p4-20020a05600c358400b0040b5e220954mr427812wmq.67.1701426052971;
        Fri, 01 Dec 2023 02:20:52 -0800 (PST)
Received: from gmail.com (1F2EF126.nat.pool.telekom.hu. [31.46.241.38])
        by smtp.gmail.com with ESMTPSA id fk14-20020a05600c0cce00b0040b2a52ecaasm8715622wmb.2.2023.12.01.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:20:52 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 1 Dec 2023 11:20:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
Message-ID: <ZWmzgqcvMIvYvWw1@gmail.com>
References: <20231130204817.2031407-1-jannh@google.com>
 <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 11/30/23 15:48, Jann Horn wrote:
> > I have seen several cases of attempts to use mutex_unlock() to release an
> > object such that the object can then be freed by another task.
> > My understanding is that this is not safe because mutex_unlock(), in the
> > MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> > structure after having marked it as unlocked; so mutex_unlock() requires
> > its caller to ensure that the mutex stays alive until mutex_unlock()
> > returns.
> > 
> > If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> > have to keep the mutex alive, I think; but we could have a spurious
> > MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> > between the points where __mutex_unlock_slowpath() did the cmpxchg
> > reading the flags and where it acquired the wait_lock.
> 
> Could you clarify under what condition a concurrent task can decide to free
> the object holding the mutex? Is it !mutex_is_locked() or after a
> mutex_lock()/mutex_unlock sequence?
> 
> mutex_is_locked() will return true if the mutex has waiter even if it  is
> currently free.

I believe the correct condition is what the changelog already says:

  "until mutex_unlock() returns".

What happens within mutex_unlock() is kernel implementation specific and 
once a caller has called mutex_unlock(), the mutex must remain alive until 
it returns. No other call can substitute for this: neither 
mutex_is_locked(), nor some sort of mutex_lock()+mutex_unlock() sequence.

Thanks,

	Ingo
