Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44476EF86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjHCQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHCQcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:32:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE601713
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:32:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691080365; x=1691685165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14b7Rs9Wd8rjA7nDFTSpP6ZFmJxIiJvGTB/lP995Sd8=;
        b=HwprDZDqMPrL7Zj654wYgowyjPBT5Je+693PMPHj+04LTiEevklzjorIkYL1sGAIZ5
         YU3tNKDGyDj2VPd8GqIMGVzK/DZrx9rxl69XF+FxnJ9ps1Fvni7mZUp5GI4/pyrbRfPb
         muZo4nrqyOUZ6Qd0MPcKToJ+mT7D71OMoS61TiRWzVHT7IdKdaBEpSdL/a+iuvefhpIO
         MgDmRRrfFCHNZx6FSLdq6XC5GpeYHoJHucn7TZjrgm/ZKiCJcBrbbgaf67aYmfZKazPg
         wKI0wX12z8j5b9WOdQjutTB55iU/3yo8MG2n6cdOrDdgvncFyyEaiQ1W/guYydVtAWiA
         kIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080365; x=1691685165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14b7Rs9Wd8rjA7nDFTSpP6ZFmJxIiJvGTB/lP995Sd8=;
        b=JWdhK1HGne6I2oNJpgG35ibEDIB148epBP3NnVTo+Rx9FYxS/ikV9D0je0S6yeU0wt
         mgh44oBEaHIW68PlgWXllBLi24jj4dacdVmuOnp79Lsr0I2ovvwIyVOkuGZFXPn1Evrv
         4YVHkweA3rUzVHAeWQuO6gMhPNkINIk1jmqIMclF1llRlOCJ+JO90q90b4RWkF6dPPYm
         Oadsf/8XkBaGNKUJFF/gmBtV4pYx+wQz3mLGDB/XfwUDcpVqtMcw3+FvJdlCyJO8099S
         mXBEMZB8X15C67Q0cxHraN+YlXJ3YYBbfzovrctkrY6jqUnCzC1dyy19C1+TtJ79NUIb
         as5w==
X-Gm-Message-State: ABy/qLYSJeTNZGIV6vhHnvEBb6IkhC5hi55b+TIOW6RysirsLMhn/Izr
        q0jtUBUIb1BpRp+I/KOfqbzNztvIUkDwgQzp68mFhQ==
X-Google-Smtp-Source: APBJJlHlLJg4KvOewFU7IA5p+IkO63/clWuytJZE4rymDY1Rle14ashYNxENtNsonVB2915jj7wiHiP56PCPsPnXllE=
X-Received: by 2002:ac8:7f12:0:b0:40f:ec54:973 with SMTP id
 f18-20020ac87f12000000b0040fec540973mr185916qtk.22.1691080364836; Thu, 03 Aug
 2023 09:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
 <ZMvKzwx2IhgXO+F8@nvidia.com>
In-Reply-To: <ZMvKzwx2IhgXO+F8@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 4 Aug 2023 00:32:08 +0800
Message-ID: <CAKHBV27q-KdcoKZu7TeFdRWGvKkU7C13yOdxRNZ5cGEEbPumCw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:42=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 03, 2023 at 06:12:22PM +0800, Michael Shavit wrote:
> > The arm-smmu-v3 driver keeps track of all masters that a domain is
> > attached to so that it can re-write their STEs when the domain's ASID i=
s
> > upated by SVA.
>
> Wah?
>
> A domain's ASID shouldn't change, why does it change for SVA? Doesn't
> SVA use CDTE's only? Why would it ever change a STE? I'm confused what
> you are trying to explain here.

Urh right, I mixed up CD entry and STE here. Before this patch, SVA
keeps tracks of all the masters attached to a CD domain, and updates
the CD entry 0 in their CD table. Now that a CD domain can be attached
on non-zero SSIDs, SVA can't simply update slot 0 in the table; it
must know which slot(s) this domain is attached to.

>
> What is a "primary domain"? Why can't we fix SVA first so it doesn't
> have this weird "piggybacks" or:
>
...
>
> This patch is not making sense to me, the goal in the commit message
> seems logical, but why is tracking CD entries introducing this concept
> of a primary domain and doing special stuff for SSID=3D0?

I'd argue this patch isn't introducing anything the driver isn't
already doing. It's just making the status-quo explicit since it has
to handle it. I do have a patch series in the works to properly fix
SVA, but it's growing quite large and I was trying to get this feature
out first. At a high level, the subsequent series:
1. Nests the list of attached masters in a list of SMMUs the domain is
installed in. Updates SMMU-level operations (such as invalidations) to
iterate over said list.
2. Checks the compatibility of a domain when attaching to a new SMMU
instead of outright rejecting, to allow attaching a domain to multiple
SMMUs.
3. Thus allowing SVA to alloc a single domain for the MM struct (which
the series maps from multiple SVA domains internally, pending support
at the iommu core layer)
4. And allowing SVA to use the same set_dev_pasid implementation used
here on that domain.

Now having said that, it might be possible to get rid of piggybacking
sooner if we create an MM per master instead of per "primary-domain",
but I'm not too sure about performance implications. AFAICT, the only
downside might be for invalidate_range commands that could no longer
be sent as a batched command to the SMMU (since each mmu notifier
would be called independently).
