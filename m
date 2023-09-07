Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0A797B19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbjIGSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245732AbjIGSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:03:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491441FEE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:02:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so21510091fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694109763; x=1694714563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPr/PaYxGMdYMFVhUkN8avwnHv5koLDyq16882quvVs=;
        b=Rr2Zemtulye/lWWXa06FG3k1XRm+VmE+zVWUtEYXFjGAU0ZQXoPFanl7kHIsKDbMXk
         iadWQ2A9sZz9KtPeXbKvIDNj9Yg1xQQChiQYc85AqhIiU2qdd2bksWvwx/TM+by0KVEJ
         tmdFMbRDpkjeoJWQ3Yxr5wrP6BXL7lgz+Z2Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109763; x=1694714563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPr/PaYxGMdYMFVhUkN8avwnHv5koLDyq16882quvVs=;
        b=LakW6EXZfVSjZfTFy98miempDukjmP7fqtd8FJzB91PCl6flIWGm4FNlAa7WMejpwT
         UA/XuhH7qPReWCzJeXnyo8DLmCFjGzMSam0lVMqr5ZoG56zLtOidXUlSAB/qo1/jILDU
         oHDh0z/htze5H8YnV+BVqIkZEiYZJ7fbY2nRe8RDzEYHrpHHLFb4bauMY4HmrT9zyk8G
         ukZ+pyunaaC+YBEmshkdb0U5hkZnEfUMlmC2EeRR2+IpPnkU7FEG/3iLPiylJvrdAAHK
         aCC3Ywl/YBPS+UdKzJVqajZccAzXk3b/Ssiz9fdXvmBtZUegHQSNcdiBPOxOgS75jpGc
         ckRQ==
X-Gm-Message-State: AOJu0YzLjfMPbtWpfv+00qa8pVzWvDKCvkQOglP7M7L2+l5tCzrrEKGh
        l0qJAywKNUm4PejNDsBh5jjhctO5hedDbmQjhhsbs4vU
X-Google-Smtp-Source: AGHT+IFMMVl5IRwK/FD9Zyk9qb1+I94GFIvcXUKyiflGUWwS59Y4gey271dt0JSGpq9VaK+aVpXRXw==
X-Received: by 2002:a05:6512:312e:b0:4fb:9f24:bba9 with SMTP id p14-20020a056512312e00b004fb9f24bba9mr173782lfd.5.1694109762671;
        Thu, 07 Sep 2023 11:02:42 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709063bc700b0099bc80d5575sm10505770ejf.200.2023.09.07.11.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 11:02:41 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1640823a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:02:41 -0700 (PDT)
X-Received: by 2002:a05:6402:1644:b0:522:29d3:4185 with SMTP id
 s4-20020a056402164400b0052229d34185mr44289edx.32.1694109760777; Thu, 07 Sep
 2023 11:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230907112743.6134-E-hca@linux.ibm.com>
In-Reply-To: <20230907112743.6134-E-hca@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 11:02:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
Message-ID: <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.6 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 04:27, Heiko Carstens <hca@linux.ibm.com> wrote:
>
>   Note that the set_memory_xx() family comes with an int num_pages
>   parameter which overflows with 8TB. This could be addressed by
>   changing the num_pages parameter to unsigned long, however requires
>   to change all architectures, since the module code expects an int
>   parameter (see module_set_memory()).

Bah. We should just do this. Change the 'start' to a pointer, and
change the page count to 'unsigned long'.

Changing module_set_memory() to take the right kind of function
pointer looks trivial too.

I'm not even sure why we did that "unsigned long addr" thing, but I
assume it is because of our (very very _very_ old) historical
get_free_pages() model.

We should probably change get_free_pages() too, but that literally
goes back to linux-0.01. It's horrendously bad, but it's _very_
traditional, and it comes from the VM code historically using bitops
on the page pointers.

           Linus
