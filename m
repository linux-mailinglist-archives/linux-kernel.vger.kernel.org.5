Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708F57ECAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjKOSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKOSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:46:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CDFA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:46:13 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e62f903e88so822705066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700073972; x=1700678772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+xxF8an19N64H/pRk8mbK+sEYYkdEuOsGzAOFfR0W0=;
        b=XHVnmuDuxFhle5ZL2Opso8SQeXdxAe1zy5BpFZJrBttytyN+vzLpDytehGTGA856cY
         9My50a+lDgbi3On8jpDyiXQeWt0YPGpZvDsaOWyNdg5sZW7Y6uPGnMbuc1Nwyy1jliZc
         Ta0WqRz3JRrcrL8evNnGDhnX0rWy4SDWRo+XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700073972; x=1700678772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+xxF8an19N64H/pRk8mbK+sEYYkdEuOsGzAOFfR0W0=;
        b=PrwvYtwNNCUZpDdH7kj8BmB1aE8aT49qZiW3gMPimLQrho/qZtqQYZlieOzMGthAZv
         vNZ4Ge7NdAelu2tLznzWfitoAWbuBpjjga0imvWVpOFgys9n7s3AAY65OyopvuJuHkm7
         cQzBuxjn/dDXX3l7mcpWMk0DUXQmjKT72EAKUtDbWBP5vZtacHRGQ2UyqFK6hIHXPmbv
         yQlBG+AIPQ0QVacKdI3M8zJjtZdNEmRUtn2svxaSf3OpBaE8EWDkufmuK9Ko003kc3ld
         ZRL8UxCyqdXSLqBMA3bjrNPxfvF1n3LcFh4aVjRBRIvglL6IVxy/T2LXxvlVBjNqvs2t
         NiGg==
X-Gm-Message-State: AOJu0YxM4C5IqP16TtkCFmWG7CAPHjSlQh8AhgO7XefqW+CcRvTdBoEk
        C9Hz/WojcMelltb08H0pZ2FPHROVJvfrN1RlTrOSlVv9
X-Google-Smtp-Source: AGHT+IHYi3eLE+4+4nHhzk++hkmn6JYSlZptNq1pA00D0K9zqKVYmMrxlwnEHRoeTn0mwT4/bE4KIg==
X-Received: by 2002:a17:906:f84a:b0:9bd:a75a:5644 with SMTP id ks10-20020a170906f84a00b009bda75a5644mr10245988ejb.16.1700073972210;
        Wed, 15 Nov 2023 10:46:12 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ko14-20020a170907986e00b009dd701bb916sm7375201ejc.213.2023.11.15.10.46.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 10:46:11 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso11063347a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:46:11 -0800 (PST)
X-Received: by 2002:a05:6402:1111:b0:53d:bc68:633a with SMTP id
 u17-20020a056402111100b0053dbc68633amr10573131edv.5.1700073971308; Wed, 15
 Nov 2023 10:46:11 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <4007890.1700073334@warthog.procyon.org.uk>
In-Reply-To: <4007890.1700073334@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 13:45:54 -0500
X-Gmail-Original-Message-ID: <CAHk-=whFGA6YPJp3zazUwBG6ort8i34vGv9utYdOgYpekyt++Q@mail.gmail.com>
Message-ID: <CAHk-=whFGA6YPJp3zazUwBG6ort8i34vGv9utYdOgYpekyt++Q@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 13:35, David Howells <dhowells@redhat.com> wrote:
>
> That's not what I see.  See attached for a dump of _copy_from_iter from my
> kernel.  It's just using REP MOVSB.

Yeah, an unconditional REP MOVSB is not right either. That just means
that it performs truly horrendously badly on some machines.

Do you perhaps have CONFIG_CC_OPTIMIZE_FOR_SIZE set? That makes gcc
use "rep movsb" - even for small copies that most definitely should
*not* use "rep movsb".

Anyway, you should never use CC_OPTIMIZE_FOR_SIZE as any kind of
baseline. I'd actually love to use it in general, but it really makes
gcc do silly things when it goes for size optimizations that make no
sense at all (because it will go for size over anything else).

It turns out that on FSRM machines (ie anything really new), it's ok,
because even small constant-sized copies do work ok with "rep movsb",
but there are cases where it's absolutely horrendously bad.

                 Linus
