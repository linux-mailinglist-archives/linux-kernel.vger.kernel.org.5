Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A0B7F3728
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjKUUNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:13:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CC191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:13:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so6717834a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700597580; x=1701202380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ6QGEjTrenF8EHQmtVmaAKkcU0S8NoyNhhDrtpW+ZM=;
        b=hKMnkWXbOAxLEqL83y8x/V38h1D0n9l8sWoXLWf5IPDjpCr14BGTErCXHTClklx4i5
         oaj7vXoGWzGMYLnXBkknFoxQZXr8Q2bqsS5qlqLjWbHeQrBBJ990kmeTB3kctrb6TSj9
         28mylqoM3G/d/0JX0Vg0Z8NDHIX+U214D94GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597580; x=1701202380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJ6QGEjTrenF8EHQmtVmaAKkcU0S8NoyNhhDrtpW+ZM=;
        b=jU9oFkecBR+K+/YDDtp+/Rwzwzk4yuPOrHARNk/nJ8LisA0lPsqZKUDFmJNRhnQ1Tk
         s0Rm+weI3EHgkqiNogP/8xm2HgbD0LNImCrC8oNyzHQEPlV3HhX4LRlRSSTR4xPmGn/R
         nz+wcXV7PwVxWo4LQ961hn97kCUvyF5IIN+AEOOO4Ifesdw9SKbHb+F0hriIONfb/Zsy
         aF+P1lPxDBEBuD8xewLir0vWcj+/MWtN3BjV4Y6vxT4f2Dn1YgddbzKYhHEXOdwZRB2n
         eqem9wOdKznC+TUmLvsun0HOat2yQy2LAB21+QPTM9/riUAdqV4EJ/wKBe0D3r7X50jV
         cWNw==
X-Gm-Message-State: AOJu0Yz9bq0vHCVhTvEGAsp1rqSVODAJzpZjA2XFUfGCZUt3yiNIvJgR
        x2B6y2c20an/43K2q5XxDrnhxI8/V3BMnFPX9WnRVw==
X-Google-Smtp-Source: AGHT+IETSm6mc/gp6bZg7Z3K0TBlznDNTVeDBhdYgTgPabn8zRm+j5GCRut/d45ro318ppKP/EUVrQ==
X-Received: by 2002:a05:6402:2d8:b0:53f:731a:e513 with SMTP id b24-20020a05640202d800b0053f731ae513mr295939edx.25.1700597580195;
        Tue, 21 Nov 2023 12:13:00 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id f10-20020a50a6ca000000b0053dd8898f75sm5414240edc.81.2023.11.21.12.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 12:12:59 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so8332138a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:12:59 -0800 (PST)
X-Received: by 2002:aa7:c696:0:b0:548:564d:9597 with SMTP id
 n22-20020aa7c696000000b00548564d9597mr287902edq.8.1700597578794; Tue, 21 Nov
 2023 12:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20231121010318.524570-1-nickrterrell@gmail.com>
 <20231121010318.524570-3-nickrterrell@gmail.com> <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
 <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com>
In-Reply-To: <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Nov 2023 12:12:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
Message-ID: <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] zstd: Backport Huffman speed improvement from upstream
To:     Nick Terrell <terrelln@meta.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yann Collet <cyan@meta.com>,
        Kernel Team <kernel-team@meta.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 11:59, Nick Terrell <terrelln@meta.com> wrote:
>
> W.r.t. do { } while (0), our older Visual Studios CI jobs failed on the
> do { } while (0) macros, because it complained about constant false
> branches.

Wow. That is some truly incompetent compiler people.

I mean, really. As in "Why would you ever use that kind of garbage"
incompetence.

Honestly, any coding rule that includes "don't use the do-while-zero
construct" is actively broken shit.

Please just fix your upstream rules. Because they are incredible garbage.

               Linus
