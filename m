Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71817B9954
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJEAqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjJEAqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:46:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82FAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:46:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so613761a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696466801; x=1697071601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l+VsFsJbDR98dMfHD7/KVXVNcs1gFsDPFu0JuDG42aI=;
        b=MCs4tn6BTahSfrsPpyefsOJ+FgGRdWXBpbrT47dnfB/kiKQFZJ6w+8mU0VPFtxDCyF
         K1pUEb5naAqAq7O3PAgQV8FSkGrOVQvkou4N2xQkMfaJ75e5+NBDO277dIQMPtjlUziA
         OSgsiqHq5vzGhxsiX7QkOmedU4toKlYURuxws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696466801; x=1697071601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+VsFsJbDR98dMfHD7/KVXVNcs1gFsDPFu0JuDG42aI=;
        b=X16VCJ6bki5zc4m/PyGdHyhOIsQWkTaJNXLVwoH++ebWqMQzV0yJ0L2Mlzse6cXCuz
         g7xuVLXRb45SzYHYevVk5M9B267tWnThbn7sxGjwxzYAuhgKQ+wuQpFsgwYafPmmmS1W
         vwsbOBnXzW4XldBKBA6ZIBXLmBswZ57nUJFKA0a4u2/mn19+xACFueuQzZ8R4NrTPd9T
         yIHbZ0wIo5gx19ste4nbz47p9r1erFxU7idVUq5l7A7Eav7M6I3MmzvKaPKIWVdmup6T
         s+5J4LHBQJdrLNV1Gv4WsOOTT4hdg8hJNNHVtrMLPVDQo2QlvThT+vMQuI3/TPZEDQZ0
         HV1g==
X-Gm-Message-State: AOJu0Yx7lMUIW8SDn+/t1NJdeLCxJTCldPb1aI1UHZ4fC9WKCtlTC1Bk
        Ssrfkgqksc8KDwFzmLmBojxHnTY8/wTCnCZyDBGAxQ==
X-Google-Smtp-Source: AGHT+IGaxrGB3sYFSCpNxQpbzOp8L36XlqSkL0ax8GyPJKxj7zXd+28Q4eXlKzR2jund6h8ORIjvCg==
X-Received: by 2002:aa7:d8c7:0:b0:532:bb18:798c with SMTP id k7-20020aa7d8c7000000b00532bb18798cmr3410651eds.36.1696466801488;
        Wed, 04 Oct 2023 17:46:41 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b00537fa467ddasm202901edx.65.2023.10.04.17.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 17:46:40 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so613731a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:46:40 -0700 (PDT)
X-Received: by 2002:a05:6402:1357:b0:533:4a9a:b0e6 with SMTP id
 y23-20020a056402135700b005334a9ab0e6mr3508227edw.20.1696466799654; Wed, 04
 Oct 2023 17:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora> <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
 <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com> <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org>
In-Reply-To: <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 17:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJjhoq2wGOx9e0zK7-EouqdaRREvmJJLN+HX-Zht3miQ@mail.gmail.com>
Message-ID: <CAHk-=whJjhoq2wGOx9e0zK7-EouqdaRREvmJJLN+HX-Zht3miQ@mail.gmail.com>
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 05:06, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> However, on the flip side I think there are security benefits here. We
> wouldn't like any indirect branch speculation attack to leak the trusted
> key material contents here.

No. Turning *one* indirect call static isn't a security benefit. That
argument is just bogus.

This code needs to be fixed. No static call rewriting for call-sites
that are just used once.

               Linus
