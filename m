Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9E7C46B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjJKAbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbjJKAbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:31:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA80199
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:24:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5859b1c92a0so4699976a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983890; x=1697588690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkMbt4JFmtSlUfUc5YRj1RfdWAlOvg8CzC6z2aU7wME=;
        b=H/WmXYc5wLeD6GCUU5yH5W0liVCMjCEkZ519SinlMcVsVwMF3XJdd+P+166jtLXXod
         BRXJ+wo29duSV+FqDpb5WqrkgSUnUfLNsNEeHzUFNnGU+kxcNxBZwsd39GgggJoSNaTH
         KnyXNf89RhBLOB1oCPQzs0xXRnfrnwpKdnfN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983890; x=1697588690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkMbt4JFmtSlUfUc5YRj1RfdWAlOvg8CzC6z2aU7wME=;
        b=xCgrCwG75hekD5M4EP8FtzkA7pFjgRJ1AMlQEk0i4ArwInw3WR2fiylcECQjBvoiMm
         MT4Hf663Ys/9nrLlQVuFAQf55kISYK59KFogGsKBDcfNVJTry9IIfcp1VYIT/PbLaWzh
         jlEkXmyCY9PjCANQUXtEnrnIPXB4SN7Ej1TOCu1Cc3Es+xl1bTHz8+KCXv11IdhyhUiD
         0kOQGvXdQ39+WHeMbP/Ym4wAlIs/gK/dUFKrwKfWsCt1VZGatSEokY/oq51y1W/0GCIg
         RhBLJBt2ilmDOIUnb7vvHJjfkV5cE1C8ucSw0/qvQ+OcAVDF4LzGTz/cOLix7CwwC96D
         Icow==
X-Gm-Message-State: AOJu0YwWpsWcncCtrmFzp7bZxoaNwtBnHtA2udr0L9wNJr/Mrt/N/fjV
        qCVEti/F/M4UkXvSvRIr1YWntQ==
X-Google-Smtp-Source: AGHT+IGf7ddXmS08xcp36Zh8uXKutL7OrkQnwSoTTPICtp9fPdkqjS7NSRkkFHEb94c/5QNvI+WnEg==
X-Received: by 2002:a17:902:ce8e:b0:1c8:8d9a:48a with SMTP id f14-20020a170902ce8e00b001c88d9a048amr17314965plg.66.1696983890661;
        Tue, 10 Oct 2023 17:24:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b001c739768214sm12442005plp.92.2023.10.10.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:24:50 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:24:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
        wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
Message-ID: <202310101722.B6D6E6CEC@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-3-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-3-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:40:44PM +0000, Hengqi Chen wrote:
> This patch adds a new operation named SECCOMP_LOAD_FILTER.
> It accepts the same arguments as SECCOMP_SET_MODE_FILTER
> but only performs the loading process. If succeed, return a
> new fd associated with the JITed BPF program (the filter).
> The filter can then be pinned to bpffs using the returned
> fd and reused for different processes. To distinguish the
> filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

This part looks okay, I think. I need to spend some more time looking at
the BPF side. I want to make sure it is only possible to build a
BPF_PROG_TYPE_SECCOMP prog by going through seccomp. I want to make sure
we can never side-load some kind of unexpected program into seccomp,
etc. Since BPF_PROG_TYPE_SECCOMP is part of UAPI, is this controllable
through the bpf() syscall?

One thought I had, though, is I wonder if flags are needed to be
included with the fd? I'll ponder this a bit more...

-- 
Kees Cook
