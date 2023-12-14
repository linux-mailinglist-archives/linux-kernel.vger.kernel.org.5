Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2A812E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443731AbjLNLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:16:59 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4ACF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:17:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c21e185df5so6874007a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702552625; x=1703157425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhCwqmV8xLeKliC/IPYCJgesOy9krq9jbqPfrEK110U=;
        b=U4mfJcqX3m54VsdVzL4nix77soE66bGG2Te9nVi0c6csFEDYFi4C5HFm2D6S6FhX7s
         9/2cb6xmW0PHIh8woA/A12Vuyod0EJ5PA+z2pHyEy7q+O3YLBi6bwrBVblofS4mDd4YU
         bYkoYs8WvK1cdgaiq77Xdylvc6I5Gj8GDL0SmZJ2+W6O0bbQUa2Nc+orCWBG2p+Qh8Xz
         MEDeUw3YjJy+y00ogQlxHXtTENklAUFYU0+Vo7IpESRXIgWCKdDB2If21JZ9u79R9DtM
         ykUhXY9UFxgFIVzGHKGxYyY/hCCScYU/Uhrv8sLPa1HNsTEoquxj8G6/Whny5atqirPz
         X2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552625; x=1703157425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhCwqmV8xLeKliC/IPYCJgesOy9krq9jbqPfrEK110U=;
        b=FMa803uMaSyNTGNS6xILd/54FMSL2m5HAvkYxPvdxZTae/DSx/nnPKW/oOaOlBEDgd
         VEz4kBPFR6VJvOSpceAUCyWdNdJwxMMsJHRiH1RIgU0rrLdbQOeOglQeoGDSQP5iFqEH
         t/axuHq6vjfAojN+3/FyjVZOed67uA/iAgjMjuA0MyeePs3MuWbvD04U/7mU0S+TZnsF
         r44fqIA8YjcAFNhl+riwi9FiTorgmVAzdJkn4FiQObbEnMusAZWpQ8VUEUcXmj9YLmNI
         m/w9FCWDkvVnqRAFEm50RpP2AxsYorvzpfwg7fWVm0dmehgxtqmNMOEco/gFliM2k48o
         rb8w==
X-Gm-Message-State: AOJu0YzlyhOpCxrUR+kkGxtl63GzWU/SA+JCQBWOyezysmzb7i34RgWa
        mWlG+xjgSCiPMB9xMkadd67EPQ==
X-Google-Smtp-Source: AGHT+IEGJ5iYsTvFrjTZorn1/MwkkSYEnSuscp/ZLU2pi2M1jcJ955V1my91fjw6E7prxIYt4wTjYw==
X-Received: by 2002:a05:6a20:8e13:b0:18f:f57a:e761 with SMTP id y19-20020a056a208e1300b0018ff57ae761mr12774382pzj.63.1702552625048;
        Thu, 14 Dec 2023 03:17:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b006ce5b4ade28sm11799418pfq.174.2023.12.14.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:17:04 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:47:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency
 scaling drivers
Message-ID: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-5-fusibrandon13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214103342.30775-5-fusibrandon13@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> Add Kconfig file for cpufreq scaling drivers that can handle RISC-V
> CPUs. An entry is included for the Allwinner H6 cpufreq driver that
> works with D1.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/Kconfig       |  4 ++++
>  drivers/cpufreq/Kconfig.riscv | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 drivers/cpufreq/Kconfig.riscv

We don't have a separate kconfig file for each architecture. Only if
there are too many entries for an architecture, we add a new file.

-- 
viresh
