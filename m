Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E57C75E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379624AbjJLSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbjJLSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:33:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7606BE;
        Thu, 12 Oct 2023 11:33:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2420514a12.2;
        Thu, 12 Oct 2023 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697135587; x=1697740387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Yt4HEDKKo6+d4XZeN0QMyHve5mG55+QEMOQYKa6AoA=;
        b=GEchmT1HUyrD5ndeq8eQvC4BXcid0V1eA3aPYnpS7ES+aKQcQmmO2Bynt6+9yNHmKE
         iR3DQgoZSlD34fWpxu4CBiMFTIx/l1WxkIGSu8EHjG6VkoBxMvy4uzCXrzY2F13leE/U
         7dBvnXP6QOYaHaGYzSLle43vxlp44JpkyBcyw47/f5DIABXVX3ynzfCJqOh8zyS0a/Ic
         AWAw/LzJc6ILx+E9OIeMs1AfwAZdrMlnrIrpkp3eMba1BBWs9e30RowUKOPIDQTSQaHJ
         msVINpDGZopk+ZhU/109zHYlgO4LoFIBMRd2KUMraEEo1T6aZlNFX+o5cL7gJi/O5QNC
         tVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697135587; x=1697740387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yt4HEDKKo6+d4XZeN0QMyHve5mG55+QEMOQYKa6AoA=;
        b=P0XRWzf2MAuTTlOXFvbPz8UYaoVpg8t5p/iC5jSK0jWJ/jgGJ4O354nXY+DUh5rkaH
         oNmXFgNTCn2KCOHoCllXymsAL+EZIWEBHFQNYKRFSizrXUhQHde+mxWpME0zijajcF2p
         k110HO2OzGjNWcrip7A/4gxyqI8gHVltMypW2b4G96qhceKGCrxZpjqf2c+7G1E8s4yI
         8Y6Y4DRBGQWp6ZZi/iowSASwEzgnu0Jt+Cpx0otYm+LLce+lyR0viAvGQxKY9a4FmTmq
         szy5TUH7n0/UYAuUdwDqg8Zy2OvxFi8uXMBnRkVLtcFbjBbr5Kz6OiSSbq2UCQjRLXhG
         GRuQ==
X-Gm-Message-State: AOJu0Yw96VPI1aNA6WDH3a14qWzP4EN/y/KIwBusE2FkopA2XAFxi1oo
        pSqnZgadrMCJzRhRC+5nvoo=
X-Google-Smtp-Source: AGHT+IFWp5v0KAwI2KVBXMv/+3XOFfW27pUVJ8GaJohETW+Lt3zJP/kCBmLgd6NrMdPNYaikHa5d9g==
X-Received: by 2002:a17:907:b1a:b0:9b6:5a86:2926 with SMTP id h26-20020a1709070b1a00b009b65a862926mr20502640ejl.62.1697135587281;
        Thu, 12 Oct 2023 11:33:07 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id b13-20020a170906d10d00b009930c80b87csm11532318ejz.142.2023.10.12.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 11:33:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 20:33:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
Message-ID: <ZSg73+7Ar/U2OWMO@gmail.com>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <ZSeMGPPfxkMvdaP3@gmail.com>
 <CAM9d7chzw4UeHHeXaMfPTiRdLbv7PbpK=xkgxMDojAxAc8y7Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chzw4UeHHeXaMfPTiRdLbv7PbpK=xkgxMDojAxAc8y7Jg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> > Could we perhaps add an IP filter to perf events to get this built-in?
> > Perhaps attr->exclude_user would achieve something similar?
> 
> Unfortunately IBS doesn't support privilege filters IIUC.  Maybe
> we could add a general filtering logic in the NMI handler but I'm
> afraid it can complicate the code and maybe slow it down a bit.
> Probably it's ok to have only a simple privilege filter by IP range.

It will still be so much faster than moving it through the BPF machinery, 
and bonus points if we merge this into the existing privilege-domain 
filtering ABI, so no magic 0x800000000000 constants are needed.

'Overhead' to other usecases shouldn't be much more than a single branch 
somewhere.

Thanks,

	Ingo
