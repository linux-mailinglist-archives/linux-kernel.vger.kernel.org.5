Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0F803F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjLDULn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:11:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B78111
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:11:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1ed4b268dso81180927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720707; x=1702325507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOU2ooCLv1IE731eabYKj790tbuwogyFPv+sco5TvQ=;
        b=Wvoe5OiGw4HQ7F6yUVfx7qJgDOLp+aQv5LrxmttJAUobmNUzzLmY9Urvh/qhwwzJjw
         YpgQ2jX5Lbx7JshLTOvuZXyI6Sb/Mq0rJ4cs+tvn2SoOJ9JltkTeyErDITl4qPjmzv/M
         cam8CpLEWDbqFDW8WndKsAbz1CAdKFdxhHtsyTd2Eae9kh8Azpm8pBtJZFFSlXgvKnw0
         HLUCoe6+pPC39vppJHkxdjg+0QQJaKXAVth8HZHMcF1AkNErcWQkWWnO9h6PoikWSOCD
         ZFbgNFz7v1+5GaABRYqswq/6Dc9kNsxA7c0D8eepFDFDwGvRys+JunVJCJ25II/yglEi
         JdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720707; x=1702325507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOU2ooCLv1IE731eabYKj790tbuwogyFPv+sco5TvQ=;
        b=gxOgHq8jECCXDVmXBYOYTe1wS/h88Nl9rOyMJx2X1urlt+q3mDoMxgz8aaOTtgpAzI
         V0FZinslXa9zJiGWkTUdrVCotatD1AQloH32eq2WlS2tyKWbxiLqpgoflW726xzmAxTF
         jydJWWFRk+GIrtzVGL62SMuIx4L8BxFmf+HIyVGvzTBtFe1ZjK3EONidAXipuECe1CF0
         473qvgfBPPB6JA/wEu5+jSXCbewMOOvpX5BAjRwZ8zhnpedXRI+GpX0L+JCqN0y5l0h3
         +9gr7BCRmqo5Xa4iCkWZn0u4A/QetjJGhbQOGqZrqjjtv45GDLBalpoDGkl4jHhu/Cza
         3c2A==
X-Gm-Message-State: AOJu0Yy+MJdkvsRfgMVVXr0kK8KCrzPUNp8D5HSKnJlte7VSqYzJPwSH
        nwR6a7S/82QwQ0R2TKA6s0vrylwNpdA=
X-Google-Smtp-Source: AGHT+IHLvL7F4SnML9BnJOEYkMPzq+JUrdFdxVVPR0p4zxv+RrWuH0X6xOW9Hg/+32yf5Zr0Hl4RQumsq8c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b650:0:b0:5d7:3abb:1424 with SMTP id
 h16-20020a81b650000000b005d73abb1424mr169600ywk.6.1701720707487; Mon, 04 Dec
 2023 12:11:47 -0800 (PST)
Date:   Mon, 4 Dec 2023 12:11:46 -0800
In-Reply-To: <20231204195055.GA2692119@nvidia.com>
Mime-Version: 1.0
References: <20231202091211.13376-1-yan.y.zhao@intel.com> <ZW4Fx2U80L1PJKlh@google.com>
 <20231204173028.GJ1493156@nvidia.com> <ZW4nCUS9VDk0DycG@google.com> <20231204195055.GA2692119@nvidia.com>
Message-ID: <ZW4ygoqOq2JpXml3@google.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, pbonzini@redhat.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023, Jason Gunthorpe wrote:
> On Mon, Dec 04, 2023 at 11:22:49AM -0800, Sean Christopherson wrote:
> > I'm not suggesting full blown mirroring, all I'm suggesting is a fire-and-forget
> > notifier for KVM to tell IOMMUFD "I've faulted in GFN A, you might want to do the
> > same".
> 
> If we say the only thing this works with is the memfd version of KVM,

That's likely a big "if", as guest_memfd is not and will not be a wholesale
replacement of VMA-based guest memory, at least not in the forseeable future.
I would be quite surprised if the target use cases for this could be moved to
guest_memfd without losing required functionality.

> could we design the memfd stuff to not have the same challenges with
> mirroring as normal VMAs? 

What challenges in particular are you concerned about?  And maybe also define
"mirroring"?  E.g. ensuring that the CPU and IOMMU page tables are synchronized
is very different than ensuring that the IOMMU page tables can only map memory
that is mappable by the guest, i.e. that KVM can map into the CPU page tables.
