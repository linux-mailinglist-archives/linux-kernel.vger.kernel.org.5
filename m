Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E483770762
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHDR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHDR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:58:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB1C46A0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:57:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58440eb872aso26602357b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691171878; x=1691776678;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rR0xmb+YpEUj3rb8g7lk+IJj++fv45EBtjmO2AP5zk=;
        b=bumgosh2Fglx/mRvU+e7OVXgC7GL8e1cUh6pLrPTjFCr9UtxKS8jKIgjXdbGU7nyIB
         oO617f8ho1qd8wT+xD4VFYTeaPZi2dl+K0fiOnV/oFPm98E/jQofZA3C46eOZpkfeTzt
         953FClrdMN0nv5fZLFsdS92yXZz+Afi5KT8m7tdXL7zd4opZR3yx0deF4nNrYv+FXPn7
         bKZ5BWu9uX07QDRB0lf3xnOAJG0MxOoOr0rZsvjSJ6u1u9iK9LaJlMjvHMRLWtt+vRqp
         gb7S1Mnrtcnfui9PfIh95nI/IYX7GEfDoTk12muH3wg97/2y9dAu3HKdoHHJldszxmPv
         G/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691171878; x=1691776678;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rR0xmb+YpEUj3rb8g7lk+IJj++fv45EBtjmO2AP5zk=;
        b=R+idzKZYVHWhWozituHJtgOiTHAo4e7ppTqDVcvG1lup2sHjNhBJZYge17WqfEw02E
         mCVJLonnk++7gTdVWq4w39pvQccp12tOQyyP8gmEiLUxXtbAwzVxXMzXvUuUAnmqxVZS
         f1otml/TsiBjnm2mzboOxAd9LV08UuG7yNeXpfuBtmFK5LfQw6upsIfYrxAdTVKClOGM
         WquL9OvR4/pNVCP+2xkmL0TWIXHyCe+j+JzUlmC0YbKycBOGdNKdHvn/acJz1bA5qDRQ
         L7tlXv7Wu3jUe++T18CIEtmI9QgjM7peZXCcxNDo5l8jmN53llacRgXQsIo3t865gAJe
         JMKQ==
X-Gm-Message-State: AOJu0Yxs2UJSzAMSdAruxl5xNKg8bbnWzv2l5RdpOtfXJKkT9x0HHjvL
        xNfWePuubHzNBaWOGvPhv/4mArCEb4oddJ32Kw==
X-Google-Smtp-Source: AGHT+IHaWtzA8FG7BfGEEKC7lPm6rGVwe5YfMHXK5sMAhQq0e/Y5Uh7AwMHjvY2Enp4SAYdR7RxsP/uFCP9yIiKaLw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:aa4e:0:b0:d45:1b81:1154 with SMTP
 id s72-20020a25aa4e000000b00d451b811154mr9675ybi.2.1691171878397; Fri, 04 Aug
 2023 10:57:58 -0700 (PDT)
Date:   Fri, 04 Aug 2023 17:57:57 +0000
In-Reply-To: <ZM0rXgKvb912k5BE@linux.dev> (message from Oliver Upton on Fri, 4
 Aug 2023 16:46:22 +0000)
Mime-Version: 1.0
Message-ID: <gsnto7jm8zbu.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Add helper macros for ioctl()s that
 return file descriptors
From:   Colton Lewis <coltonlewis@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     seanjc@google.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, mhal@rbox.co
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Upton <oliver.upton@linux.dev> writes:

> Hi Sean,

> On Thu, Aug 03, 2023 at 05:42:24PM -0700, Sean Christopherson wrote:
>> Add KVM, VM, and vCPU scoped helpers for ioctl()s that return file
>> descriptors, i.e. deduplicate code for asserting success on ioctls() for
>> which a positive return value, not just zero, is considered success.

>> Signed-off-by: Sean Christopherson <seanjc@google.com>

> I appreciate the desire to eliminate duplicate code, but I think the
> naming just muddies the waters. TBH, when I first read the diff w/o the
> changelog, I thought you were describing the input fd (i.e. 'kvm_fd',
> 'vm_fd', 'vcpu_fd'). I don't think explicitly spelling out the condition
> each time (i.e. ret >= 0) is all that difficult.

Couldn't ret >= 0 be the assert condition for everything? Don't see why
there needs to be different helpers to check == 0 and >= 0.

Unless I'm missing something, error returns are only ever negative.
