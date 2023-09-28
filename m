Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABAB7B26DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjI1UxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjI1UxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:53:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17024180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:53:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so1745942766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695934398; x=1696539198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oarHGigZ2g+kUjj4FbG0DTMQJe2n18jj+wl6eh8aRW0=;
        b=d7n5v+uYkRr9OelsyVFl0SpyDbT4COd2UW4iW4JcF/Lqk/yZ5uco3Mf0uBD7b+2CKN
         UzWhypsxX1ZUs31s2U798kR1/fZh2Gad9GdNuE3Z68TuG7HSCyCryOe2zGnXbRBFgG1o
         bZLDCbYskCuYTPquDM3qr1iDRggKnG8Ox3CBXpZPkP3GNQJ/MxbkGt4JYjoGHlSqibWc
         aYn8o4m2y5BvXMxagIPfV6Wa+TxfmGMi24T99Agi4H2C6wXUpNnDDdDCoYPbOmxE5KJt
         gBotRN1MF9Lgp3B4zWx93/bQxoBblrg5I2a/oGXWuF5jZCDpHEJi2Ut5dFiQdcH5rE3y
         2qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934398; x=1696539198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oarHGigZ2g+kUjj4FbG0DTMQJe2n18jj+wl6eh8aRW0=;
        b=NFo7lroIgko9zSIK+hnyMysex9VOk58ukM0VAEUPACTpL5V4Tats18Xh2lXB8MusXU
         glfNeiAaPiJDDKcrpvmd8v/egtNs0kX6C02RYj9Pgu7uXCDxWQ1PgmZ932KH1NZg+Ax7
         6VSsbKtbTumVrL2RXD6nJc1MNv9Rgoz88twXB8Y9OzYTprvCmtZNS1CLELQpyNFHGMip
         62lomBZcGL8eoNSdN2TwYFn0s97LrddyVyVvWJIijzPp1kenbH1D261Wi0zrQkX8Cppn
         AYQGWWBDB6SwdgWghF3IOqQtB4t0KaBAAvqqhyZCeXi+t3bVexwQKcipUGUyy4vLo8Zz
         ph3g==
X-Gm-Message-State: AOJu0YwrIViLMC20HiUfQ3K1oSm6NR3WKmvunv0I2kmBoF+/SGBuBtqI
        bnhsLN6q9FylPLZ0gM+1Ndg=
X-Google-Smtp-Source: AGHT+IFqC4PlKLBf9wG5aE9nBibQLVWC1Y+zxiLxuz1f3j13EOA9qJ4cYASg/H5Xz4LLfcISv3g3DA==
X-Received: by 2002:a17:907:6c14:b0:9b2:8c37:82a with SMTP id rl20-20020a1709076c1400b009b28c37082amr1972785ejc.35.1695934398160;
        Thu, 28 Sep 2023 13:53:18 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id lw13-20020a170906bccd00b0098884f86e41sm11214113ejb.123.2023.09.28.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:53:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 22:53:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RESEND PATCH 2/2] locking/x86: Wire up sync_try_cmpxchg
Message-ID: <ZRXnu+8gQGVZVA79@gmail.com>
References: <20230925150905.54842-1-ubizjak@gmail.com>
 <20230925150905.54842-2-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925150905.54842-2-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Implement target specific support for sync_try_cmpxchg.

Could you please provide a before/after description of how
this improves things exactly?

Thanks,

	Ingo
