Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3290D7B5E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjJCAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjJCAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:30:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED03AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:30:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65d0da28fa8so2452616d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696293026; x=1696897826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm95BT66K1A2Zf/YgTxpWCUle5PuInPRhEHdoEUKoQE=;
        b=F3SOZI5Affm7XwvYCNy1kYbY2urL72mIe19Vo+2y0mYD9/U5GK+mcgSSCcZ/frjKRK
         4NigmqhHFASsvkPbf9Wr3pdyJzr6uM3cyvZRdu91Z1GrqVKW34A84djwqe6vLE2E9pmd
         Co00+HztcfTv6rBDwoQVlUWALKZLpLytnNulhsbLXQtYfi2Fm6zbdoBJ3+YINB8wLVVf
         IQl5QhFXq7VvNWYQgZkxXh/+9Oncga4EMQ+4ApkM9Sa4he5mtsmqfX5TDqF0niPydF7o
         hSeYBwUe8d51xmX7AkhhJWeoZCpfr3XoQDgZpgoRf8o9/uBDIlHOI0BPKW8qERrirvqq
         M/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293026; x=1696897826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm95BT66K1A2Zf/YgTxpWCUle5PuInPRhEHdoEUKoQE=;
        b=L4RALk62TJzLkG8/gbfx2aSR1YQzUSQM8/hjqH2Ep29F9KL1DOloUUtCHeEJqWjdWC
         dmmBwr1KpQ/rqm2cIOa0RIMOOETU76lJwycDP8obRix2xs7F7Ih5Eh6zO9wxMHZEhvfi
         XjkTDf4KSx1gsnZX5BxuIvuaktttvmxcM0kmfw44OwdQ20LCIy7ONkm/kRR9WTV8twte
         CSwAgBsBZqa6muSXNkDZIk8TwV7VaT0xnjAHZOSbHmBTSmG0aBJ+icECQICjHql/4Apy
         L91zS89GwHU3cgh8UFJqh9u27oZbtQPrJlpQ73e5nDQUy0INrLMsPUBzgYa8s3kxCpWo
         VDag==
X-Gm-Message-State: AOJu0YxDv3yfKx1rHDLXFI1FCTrntEQ5eNndjaoKxX0oItw8rJUq04Jr
        issdLw4RunwP9uYmkt21KHpYxlPNCBKYAug6ZaPdLw==
X-Google-Smtp-Source: AGHT+IEpb7Cfo0yp4UqChQuah8UnSbiBBCbiC5lnkF9DzW3+QZ+WfjSNxRJF6F4+aUbfmcOC/wgFcIB74fjZr1vko4s=
X-Received: by 2002:a0c:e383:0:b0:65d:4840:6eb4 with SMTP id
 a3-20020a0ce383000000b0065d48406eb4mr13854778qvl.6.1696293026067; Mon, 02 Oct
 2023 17:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230929023743.1611460-1-maheshb@google.com> <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
In-Reply-To: <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Mon, 2 Oct 2023 17:29:58 -0700
Message-ID: <CAF2d9jgWpwNye89qrANfngG2+NQPDhpZQjXMKBDG6x7e32_cOw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 2:25=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Sep 28, 2023 at 07:37:43PM -0700, Mahesh Bandewar wrote:
> > add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() meth=
od
>
> This is a useful idea.
>
> But how about a new system call instead?
>
>     clock_compare(clockid_t a, clockid_t b);
>
The purpose of this API is not to compare clocks but to get the width
of reading the MTS value (offered by NICs) in terms of the timebase
that is selected to essentially improve the accuracy.

> It would accept any two clock IDs.
>
> I've been wanting this for a long time, but never found time to
> implement it.
>
> Thanks,
> Richard
