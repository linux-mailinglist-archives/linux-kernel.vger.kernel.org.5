Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C772975F501
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGXLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGXLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:30:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD5E61
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:30:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b4749013so33860185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198222; x=1690803022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wTwN4pAorOUOyXMOhqG3AkkB1rX6LG3xQzfJKwRVRg=;
        b=jNsDDcu07XuErllFwj90pV3I2k1w7MyPshKAIq/Z3yHNaETTEAOeOG3pkQ75ZOMH0R
         knCMoz8xYQ5YVdvslAatHlEIeDQeIo11halj8jjZXVhxEfaoLZ6ID6M+GrXlGpQozK7d
         LoUChR1wshNuvcdLUhFI92EhZ/7Thb8TFCYXea4CBslP5fIjg3BfzQzG0j5oVosyxKHa
         AashG8/mrhroYzHrAIxoEsIUIMhx39IpseayvF5nN7mOT8UZUyKkYn101WY3KMJYEob9
         PMFZV1pZN2TNkck+9Kqal+lIZyZ3ZGmpmUHsCsso7nUa31iRP3CfE+EzSEbbgGC/7G+C
         q7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198222; x=1690803022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wTwN4pAorOUOyXMOhqG3AkkB1rX6LG3xQzfJKwRVRg=;
        b=DaFmf6uj7FHLoJ9qC+lyYMoqXJ/aeRJediKU7dq2MUFhfbqVKhqJn17aveovjcfv6h
         e/zKl3rrxVC9yRoMyfk1nDjJ0RU0EfvLsZLmORape61pgpqVcpgEPEB/P0fRBe4/gekd
         t3nVYFoeA4ZnV1OWXYtnb80xqUGOrIktxv6VCbyR2a+oFFzECbSaenIod21VpJBmWoRw
         HC1z3FMPhy5dR6azv0oLZszlwn4atr3tJlum+KINKSfcpKErqVA3POs5oO84F1GchwVN
         9FIoMtwHJKb0tsBitoj/MOAA4G+sNIxEdlNqYztQ2QI9I1/s7ow4CRSlYatw+thbuTWR
         yQzg==
X-Gm-Message-State: ABy/qLaM4An0K1G4DNb4y8zn+2q/Uq9wpcHS/LfuKsMUffk8fLkCStXc
        nq7sSjD7QYRXl2zF4VLEISE6Tg==
X-Google-Smtp-Source: APBJJlHiTNX9dGv2bQKMKk+nEIGvhnwrVswpIJsw/BOzGutW/OEVqXS41QvBJtE+Nr5CDCRrAAVJyQ==
X-Received: by 2002:a17:903:11cd:b0:1b8:3601:9bf7 with SMTP id q13-20020a17090311cd00b001b836019bf7mr11217761plh.24.1690198221960;
        Mon, 24 Jul 2023 04:30:21 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152048165.netvigator.com. [58.152.48.165])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f7c100b001b8b45b177esm3627602plw.274.2023.07.24.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:30:20 -0700 (PDT)
Date:   Mon, 24 Jul 2023 19:30:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        john.g.garry@oracle.com, james.clark@arm.com,
        mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, scott@os.amperecomputing.com,
        maz@kernel.org, anshuman.khandual@arm.com, german.gomez@arm.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        fissure2010@gmail.com
Subject: Re: [PATCH v1 0/3] arm64: Support Cortex-X4 CPU for Perf Arm SPE
Message-ID: <20230724113013.GB76473@leoy-huanghe.lan>
References: <20230717054327.79815-1-leo.yan@linaro.org>
 <20230721181653.22398-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721181653.22398-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On Fri, Jul 21, 2023 at 06:16:53PM +0000, Ali Saidi wrote:

> > This series support Cortex-X4 CPU in Perf Arm SPE.

[...]

> This looks good to me, but can we add the other cores that operate the
> same way now too? Flipping through the TRMs A78, X3, V2, X1, A715,
> A720, and A78C all have the same encodings. 

Thanks a lot for exploring more CPU variants which share the same data
source packet format.

The latest Linux kernel have defined the CPU part number and MIDR for
below CPU variants:

- A78
- X1
- A715
- A78C

I would like to use a patch to support these CPUs in perf tool.  Given
other CPU variants (X3/V2/A720) have not been supported in the kernel,
and so far no one requests them, I would like leave them out.

Please let me know if this okay for you or not.


> Reviewed-by: Ali Saidi <alisaidi@amazon.com>

Thanks for review, I will add your review tags in the new patch set.

Leo
