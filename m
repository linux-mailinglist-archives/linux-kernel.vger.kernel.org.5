Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C07EE874
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKPUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPUqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:46:22 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B698
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:46:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso170608366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700167577; x=1700772377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aSp9lzLdexzLy4YCwYMOeITU16swn1+BuYTl7JNpDU=;
        b=uhxglTcpjQINBu1pmoz+E5p81aLTTN5jY55YHkzzFnLbB5pKo4U3YxZ5i9Ba/d8LLq
         wTdONo92F109OHxXnOQ38J9CCG2HQv/hThs6HrWQSN1TxXT6vrAU2STX/qWrh16/YVTF
         LR4ERxlhoxL5J8PwvavRwtwBkOX65E0RNgxPCOu3cxEv1lUspNKZvBzyhsY5f1D37jrs
         FAukbxveInsvYQjAwyS8WMes8JYQpx+Jporh1nS+/4pX4kKA9Vz2ZxkdDNpBd0kH1j7T
         +bNz+0yhbyN2cCAQRC4reh4TW3cPH2jSJlHuWEDnIZlvxRJTzzSoG0aw7XujoJZSrJLF
         2o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700167577; x=1700772377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aSp9lzLdexzLy4YCwYMOeITU16swn1+BuYTl7JNpDU=;
        b=AA2xR6OjT4oOrMiforV31ghF7jlP5GFbkf+WqAt2ic3T7kC4jDW4vDkCPZLAQfNVbf
         J8M0Mk4jZzbVTyX4wQA41ukpBGnrNgMwQL0/OvPKpRQAWrShdN0u9QeM7O85ifkQUsrl
         DyKa0wTZbXIgKVWNv/kkce+Md/xqanUFlKHcmWHwtQPW+2u1T7s104jM0PIk2bXisk2x
         D9VA7FJTWtQzGi9zVu6IC6SigfthlUqkEZC70RDaOtvohG4hAMbLQhSAK082CgpYrxIb
         Ue1sp3QT1tNBemqFMCndVVmH34fHspILPI9CIWmmoWkRTvXIJdRcBNGCst1H6RPhYGYi
         YdOw==
X-Gm-Message-State: AOJu0YwBKL6SQqygOI1HP0xCbDECS+lcIr1b5244htInEC6lusYZnzXL
        2fzrIvYZh7uL+IQbQCrng+EKcXAdfYGtoFFbinrAIw==
X-Google-Smtp-Source: AGHT+IGDUciKmW57AZBbBvkRcBsP8S8YUWoooRjJ005PGY5aBzSh8gq27qCQsjfHqiKze4TuMVww56esuF+d+Nlvc5A=
X-Received: by 2002:a17:906:361a:b0:9dd:bd42:4ec2 with SMTP id
 q26-20020a170906361a00b009ddbd424ec2mr11685133ejb.10.1700167576851; Thu, 16
 Nov 2023 12:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com> <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
In-Reply-To: <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 16 Nov 2023 12:45:38 -0800
Message-ID: <CAJD7tkahj=QkNj1PBfzGRcDyrpE-n5Dbav7VVOVsAFR4vtx9LA@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Chris Li <chriscli@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
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

On Thu, Nov 16, 2023 at 12:30=E2=80=AFPM Chris Li <chriscli@google.com> wro=
te:
>
> On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > Not bypassing the swap slot cache, just make the callbacks to
> > invalidate the zswap entry, do memg uncharging, etc when the slot is
> > no longer used and is entering the swap slot cache (i.e. when
> > free_swap_slot() is called), instead of when draining the swap slot
> > cache (i.e. when swap_range_free() is called). For all parts of MM
> > outside of swap, the swap entry is freed when free_swap_slot() is
> > called. We don't free it immediately because of caching, but this
> > should be transparent to other parts of MM (e.g. zswap, memcg, etc).
>
> That will cancel the batching effect on the swap slot free, making the
> common case for  swapping  faults take longer to complete, righ?
> If I recall correctly, the uncharge is the expensive part of the swap
> slot free operation.
> I just want to figure out what we are trading off against. This is not
> one side wins all situations.

Interesting. Maybe we can just move the zswap_invalidate() call to
save memory early, and leave the memcg uncharge call to be batched?
IIUC we already do some version of this internally at Google.

>
>
> Chris
