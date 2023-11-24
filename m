Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63807F69F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXAxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXAxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:53:10 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBDD44;
        Thu, 23 Nov 2023 16:53:15 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-54af1776bc5so177403a12.0;
        Thu, 23 Nov 2023 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700787194; x=1701391994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QS8CVpY2dRIE9/ItXow6oOuaCdUNl5jE9qUR+XAHyUg=;
        b=EeWOwUPJxFxlvwM4yQ5YQVNx5Lm/YwPaL4xaTXeO/p2p/dUi9e7fOnZoYlMOXhUkEH
         7bkZx+vSC1fKYq8CX06mPQxsn4kTlrqsGDfhogeYjYdiCtfVgyvgsgFXwDYdhoM9xUx1
         29wjCftqbAb9CdqJNwxzkKz4QMERgW7HzEixfmeMYa+B6ccQ1UjkROE232eMSrODFLex
         /3ZoxfN21fcyZ5Fphil4XV1gECeMqNs0VseVI+dlRvwhYwF4JrIxZgLitUFRFDPaKCtF
         Nk9874ToXRTcl55MJQ49HZkN3xEbaUtyFh5zPseCOTKlxmV/plduwdEm9lfl0BtKqm6B
         1sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700787194; x=1701391994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS8CVpY2dRIE9/ItXow6oOuaCdUNl5jE9qUR+XAHyUg=;
        b=cbwMMde1Pg+Owhti9hPORR25znQciK1+BZ2SNQvCSWors7oymlQ8shEDyLGRhCxaHF
         Is1IDBIIBsO0UeTY4IJDrrHwD+hexTAMaT5rbXdW8nryAZURCVj8mBaMMfj9pPg9GTvE
         FYIpSwnZo3E/iYq/OrIr1oAah0rltkaRkIGGcZWLMTJ0mVtoRRuqX5O1pvfFAdwiGknk
         nkN7RkdqSKFpx9OzrHEqzRYDPB5qA7CqOFGSwUI3QNb1jRIQ8gCChkur8jCmx82fgYDd
         L+zbTvPh7pP3SGzW26e7YOrh0phk6WdFcffUFLeMXbSuAuYlUrUHKGUgJus+/or3AuZZ
         W6Cg==
X-Gm-Message-State: AOJu0Yxuiqu4e5xnUbJ+tkfqLPFf/8MrdE0yubuDWEI65iKgf7AKJdlA
        cgdC6MGzk61YA4D5vGpTAEe6T2rGxhT3bMZsp//WAnJhUE0=
X-Google-Smtp-Source: AGHT+IGzTE1+5yQw2oSsdNswRImIAfvmmX9ZG1e7hUvEAb+IPtk3pOyxZFP19bVMuYBUEsKCVhKt0PWNrXikDt+qgIE=
X-Received: by 2002:a17:906:10d:b0:a03:d8ea:a263 with SMTP id
 13-20020a170906010d00b00a03d8eaa263mr587176eje.16.1700787194247; Thu, 23 Nov
 2023 16:53:14 -0800 (PST)
MIME-Version: 1.0
References: <202311231458.61e2502f-oliver.sang@intel.com>
In-Reply-To: <202311231458.61e2502f-oliver.sang@intel.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 24 Nov 2023 01:52:38 +0100
Message-ID: <CAP01T74ibZtsdssLB9WsSxP0SPusaNqfmzsqWz83T2H5TV30SQ@mail.gmail.com>
Subject: Re: [linus:master] [bpf] f18b03faba: stress-ng.seccomp.ops_per_sec
 -2.0% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 01:41, kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -2.0% regression of stress-ng.seccomp.ops_per_sec on:
>

Interesting. I'll take a look and investigate.
Thanks

>
> [...]
