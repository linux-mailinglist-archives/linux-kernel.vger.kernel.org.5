Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259A7B76B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbjJDCul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbjJDCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:50:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA51B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 19:50:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c61bde0b4bso13834205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696387830; x=1696992630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOKVkRIlUClvH6h3CIZ9FG68iZnhspFEEi3dJ7aEfBQ=;
        b=W9+GdKXGbiPLPbfqZZoL6XVKh1yFhaXDa/Md5Nht2t+nYIK1Q+CwkkwooLsXIMp624
         URJCKtT4VRXCphDcdPAaDFIRZK3MDL0ywWyrGIPWbFwA4IcsAKtTNCjLQ9TTh5Xe6Wd+
         GZ3bEMpmf/k4r/8IAU3ZTMwWyRRYNjm1iy9hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696387830; x=1696992630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOKVkRIlUClvH6h3CIZ9FG68iZnhspFEEi3dJ7aEfBQ=;
        b=qm0rOZ7AvC53REhNslFXflk+fd4oU46urANP3JCM0hwD6TDOUEa2cprfocM0KS8Xn7
         Goz0Mc7H4XPhndC39KPgfHoHdXMjM3aSgmRVJDwwuxvgDoH6JzOR5IU0iy4wAMGvPexf
         b/cs+cRFdxdzPDcoLYJyXt2ZWfLufQC0tFOkljMDK8ZgrabjRQ67Ei5gE7zATjdQslCY
         VlxJg6X1FbjXITyiab+t/o6Orr6rtk4B0YOQIw2TXzijIlhWasTe2a8EIJPyk9eA2cq6
         ohWw4YUG8FvE+24ppHD9twd+1dUPzifSvw4/sEfWAEdjCl1O+RQLnPnMiqJ9ZXvqzSeQ
         VcYw==
X-Gm-Message-State: AOJu0YwWTJ4ZfHVt4wSM74KwbwRXDbPsmBLtR3eSKIl0Tb08Ww2UmFPL
        JLnGxxibbTF+gtqnZgTg+pilYg==
X-Google-Smtp-Source: AGHT+IFddbMh8XutvwSJLmRf9/pBtZw2ENY3tPF1YiGdt60Sf1BbxQalDpER/veXlhndYyU4KGa9GQ==
X-Received: by 2002:a17:903:4284:b0:1ab:11c8:777a with SMTP id ju4-20020a170903428400b001ab11c8777amr1325242plb.13.1696387830493;
        Tue, 03 Oct 2023 19:50:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001c731b62403sm2349948plz.218.2023.10.03.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 19:50:29 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:50:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Ott <sebott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the execve tree
Message-ID: <202310031950.E698038489@keescook>
References: <20231003133522.310bda60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003133522.310bda60@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:35:22PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the execve tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/binfmt_elf.c: In function 'load_elf_library':
> fs/binfmt_elf.c:1323:37: error: unused variable 'len' [-Werror=unused-variable]
>  1323 |         unsigned long elf_bss, bss, len;
>       |                                     ^~~
> fs/binfmt_elf.c:1323:32: error: unused variable 'bss' [-Werror=unused-variable]
>  1323 |         unsigned long elf_bss, bss, len;
>       |                                ^~~
> fs/binfmt_elf.c:1323:23: error: unused variable 'elf_bss' [-Werror=unused-variable]
>  1323 |         unsigned long elf_bss, bss, len;
>       |                       ^~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   f2a1e5fab9ae ("binfmt_elf: Use elf_load() for library")
> 
> I have used the execve tree from next-20230929 for today.

Whoops! Fixed now. Thanks. :)

-- 
Kees Cook
