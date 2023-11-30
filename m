Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A237FFE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377159AbjK3WY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbjK3WYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:24:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B510DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:25:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so6797a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701383100; x=1701987900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXxq4jzNzbip8+DqWns+0xF+IlitTmmGXegG7H15TtI=;
        b=eRZP00qaewmW9j36TZvIob2RaWPDI2dB8RsmElBOkSTIHr7CHODs3XYTyUqiMHRAgE
         O/YKuXTTReqy2AZTxPleIO5l+rvEDD+ADt3ELgx2Vf8Hg18E15IWIftT1bjwS4hTCy7J
         X1yYFfre5kZd1BjNr/b2egWdkEDchiColDIp7h8PUeQuNFZWnZgkd6HHZr0LQRTGvnM9
         xvRccc6r/dcdKy6he4rIjsEKwx4vECW9+L/W4GxDKjnvH+shgMgP2OncSVmc6PFLIcAz
         eYSA9g7FIAKW7lbymY/B6zCbhln0x5XqCGgvJ3VjpcqxxcTA2q7t1swWsSCvaRVNn+YE
         eeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701383100; x=1701987900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXxq4jzNzbip8+DqWns+0xF+IlitTmmGXegG7H15TtI=;
        b=TqqFOC/pA0MIz1pqtSrZiLJde3DFcmysJ03RYSWNYmtOPb9AyR1GBBlZD1XWyGmRX1
         Fp/gBnCgZx4UBgRxapmsymsLvG3+JV2ZFpmHr4kS02bFkh0iuxhgweCyC7ffazyCXzkL
         CiPFLaF/krYVpnusb8TKTyGst+Dsk2K5c4ftSYa4lnQiCrt9jopIYnZByix3J7RRVvb4
         jkQy2UJ8Qifk2w5KLNICJlawtgmSU8/M9hW0SnasBHuhjeFLA8lX6hmA0j9bTKWMQZRy
         pr5js6tl19euAj+7PlkGndzFdhIwDKbYNdHOieOHho4gHf7RkYuTOmU4P2TRpUkEYlqz
         afyw==
X-Gm-Message-State: AOJu0YzUnQUtP6zdKuclPrKwo/PbvPSJZm3lJjD3w8KJHhVoQg7iScrw
        duBDtbkQ05iWAhZnBdYR7XAbnjFijcTe4+wQ+biKqo4oCbk10C32sb6YGD1H
X-Google-Smtp-Source: AGHT+IHujrMU3m4bd6l5mDQRSI3xZ/SfLh2ffoX//hMzCXxeZsEK81R/DiRsZguQh9l/uzivzrsp7FtBDsJTJ4KH9Hc=
X-Received: by 2002:a50:9353:0:b0:545:279:d075 with SMTP id
 n19-20020a509353000000b005450279d075mr37248eda.1.1701383100391; Thu, 30 Nov
 2023 14:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
In-Reply-To: <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Nov 2023 23:24:23 +0100
Message-ID: <CAG48ez1oXW=4MfQ0A6tthud-cvDZUTA+VB=jzu-HxvWzbj+X0g@mail.gmail.com>
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:53=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
> On 11/30/23 15:48, Jann Horn wrote:
> > I have seen several cases of attempts to use mutex_unlock() to release =
an
> > object such that the object can then be freed by another task.
> > My understanding is that this is not safe because mutex_unlock(), in th=
e
> > MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> > structure after having marked it as unlocked; so mutex_unlock() require=
s
> > its caller to ensure that the mutex stays alive until mutex_unlock()
> > returns.
> >
> > If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> > have to keep the mutex alive, I think; but we could have a spurious
> > MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> > between the points where __mutex_unlock_slowpath() did the cmpxchg
> > reading the flags and where it acquired the wait_lock.
>
> Could you clarify under what condition a concurrent task can decide to
> free the object holding the mutex? Is it !mutex_is_locked() or after a
> mutex_lock()/mutex_unlock sequence?

I mean a mutex_lock()+mutex_unlock() sequence.

> mutex_is_locked() will return true if the mutex has waiter even if it
> is currently free.

I don't understand your point, and maybe I also don't understand what
you mean by "free". Isn't mutex_is_locked() defined such that it only
looks at whether a mutex has an owner, and doesn't look at the waiter
list?
