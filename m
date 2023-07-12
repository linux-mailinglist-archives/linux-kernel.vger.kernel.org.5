Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374CA75146A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGLX0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGLX0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:26:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2601BEF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7589b187so185954e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=gK6dgVUVl9fXCQzQpwk0Vta2voZg2T1QCMWyXYVxed0R2wqtK0Zg32/nG/SF0Xf57B
         Xt/BYCWLVObpcwHdEIzl8RGpBzWgOneAqsqfh9sMfH6tH3LWWmEFf1icgvJ/tflGvk6y
         6+oxV/qHO0HPEXkMvxVw1xV8+ZgnMf8Ys62V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=clr2agtP4+9NFdlc6W3vFykAzdq0McA+yTHQ2N+hYPgXYZeWFTDWdtYFE25C/s3BZt
         Jq8jNS8sNd/10sPW4g799MrnXX0GqX3UemdP+O+yMJIsa4khcdLGWBBZD+x0nYK4sCOT
         gbYyL5ZgmE5PU66QaVspl27//Xr+pyX9tZ3/uSuTyl5pS+EfnhXJH4L7a7NrUysUV914
         Bejc+6HSFSfVNawnuKFSAa45OO8nS164wD42PKAWmskqv4wzl2sRCgYPNTfzXpu8rus8
         +ojj6HWvqeW3EH3m4J0U8yYQM3+SMORBsa1TdZaeQKLp1I3Gw1Wd61If60hc/Lud023q
         li6A==
X-Gm-Message-State: ABy/qLanfba9Kkbjna7O1eUPDLdfIBqi8sOyLT90wcnPohn5L/hw6Pn+
        IL+X4o64rR4Qcf6J1XWHLdH+5hIu2qck+q8QYqBG3Avq
X-Google-Smtp-Source: APBJJlH1CQO7nLB4daG+9zLrudyuSGIVr9hfiAOyEIutlPOXyVUj68Y+d7k0yvTwh/CWwwSvCxAhSQ==
X-Received: by 2002:a05:6512:12c7:b0:4fb:8bcd:acd4 with SMTP id p7-20020a05651212c700b004fb8bcdacd4mr19669163lfg.37.1689204407463;
        Wed, 12 Jul 2023 16:26:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u13-20020a056512040d00b004fb915e8b9asm885236lfk.170.2023.07.12.16.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f122ff663eso171410e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3c89:b0:4f8:75ac:c4e8 with SMTP id
 h9-20020a0565123c8900b004f875acc4e8mr20148535lfv.43.1689204406009; Wed, 12
 Jul 2023 16:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230712223021.636335-1-mkhalfella@purestorage.com> <20230712190723.26ebadea@gandalf.local.home>
In-Reply-To: <20230712190723.26ebadea@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 16:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Subject: Re: [PATCH] tracing/histograms: Add histograms to hist_vars if they
 have referenced variables
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mohamed Khalfella <mkhalfella@purestorage.com>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 16:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I run this through my full test suite, and then send Linus another pull
> request.

Ok, I'll ignore the one I currently have in my inbox.

              Linus
