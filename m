Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B875772B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGRI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGRI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:56:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0969B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:56:55 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so172771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689670615; x=1692262615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rodheHV2L93rQRXHbBUNdU4pWD7PnnJnSenJHS1HL64=;
        b=jCeJW7PR9+h08z2empYxxPWft4PKJo9uGHqdtqTdXJkappa83K4ZWb8QLdH3V9UmKR
         wWXfrsgB+cMbdbgpvCV9q4nwJa1ewTPJY0fCJaj/te0y7tH/DU/9RRL1Y/vyzSKumh8U
         bWP3BVf5ULXpk9UlaVVazfD7YLlsvCArTIUMgo1XSNc9kkG9x/QKyRAK2wjCllZPhJII
         Jt05hFNL3/xMjIi+tO/kYZ+UpPYCMpvCc6+qC3lI2D+1zaquAsu4VdfNk+uZNEJRI2In
         Z/Y0WBnGfp+z/l9Bq8/3kFIJ2tr5k6Zlxz8l9FcKo7X3HAItuTODWazxYEQkzEMh158j
         ev8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670615; x=1692262615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rodheHV2L93rQRXHbBUNdU4pWD7PnnJnSenJHS1HL64=;
        b=GbFR32RYITvwyIDrG/FcWaGotcNNEEj31+MmL5ORumWU7T9Knx6Vkipn+hi9d1L0P+
         GsovbH3vX8d7eipobHDQxEV1cUTpfcFCyHQFBPMfFYel/B/A/QXgoa2gbJNGYRYJPLEm
         3EtXhkGPdnt4WMpeNQ3TnHmfcSK/Y/SKqPVCTGhPXCrof3fO5xxNjbPkGFPH69XvakZx
         hQWz7qzqHv+nogE1vooded9hyLv7xhNFuuoC9bQXAxAYZ6WrWlm/xsAJMeDTBTRvPop5
         PCPvEieP17iEfcFE2iBBfiDyl9ZjZXJ0+FGg2mQK+uUHtR05ATVpgl2ZFjDdJdwMZ/nG
         kkgQ==
X-Gm-Message-State: ABy/qLbnz93gCgI6Tz66KCdHQD8eH+Z2bNGrkkVzmBu28RR8ZUBhYkAl
        ReGjWBQTogRsVp/8Ivst90Heig5XbTQdYHwCNDF6hA==
X-Google-Smtp-Source: APBJJlHBCHYfw13JpzJGRu2TACPWOH/wZg45kLtwQ2SXr9M0EtD1O27bUgpUfRMATkgUP2Z8e0kzumhK+0tdZdotTCQ=
X-Received: by 2002:a05:622a:1ba2:b0:3f8:3065:7fc5 with SMTP id
 bp34-20020a05622a1ba200b003f830657fc5mr110472qtb.1.1689670614760; Tue, 18 Jul
 2023 01:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com>
In-Reply-To: <ZLU0IZJr6WSjknHf@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 18 Jul 2023 16:56:18 +0800
Message-ID: <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Haven't had time to address this yet; but Ack on last message. Will
address in a v5 series.
