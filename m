Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9367D04CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjJSWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjJSWaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA2112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:30:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so225420b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697754602; x=1698359402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRjIelt0NvMM0M1d/d7SNIFGl4vNvYKXYEnzgIUJnYs=;
        b=C6EzM1z2/qOmEjQwnLVUD6fFp3TMFlWZmERJKwIlQ1h+zJrsFGH4bUeHahRWa45ZFL
         DDibLxepjjVWiwQaQmDLTje2a7V9XvZdTTDD2IZvtf2ZtuPW8rVWQLjR2aWGV/3/Ulww
         cmfV3AVASM79Pt0qexxBttWdhcfnz1wMbl0cOOkF7keLh0bIQJfXaWEaT0JAZtLjs38X
         H1DyNy78AvtVDt4RAQyKymhubF23RHy28yXFw2tzlJubXgkj8J7O4/pr8blowyksHTj3
         6UyRCA3m96x11yVZMmMk6Gr76pG+PGmRB9PT1Q00Nj0XEW21V0nK8OdblbkP9DgwtEVz
         VX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697754602; x=1698359402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRjIelt0NvMM0M1d/d7SNIFGl4vNvYKXYEnzgIUJnYs=;
        b=BpCIIyT2REMS4j0fFkmH5fGLm8bwLJFiXAXsnj3cSzp0IyvZKTAwx/J1tZJ8OfbtW9
         w7ANnWFl7giHO96zJ42RSFeTY1/C0fzNMJ6hgen5oSmBUoeJv8Iql76V+40zU81XAfAX
         4W2xUiJ2J7ssuY48Hbz0ZYExQMOkh4oa9dlo7hWE8UMbaa1trYRn9/Xwru5FXXOqLZAt
         Qai8q/M08HgW93Ep0hDf4Gf7jRUBZjJy5E16FIgPzO+T9n+NspayvA/L0fW7WW3/ulwW
         3Sp+7z6N0K/9z1SMoB2SLuK/T7LPxxAa2srVVkmcSJTU7UKYEyjmOClzLV1Q+tD8ywOG
         YKbg==
X-Gm-Message-State: AOJu0YzuBIhEO37WNaAqqBGTrFwYL/GoPvAQpI8ZO6vgpm4jqyjyYog7
        9JjiliuFKIwMwcticWnbvbbMsg==
X-Google-Smtp-Source: AGHT+IGqRt3QfdHDEQzWg8DelpnAR4WjGTh1rMCz0gWhDqk5+5lC5+0yN1Art/nA5SMK4FbwToWlvA==
X-Received: by 2002:a05:6a20:12d4:b0:15e:1351:f33a with SMTP id v20-20020a056a2012d400b0015e1351f33amr139118pzg.47.1697754602124;
        Thu, 19 Oct 2023 15:30:02 -0700 (PDT)
Received: from [192.168.60.239] (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with ESMTPSA id f10-20020a631f0a000000b0056b27af8715sm248681pgf.43.2023.10.19.15.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:30:01 -0700 (PDT)
Message-ID: <738df245-e7d1-4fc0-9076-3ac5afebaa44@google.com>
Date:   Thu, 19 Oct 2023 15:30:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
References: <20231019185319.2714000-5-arakesh@google.com>
 <202310200457.GwPPFuHX-lkp@intel.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <202310200457.GwPPFuHX-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 13:32, kernel test robot wrote:
> Hi Avichal,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc6 next-20231019]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Avichal-Rakesh/usb-gadget-uvc-prevent-use-of-disabled-endpoint/20231020-025512
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/20231019185319.2714000-5-arakesh%40google.com
> patch subject: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310200457.GwPPFuHX-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/usb/gadget/function/uvc_video.c:231: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Must be called with req_lock held as it modifies the list ureq is held in
> 
> 

Greg, apologies for the newb question: do you want me to upload
the fix for this as a reply to [PATCH v6 4/4], or upload a new chain of 
v7s with this patch fixed? 

I am not familiar with the kernel merging process, so not sure 
which one would work better for you to pick up.

Regards,
Avi
