Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC07A7D8774
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjJZRTk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjJZRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:19:37 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8C1B8;
        Thu, 26 Oct 2023 10:19:35 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-577fff1cae6so835309a12.1;
        Thu, 26 Oct 2023 10:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340775; x=1698945575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb0eQOMATExq/akjsiAw6q/kyVoFbGjr7jLMdnPq2PI=;
        b=ec1nwaL15PoZJdfHLP+lSSF1GMaqmBoIX2Zg2s80ZK0Qcb3Rgkbre8JfCgTaK1mWj9
         xTc6UWcnJ5OasASY08xa0efmoqXVKD5Mwj6P8fF60bbnWKL9P0k3Sp8CoSftDqbkf8U7
         J+5BkroWVIa8IUjjkoMmQw71iIjTUg/wt3xCZ1MPsMwvN7mCRqHftWxtuwfE/KtQRAa2
         EhqRXFsr+E7ar28pzZnZesC7SnMamLX/IGNXrwcpyn9ubvkqIxPqVVWQOEhlP25C7iiN
         462fF3n5DLiCf9cSZHEjfHyEWro/yYE+4oDc05wWj1aRfpZRRaAdWAtg+1G5P0Zbiz2+
         pZKw==
X-Gm-Message-State: AOJu0YxO/R9+2LmY2FLrrDTu4bNCbgDERjYUYN2Cg+IvmBOMHbeEPGTT
        wZSJeM+s4WYeRqiBOaBXbOHb2MqwEVqpR7zs0wc=
X-Google-Smtp-Source: AGHT+IF+F0nM9v0EO5vdIGbm1sjh/JcAxv4NCwzuZm48hXTLQ7bb5RrTI2IPvbhHACzEOJMYyom/3bKbAuuEkh32IFw=
X-Received: by 2002:a17:90b:1d0c:b0:27d:306d:71cb with SMTP id
 on12-20020a17090b1d0c00b0027d306d71cbmr4289000pjb.10.1698340775255; Thu, 26
 Oct 2023 10:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231026062615.3096537-1-namhyung@kernel.org> <5a153604-3e9c-4ae9-b216-64f24199efc4@intel.com>
In-Reply-To: <5a153604-3e9c-4ae9-b216-64f24199efc4@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 26 Oct 2023 10:19:24 -0700
Message-ID: <CAM9d7cgkCZbHA6N2mcEMzHBuUq5puojtcRwME6AODBudEcTjfA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add -H short option for --hierarchy
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Oct 25, 2023 at 11:46 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/10/23 09:26, Namhyung Kim wrote:
> > I found the hierarchy mode useful, but it's easy to make a typo when
> > using it.  Let's add a short option for that.
> >
> > Also update the documentation. :)
>
> Perhaps it would also be possible to support bash-completions for
> long options

I believe it already supports long options.  But I have some setup
which doesn't work with bash completions. :-(

Thanks,
Namhyung
