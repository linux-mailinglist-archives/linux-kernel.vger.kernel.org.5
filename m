Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112167FCE50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbjK2FcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjK2FcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:32:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328F19B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:32:17 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso25511235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701235936; x=1701840736; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj4mmJIBUQjwsLyHUMay3Il1zQC/QaufE2Lzb1TCd5k=;
        b=XehcGEKnQllIjLwTV125DL3Q5TcTaQyhujMtSCEIB9bYMk4ynuO1fsPWRACWBwrQ8w
         wAynnqFls6La8FoXFw8GU3wB/5hCCTEOXzzLjtXtYBd+5vSeSEvSbb8R2bGfmk4nf9Sn
         eRxIF4EH8/WJLA+UmiC+xyVEuxslBf5+H7plw4KZ4E0yl8IgqBQ2y0RbZ2zUmlgToUWd
         mn1xzD5wWSACfZ9l5Rjlv/LO0NV9vV+VPnfzD8D8SP2IkmNWBHtxHa3eRu+pbNyWwqqY
         tJ2cPRhYgs+HuAOKnC1hlkPSfobG0tkijodZL5ja18ezEH0nkI7kqy1Zfle1Wf+jrlpn
         KMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701235936; x=1701840736;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj4mmJIBUQjwsLyHUMay3Il1zQC/QaufE2Lzb1TCd5k=;
        b=P79vTL6YeQGaOLGSvXhAkMePoJNzBM4vo1cWcU3UxjCfMfTk2XwROUBelII5U9QZ5f
         EN6aLBzmiNGKrOulXZHQ/Pur/8eX2U/HDJ/vaZPQeI02wOLrZftTgz+kWg3la/7g0oZO
         8xcFaPzqEsMer/b/ycHCApKjJGUmF67e2qTJUqkXZICQualkldUT73EBxrsog8lczwoK
         FIkCXCfVoMuyVGvh9Gncd9t9kX6E7cXXCG0iKee/Cp0vLUCdG3drqCVfQPs95sUhz+JH
         6Re8Z7VNxLUXH5UWa47i+tGAi6T14bl0VN/8VuZ/qrs5uIKWSZcZQUlsIEvLfFFZLmOM
         q8Vw==
X-Gm-Message-State: AOJu0YxlURo9QczTaV8E1Ba9+/5aBnzn5k+G6oCf6bClSf5BY2i1kamc
        OWS+qijqsZjmat2jo0HpfMILhg==
X-Google-Smtp-Source: AGHT+IGFsjXCW/Ho6O60mLG49EAl+1QT8CzD7tPecYI3HFKFAodNBvFnLj0US/gDsjpY2a1LcMzpWA==
X-Received: by 2002:a17:902:7005:b0:1cf:d795:5e4a with SMTP id y5-20020a170902700500b001cfd7955e4amr6885924plk.15.1701235936505;
        Tue, 28 Nov 2023 21:32:16 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5a34:50a0:78b5:5013:4cf4? ([2402:7500:4ce:5a34:50a0:78b5:5013:4cf4])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001d00c25c282sm1236711plb.18.2023.11.28.21.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2023 21:32:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 12/13] RISC-V: crypto: add Zvksh accelerated SM3
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128041314.GK1463@sol.localdomain>
Date:   Wed, 29 Nov 2023 13:32:11 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2E9C9E5D-D03B-4038-AA6F-D30540390816@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-13-jerry.shih@sifive.com>
 <20231128041314.GK1463@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2023, at 12:13, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Nov 27, 2023 at 03:07:02PM +0800, Jerry Shih wrote:
>> +static int __init riscv64_riscv64_sm3_mod_init(void)
> 
> There's an extra "_riscv64" in this function name.
> 
> - Eric

Fixed.

