Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30A375E3FB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGWRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGWRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:10:37 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C25B5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:10:37 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b03ec2015fso2641150fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690132235; x=1690737035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgyTeqzzEBTgMPq8o2Ksi8juxN+B8S7QtSriz161NTk=;
        b=CndI0q4jZmZX+yEgkciWpQorfzd1k1dDevtdwVzqOqEOX3QhBFQxwzG2K49nXro12Q
         STMfrBEGeTUW1BpmHZyVioaIAxqQDnje468k53THnfue214Fv9W7gTI/Q22zrk/gvdlj
         fDDs3urkmL545jlsIrW8VeVvoOaCsRbZVfZHEMpOBpCv+0gy5iHTMOzV22sum7VyI+80
         zDnd3uMuq9bgYGSa3oCF7fI4taYITLcLswzvYLzxD7ogFNNzcbAGhfljCjqFW2GYej7j
         YlLsIORlQXELLhAwM+ZYFHP+xJkwVtdHUjrYLDzk8A//v6WM7++fwWFE6FDyC13lpAQY
         Lr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690132235; x=1690737035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgyTeqzzEBTgMPq8o2Ksi8juxN+B8S7QtSriz161NTk=;
        b=kz70FugxlQ0NIPG3k0NYMyvT1LUMhtXiSRp1rMg2N+DGbTYMBzjjaVNwlTDxVHL6lL
         fdE91yB3gKkibpaXXWTxlHAec1Y+QOz3x6MnE2TbuXsan+4gERyOAgXcNsk1OAU+aT1Q
         MIWmJJLZIh/YXGmRvkQ1Hj92VvE5byBxWQYQfdkNmY1M7nQYenZ+nPkiiziyt54njs0U
         K4rolI2Patj1sWp0mnvSbk/z9uBqlCmu6W+fP0jh/9+mw4vDtXNmkBgOSQ+BxXOVfjIi
         wcMp+HrVqupoHPkEIEJHDTt73W107c+bIPPj9mFKE+lowT3eMv31F2iZ1E3Y8Coqhdul
         PwMA==
X-Gm-Message-State: ABy/qLb8wrPunJ1kQ11eWtxK3ViQEcTrGf93BcJrXeKnm22ivxywqxnp
        nJtjyJELdxgHyiuOwhZ2Lr9LLw==
X-Google-Smtp-Source: APBJJlE12sMCV2EzMzXjJOS4YAI2oblAQYPP3KokynCvM9eCcrdNQYdLfYc/J1E7WQSVveGVFPhvig==
X-Received: by 2002:a05:6870:a54d:b0:1ba:dbad:e70 with SMTP id p13-20020a056870a54d00b001badbad0e70mr9642657oal.21.1690132235204;
        Sun, 23 Jul 2023 10:10:35 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b0068288aaf23esm6178456pfa.100.2023.07.23.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:10:34 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:40:27 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem
 address
Message-ID: <ZL1fA0p4nFzvTdMP@sunil-laptop>
References: <20230723150434.1055571-1-sunilvl@ventanamicro.com>
 <20230723-penniless-revered-20ab702bcc8c@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723-penniless-revered-20ab702bcc8c@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 05:49:22PM +0100, Conor Dooley wrote:
> Hey Sunil,
> 
> On Sun, Jul 23, 2023 at 08:34:34PM +0530, Sunil V L wrote:
> > Fix the acpi_os_ioremap() to return iomem address and
> > use memory attributes from EFI memory map while remapping.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/
> > Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> Huh, there's quite a lot more going on here than $subject would
> suggest... This really seems like it should be a pair of commits, with
> a trivial one fixing the lkp reported sparse issue & a second one, with
> a more detailed commit message, implementing the memory attributes
> stuff. Doing it as an "afterthought" as part of the LKP fix does not seem
> at all right to me.
> 
Thanks!, Conor. Yeah, I agree. I had the patch ready to enhance this
function and when I saw today bot finding the issue, I just updated to
make it fix patch. Let me split to two patches.

> When you split it, I figure you should CC Ard and Alex Ghiti on the
> patch adding the EFI attribute stuff.
> 
Sure.

Thanks,
Sunil
