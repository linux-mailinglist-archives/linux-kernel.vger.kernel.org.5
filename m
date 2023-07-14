Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F319975362B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjGNJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjGNJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:13:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112692710
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:13:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403b622101bso209701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689325993; x=1691917993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXXFs1U0EQirANF72vGzE97gcx0mGEeOxn7yBPDJD4A=;
        b=B2Qy7FEqZ7cpvpNr/7I7YyMWCRE03jyN3Wx391rY6FsqZwmNbHkQyghsyfh0t/C9Ge
         bNH5jHKznr5cb3VD1TAhKhrL4671zDAJLKeC+OPeWd/F6i+htAtjtQUYfDqbvrdDYLqo
         7vsPeYv+0QwctoFSm6VMY49JcvLwU1JLAgN/b/kA4AJhd1YIpApVBScBnozL5Bo4+WY8
         v1QXeO4C/lsCfryAivvaIQfQY1/ASdrsLClpld1HKvJ5tOWHPoG1IjECl+8aadEHVcKH
         AOgRaI2pdsc3Kqu9KJUpKkO22y5lIvgEgQOrrQmZD6tY5SXDT1qHxQofIVTIO6FPPVux
         T0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689325993; x=1691917993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXXFs1U0EQirANF72vGzE97gcx0mGEeOxn7yBPDJD4A=;
        b=IXmkxP/OZjYOCH7UKQjnlCnL7Lo90zc4rEdENZ3/QLuinudKuqZWFwbrKSKZRut3af
         GWufpWwRp1tps/9HGyY60igs0vmO4cNXi4xVBFW1IRo9FD+lVD0jWXvRjsq8C1JUeLNH
         rVfxYb7d3aKO3jz30ngj6ZUh9GSwh7CayBpC6fABkPbc3ny6e7ulvxz4If+KVLOnonq+
         2AH9x+MUD0YsdU78ESnhsATW818SkJQ5VRb/ktAAgoiTqcfKI6tD6/UDSoaTRqxP//lu
         sQnnw+FTwKS5dB+7dXFa3aZAGdbn5nVcvEgdCr+8BOfkCw763rc1O6KQl6PWudHAXdc7
         thJA==
X-Gm-Message-State: ABy/qLYbLvItnknzP/cTlufeJ6TT7+1UMXl4a0ZznpH9+Szx0GB7l+2B
        xukf8AaNF8JjX8oEcAYTPm+GmI37QSy5N/zokpW5gw==
X-Google-Smtp-Source: APBJJlHMkDrXr7BvzQxv+DKt/d+UTDl7PF7376N1v7BM/R1n9czmCwE+wgwvAnTdTWWotOkhYFRfKkgvySA+/jhFiks=
X-Received: by 2002:ac8:7f8a:0:b0:403:aee3:64f7 with SMTP id
 z10-20020ac87f8a000000b00403aee364f7mr794692qtj.6.1689325993037; Fri, 14 Jul
 2023 02:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <ZLBWh370pPjx2B+z@Asurada-Nvidia>
 <ZLCNUNRsWy/YuHhQ@nvidia.com> <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
In-Reply-To: <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 14 Jul 2023 17:12:35 +0800
Message-ID: <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 9:14=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> @Michael,
> Would it be possible for you to update a v5, following Jason's
> suggestion overall? And I think we can have a smaller refactor
> series first without set_dev_pasid, to have a common codeline
> sooner for us to add new features, such as set_dev_pasid, the
> use case of IDENTITY default substream, and the nesting series.
> I will help testing with some pasid/non-pasid use cases too.

Want to make sure I fully understand these last few messages first. At
a high level, we want:
1. arm_smmu_master is allowed to own a CD table, but not an
STE-precursor (s1_cfg/s2_cfg). The s1_cfg is practically already that,
and we can probably get there with minimal changes.
2. arm_smmu_master shouldn't point to the currently active CD table
(which may or may not be the one it owns) or STE-precursor as a
shortcut. All code should figure it out by looking at the master's
currently attached domain (functionality could be provided by helper).
3. arm_smmu_domain shouldn't pre-generate any STE-precursors. The
STE/CD for a domain should either be computed right when it is
written, or computed ahead of time and stored as a copy in the
smmu-domain.
Is that right?
