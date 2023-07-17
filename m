Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE68756B48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGQSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:09:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5EE60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:09:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad8383faso38406605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689617341; x=1692209341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkJFntKWbGRpv5Aq0XnB+WBvdM8xqNaNAOxWsG/ttJc=;
        b=JYfdQdmjmQ4tShNoTk8QuVCu+Wzv1ElsLHCJEBcggEpe20lS3Vz0E+PAhNFG7Lir0I
         LaH29W8GwcsTLY7MOdU8qtlPN9EHiydRdJ/tAhdqFIFp6XZ3ptzNyuiqhr/iuyhSdi6w
         RhtU3BRInR64hZo/2HnnU6Qz/Y/wSlEu1IOCDlYn1Tlqdxw4XZ0UNoEw3j8b03TJMbu3
         xNpHSSdPQgimdzbUq8LWACZit2Lf6rpVNylijSpXfRfwtTKbT/CX4Bw6/JqNo+RIfGdC
         iYswWScbX404yuAzD8wvr0yrj4czeHJ9hpBaWV7x22FaZkJIwU+YN4S13HohJkVi4T38
         ZKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689617341; x=1692209341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkJFntKWbGRpv5Aq0XnB+WBvdM8xqNaNAOxWsG/ttJc=;
        b=AZTm+1qUx3AFOG9579Rp2pzxLoBkqEehq37ThTAKrFE9jt1Qazw+/ALnpmReE/JqAl
         eGK6rBL2QoXrZCr07Ki6kYyddWKuzWgxMbsoz0zV1AZNpXaXvorkv0PaQchXzYFiPJWy
         HL5RWptQKjt6M20NViX+Lzj7zwv+yGaW4V3jroTyG8t7uG5F0WQ3ovzEMLhToXzi2VXs
         gaUt7YwTax+8NsBa1x18IJ1l1RiPvQEqRqXQmzDy8sbckiG9FCkOPdXvipyaeprE9Org
         Fg4sgK8SEAQtRVWQXjOJ13ZLlFTTLgY5TrJWv1514bLhaWQ7SsY6ovZVHP9wgRkL1llR
         m1QQ==
X-Gm-Message-State: ABy/qLZb826Va1z6b4fSI2TdTycKNDJrs/7njGyG1PP3H1sBTXwbfk6W
        6MGDDyRogrJVGW7/ek4xi/A=
X-Google-Smtp-Source: APBJJlGUo4U5ojubaCUgkg9GuGZRoSrhAhPcphyxYJZPsULhCCAP4ZvI6gWHkQZ6dRdI9/2NsQ/gkg==
X-Received: by 2002:a17:90a:dd93:b0:263:4962:94c6 with SMTP id l19-20020a17090add9300b00263496294c6mr11842336pjv.20.1689617341230;
        Mon, 17 Jul 2023 11:09:01 -0700 (PDT)
Received: from localhost ([2607:fb91:1ee0:54da:ec41:ee39:e52a:3118])
        by smtp.gmail.com with ESMTPSA id 95-20020a17090a0fe800b00265dc26d8dfsm5697248pjz.27.2023.07.17.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:09:00 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:08:57 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <ZLWDuZ5Q5qBnmS25@yury-ThinkPad>
References: <202307171254.yFcH97ej-lkp@intel.com>
 <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
 <CAKwvOdnUjAXg4VRbCBKUOZDCKs-=5aA2-ef1tFRj-P=-1bBjaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnUjAXg4VRbCBKUOZDCKs-=5aA2-ef1tFRj-P=-1bBjaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:35:49AM -0700, Nick Desaulniers wrote:
> On Mon, Jul 17, 2023 at 3:04 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Jul 17, 2023 at 12:42:57PM +0800, kernel test robot wrote:
> > > Hi Alexander,
> > >
> > > FYI, the error/warning still remains.
> >
> > Alexander, either you can escalate this or just propose something to discuss.
> 
> https://github.com/ClangBuiltLinux/linux/issues/1874
> Sorry, a few more fires have popped up in the meantime.  Regardless of
> changes to the compiler, we still support many versions of clang for
> the kernel, so we'd need some workaround in the tests regardless.  I
> saw there was already one for s390 + clang, but from this report we
> will need another. Feel free to use that link above in comments in the
> tests; we will clean those up once I have a better grasp on what's
> going on with the compiler here.

So, it's:
 - not related to bitmap code,
 - not only s390 issue, and 
 - fires with CLANG when GCOV and KASAN are enabled together.

Is that correct? If so, I can disable the test for CLANG+GCOV+KASAN
configuration unless the above is fixed.

Nick, can you please confirm?

Because it's a build breaker, I'd like to have it fixed in v6.5.

Thanks,
Yury
