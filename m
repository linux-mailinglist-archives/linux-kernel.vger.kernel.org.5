Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFD7A75E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjITI3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:29:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31157A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:29:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so11021360e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695198547; x=1695803347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0MfWcAb3Afp2pYNnti4RmJ1Qs6ejpeucHp6Vo3y+PE=;
        b=CTUhqUFZgVsJRTyiL2L8O+HMboJUBiN+GE4SVkORlhB631Q74UH5lw2LbT1bzCvZGF
         WSDez2EvOfLVOdxiEmmK3tCabA8m7z5dVXi7tsY5aw68c/8JpMWwL57h4gwOjkGDrZ3W
         EiiUNQ1qUIopAoCY5v/b7F0pneH+DDIN+1AlbPK0cLsLxd2RpsspVmPwFX+66y1p7zoN
         a1VXkznAakGQAh+H6AKzZDb5PWYhwp418/6Vz1vz5evH/kunelVjex6Jl++TlgY0Otfa
         Y32kZw7UVUAfZ3CROQ20noADvCREZd0+WAFRgJ21AbFVJpHqC9RZeeLI4YgO5MfR6O4v
         MZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695198547; x=1695803347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0MfWcAb3Afp2pYNnti4RmJ1Qs6ejpeucHp6Vo3y+PE=;
        b=F4/0SACCifStzYD0OxOmg73VcgNLfdNAEep5yXK1VY/nOWQLX9Kb1vLICzAcp4nX5A
         NNw6vU96eDvUgTJXwlLl600YTx96B65wwur/M18lsUTwUzZQygeGYZkN3D2qfOxCciFJ
         yktU1T6lL0CXE0uK0S4t7Zcs1s3eMsLRKdfIVZCposn2KyfYQ5OzY9uMqBcKPo271SRV
         NqtZ+MYHbgIYnYLIfKoItnQyREjwVFbiAnRAgupH1vk6aBpEbd64/igvWTCNZJGf7NRf
         j7PUhlE1Wm/NZBXUBRx9eWHE4vpc7gUGYLiILOMryg0tPSZfpOVxCgWZBOZPZmhnnzQp
         BvHQ==
X-Gm-Message-State: AOJu0YwJ6vzI42GzHAUqbHokh9vzl2AG49BQr9kKiTop3HDxvjAn6QuL
        o7U1zD2ev6RUGajAzHepM97Uww==
X-Google-Smtp-Source: AGHT+IFBXEnma4H6oseO/7HjER06wVXo70jAGnZqCu1JYR1l5pH2Rsc0xFBFHAXJ7nG8F9xDVJ9kUw==
X-Received: by 2002:a19:6905:0:b0:503:26b0:e126 with SMTP id e5-20020a196905000000b0050326b0e126mr1159365lfc.59.1695198547026;
        Wed, 20 Sep 2023 01:29:07 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z11-20020a1c4c0b000000b003fc06169ab3sm1292246wmf.20.2023.09.20.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:29:06 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:29:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        haicheng.li@intel.com, linux-riscv@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Message-ID: <20230920-645cd4e9612d83768e596514@orel>
References: <20230920074653.2509631-1-xiao.w.wang@intel.com>
 <20230920074653.2509631-2-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920074653.2509631-2-xiao.w.wang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:46:52PM +0800, Xiao Wang wrote:
> Now hwcap.h and cpufeature.h are mutually including each other, and most of
> the variable/API declarations in hwcap.h are implemented in cpufeature.c,
> so, it's better to move them into cpufeature.h and leave only macros for
> ISA extension logical IDs in hwcap.h.
> 
> BTW, the riscv_isa_extension_mask macro is not used now, so this patch
> removes it.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>


Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
