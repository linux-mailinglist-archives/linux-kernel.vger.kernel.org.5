Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE227D5D16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjJXVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjJXVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878810E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso32565595ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182350; x=1698787150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnI8XGGBa5Ged2dlOjjAPxHj4mUm8WGd6bk+tJs2a3o=;
        b=hGvj21ZX5i24BDdFA6wdJ+Sf552YeLV5EGHpryoOLIBxt8rAGWQGd60subTVaCtUiJ
         RnT98PQPbfhxkFudULTtEugqlSzZuXt9qqa3DyWSz0j50s4YX73PE4NfmAeg8uO+SC88
         JqkUwSaPuYMhF5aPc2a5SJohc+Lnwgo7O7CfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182350; x=1698787150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnI8XGGBa5Ged2dlOjjAPxHj4mUm8WGd6bk+tJs2a3o=;
        b=bL90/zvkcc80CM8g3UwzRgua9s3WmM9f5HxdYWqxTfnu9Ib3AQ+Af6VlXfYJolNr4+
         NoUuj0AWc1oAUNgXU/434zz/ORDPc56WSNNb8DA8uFYQ4UcVKKiu1BSkrtYPy+W+dp4Q
         N1366dHxYLP9cAhp25qGsXH+EQhbHoyeiSxVP6j83M1f/u7siuY0h2+WeUdDC0k5DC4M
         5sh4Znht25ZFEgBD1BGwCCFa00qbowGERZF9NH5nkWh3YiYXm558i6O7lVRzE25fPaa/
         iLZkYyEMNABZj7ELdM61kxLMN1rqsx0MPsEvdyip6OpeXqp/zLC6wCR5jnGEhHfi69NY
         CyQA==
X-Gm-Message-State: AOJu0Yxd7ZHYKz2Hdi7r0V/62Yh1ZgOlYHkzUizUOVhVL204UJduuwGR
        8X3OyzQ+7Dp5eA2LuO4EO2LYjg==
X-Google-Smtp-Source: AGHT+IFLiNPphz9TGJutCgbcHvP4j//UbtA+4B8E1BmP+ZRyb2spD6/OWsEDhqeuX4bWNmF8o1WI2A==
X-Received: by 2002:a17:902:e747:b0:1c9:bca1:d70b with SMTP id p7-20020a170902e74700b001c9bca1d70bmr14578120plf.39.1698182349784;
        Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bdb85291casm7807107plg.208.2023.10.24.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] reset: Annotate struct reset_control_array with __counted_by
Date:   Tue, 24 Oct 2023 14:18:55 -0700
Message-Id: <169818232966.2100071.9153679108451026314.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175229.work.838-kees@kernel.org>
References: <20230922175229.work.838-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:52:29 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct reset_control_array.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] reset: Annotate struct reset_control_array with __counted_by
      https://git.kernel.org/kees/c/fed2ef7abaeb

Take care,

-- 
Kees Cook

