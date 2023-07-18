Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF2757712
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGRIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:52:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CEE197
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:52:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-403f21d3c2dso173481cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689670356; x=1692262356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYiyuxt/N5ReOBp+6DLzcnLSJb59cmexqlxBPjdaU+I=;
        b=CgDv/w4umtpcqM4lU+wjtzqvMOW5k5wCdeUDfhXa/lCNH0hulr4DpFxCOrol2sLw0Y
         wK7ZwWhs/92u9acenAT3PRZOkN2anHV2YA9+EhNwWAu8GTe+piNIWX/ZOmVDjpxg/XoS
         gNaUn5/uisOslv5SOisanOuajIHCT2XAqit2hR5Xdii+IvbI2wodDL+GFJwEK1M+xvQ8
         mve8s6mp6CNpw3m+qTOtxDnGXTJWgeZvU+VRQh78/NablesAbjmgR6fgayTn3m14U5T6
         eNiZtAqZKnE8xly41lvmYJlcdmVDwLM+8oxVyJU384hZ8WUVSpszi+gF4xNqRxrC3FIY
         aDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670356; x=1692262356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYiyuxt/N5ReOBp+6DLzcnLSJb59cmexqlxBPjdaU+I=;
        b=bEEZO7ZtEqKoRA2IEoQSVSjS+bEstXcjs/F6MnuonZFxhvXEk3oLEYFcmAbMOr4BAM
         ixmIgMjLrctZOg2BSAzuDc386hqczJkERb6uL+GNaXiCQ+6JJwoRGjjENJU5dZ5OuPQt
         RLf1rqiZhTQvPJ/mn9KaAKb2v6v14BU7qRJnpXxIapNRdOIAkjTJHwb2D1XwXq9hTtOF
         rG3X7df0phNkK2nklSbyl9qFsgFG/5bvEgMxIxU7K+vdJGU/qxGWmn++bA996T03Ti3R
         aPTKUUW6LN6hX/hWyAu5ZVkz+ktgPhOghffeyP/TZoiyLdqq6HYAAd/uV0EqBJtfF1pd
         lTtw==
X-Gm-Message-State: ABy/qLbq0uM7Oo8vLpcqswPhmqbCjUfQmF/PUS7/giP2tX4f9Nydg6Mm
        /uNPcbGu7DyNr8Yfe0rZMSXmK6qvg1RsjCrGuMeqSg==
X-Google-Smtp-Source: APBJJlFCj+g3+yVxx0XuWKRe0hkfwk4QruUfGKVc61L++n23uTaYOm9vYpWIeIZwwyFWo8ewaQZirqcfdmjyHbLVtks=
X-Received: by 2002:ac8:5b02:0:b0:403:e1d1:8b63 with SMTP id
 m2-20020ac85b02000000b00403e1d18b63mr207657qtw.24.1689670355892; Tue, 18 Jul
 2023 01:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK+BZhwbo8JLMPI2@Asurada-Nvidia> <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
 <ZLHp0r1g1lroGYlN@Asurada-Nvidia>
In-Reply-To: <ZLHp0r1g1lroGYlN@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 18 Jul 2023 16:51:59 +0800
Message-ID: <CAKHBV25ButEYJLxqRHo1V+KrwoDAGqfJGSh1G1Pe3f3_djE_TA@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Sat, Jul 15, 2023 at 8:35=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> Well, firstly it's kinda odd to have this optimization hidden in
> a big rework patch. And I am not sure if it alone would work for
> all use cases, as it impacts the arm_smmu_atc_inv_domain() that
> passes in a zero ssid, in which case the affected function is not
> used by a pasid case all the time:

To clarify, we haven't changed anything for the existing flow. Before
the latter set_dev_pasid patch is introduced, there's only ever a
single {master,domain} pair in the attached_domain list. When
arm_smmu_atc_inv_domain() is called on a non-pasid domain, it issues a
single atc inv command with substream_valid=3Dfalse, same as before.
When SVA wants to invalidate a domain, it calls
arm_smmu_atc_inv_domain_ssid to issue a single atc inv command with
that specific PASID, same as before. At no point does the driver ever
rely on the fact that invalidating with substream_valid=3Dfalse would
invalidate all PASIDs.

This patch series simply follows the precedent set by SVA: when a
domain is attached with a pasid, invalidates those specific pasids.
It'd feel kinda hacky to rely on the fact that invalidating with
substream_valid=3Dfalse would invalidate all PASIDs.
