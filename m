Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11032768512
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjG3LZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3LZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:25:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCE198B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:25:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so240141cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690716305; x=1691321105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Nr6dlI8F3llvlegcjiyeAhHSBiDt0NzvpUEp9xHLA=;
        b=XXyrIdn+Bpd4H5IkEuuJhXO849uxRMOnvX6C0Iaz9kJxqLm46WIBdYyoRNcALHM2Bn
         9LNyUHteq6SYwZ/7/4iZgD1ifBCkCJyXYoeHU25cY7UDdfa21cWUpIzNyO6z5Fag2MBm
         c6wzPcPDnaJPA99+Y6q1UdR7vjr1AOTIP+NUlczb1blEx6ulvRqWZFA2tvHpdW8ZmYSI
         GpA3OHehm3xboj3LmBmYTmsTgESdfeb1ha7gtr2NAg3RpITD3SeAssFrywN2+iovrBtL
         kLKT8hNEN677Nyk8Z9C/9mummztFzKuKc8HXMDnOBrgetG/i62OBKguwRTUZ94ZgXw7k
         GMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690716305; x=1691321105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5Nr6dlI8F3llvlegcjiyeAhHSBiDt0NzvpUEp9xHLA=;
        b=kKAOvhkv/0lEOJ0jYdydLEHvtc2hhOBujEV3SAkmBFZb0N7eMSmB0bPeqdHxnCjNPN
         5p2j1UmtLAVMaWV7M99gLbwHLxMiYVlm7LYL67wIdaAzSu2lVtSoCX5mlYfrMdbiSlQB
         oSqAoEM3P3LSVRhXHwcGMFC6Nc4vwfIyyuXjFdRFmAuFSOAYS8aJHSz10sukgJNxZp39
         iXeSaaIyBrpBtROKKE69R9orv22liZiglGb1zX3mMDh8LTycj1jhF2XpJwuOCug1rFHb
         hk7GgYFa8+Z/KUWdue7zGJufcuu1hFC30W5SFgQkFkQvJqrl4i3fBiKoeprbNJDwM2iJ
         tkbQ==
X-Gm-Message-State: ABy/qLaanABO2rJnmm9nj0BWdYWF6V1ER2iEN9GS14fF4cE0cGosmN7m
        n8oL0urAH4c8EozXwHQEBWnJN+5grTkRZ0vcuohYRg==
X-Google-Smtp-Source: APBJJlHwemhYYDY5qu+ZyE+91u/RXTQOw4aWyxcEaN9DeyLP5fRBy1ICRGNWyDhoEaXLxgqmoiLHYCh4ZemQwLyKDeQ=
X-Received: by 2002:ac8:5b45:0:b0:3fa:45ab:22a5 with SMTP id
 n5-20020ac85b45000000b003fa45ab22a5mr279468qtw.27.1690716304854; Sun, 30 Jul
 2023 04:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia> <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
 <ZMOzHJO23ZakRs8b@nvidia.com> <ZMQL1qjHT3NE9FR2@Asurada-Nvidia> <ZMQO0iLDkgaDe7ZT@nvidia.com>
In-Reply-To: <ZMQO0iLDkgaDe7ZT@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Sun, 30 Jul 2023 19:24:28 +0800
Message-ID: <CAKHBV26d16Y2zWiSe2FuMgqGQW3vz9hk9vb=G=h373YN8X9Zgw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
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

On Sat, Jul 29, 2023 at 2:54=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> > Still, it would be odd to have "cdcfg" and "cd_table" at the same
> > time. If we have to be conservative, perhaps we should just align
> > with the old naming: "struct arm_smmu_ctx_desc_cfg *cdcfg;"...
>
> Yeah, I think changing to cd_table in the places touched makes alot of
> sense

A bit confused by the "Yeah" reply given the quote... Are we ok
keeping the v1 version of this patch w.r.t. to cd_table/cdcfg and
struct naming?
