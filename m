Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03047CB394
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJPT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjJPT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:57:34 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C333EE;
        Mon, 16 Oct 2023 12:57:31 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c496719a9aso2591223a34.0;
        Mon, 16 Oct 2023 12:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486251; x=1698091051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgQIgwOXkE8+0o51RaJzdyOkFFFWSreK0o8H4z9cVpQ=;
        b=oBP8tHCUNMmU6Y5Dsm7+IRSZcaQXEN/QXztM+NI0yVY4a995zbfQ6Eb8JlOqstrluu
         nDglt3jQqcTizE1VDxk0E97Ft72G7+CUr6A2+7VcgWk6oArXVu8/BduW4MDlp7Fz3q6x
         chqM2FUOhRstCSMlCUPA9o7CP6QHTo/sd0hsPgO3B8OUu7DlWuC0mKRsSzAhGVgxvwa9
         1dudLMmpfqxE1JstV96Dxgg/AgWuPN4EF81ZmMu4VNNmgBF5jdb7hH9TS/5h156uVF97
         KIac0/6wR1mz9RoTh8xEfyw82idjqWD7jYETlshGwp0wK/DqqSyfI/gEeFGOmo+/amkW
         D0+w==
X-Gm-Message-State: AOJu0YytsUTDDiOhx1Wtiji7tTPvXbkHh5xRwa2UBH3DzWIg7VTVdIWz
        fuRWE9CEP1lG6T0JWiL0uA==
X-Google-Smtp-Source: AGHT+IGoyMGj6H9sD/fs05ifW6mHn46aUoo5Qt+hMR2U+JvUvpzoojkGcwQxcXOLaOmM0ug4oQUITg==
X-Received: by 2002:a9d:4d17:0:b0:6b9:cfc3:65d1 with SMTP id n23-20020a9d4d17000000b006b9cfc365d1mr218237otf.17.1697486250789;
        Mon, 16 Oct 2023 12:57:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d26-20020a0568301b7a00b006b9348b6f51sm1813787ote.54.2023.10.16.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:57:30 -0700 (PDT)
Received: (nullmailer pid 3575170 invoked by uid 1000);
        Mon, 16 Oct 2023 19:57:28 -0000
Date:   Mon, 16 Oct 2023 14:57:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
Message-ID: <20231016195728.GA3574754-robh@kernel.org>
References: <20230926194242.2732127-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:42:38PM -0600, Simon Glass wrote:
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
> 
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v7:
> - Drop unnecessary |
> - Add a blank line between properties
> 
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
> 
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
> 
> Changes in v3:
> - Add new patch to update the /memory nodes
> 
>  dtschema/schemas/memory.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied this patch.

Rob
