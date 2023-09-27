Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5E7AFE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjI0I0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjI0IZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8291A8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:25:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c135cf2459so160113811fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695803122; x=1696407922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mBwF4TjOFyMQxtQEAd+K0NWN+3oWRxy6Qb0vWZMLSfQ=;
        b=MC2Pb8oSCrGEf2Modf//RHPSDeqWUoX52Q1PuzB7cIClcveH+Sl6pNWKn0jOTfyw39
         8ZVbZAMg9hk02hHQ3EJiOppmnXgp1IDyAc+c5Avd1NoAlS9whDDUVwLDuXyble+x22uc
         IVSs2bIXC9ztyFgzxqXTUlC08YTo3ZytFlpwuO0BP9sVUiq2rj+tVV8GEDpdaYFw+TKI
         DOW5RvybBmlj+qQXLN5tW8tN3ztBf9rPUhUlcOdI/hkZg52NiR1Y7J9YLc6w35jKSYwu
         jYTndf+5pwUuWOzou3WihIxvNV0HyjM8nXaJiqzwNrWs1JOIDpAOS1VdYLd/FyClFAOd
         5V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803122; x=1696407922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBwF4TjOFyMQxtQEAd+K0NWN+3oWRxy6Qb0vWZMLSfQ=;
        b=Q4lh8XIhxaRnA/MJjlcPNeTq63WFPPX8VGrw2UG7wdzAdssDI99kJg9DuLSOyKK2Xy
         ZWZZk+XuneQGob/prJ2IrociA4i4s3AtUDpu8qeNDVfCTT+0BtwjH9nNQSUwpb4pP6fP
         oD7RL5F7ZHSr4aLXj6bjrDfgEBHfG3F3SB5Tmt2U/HtKKkLbdwsX6wUDaMjaMmMWkByk
         x9d7xnDsFfAYrkPUc9ttrJ0iC00tHrPgVnnM8RjWipM4uwDNJB1ljZYmvZe+f5kqlayC
         B9N5LVf33nmrunCEjfgKI1a6kepHf/JcNVqdVFZ6OKxrOkF6wd1vbdGqO97EL7vyt59H
         STyQ==
X-Gm-Message-State: AOJu0YyvjOL7LbsJ6+5Rkk/pPLr17hTfEjjJfaAwttPEcTXowsdcxDkW
        UyWrGOd0404Nu1SeRAWbC2ys/M4vcK3w2jYBcBssaw==
X-Google-Smtp-Source: AGHT+IFLYKNnSn8AMqtBsr7P4yryUjv2RNpVyFePMS9VlgGOQLYBn1L0H3VlWicRyWTB9+TEUYCH/1xAuPdUbGyKsT8=
X-Received: by 2002:a05:651c:228:b0:2bf:eccb:548 with SMTP id
 z8-20020a05651c022800b002bfeccb0548mr1347411ljn.0.1695803121875; Wed, 27 Sep
 2023 01:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com> <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
 <6513e6079a427_91c1e294e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6513e6079a427_91c1e294e@dwillia2-xfh.jf.intel.com.notmuch>
From:   Thomas Fossati <thomas.fossati@linaro.org>
Date:   Wed, 27 Sep 2023 10:25:05 +0200
Message-ID: <CA+1=6yeP6dDiXVQrxMt0AaEF_7S05p4Do67=ysXK-Chfvu-9ow@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sept 2023 at 10:21, Dan Williams <dan.j.williams@intel.com> wrote:
> It can be expanded when/if those platforms expand the
> size of the supported user data, or another configfs-tsm backend arrives
> that needs that capability.

Makes sense, thanks.
