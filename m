Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32C5800FBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjLAPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjLAPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:55:56 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08D19E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:56:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c641d55e27so631939a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446162; x=1702050962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+9aLJpGyu0Q/y7mwBTnwWcmuz7X2zXjBIdqmSWvzkk=;
        b=N+fHmNuMBdBuSJAJex97iOFcMfroAQEN/7g7vNKNXNAV0S6RUHvPifwMoN76hVOmJC
         V149BgvgugDmsGkVBQnvxBE1tSVx0MbVN925TdBNs7xG2AtbXFY0SjwVL5+cY5CExXgn
         l8iiBKXoU10Bc+e7wWl2ONL9liXD44bIU3rfkqhSWKpAzjo27dtjvYVELt44JD1VfkWP
         Q08WGTnTn8SLD62ZhO/MoBFpq/Kr3Ez/gOH0oKtimJV8J9mLTKDSmPWQJjt/EXdJnMEt
         6rnxh6QEb46atpv1qmq0+cLdNwMVvVjJc6ucVIy5sDL7m1yv9Yp2ox8gqjL9wi5r4tAT
         6txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446162; x=1702050962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+9aLJpGyu0Q/y7mwBTnwWcmuz7X2zXjBIdqmSWvzkk=;
        b=wmYBnJxAEu+SyDxuBBbrh74Oi+HNTULUDSffb8ndMWPuCWVRiK6sH6GhhWZKighUVu
         yUCXWz9AR8CY2BPTqusgc+vbmanRn8n4uDcfnnHkiD1nIJdqUBQEXAO5vJBzord9Pq8A
         d9pfzf5oBz3mtGqJxDBQYCf2QqtggfrZfVG7qrcSKs4o8GqWhNfHpQTWq82gVM90rxa3
         EluXvQp/I8YZAtqY91Zn/QmWPGqQ8iJxto5BKqsffctFCP2fmtRa/VwxdhfkbPqAYw0P
         SNhM52AzMBhcD/XdzoLpCN1CdcSYVqWYu0CPxIN9yyaXb8R7nTaz+YKWFrexCPlUH+7E
         VlsQ==
X-Gm-Message-State: AOJu0YwqogznVhoQhE87SN8HAGGrzm1pXTk3sshpkkYPy+NCwCCG1s+o
        6vjizwDYCKRJd9NBfZGcRCjoJg+q07Y=
X-Google-Smtp-Source: AGHT+IEIZp/UjGQmIqcjxLcrjtAVgVHJtCowAaXJ8Z6oo7dg35tnLSRyZWGu2wbxgV7cxavSU+m4ulAH0aE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5c0f:0:b0:5c6:504:7e22 with SMTP id
 q15-20020a635c0f000000b005c605047e22mr1192330pgb.5.1701446162412; Fri, 01 Dec
 2023 07:56:02 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:56:01 -0800
In-Reply-To: <ZWl466DIxhF7uRnP@yujie-X299>
Mime-Version: 1.0
References: <202311302231.sinLrAig-lkp@intel.com> <87v89jmc3q.fsf@redhat.com>
 <ZWjLN3As3vz5lXcK@google.com> <ZWl466DIxhF7uRnP@yujie-X299>
Message-ID: <ZWoCEUvk3Nlmlb9v@google.com>
Subject: Re: arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates
 bits from constant value (1b009b becomes 9b)
From:   Sean Christopherson <seanjc@google.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023, Yujie Liu wrote:
> On Thu, Nov 30, 2023 at 09:49:43AM -0800, Sean Christopherson wrote:
> > On Thu, Nov 30, 2023, Vitaly Kuznetsov wrote:
> > > kernel test robot <lkp@intel.com> writes:
> > > 
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> > > > commit: a789aeba419647c44d7e7320de20fea037c211d0 KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"
> > > > date:   1 year ago
> > > > config: x86_64-randconfig-123-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/config)
> > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202311302231.sinLrAig-lkp@intel.com/
> > > >
> > > > sparse warnings: (new ones prefixed by >>)
> > > >    arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates bits from constant value (a000a becomes a)
> > > 
> > > This is what ROL16() macro does but the thing is: we actually want to
> > > truncate bits by doing an explicit (u16) cast. We can probably replace
> > > this with '& 0xffff':
> > > 
> > > #define ROL16(val, n) ((((u16)(val) << (n)) | ((u16)(val) >> (16 - (n)))) & 0xffff)
> > > 
> > > but honestly I don't see much point...
> > 
> > Yeah, just ignore 'em, we get the exact same sparse complaints in vmcs12.c and
> > have had great success ignoring those too :-)
> 
> Thanks for the information. We've disabled this warning in the bot to
> avoid sending reports against other files with similar code.

I would probably recommend keeping the sparse warning enabled, IIRC it does find
legitimate bugs from time to time.

Or are you able to disable just the ROL16() warning?  If so, super cool!
