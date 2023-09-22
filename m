Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8147AAF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjIVKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIVKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:03:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53288F;
        Fri, 22 Sep 2023 03:03:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-321530de76eso1719744f8f.0;
        Fri, 22 Sep 2023 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695377017; x=1695981817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBcsfPRS8DaMT9oS6VIAEGSvywjj27gVzR+KeQ+aIHQ=;
        b=Wx8KCIzGjxkVaSbAoPKUhs4C7lez8kc5/HRVazgKt8c05a9YvsK/Hk1vCTChCJTnkk
         m6nil4RFbPOuv9usuw/M+5+oibCooXi5XgbNeKk243IvKPSjBxR0RzZILzyrhjtUGRrF
         AXBMEYGUD25eQ480Pxm5iJTWC2KPXI3Qd0qgh8PM8jCXOZWLivrtbBv6azN4WS4x8+IW
         NMVFgtB6DT5PlE5yZen7PfTzYu0DH0vXvAa8c31AhbXQ2KButpKmelVd88Z3QCzTSUJx
         1iVHI7AdmammtvvsIQlgDg7LT+1p1yLMR+SXmwwZsckrTbo3qwE7FNgX7IPpBgiNOxle
         4qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695377017; x=1695981817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBcsfPRS8DaMT9oS6VIAEGSvywjj27gVzR+KeQ+aIHQ=;
        b=uB9DEeVuWUVNgdsjfT1YEm55Leh0HjylLhf9Wq1DM+YOjpV/5oVJv4qpGrVcMmS1CD
         nmK40knZ1A2C0Gs4evTJ6tM42taU1btU9ZTLOvI+t9qpS7bWRkE3KOzDdWmG1cwkJ9NK
         9UI/UAW6ghJFXogqhVHy73J0UnthDOTlL2+3S7Nxz8xjIv1IjpoNh+KEWCJi9AtWv5Jm
         BVbuz/vYUYW/07HSIfL92ry5SAROrD8WR5P5bK7m5d8BnW+7SPDJWxFJf8AotdfY/HN9
         9W/ZiYmTauWpp0+7p27sjPu7JL2UumRfIcsgiM1VXsmEtnwweXWnJpGcbve9tM7/xMtm
         jyqA==
X-Gm-Message-State: AOJu0YyObUfLs5f+Vy14XDy85luhv6uQK5Dtq7ZxKR3j3lvDE0Ji1DJy
        lPE93DDylapshNONHrf5VAHe4baBTws=
X-Google-Smtp-Source: AGHT+IHXNhCOVDN22ezuRhafl1JdUeYEasSvslBktkV+8XLJPt5Xn0a/NOQMNgS1lkaRklCIO6julg==
X-Received: by 2002:a5d:59c3:0:b0:322:dbc6:8cf7 with SMTP id v3-20020a5d59c3000000b00322dbc68cf7mr2196407wry.16.1695377017142;
        Fri, 22 Sep 2023 03:03:37 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c21ce00b003fefcbe7fa8sm4217852wmj.28.2023.09.22.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:03:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 12:03:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, leitao@debian.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, leit@fb.com, dcostantino@meta.com,
        jhladky@redhat.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: rom 3540f985652f41041e54ee82aa53e7dbd55739ae Mon Sep 17 00:00:00
 2001
Message-ID: <ZQ1mdoMBJd4PCvZa@gmail.com>
References: <20230914140604.267672-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140604.267672-1-sandipan.das@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sandipan Das <sandipan.das@amd.com> wrote:

> Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
> handler, as shown below, several times while perf runs. A simple
> `perf top` run is enough to render the system unusable.
> 
> WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
> 
> This happens because the Performance Counter Global Status Register
> (PerfCntGlobalStatus) has one or more bits set which are considered
> reserved according to the "AMD64 Architecture Programmer???s Manual,
> Volume 2: System Programming, 24593". The document can be found at
> https://www.amd.com/system/files/TechDocs/24593.pdf
> 
> To make this less intrusive, warn just once if any reserved bit is set
> and prompt the user to update the microcode. Also sanitize the value to
> what the code is handling, so that the overflow events continue to be
> handled for the number of counters that are known to be sane.
> 
> Going forward, the following microcode patch levels are recommended
> for Zen 4 processors in order to avoid such issues with reserved bits.
> 
>   Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e
>   Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e
>   Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116
>   Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212
> 
> Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
> the linux-firmware tree has binaries that meet the minimum required
> patch levels.
> 
> Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> [sandipan: add message to prompt users to update microcode]
> [sandipan: rework commit message and call out required microcode levels]
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

> v2:
>  - Use pr_warn_once() instead of WARN_ON_ONCE() to prompt users to
>    update microcode
>  - Rework commit message and add details of minimum required microcode
>    patch levels.

1)

I don't think you ever re-sent this patch with the correct subject line.
( Or at least it's not in my mbox. )

2)

So if the fix is from Breno Leitao originally, then there should be a:

   From: Breno Leitao <leitao@debian.org>

at the beginning of the patch to make authorship clear.

You might also want to add:

  Co-developed-by: Sandipan Das <sandipan.das@amd.com>

to make your contributions clear.

Thanks,

	Ingo
