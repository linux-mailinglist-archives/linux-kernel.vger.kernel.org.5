Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE07CCF16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJQVUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:20:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E9C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:20:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso6431971276.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697577641; x=1698182441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbWekF0w9cC06aH6L/UcQkrsWi28yIOenpdtU4+ME8U=;
        b=AzS/OyawPp8HcUFl39XpIqC8sIWplDfyPDmA7xrxx0HtvTFedOrfkJ7qL53RSOCjb4
         TaJUG61XxGWF+ojhA99qO1hv0KaM9KGRvqa216IGc/e4cogO7y/S+x69QJaW12jSDor9
         5uUB0RtCQrXwHkiH1jD5y3e2aWGoBB34oTrVZ2mxc3xrD07aQgpamD8HtEFNmcTUCGgf
         tn9UDw/iRcSqkXQSJ4B52P+6r5dTKvKkHj5veR089uyPfHhaqCrI+fFrCCDPlLjcw7nQ
         RkSRpHrjuqq8be9ne39a9RjMqsn/gxT/PrOEAJvQZ4Xu0ioDtjixms3X+SGye8s1iGlx
         rqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577641; x=1698182441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbWekF0w9cC06aH6L/UcQkrsWi28yIOenpdtU4+ME8U=;
        b=WpvplJ3fgbon2KRp0au660/mq+h3pG0fLoBFssrLdBcUkRfyIukWL0owSLsoNI8DqY
         5lU8JULamgfK19Y5klS1KGE3mYpxSoNQyMJzKk9LgblP2okA7FcowzsyDbSfb3cSR1QF
         IWmHaTUcIT96tsjd6y/Th2EkHSwWusc19youscFlToAqz/Ki3Own0q6FCWC8677b92Pk
         M16YUDJQPqIsPTmGRFfhW7KfAPDPnp2UA7L21UP4Fauzz/H7vsMJFDcvuGV3rHwx12kI
         90r9TXD347HWIvSBo4uZV2Ozrdq1Rt4boF0XxzvTy99EET/19U+/si6KNZvVtxN4T8yG
         kEgQ==
X-Gm-Message-State: AOJu0YwNfU8WjgvC6t7ZS1tkmKWb62Ffwlye+KLbUpIZVfs2g/Imopgv
        eSpwvB7Q6tJr9dRt85DZ0h62T86FrIRiV74S0Hqp
X-Google-Smtp-Source: AGHT+IGsuaxhp+B8Zpujpu9HmIQottzDLr1BvXltabdWD9nEXRajYWzawRxXlkN3jQeL0pkRYCPaVNBuQFI/eSoR4oI=
X-Received: by 2002:a25:abe2:0:b0:d9c:66d1:958f with SMTP id
 v89-20020a25abe2000000b00d9c66d1958fmr1794163ybi.55.1697577640793; Tue, 17
 Oct 2023 14:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230922152749.244197-1-chris.riches@nutanix.com>
 <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com>
 <33830e43-00e6-4be1-855e-339d3e74a8bc@nutanix.com> <CAHC9VhSbfCKxJM=+mKGCQJNjtL8JuwZ5-mSCLCSvkkUEJywOkQ@mail.gmail.com>
 <e37ec532-2fea-424e-90f8-77d0997c5eea@nutanix.com>
In-Reply-To: <e37ec532-2fea-424e-90f8-77d0997c5eea@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 17:20:29 -0400
Message-ID: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:49=E2=80=AFAM Chris Riches <chris.riches@nutanix.=
com> wrote:
> On 16/10/2023 21:16, Paul Moore wrote:
>  >> While typing it out manually, I noticed that
>  >> the condition for sending the ACK isn't correct - if NLM_F_ACK is 0 t=
o
>  >> begin with, then ack will be false to begin with, and so no ACK will =
be
>  >> sent even if there is an error.
>  >
>  > Good point.  I'll just casually remind you that I did say "untested" ;=
)
>  >
>  > I believe the following should work as intended (untested,
> cut-n-paste, etc.):
>  > .....
>
> I think ack must be set to NLM_F_ACK initially - otherwise auditd_set
> will always send the fast-tracked ACK even if the caller did not
> request one.

Another good point.  I think I'm working on too many different things
and forgetting the details between our emails :)  Sorry about that.

> The following is a concrete version of what I roughly
> suggested in the last email - is there a specific problem you see with
> the (ack || err) condition?

I'm happier with the bool over the integer type for the @ack variable.
I'd suggest updating the patch and posting it again so we can review
it in full, but we weren't very far off last time so I think it should
be close, if not acceptable on the next revision.

>  > I'm not sure I can recall everything from when I was thinking about
>  > this previously (that was about a week ago), but my quick thoughts
>  > right now are that you would need a lot more information and/or
>  > handshakes between the kernel and the daemon.
>  >
>  > Unfortunately, both the current audit design and implementation is
>  > seriously flawed in a number of areas.  One of these areas is the fact
>  > that data and control messages are sent using the same data flow.
>
> Makes sense. The question of why there isn't a separate control socket
> was one of the first we asked while looking into this.

Yeah, there is a lot I would have done differently, but that's the way
it goes sometimes.  I have plans to find some of the larger problems,
I just need to find some time to work on it.

--=20
paul-moore.com
