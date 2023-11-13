Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88167EA516
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKMUyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKMUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:54:02 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7A19E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:53:59 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45db499e2faso1921457137.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1699908838; x=1700513638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWAbCLt+MItQFwnvzaodehn7LGk/y+Zv1GtCg56diao=;
        b=K8PKCK4sL0etgIKt+KNND8FG0XTWDkz3RyFnEdU7ftCjYshRZqMUBgEWdHh+32ziCx
         QwL2nfE0SSylgwYn09eJt2Lkumh0FakPow52zEhutbX8NZavupZFetMQSiqAeMtBlbd4
         F6He3zBOqUgba0g5nOUFqZWVnh7jBFXhavd69PX3CXiirolYIHgA0HBFybCqUKP0NkVH
         nTDxyVMkroMi3w+BOiIOb+z2kqglvc2pNaKH1iIGGZDdI9FO85zfSJVCkqPW6KNGnleY
         nDPXmyvhvOD6j3u7We1GIK9maB7uCe5dYcVkPr+AJdblA4oCGYMnuJ+TlozkDm+7qQjF
         lsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908838; x=1700513638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWAbCLt+MItQFwnvzaodehn7LGk/y+Zv1GtCg56diao=;
        b=JyaSkuvqL98J4JxXCz/pHoEu4KVjmHBQgH1F6P67vG+gLk70FX0jj9OglqyW+SV598
         pg3ZPZFY8RrZkl7M2dJ4dpKF1XhYXTlr6BNppuPzSSeBb3lOmu7TpcR0hm4hS1joLuKf
         luKfhhmLHpf+B8cTNIUj8a2dEHW9orHRRQaApBYZYFakJ8N1/DADffuNvo4LOtmmJfw/
         LZVFl10jYqVZvV2iefk60B22rD1J9DHhIRBOMoNZo0b44lDXLDoerx0CeQjvW2ciMMyu
         C27ph1w3tnnZEQEA0AiTqhWwplxKX/ChVfe0ba2qhcdIhaL2sacmy7FPl8FDudI+WMfp
         o1SQ==
X-Gm-Message-State: AOJu0YxwjQ4zlPDHmq7nY26gtFM3L4Azpdxyyez9Axr3i8QKdox2ik2M
        J3q4jBsx0s2up1he9vTd0YSWhNujzv21A+GnQJNToA==
X-Google-Smtp-Source: AGHT+IHlFX+DtoGKFh3NF0s5Kq5Mvb8zV+cDeZ110Sl/zkIVkXQejFA2glraDoGU6SHuRPyFNMJA4kEP9FUWdZugESg=
X-Received: by 2002:a05:6102:4687:b0:44e:8626:71f2 with SMTP id
 dw7-20020a056102468700b0044e862671f2mr3457922vsb.13.1699908838563; Mon, 13
 Nov 2023 12:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx> <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx> <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
 <877cpd7a96.ffs@tglx> <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
 <87y1hb1ckk.ffs@tglx> <CAMRc=Meq6qrXsbDQiQHJ8t9tTh2V5Fb2ut6TcWYd5CKJwGBiAg@mail.gmail.com>
In-Reply-To: <CAMRc=Meq6qrXsbDQiQHJ8t9tTh2V5Fb2ut6TcWYd5CKJwGBiAg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Nov 2023 21:53:47 +0100
Message-ID: <CAMRc=MeWPcaiB12f_R5jR+b-THZgHYS2bx3KypX+o5Afz1ebyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>

[snip]

>
> My point is: the same rule should apply to in-kernel consumers. When
> they request a resource, they get a reference to it. The resource is
> managed by its provider. If the provider is going down, it frees the
> resource. The consumer tries to use it -> it gets an error. I'm not
> convinced by the life-time rules argument. The consumer is not
> CREATING a resource. It's REQUESTING it for usage. IMO this means it
> REFERENCES it, not OWNS it. And so is only responsible for putting the
> reference.
>
> Bartosz
>

Hi Thomas, Greg et al,

I am at LPC and will present a talk on Wednesday 5:15pm at the kernel
summit about object life-time issues. I'll reference this problem
among others. Please consider it in your schedules, I think it'll be
useful to discuss it in person as it's a generic problem in many
driver subsystems.

Bartosz
