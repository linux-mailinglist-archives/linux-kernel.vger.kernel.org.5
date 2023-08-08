Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58943774D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHHV7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHHV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:59:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F49E51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:59:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso8182385a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691531978; x=1692136778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vjVFfWFImhbbV+PvD1bDCoF45rIONe5KGNnouWDJ7A=;
        b=VPeoi0aK0FbUNYIS4YhPmyNq1Ylc3RUKJ/XvDTbL16kpHv2dYA5Xba3ITMXv+tObCt
         29+LnjVzEKb+A7Ldz1LI0DHOuDV89LEQIZETqkPtqTA1RMhcyTT1F/ZfHtSd2XCPmV3s
         pqJ4txZx3XcR9e6yuaw16KEpNXJcz1kZFvipo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531978; x=1692136778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vjVFfWFImhbbV+PvD1bDCoF45rIONe5KGNnouWDJ7A=;
        b=kMv0/ODGoNPqkbcYNM32sKN3Bn+gK+IrozXnXGjFaAOor4TIuUQzvhrtiybsX3/mJD
         V6UVTYYY2ZcYY7hMRrT1jj/yF936WPGykWEmU94WjvQzcSo3mbWrDcScyADJniNn+Abi
         rI/Pln7a3m005Ixed2hQL8BW4FY6D7HPFP2KjBc2CldPXlfAa2Fx4OKeF01UbHVlf7yV
         R+dxqHMxoivxbGeKtr1lm1NLASPFoJjXCZnTygjPXoMhcFkMb0opf9q+FBQPawLHMXH1
         8cobLGFTWuVs/iJtZeec2zF/fwirw3g7RqWGyYkFedTOjEOTvZk8Jms4GiKF4tCRFO3k
         HJww==
X-Gm-Message-State: AOJu0Yy3oBeeoGXihdKRS2MQDOKg1u0udmkAtUjUucPTQC/tSEAFllyk
        Zz8gev9f0526Pzwo1Wlz5j+IVPvRPDMqWGgVgsZGSdKd
X-Google-Smtp-Source: AGHT+IFLCINvThEp+lkIw0+RbAXNpPCLDpIydMvfg42I9Q1Ogmzlgy1Vx0dc6FQ4/FPk2GCyb+9Okg==
X-Received: by 2002:aa7:cb5a:0:b0:522:36f0:f1a3 with SMTP id w26-20020aa7cb5a000000b0052236f0f1a3mr968920edt.10.1691531977986;
        Tue, 08 Aug 2023 14:59:37 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id b20-20020a056402139400b00522d53bff56sm7008504edv.65.2023.08.08.14.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:59:37 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so907538466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:59:37 -0700 (PDT)
X-Received: by 2002:a17:907:7629:b0:99c:75f7:19c1 with SMTP id
 jy9-20020a170907762900b0099c75f719c1mr684831ejc.39.1691531976818; Tue, 08 Aug
 2023 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <874jl945bv.fsf@meer.lwn.net>
In-Reply-To: <874jl945bv.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 14:59:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipcJKtWRtBHDDjRx7UXyZAD2eswjCiD19tuz+XwjUxhQ@mail.gmail.com>
Message-ID: <CAHk-=wipcJKtWRtBHDDjRx7UXyZAD2eswjCiD19tuz+XwjUxhQ@mail.gmail.com>
Subject: Re: [PATCH] docs: vfs: clean up after the iterate() removal
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

On Tue, 8 Aug 2023 at 14:00, Jonathan Corbet <corbet@lwn.net> wrote:
>
> If nobody objects (or beats me to it) I'll drop this into docs-next
> shortly.

LGTM.

I did grep for old uses of iterate - including in docs - but I clearly
only grepped for the "->iterate()" and ".iterate =" forms.

            Linus
