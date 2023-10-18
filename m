Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B77CD9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJRK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJRKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:32:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24811A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:32:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083740f92dso9536475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697625146; x=1698229946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsiPnpSACr9B+lnlwbErKj29RaM0XAz/xPYHLf8w0YA=;
        b=StZFcdb2oiqD02YeQN9ixMofOvhyf3zaLnK0vUq7q02798b1I+k+niNHeRfjig49IO
         iuqk/B2ObgF6vbaQTNCntrirO+wL34PEV4aFAZ91Ta+T7DXuiqXdGT8+qY1AzKTL1I1Y
         M8Hp+FFKO83wo/Opf7hf2StH7qQuD2afJ03v/Z2XHVo2im2jNc+Tj/Qo17n87pI/JE/f
         x46DcHrQFvZooPJ1mw8QcntiKDRAZH9lDFLYlCYVAFpmszLrfZscWYQ14MP2Lgf5bOH5
         7ZCKrtvMTQOfvI3SQ3kVVsoPIWeWJSlawhC8Cdi3p/BQWhpNosa1ZOXjerGxjb+GgNAX
         HK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625146; x=1698229946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsiPnpSACr9B+lnlwbErKj29RaM0XAz/xPYHLf8w0YA=;
        b=PkRFDejxnBPjtcS3D/+uqA6W9BoWbyMckSk8R9v+7Bxpusc9TMBSqSx27kauLoy1h2
         lScEeHuBhDQAF+BpVy0FtlY52vkQ7z+eWMX1QXYanHG4ZyRbJYg3IBGJFia1hD62rFKP
         oYit7nVUhC6RDVeUQKzqyxjSxVfnPPxWn6hqv7Iy8wa7CK0yH17VmfxemOFAcAOhyHxY
         BRotBl22P5zi95ukjSlZYHE0XHmNu6s7yKJ8YPWS9fAQVgdsYJfKJAE67J+50g/PZ8q+
         kBAj25km2EHim0RGg6dCXmk4YqrMqlJuK5POTNAv4dTSP24EW6J1QWag5wcQ971OgaiO
         DhFQ==
X-Gm-Message-State: AOJu0YywMs09db9ruRl+sgMPkTnECGaEPUD6J9WleYWYlghlyFb2qdoP
        kI7vg+WSbU6YbG7FZmJZu0F4EWjvGqOSzjDEppU=
X-Google-Smtp-Source: AGHT+IHcrwjdRkE5UPJdS7rOGC82f4RgDgBOYpmwPQMMUj4HIKQ5pdH5V2CaRMgoGmuCxZRJQM7h5w==
X-Received: by 2002:adf:fd50:0:b0:32d:87c8:b548 with SMTP id h16-20020adffd50000000b0032d87c8b548mr4100977wrs.21.1697625146265;
        Wed, 18 Oct 2023 03:32:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4712000000b0031984b370f2sm1798863wrq.47.2023.10.18.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:32:25 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:32:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     oe-kbuild@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
 <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:54:33PM +0800, Baoquan He wrote:
> Hi,
> 
> On 10/17/23 at 05:26pm, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
> > commit: 4c91c07c93bbbdd7f2d9de2beb7ee5c2a48ad8e7 mm: vmalloc: convert vread() to vread_iter()
> > config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
> > 
> > smatch warnings:
> > mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> 
> I see the code deficit, while the reproduce link seems to be unavilable.
> Could you double check the link and provide a good one so that I can
> verify the code fix?

Here's a link.  :)

https://repo.or.cz/smatch.git/blob/HEAD:/Documentation/smatch.txt

Just build it and run:

~/smatch/smatch_scripts/kchecker drivers/whatever/file.c

regards,
dan carpenter


