Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C37D0561
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbjJSXZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjJSXZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:25:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10E124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:25:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5836ab12so280765276.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697757946; x=1698362746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxadM6dkbOYlTvs8yd6/RgRBOylyunzhgUiG5TSJo8s=;
        b=tFyYNex/QqOe5/QCcaYL6FLmuy8gZ81cr1w0YxT9RHUXes4Q6tmp5TaK+vEAndWEJw
         H84sr102FwvYKWkCTgiFFrOfEpUpw0c9EYPRJ6LZo5ElhmjCeItgogxgc3WT9wpPs0iv
         wI35P0YHMyLL2/Ouj5DZTDXooQlQArRnc4asLFMBPjDP6XlQ4ev3YeBHn+QBpKfz/Z5g
         OjQzTF6oj9F3DJ5vQxQzzlolqQH7TdP/bbot7BYg+/c4txSii/V4lTU+j/xIKZNfnE1O
         bEQ3t1h5eSENcpCrJdVhFbvOw5eWVXjsO91MeaFGC4rJGVJc62oDClHJvaYFsG2jPJJg
         JEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757946; x=1698362746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxadM6dkbOYlTvs8yd6/RgRBOylyunzhgUiG5TSJo8s=;
        b=U5Fb49xfnu6FatoEsy/A9X4RlIfA8mzpccbmruN15OvyoJ9cjJZl5YQA605IVV+ES+
         tqhWRTdIpjGPRuPQEiLaALqMgEJ2Xy2mJ2Kjv9Asv7annu0gsq3fdBaoXZT7we5IsJgT
         YsPmHrrrMU5Hry3KckmsGQWIhMHgYx8BUJM1UFGLge00KXBvTpdeg4EcRO96XILJxQVN
         Lj/y7G9JZR0aKPxuDlv8coNBqFHq+P3YhkbW5qP0jBkuDMtftz6wcTFty0SYZMYXKaoo
         403SFeqgVUhghip//ZrH/bV7yfqJMkr4XYPemegdU+G6KthbW4UTU041VtaEdBU0D5WY
         cznw==
X-Gm-Message-State: AOJu0YxAGWgFrqT20c+/UuxzzgQdEc0zB1U1wn3S+CiVilMIu8R8kpqF
        9poTzbvoSKZaPl1DNKCQNYVD3tS98Kk=
X-Google-Smtp-Source: AGHT+IESFIEpog5mgYIynPrnCsSyXLSYX2fnHymO36oJ2DKvdCCno9OkUpLvvn9OEvYlySwvbQyyi0tSEdc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr10132ybu.7.1697757946202; Thu, 19 Oct
 2023 16:25:46 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:25:44 -0700
In-Reply-To: <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com>
Mime-Version: 1.0
References: <20231018173409.1871540-1-seanjc@google.com> <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com>
Message-ID: <ZTG6-GalaSf2lMBq@google.com>
Subject: Re: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From:   Sean Christopherson <seanjc@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023, Robin Murphy wrote:
> On 2023-10-18 18:34, Sean Christopherson wrote:
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 01637677736f..e071415a75dc 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >   		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
> >   	tlb_addr = slot_addr(pool->start, index) + offset;
> >   	/*
> > -	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
> > -	 * to the tlb buffer, if we knew for sure the device will
> > -	 * overwrite the entire current content. But we don't. Thus
> > -	 * unconditional bounce may prevent leaking swiotlb content (i.e.
> > -	 * kernel memory) to user-space.
> > +	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
> > +	 * the original buffer to the TLB buffer before initiating DMA in order
> > +	 * to preserve the original's data if the device does a partial write,
> > +	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
> > +	 * the original data, even if it's garbage, is necessary to match
> > +	 * hardware behavior (use of swiotlb is supposed to be transparent) and
> 
> Super-nit: I think that last "and" is superfluous (i.e. unwritten memory not
> magically corrupting itself *is* the aforementioned hardware behaviour).

Ah yeah, agreed.  How about this?

	/*
	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
	 * the original buffer to the TLB buffer before initiating DMA in order
	 * to preserve the original's data if the device does a partial write,
	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
	 * the original data, even if it's garbage, is necessary to match
	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
	 */
