Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAD77FC89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353448AbjHQRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353833AbjHQRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2830C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:07:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so8651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOrR6jLvPvNePyIC/+imo6fGglOwhNPI+mbMxjZ0VQw=;
        b=mbmVCvZpWFNNWlbr5PyQeTm/nq6fYbpjeO9BfgwZxNpukj4mobAKlDUiQHt7H+VrtW
         auYi6sKPedNwPgnshaQiGZn50kRJ3L+uq+AtDp3dN4Hn3DqO4Gdd4FYzguzbCJDsR1ZU
         kn7+C6mGcepD3Nn3SwZiIvqmKoi7Da0UgG7rvfa/GxSHR2Dtd+UuBIr08uR8rpOvGJio
         GhWXowPd/IGl1l1BU4J4SGcYDyYA+sP+1nSae2UnbsoKWTyPE7EKqCIOSWszqYbYL5Gu
         l+/eq6ewzEEuE2VFCqydXhBCswHci6Azi7ktHX11tOD8kXHi1g8lOBOkGeozWk33tcG4
         thiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOrR6jLvPvNePyIC/+imo6fGglOwhNPI+mbMxjZ0VQw=;
        b=YxC87YCKe1HDlFf94Ik++MGdYVBKfm5/9UhT3tNyCiNpt+YE8lhVg6NRrMTMx8i/V6
         zh+tSgOTbWkA6B4MFy9IK56U0QCNQo2UyVlFL5AIzRaIlOHycPWsvCFtopLWa5PSUsF1
         1p5dEeYu/LHCYr75UTvxFGKrPzfH3dlOqmjD/5SiWUYgR3BaKO65MBdDxIE+uQQ2z/HS
         K9qhe6AciwBq3XGUFLzlcgASbBDeTtr9W99jQIxC5mCuXQ5GOIFc2cf8FVNynAYrG4uG
         U4nuNqYxdlowh90OZqM/nro2cHsiLNYXjpiXHh9MWxI1O7tyJnSgGVXtlXGendNwA0vW
         0PWw==
X-Gm-Message-State: AOJu0YxpXaPk76F8HYKu/8sHu8nJeMSZe9rCJ95r1zETCmJTwDsNaE7e
        Lqu0OdAryhJ7D6wfH+NsK2zHgWYoe9wdOL3Wz9utlw==
X-Google-Smtp-Source: AGHT+IG2FLtDtq9HHsFn8+IjnWSDn8a6ohvAB7pmeSpQ35VRAU2wtAHnE9fn4vA6v1FfKxnHC3jWjVzJpaNgMlwuE1s=
X-Received: by 2002:a05:622a:180e:b0:3e0:c2dd:fd29 with SMTP id
 t14-20020a05622a180e00b003e0c2ddfd29mr12369qtc.4.1692292044789; Thu, 17 Aug
 2023 10:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
 <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
In-Reply-To: <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 18 Aug 2023 01:06:48 +0800
Message-ID: <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Will Deacon <will@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 12:35=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> The reason it's like this is because of arm_smmu_enable_nesting(), which
> *is* the additional thing that's going on with the stage selection logic.
>
> Thanks,
> Robin.

Right, but arm_smmu_enable_nesting isn't involved in this computation
at this point in the flow.

arm_smmu_enable_nesting returns early if smmu_domain->smmu isn't set,
and smmu_domain->smmu is only set after arm_smmu_domain_finalise.
So at this point, smmu_domain->stage is being initialized for the
first time. If this code is responsible for handling some special
nesting case, then it's probably not working as intended.
