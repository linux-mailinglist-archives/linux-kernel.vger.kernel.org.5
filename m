Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF28789053
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjHYVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHYVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:21:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CC2125
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:21:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a41035828so1120355b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692998508; x=1693603308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4OY3QMtQlW2A8shzjZaxk5Of7hJ4fmFNlBUbsxtkxQ=;
        b=fei7i0uyzl9ptkYyenDgvKj7vBA/GDCxWwYRfjKiD1l8g9jTZv1V5AE1sf3PGmsjVJ
         DymKAFHmwRkvAHeKJEEozluqczr53bD73KTvLcmtPBG/yjUMT1ks9d4gD3X5AOEbStzd
         u4RYm67sqIEtn3WiHIdt0LlfYQhAlx687Tcx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692998508; x=1693603308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4OY3QMtQlW2A8shzjZaxk5Of7hJ4fmFNlBUbsxtkxQ=;
        b=WaOc2/o0ESK4J/mOvPHh6649QZEB29xySjDx9GC3GgzSw4/3XsEJFPuxVXNwFGfroC
         lPQ00y020cx/c9aeGOWlS+8ve9uHlu4YaldIdhvC7YxE+j+IxNGNkB9uzsjZifjvTaVh
         SoOpoYNeLOKHN8pfUr15T+an+9ZLtsPsWc+iMINE2R2i5Pze6ZEf9yAapn0JqtHgY8fL
         Rq6/Cx/xwgBIP7cWstT3Y+v5mR11t7f9CFIWuwrE34YFBgcOwqmPHmx3UP+I5zYK1uAk
         bgpghZ6lLoc3ZqTIri1YJYLOCY7vGX4POIP8DJDBNo/G4euXCe3hopeSly4xWL8GzRz9
         ozwQ==
X-Gm-Message-State: AOJu0YwvYWkvOnphS632oGe9odBSPvWGTaRWb2MJBDC7oGJUlu2ZZ+Ja
        d6mnComkf6MdIO4bcTlBt6oIRw==
X-Google-Smtp-Source: AGHT+IGAd0eL6EeVbMYxqriAmnLzeAiz+RO+l1tdF9fEaU4IwWXUrBlVotMXRKCSDJwtaCSW7sT05A==
X-Received: by 2002:a05:6a21:3e14:b0:14c:5f8:fb3e with SMTP id bk20-20020a056a213e1400b0014c05f8fb3emr5693501pzc.38.1692998507874;
        Fri, 25 Aug 2023 14:21:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001b9d95945afsm2199984plf.155.2023.08.25.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:21:47 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:21:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     lkp@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH] x86/shstk: Change order of __user in type
Message-ID: <202308251419.0EB21A4A@keescook>
References: <202308222312.Jt4Tog5T-lkp@intel.com>
 <20230825014554.1769194-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825014554.1769194-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:45:54PM -0700, Rick Edgecombe wrote:
> 0day reports a sparse warning:
> arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address space
> '__user' of expression
> 
> The __user is in the wrong spot. Move it to right spot and make sparse
> happy.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308222312.Jt4Tog5T-lkp@intel.com/
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Ah yeah, a good find. I with we could sanely use "address spaces" in GCC
and Clang so we didn't need to depend on sparse for these checks. I
tried to get Clang doing it[1] a few years ago, but the wall of warnings
was huge.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=clang/address_space&id=beff911c13390a71b3f7921fd82ec6a71ca75c02

-- 
Kees Cook
