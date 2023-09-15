Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A827A272F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjIOT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjIOT3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:29:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89A18D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:29:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2981058a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694806155; x=1695410955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5LEUqCHPCnrv8BOdK+xwDxdUDvpSxeP2kE2OxD9W0E=;
        b=a+5BIW5sHZewITQvD/isc5fdLk2eoN496uxsmlcWxYI3vL+iA7nfcxhz4Ys+U9aUZI
         fZ23qHybxz0Iah3QNX7AlBxhEgNis8LW2zFvIMrnGtRNCtnfuwNyLpIzKH5jCC3b9PHS
         4I1/DWJz/urGtyhnnvVRXEjcIdpoYRcch3lx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806155; x=1695410955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5LEUqCHPCnrv8BOdK+xwDxdUDvpSxeP2kE2OxD9W0E=;
        b=KhUsviIjyV1IzrfSqVDbPgzjnEYVR3ntJqWSbizDgoKp/jQmdCJEfQrzSWH5vGh92e
         XfFUH4mnEqIDFAus3YK8d6b1iIooT1xd77bKVeWcibwi10WET+jehLwHgp6KGI0tf+IC
         jOYWgPcX/dmRTciF8WF2O1Z/4a+XMt4Ef9BD8roO/OBumkHh0lGrFzwoQBiv3Jg6wi83
         Zwpmh/Ig3mo0mZCp696goFYO+IcxZtkX74UXI8CiyEgs+LGLTxnvR8p81PIfO+9SK9+d
         2x/LgZThYU+ONuHzoStrTp/U0DTyymRfc7ykN4wHn7qsPkSFbzuphsQJchJdQV9WU7Hz
         Q+bg==
X-Gm-Message-State: AOJu0Yzy02K6gtLSOM2S94GqPzcbn8VlY+pJsLCrfe9bgoASVTArp9s7
        c8Pru9ku6WQkfiqugd/TaDSZ46oOIZyYlbFL4FYqGQLH
X-Google-Smtp-Source: AGHT+IEq6+NcqKHpaYxhjiTQfgAuRpHn1PeosS5vUFMLT93sCjO0Guw989s2lfXP8ScWP6xJoFIKdA==
X-Received: by 2002:aa7:ca47:0:b0:51d:95f2:ee76 with SMTP id j7-20020aa7ca47000000b0051d95f2ee76mr2158358edt.27.1694806155531;
        Fri, 15 Sep 2023 12:29:15 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b00530aae2d5bfsm471523edb.9.2023.09.15.12.29.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 12:29:14 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so2978874a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:29:14 -0700 (PDT)
X-Received: by 2002:aa7:c6d9:0:b0:52b:d169:b377 with SMTP id
 b25-20020aa7c6d9000000b0052bd169b377mr2037149eds.6.1694806154510; Fri, 15 Sep
 2023 12:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230913192905.0a92bcab@gandalf.local.home>
In-Reply-To: <20230913192905.0a92bcab@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 12:28:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
Message-ID: <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
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

On Wed, 13 Sept 2023 at 16:28, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tracing: Add eventfs file to help with debugging any more issues
>
> While debugging the eventfs dynamic file creation issues, creating a file
> in tracefs that exposed what dentries that were created along with their ref
> counts proved invaluable.

Honestly, this is neither a bug-fix, nor does it seem to make any
sense at all in the main tree.

This really feels like a "temporary debug patch for tracing developers".

              Linus
