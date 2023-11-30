Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316A7FF8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjK3Rtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjK3Rtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:49:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE2106
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:49:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ce16bc121aso20972307b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701366584; x=1701971384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=poBE260KekrwVAOgg+M3fF5Kt/ICZ7GAjNWMaWtdSzg=;
        b=ICJLpAgwZbOfuOu7k3JAI8dnsLJszQlCa7NVU62wiaNNst73XZK+ES47fhiEdEnOvr
         +ooCzCai9wy//ibux1cb7ujsI8CBtyd6yNgvkU7/j5GR/ayIOoctD0ru18+Kn9qD9m+Y
         DfTZk91fk6FEGAhmHKo0z6QDnnXKcIkJDo6OMSUfn3yvwk5IJvySTa+WaqWBCP2Ws68M
         dLQ3scKQZPQf1Gzhjc0NWW9X23qBHYlOm3iikWABViIXwRyb++EDa8kSZbv58tmmpmx3
         HungqifzqNzLLedVOx3m6Iou29MVdurIlDvusdm4c7bNvLj1r7cl5fluDDOlpph5DVHi
         VA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366584; x=1701971384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poBE260KekrwVAOgg+M3fF5Kt/ICZ7GAjNWMaWtdSzg=;
        b=eU+T8QsgrcERA1yg6wEi2GQ8m1vZIF6LJOMD9bQpVkk04zp4wrCyOv3U9N+Mt1uxp+
         0J3na/QtcCByyobkc7b2BIfyONsSP8jrYxf5oPl8Qbq1KqCU99BUcsEhGwDcADF3JQry
         e/IKPu1c+7VS0rqWy75KZh+lgYgeztIu5MeCV/uQ/bXzs1ZRRE6cYbvtUkyZUnKmNMOQ
         PSTpAImNRvk8EMGp3T2KOPyKXQsBTkojrjuXX+k5iUCZjGaaPQEa2OHGWbtN9nRMQLZ9
         mBsQfFhK7P3x7mjKgD+1FOUrf5XHPNkOTa+uuHdNCk6003FlbPfxGSepLEMiId4DgM6j
         suzQ==
X-Gm-Message-State: AOJu0YzmJPI0jg1s7ClKj7kJJGLfW+o6NEhYLjJlCgdpn9rWLMhNuXeQ
        e24nTCB/8M8PpYN04iA7jmkn9ShuMeA=
X-Google-Smtp-Source: AGHT+IFKIQiSFMhY9qIDegdCeGs56VhwQM1SLPMyPsnHTxpb4uIQIzrRqUJpJKjBsiy/h0VKitgvRRcgueU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3383:0:b0:da0:c6d7:8231 with SMTP id
 z125-20020a253383000000b00da0c6d78231mr749060ybz.0.1701366584635; Thu, 30 Nov
 2023 09:49:44 -0800 (PST)
Date:   Thu, 30 Nov 2023 09:49:43 -0800
In-Reply-To: <87v89jmc3q.fsf@redhat.com>
Mime-Version: 1.0
References: <202311302231.sinLrAig-lkp@intel.com> <87v89jmc3q.fsf@redhat.com>
Message-ID: <ZWjLN3As3vz5lXcK@google.com>
Subject: Re: arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates
 bits from constant value (1b009b becomes 9b)
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023, Vitaly Kuznetsov wrote:
> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> > commit: a789aeba419647c44d7e7320de20fea037c211d0 KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"
> > date:   1 year ago
> > config: x86_64-randconfig-123-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311302231.sinLrAig-lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >    arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates bits from constant value (a000a becomes a)
> 
> This is what ROL16() macro does but the thing is: we actually want to
> truncate bits by doing an explicit (u16) cast. We can probably replace
> this with '& 0xffff':
> 
> #define ROL16(val, n) ((((u16)(val) << (n)) | ((u16)(val) >> (16 - (n)))) & 0xffff)
> 
> but honestly I don't see much point...

Yeah, just ignore 'em, we get the exact same sparse complaints in vmcs12.c and
have had great success ignoring those too :-)
