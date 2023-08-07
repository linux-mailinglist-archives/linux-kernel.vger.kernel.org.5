Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF47723E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjHGM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjHGM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:27:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5EC10FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:27:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so419871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691411230; x=1692016030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfw4eA1M1eAizs+i2Rvt7ynF9VVbRXwpBeFGZm5EOCI=;
        b=uIY0vvVkH2wTUXghdeMKjG7sWv1UPL4IrjF8KZb9DWiN+hBfBqFVzfJCWntahzNMtr
         4XAjyqRRNaPl8oIWv9qPHCh1xmDXV5fN8d5QrC/vex5S+GxAojZBWuWtgle7WKUXEniI
         mMJsHXkjbr0EIToRLK/ClI8deBg5KqaDA6kOiqaKKGTk8iqsnbhAqidcVJwgWz3cdvRD
         1sMW58L5GV4xeVePIWDut2t570I9BnQdPGYhL8WRElEfzRuHVsedF/OAMY1Jv+lcR1gq
         bkRcebLmUZRaezXlf5nAj26AbsnRJuQCGRAhJeHCWEhy2HfipDf/KNBc85r0tzHFE6Hf
         pVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411230; x=1692016030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfw4eA1M1eAizs+i2Rvt7ynF9VVbRXwpBeFGZm5EOCI=;
        b=EwLGVRwgCyBYsUIQ534gi+Po+Y5TvPshaj8ceJsiP7icZ+VKtTES0xLMiOnt5/VZDT
         wno+gcljdspPmg/2cF480Vc0EOuvDhutmn3HiydfcZqngZ/35sIGKPNd6l0hBXHO6hx7
         qyXZCpTufzxXQNWCw6U0luS5vMDthfRsbQqu/pAVou3uummGwqRayswrTrjivE0YXcSB
         f1ZYXpULKSTz0hbiYuzMukVrk2wH+qb3S5kdwGRohddM9Fvt3Yd1XXeqomELZN2yVoey
         gWZDa4ZGdHUXxCYKKlK7iJCOn2vxylpACZe5V3FVdKfSLXBaL3sR/9Rd20PCaDkd61qY
         8GEw==
X-Gm-Message-State: AOJu0YyqLaJ1ze5dQ7/ceL9ZfYr/Oc2g++M8/LNKi1nZ3N/i5pj2Dq9W
        AY5O0WG3so1AOzzWlbYgdK0YQ2quTDfUn/eC7ax3n0tBExFNUY2pPZPmkg==
X-Google-Smtp-Source: AGHT+IEAMtAejquu7vKS5bRdlWrv54j4W0GWjho09B82bo5P7V0+fV18nd9ECZezJJyK7/3WFBcTOADuTwl6f009U7U=
X-Received: by 2002:a05:622a:1a12:b0:40f:db89:5246 with SMTP id
 f18-20020a05622a1a1200b0040fdb895246mr360275qtb.21.1691411229975; Mon, 07 Aug
 2023 05:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <ZM1eAGMxLwZWjt96@Asurada-Nvidia>
In-Reply-To: <ZM1eAGMxLwZWjt96@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 7 Aug 2023 20:26:34 +0800
Message-ID: <CAKHBV26VmoYSF5eRVmAt3zn29o7Db+r1WGUZ5PXpUVcswi2fHQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
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

On Sat, Aug 5, 2023 at 4:22=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
>
> There are a couple of places calling this helper but they don't
> check the return code. Not sure if they should check too and do
> a fallback like this: if so, this fallback can be squashed into
> the helper; otherwise, this should be fine. Anyway, if there is
> a need of change for those, it would need another patch I think.

Yeah noticed that too; I think those other calls are technically OK
because the call can't fail when writing to a CD entry that was
previously written (it can only fail on allocation of a leaf table).
It's also not obvious how those callers could gracefully handle this.
I'd prefer keeping this commit as close to the existing behavior as
possible.
