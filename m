Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F227723B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjHGMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHGMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:20:46 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE995
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:20:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso421861cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691410820; x=1692015620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKndJRH8+fA20vciO2QWMbTLEeBf2QvwlRovy10Zq5s=;
        b=goQJDvsQtRExrxHcS+ViWDBPY8yY1vbu/PiFqwPcHswJuKsGNLmJFm+sjmFUgfBjAv
         lPQTr5QQZWMgsYAYvLmPEfyVYuxaHuHJQAETCqMYgs6AOPSrAOES13LUMemC5Jg7TEzn
         WYZ653imtkIk1DppFnE+DPVhQHYg2tTyY/5Bcb6PSi9MrmmRaTEcCWMBh0yzXhvqc/Sh
         pa89CLgW1DtaO1cWMkAAGhQItaJtMS+nLWoXY9LPRVLvzXFtzmBbW2nXVsldWB6tVe1C
         2In9tNIkaNkVMeVz7PYhveuzZsSXHOp//xmdWYNSzD5OXDwpAGXpIrvQG+aZofQOB61J
         lHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410820; x=1692015620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKndJRH8+fA20vciO2QWMbTLEeBf2QvwlRovy10Zq5s=;
        b=cA2KwedufOP0cwb/XtrxfJ540iC1Vj+fXrUoiRuTzwHhaCJRk79B6KYNTx+F/EOlnM
         wbh9ykGhb1u4ZcbvEjcl62DjFRa8gjBXe5bd9Dk0px0MSLDTNLrNj7lnAtcKh02OPBWs
         /kpZhU0dOBxP83wv/fyAmWcsqih1b+ltAPJ65yz3l+Fhqh/tR1sf36ExlvI8MEnX+2dD
         RBs59GdSSxMLO5W3hOA55/EkdBdYUbdvf75j07I14v2IwA1fsQZvw8uvO8Eflz+XtIBT
         HuAlNXYrl/ArhzZEhilJeTU74lHc+83Wku4s3I8pXy/B9xR6rPj8E82ckjT5vKXpVHlq
         ZZXA==
X-Gm-Message-State: AOJu0YwpLgoBP0lr0CcT4JWJcqm83z5xUiAJ5U4q1q3aidgWDbz0KUml
        2iQU+2RZkMbwGY9SvtyUiQecF3JicXxZ/wFXo6llMRxwMwwZgG4seLXctizk
X-Google-Smtp-Source: AGHT+IHLXvW9OoK5Akyt4yjw8GIDQ9eEk6i0Zq0Abc3A0zfrE7HvA40+g9GjhZY3GoldgZDmVpVHILmBuMpzLsKlJkI=
X-Received: by 2002:a05:622a:589:b0:403:fdf1:e05e with SMTP id
 c9-20020a05622a058900b00403fdf1e05emr338193qtb.19.1691410820262; Mon, 07 Aug
 2023 05:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com> <ZMv2WJX6b2UBBelt@nvidia.com>
In-Reply-To: <ZMv2WJX6b2UBBelt@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 7 Aug 2023 20:19:44 +0800
Message-ID: <CAKHBV25fCOE3pVysLaB2e67G0Be3FdWLKb+ZsmbHg8CyPpwo5A@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
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

On Fri, Aug 4, 2023 at 2:47=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
>
> I'm not surprised, I think arm_smmu_write_ctx is a little too clever
> for its own good..
>
> I would have written it by computing the full target CD entry,
> extracted directly from the domain.
>

Yeah I was considering making a fix to arm_smmu_write_ctx instead; but
clearing the CD entry on detach feels like the right thing to do.
Relying on the 0th CD entry being re-written when the CD table is
re-inserted feels fragile.

Perhaps re-writing arm_smmu_write_ctx could be considered as a
separate singleton patch?
