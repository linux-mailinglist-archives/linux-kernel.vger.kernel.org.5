Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557087DCC14
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjJaLqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjJaLqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:46:11 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844D97
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:46:07 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d09b6d007so38288116d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1698752766; x=1699357566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RyJr69Zjkg4/uGgk720yPGxk6Fi/nOg06RfMojBpdE=;
        b=VXANg8GdP4W9YDhfLRG4D4er9me3m3U8EhriPO3RC6qTU+FruFkF0WpkTvmisDLm7B
         ZIQUQnjnok8Tu3zhjIypEst+GVp9eMbKIJ24MgvqJEKTD4CV9X39jpNZcgwCT6CMEXac
         cTi4Yismv4x/EouGK5pDrlekyLv0M+QVSplvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752766; x=1699357566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RyJr69Zjkg4/uGgk720yPGxk6Fi/nOg06RfMojBpdE=;
        b=vCKyHw+iyxLP9ZVNmpWW/INm5uM/2OxeYS66u8rzY5HYpJBpU+rXAAod5UC3wvyA85
         IZCnsZ5pRqHxPwPM933mY0KrPht64W5p/rdaQyFfy6sDBwfaAEEp3FzVZoQP0Ps+y9Op
         IwGYsMQH6JzpX1K34zEvkb411EW1R3kTmtzfVOjW533fWjEzv+ZkhXqZDATxwYj3hUg2
         NJodEtPbLPL/ZnBgNFpriUZcxaNv4Ha2iZrjHa6q14N7pz9ULv90O20E+7pqU24ssAHU
         SBbuNWHdRRGEig30tgZfUSTDIW+lFzc2hdb3cfp7ik9tErJRBA7RBY/7vnb1gnzfFiGI
         frMQ==
X-Gm-Message-State: AOJu0YytwLOZtp7g6X7a+0quM7wcj34K540D2wofdcmXHcvxk1DrLkQO
        4uoiWXiaEGPnhX/A+uoQ893cVK2N3N2RmT9qqNQbng==
X-Google-Smtp-Source: AGHT+IFTS994PF2eivbjl4D87zli4XLFKRYnso6wsgAbR5iJm+HvYpJK5Qak0c/vkJYa00RCMxjYZw==
X-Received: by 2002:ad4:5aa1:0:b0:66d:1b4c:e85e with SMTP id u1-20020ad45aa1000000b0066d1b4ce85emr15585877qvg.4.1698752766592;
        Tue, 31 Oct 2023 04:46:06 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com. [2603:6081:7b00:6400::13d])
        by smtp.gmail.com with ESMTPSA id o5-20020a056214180500b0066d11743b3esm449095qvw.34.2023.10.31.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:46:06 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:46:04 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Message-ID: <20231031114604.GG496310@bill-the-cat>
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
 <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
 <20231030161209.GU496310@bill-the-cat>
 <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:03:18PM +0900, Masahiro Yamada wrote:
> On Tue, Oct 31, 2023 at 1:12 AM Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 03:35:34PM +0000, Russell King (Oracle) wrote:
> > > On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> > > > Hi Masahiro,
> > > >
> > > > Sure, but that is a separate issue, isn't it? We already support
> > > > various boot targets in arm64 but not one that includes the DTs, so
> > > > far as I can see. The old arm 'uImage' target is pretty out-of-date
> > > > now.
> > >
> > > Does that mean it can be removed? ;)
> > >
> > > I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
> > > opinion that boot loader specific packaging of the kernel should not
> > > be in the kernel but should be external to it - even more so given the
> > > multi-platform nature of 32-bit Arm kernels.
> >
> > I'll point it out here rather than Simon. As part of
> > https://github.com/open-source-firmware FIT is a standard and not "boot
> > loader specific". And one of the points of a FIT image is that you can
> > easily support multi-platform kernels in a single file (without
> > optimizing things further, at a cost in tens of milliseconds on a Pi 3
> > anyhow) and with user-controlled security.
> >
> > --
> > Tom
> 
> 
> 
> It is a copy of the document in U-Boot.
> 
> The file was split into two, but the content is the same.
> 
> 
> [original in U-Boot]
> https://github.com/u-boot/u-boot/blob/v2023.10/doc/usage/fit/source_file_format.rst
> 
> 
> [flat-image-tree]
> https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/chapter1-introduction.rst
> https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/chapter2-source-file-format.rst

Yes, it would have been a bad idea to change a 15 year old format as
part of getting it included in some standards, and we'd also recently
cleaned it up to rST. Similar comments would I expect be true of turning
grub.cfg in to extlinux.conf and all of the organizations that has moved
along, and anything else that wasn't developed by committee at some
Standards organization.

-- 
Tom
