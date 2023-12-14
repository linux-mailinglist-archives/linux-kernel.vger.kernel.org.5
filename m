Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27662813493
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573737AbjLNPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:21:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95678121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:22:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333074512bso439229f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702567319; x=1703172119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bSSRhAXdmXAROOGjFIgArjcRM7oqtGCLaLHkAUJnSg=;
        b=BaaViHUGnMttb9goZty+qF90m4urAdAEKfw+ec2UUHA5IKpQhFWcFne+KdGF4GZVxs
         bazUYOMLEs0Tkb8HMC/4Vb6b/oh8MIHM8unSmEGTWv1zPbxmfK/G4c+dsA0LyCu6/uqP
         r/NId/qSldKa1cduRouzZEo9UJCmIBVu08DEQvUT7g7ymi40w0DA/gdJGUak5yhCrdhv
         rhMjpLWAzaNMtONmHA8jXfIZEn0RVxPFjMTKmvqhnHHhH/dw3CBqWQ+Z5iQ+4LCBdVSs
         1PZ6V/CvdoACj9GzkpNe1mDYwWgT5mynwEHbc7EMNfyyd8i5RC8iTW/vkKEjWbos+Br9
         IHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567319; x=1703172119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bSSRhAXdmXAROOGjFIgArjcRM7oqtGCLaLHkAUJnSg=;
        b=wKPe9uE8VMN9nkKM0iX8B+rMwMAOJLtyEomCljn1eqWCj7Sgpf49l1gWDoyLB4nHGW
         JCG7FbMr8sumc76DKTfMsRbBjfO9LCkPzv8CRVZj4n9uuuyKawGz/Jtk4cCKbj5Q4KTQ
         VmTswfKzz4lr7X6UrEMHDzx1DRQJ7GLJN4NqM8M3opMBl4lBh5PZfpIdfZ2u+UcWKJcj
         RZn4+m+Oy7vXiGg4zTImFkvuWRFFRdjKlDM1qWTYVyjzEkZdQqghamy1bipRc/l3ZO9r
         FEdS30Zpg0vTArlWlDPCxkQE4tn3DHAKJQNOd7krVOAANQJt/fNROgvIHCVs5oMf8fDT
         dH9w==
X-Gm-Message-State: AOJu0Yzi5rpe03qc/Hpr9gVKQFx5fELb7kbUGda9yxUK5L7SFBDjz+4X
        EtipdTtObxf/tLIrY7cM+d3JSg==
X-Google-Smtp-Source: AGHT+IFNYdxveqf3zoi/Rky5KhkHGvNYerFKbxknnd39XZPaV13yasmExLP0rV2+gBo1TMNuyKiYqA==
X-Received: by 2002:a7b:cb93:0:b0:40b:5e4a:2348 with SMTP id m19-20020a7bcb93000000b0040b5e4a2348mr5298274wmi.74.1702567319038;
        Thu, 14 Dec 2023 07:21:59 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0040b30be6244sm25072367wmq.24.2023.12.14.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:21:58 -0800 (PST)
Date:   Thu, 14 Dec 2023 15:22:06 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/15] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Message-ID: <20231214152206.GA3625745@myrica>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-13-ryan.roberts@arm.com>
 <20231212113517.GA28857@willie-the-truck>
 <0969c413-bf40-4c46-9f1e-a92101ff2d2e@arm.com>
 <2e6f06d3-6c8e-4b44-b6f2-e55bd5be83d6@arm.com>
 <20231214121336.GA1015@willie-the-truck>
 <fbcda9e1-0473-4669-a869-d4de351c3197@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcda9e1-0473-4669-a869-d4de351c3197@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:30:55PM +0000, Robin Murphy wrote:
> > Robin, Jean-Philippe -- do we need to make sure that the SMMU has completed
> > its TLB invalidation before issuing an ATC invalidate? My half-baked worry
> > is whether or not an ATS request could refill the ATC before the TLBI
> > has completed, therefore rendering the ATC invalidation useless.
> 
> I would agree, and the spec for CMD_ATC_INV does call out a
> TLBI->sync->ATCI->sync sequence. At the moment the SVA notifier is issuing
> its own command-based TLBIs anyway so the necessary sync is implicit there,
> but if and when we get BTM support wired up properly it would be nice not to
> have to bodge in an additional sync/DSB.

Yes agreed, with BTM the CPU must call the notifier that issues ATC
invalidation after completing the TLBI+DSB instructions.

SMMU IHI0070F.a  3.9.1 ATS Interface

	Software must ensure that the SMMU TLB invalidation is complete before
	initiating the ATC invalidation.

I'm guessing BTM will be enabled in the SMMU driver sometime soon, given
that there already is one implementation in the wild that could use it. I
think we didn't enable it because of the lack of separation between shared
and private VMIDs, but that may now be solvable with the recent rework of
the VMID allocator.

Thanks,
Jean
