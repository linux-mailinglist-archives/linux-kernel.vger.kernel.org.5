Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594175149B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGLXny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGLXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:43:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10851986
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so155565a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205430; x=1691797430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IwbsLNMZjoBI8pt2zzSuSleIDve//tt+1qPzYCGebU=;
        b=knCtFMbN4WML7vj766sEtY8KvxapiU2by8fS/mxlg7A9NlKY6gTDWsRrCG++Ao3uMm
         ljImTF0tep7vUF7b0Z0u3jKnOC2ANSzndhehbtN5RBZysfVoKdrkWIncAOlr9TCKczBv
         mRX/2KHZE8O62zUYUxwD6QwApWqpHXBsZvMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205430; x=1691797430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IwbsLNMZjoBI8pt2zzSuSleIDve//tt+1qPzYCGebU=;
        b=j/Ag3TFSsn8+wy0R8DFKp32S8tBwcW50kVlkfAy5dy5qAMVUR7hiJPQp0vn00FIuCe
         lXh33QP/qRjxbN5/U23SutcfCuQjEHSRceG1P+5/9lg8fuZZuH9rgV1xNwKGYkHYVcPM
         ZqYUFh8zLyqZi3rvusEXbYe7MQjqm/Wt4AE4LOL4FDdiNclNh0VFzw4nZOk3BoVMt8vP
         VMVIumlzkH9mFQazjX3oF2axPBpiYpKCIvMXRCgBmxXv2lLjW5AUocgkTpsovo2x5In2
         D5TQK/+/yI8G4LVtpUZZ4grkK4JitUSXZO7fMMvXQmZyYQWx53M2jIE08Odv6vk/03ww
         GMYQ==
X-Gm-Message-State: ABy/qLbMpW4Sa7bgYSLM+NtBZxz5nhjUradNYsXE0USGhiEeX6Fuba2x
        KbkDAXQI6iIrnbJ6M7H05jxn1w==
X-Google-Smtp-Source: APBJJlG2587sgWGWzoLeo2iZEAvVs8nrf1/dt7I567aIm5zKF1zfvqFb6t3P/L2tTUZYA0qQ3fY3mA==
X-Received: by 2002:a17:903:2288:b0:1b8:a3a6:df9c with SMTP id b8-20020a170903228800b001b8a3a6df9cmr32020plh.60.1689205430441;
        Wed, 12 Jul 2023 16:43:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001b83e5ec666sm4561085plg.6.2023.07.12.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:43:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Replace strlcpy with strscpy
Message-ID: <202307121643.096BAB33@keescook>
References: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:58:16PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
