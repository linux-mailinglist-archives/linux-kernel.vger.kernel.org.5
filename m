Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51D7FE4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjK3A0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 19:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3A0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:26:34 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396891A6;
        Wed, 29 Nov 2023 16:26:41 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c19a328797so348864a12.3;
        Wed, 29 Nov 2023 16:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304000; x=1701908800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mfHVkbJfa0IzeYbRVGEK3uhGnyMrdpKqs5i/JayJSA=;
        b=lgt+HD1Dk5zFpt9tBWYQ0OPXjzUPrEA5vOTWVw74E7aRBuQrUQOC2zb5E2AtvsbIEl
         9LHHOkWLfRPiAkXpKI9rUllmv4wMT1KXVtWjJQb9/gw7RrLb6LRLr48QfxoSRLCLd8bV
         ZrJbdLfQYOXp61um3WWAI+dR8Hw62qDN+CYIXz50xDUC3NiMlY4uLJurconsPd5hSHNP
         eBny2scMnFEegY3kAVxtPbnBZY1JMYbDSFp15CQ+83BmpN3YV489KOd1fjSCNqc9Sqfv
         nORBVNkaoIGJgiRUBLLEDR8rBi5YYHVpOww0yISwQLVTEOwRy3FV+57Wk2YEmbHXuUww
         X3vQ==
X-Gm-Message-State: AOJu0YyONYU4otFQaZNz6tqpR/cvyAyJacEXUFvyN3lkt+iX7pOQW0sS
        4Kin3Z7trW4/9jzGYhRx+I64eYuf8m8QRTxQjpiTdC8HYkU=
X-Google-Smtp-Source: AGHT+IEMu3Pds/HHk6JlO307HXPc18MkaIca8Nr4tDqCqffNMGJZnaI1x+rjESGOU/atrN0vG4b4oLI2Jyy5pJFK5kw=
X-Received: by 2002:a17:90b:4f8b:b0:285:b6a6:c40b with SMTP id
 qe11-20020a17090b4f8b00b00285b6a6c40bmr13562414pjb.42.1701304000577; Wed, 29
 Nov 2023 16:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20231124102857.1106453-1-james.clark@arm.com> <20231124102857.1106453-4-james.clark@arm.com>
 <6bb84dec-42de-431a-b2e2-ebb532e0375e@arm.com>
In-Reply-To: <6bb84dec-42de-431a-b2e2-ebb532e0375e@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 16:26:29 -0800
Message-ID: <CAM9d7cjvJy21G4E04_eN8wJyOSwped-q60z8hLjWZ+N8n4Ua3w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Nov 26, 2023 at 9:50 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/24/23 15:58, James Clark wrote:
> > Add documentation for the new Perf event open parameters and
> > the threshold_max capability file.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
