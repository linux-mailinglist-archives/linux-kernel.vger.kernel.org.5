Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE0772882
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHGPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHGPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:03:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20339F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:03:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-407db3e9669so469171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691420593; x=1692025393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sjbQgfVh4+chNJ8EXVHqEaf9Z0qufHdO6KYLZ0+AlE=;
        b=C13nAX71DuxP8u8617uVB420fVs33zJxNc32Nz4uo3tPmeOfxMu0iUIxYp09pE7q53
         rw50DsGmJoJmzuziN+xcSYGi6PZwBsAeB0g8sPpr9LUiDjo471gQdZaa+aSM42u96OBa
         B8pOdFy1d+PtTpqiZqI547fF8x6Ii+4UZEc+5c4opfh9eWbANSQfDzrKEW1WLVrp5ssT
         6XD0xyk7q3g1KZ6V893GRTJSKq4QWxfVZNY4XVUkl43HL5Z8O/pKAFctscSUcCmS0wWl
         0PoBGcf4wnSqB03+1nTMLEDafoTekrrUYmlHW/L/2VumHIbqGdDrzzn3TeK2U2sHIBPY
         giEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420593; x=1692025393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sjbQgfVh4+chNJ8EXVHqEaf9Z0qufHdO6KYLZ0+AlE=;
        b=bexvrIdnqsWXWBzPpR4W3Rg7xyag6BkH1egXvaPNk3IWORm8xBd+i+1L8eObA2+C4C
         yT+MRc4KQycTCdn8DZYw1HBAki3xCXBSNUjnlHmkbpROTPs1H9FYHfldZnBbMoIwnH1c
         5rJd9iR2gGiWp/Nv+towjZy9zW2GJsz2U4eYMGq1jZS4EatnwbktaGNONNQC7+Jr/OUW
         UFQDTTE0kaF43ExO6VNG40Gaz2COcFcFLPYoiTD78TUMmtoQsOrSGcBYVXpCYllnSc4u
         gPj9zsFC3DiB5ve5i6/9otLPg6kOnvYtipO9EjwrqcVTFzC87RmMnk+RpujtPARAhEwN
         /UiA==
X-Gm-Message-State: AOJu0YzA4PDmKbymwomeVijVcTDDPI9JPkGRaHi0xJ09L3E20i4rw3EP
        VHx2BO6noqFL08UA3NZqGyqR2pQLtVwXCE/zojEjFw==
X-Google-Smtp-Source: AGHT+IEGoZQC7C1AQ/DFaQeVurM32Yd2O9ZQ+8VygMrQeWsl+H1IH61VxF2PRXaBNe4iiVPWyOtMfBWdCO4Px6caR34=
X-Received: by 2002:a05:622a:40f:b0:40d:eb06:d3cc with SMTP id
 n15-20020a05622a040f00b0040deb06d3ccmr429004qtx.7.1691420592462; Mon, 07 Aug
 2023 08:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <ZM1Yh5vzfxwV5Rbc@Asurada-Nvidia>
In-Reply-To: <ZM1Yh5vzfxwV5Rbc@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 7 Aug 2023 23:02:36 +0800
Message-ID: <CAKHBV24356NsGu8QL3iVh2ANt8NMGx+ppMuwgYF=hwHTVE0-MQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 3:59=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
>
> Before this chunk, there is another fork for "Bypass/fault", where
> we could set "installed" to false too, although it doesn't seem to
> cause a problem at this moment since arm_smmu_sync_cd() is called
> only in the context of an ARM_SMMU_DOMAIN_S1.

Oh, good catch; I didn't notice the return in that branch.
Fixing in v5.
