Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA276656E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjG1HfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG1HfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:35:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CD22D54
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:35:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40631c5b9e9so164261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690529717; x=1691134517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDPcwp2Mz7C9Ps/iDhtZ7bunn4aijZQT9NN7+iAapjE=;
        b=enyIBgwAzyuWA4J7wtv2SOUubtS9qNle3EYaLS2TgsFOC+e4n9N2BIKHbKeYDdtyXE
         k+6wMKY0IpytJSvZ9oxRr44s9qeFc4Vp/PvLsf6kOsdm4a7IIUsf2dxpMRmmu7ZcXDTI
         0STmNj0oz/hR40nn4tgPCz7QnS+5YkpciOlONChR2XSLwpvEe8sWc1/oatPzoI7aO91q
         zG7X8RuQpP2JX3HXDMbuNDuAe/UFPNI0RxYArQQ+jaoK7AjLDe13czEvAYuQjDXRnRMo
         gUc9K8sjiDTqFk34TNN5QQGwiflosPTBtsLaDYz1I7ukkZlTTQm0nWI78Ga5khz6/Q6B
         7h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529717; x=1691134517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDPcwp2Mz7C9Ps/iDhtZ7bunn4aijZQT9NN7+iAapjE=;
        b=LtyCCkzWbdyDwF5dXsWjI5XsDXETuKezDeApbdbekECgw1S2NJF6xuCkePFzgFW1km
         EkuvC6z4ZBgz9ZzBn5PKr9fG329gpBUVgyUnvWQpOUXw6zvfAHwCbhqUHleGQhMOwxi0
         vgihIetNc8LiVFwkBqXNRHLB5nJhwQlbLNBLmWebpWllkeHJQmpALPf2MNVXGTrA/8NI
         ZJyC7sB22Nrey/s9OxZSMUD/FSd1o8jCUgMUi5x6M/vm70hmlPNZUXPrkmzNDeCYKj+r
         f96fHTwr/BCBcFoHTQdsRHCYtX/VGDnCK9ESUYWbPBvJyv9JKDX2+gX8jcFlZZVh5Kns
         qSkA==
X-Gm-Message-State: ABy/qLa1+S77R2f8tcI9xsVT6l7r0wDuSkZCwD01xA93vAWrCqnOKB6D
        w69K7dxXg6qtLTvTTt3SgxvhfZDDUnSjFjIzTEDO2w==
X-Google-Smtp-Source: APBJJlE/pbAViIj8z7R0ccyCBgMKazmGFjRMSrrXL0qn1D946pmZzAb/dW3nng2iPFM+zl342ybtqyqB9ublMYbARVE=
X-Received: by 2002:ac8:5907:0:b0:3f8:5b2:aef5 with SMTP id
 7-20020ac85907000000b003f805b2aef5mr158028qty.29.1690529716970; Fri, 28 Jul
 2023 00:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-7-mshavit@google.com>
 <ZMLjqfp6M6n7HAxl@Asurada-Nvidia>
In-Reply-To: <ZMLjqfp6M6n7HAxl@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 15:34:40 +0800
Message-ID: <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
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

On Fri, Jul 28, 2023 at 5:38=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> > @@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_dom=
ain *smmu_domain, int ssid,
> >                 cdptr[3] =3D cpu_to_le64(cd->mair);
> >
> >                 /*
> > -                * STE is live, and the SMMU might read dwords of this =
CD in any
> > -                * order. Ensure that it observes valid values before r=
eading
> > -                * V=3D1.
> > +                * STE may be live, and the SMMU might read dwords of t=
his CD
> > +                * in any order. Ensure that it observes valid values b=
efore
> > +                * reading V=3D1.
>
> This seems to be true only after the following patch? If so, we
> should move this part over there too.

This comment is more in theme with the next commit so I can move it
over. But FWIW, the fact that the STE is not necessarily live at this
location is true before this patch, in this patch, and after the
following patch. Fixing this comment is just a drive-by, not a result
of any of these changes.
