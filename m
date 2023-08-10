Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301217774DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjHJJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:45:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A81BD9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:45:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so168301cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691660740; x=1692265540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgn4/qIV7fxvKZzxqSyuDtxTvEtyWVBr/gC+RKJiMZ0=;
        b=Rl4LWFZSxmP0VkxHciD8VhjO8/5h/FGy+WWDDjSPkV1/KQ7gP/QeOi1plC5N32mwqV
         h4S1Qp28dCmmXe8/p1G1BMd1AcF95bf2635ohTrRogPkfsEK4ghPJoSJl0Waobhjp/if
         v5ooebxurbyrTUt6s9ePt4iAXz/zZilY+pMDvz1b8E1Ntvd2pImDQGkgU9eXgT4loKNd
         YoQTVuChJwP1utUbTyadI7n7v2/N8TQNFQ9yhyb/49obm4e/k6M927cCXxFNQL2qCxyX
         PPjvhcnZpJZW/R6OdvE+RWYzrjhDlugSVEg+cvqYsLR/Egt2VSttP6kHKrEpPHqFIiqt
         QZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660740; x=1692265540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pgn4/qIV7fxvKZzxqSyuDtxTvEtyWVBr/gC+RKJiMZ0=;
        b=EJrZcoWegUVpgl2n9tJAgRBITAwoIh/UW+VCkSQg/VHl2QCy2sY0X3dDqhMerzuTNt
         UgzNtCO34oh5cryfwGhqH+NyeyxQDgMJVDBX206kR0KTvUSsCMN/ZdP46b8oQfkV+Mn1
         J3FgcUXXteS1RH/c9TM6O6c4zTY/IaBeU+B/njCjs2W2cbDPHJ9S5JmJbYG7W/AsQjFW
         uIWb3Osc8QJJBzCTnT2DkPrmpSjbBlBO6gzIHgPO/zZK+qnH2yDQWQELwa6EKp+gj4CP
         eiV3kPs/q5MCIfzNynDZqsNeuDUk3zxwFLRU5HkGym901BbRLsTGViXvDw7VI62UDN64
         VMIA==
X-Gm-Message-State: AOJu0Ywu+Ph6+f7wLxbaeJ6hj/i5eNnSMrLvtgPuLpalzarShYWtqg4j
        6Z6UVH0uA49dqYHEseooszE8f2PlrzHLTWRAIadAmg==
X-Google-Smtp-Source: AGHT+IHYqi+XITMAC6nlqBrd8lUaSmvP6Ltp/H+mOIvB+jI0bmh1wykyAMSbPruSInfIOKj8aBor1Ra/apMk+Ehc9QQ=
X-Received: by 2002:ac8:58d1:0:b0:3f2:2c89:f1ef with SMTP id
 u17-20020ac858d1000000b003f22c89f1efmr402291qta.5.1691660739834; Thu, 10 Aug
 2023 02:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
In-Reply-To: <20230809135024.GD4226@willie-the-truck>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 10 Aug 2023 17:45:03 +0800
Message-ID: <CAKHBV27uY3TK3bWX8q1VHPo-ejeNmY53RAVNH_VqyYwZASKsNg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
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

On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 09, 2023 at 01:12:02AM +0800, Michael Shavit wrote:
> > @@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_=
domain *domain,
> >               ias =3D min_t(unsigned long, ias, VA_BITS);
> >               oas =3D smmu->ias;
> >               fmt =3D ARM_64_LPAE_S1;
> > -             finalise_stage_fn =3D arm_smmu_domain_finalise_s1;
> > +             finalise_stage_fn =3D arm_smmu_domain_finalise_cd;
>
> Why is this a better name? Now we have inconsistency with
> arm_smmu_domain_finalise_s2().

There was a time where s1cfg represented the entire STE and carried
the entire cd table. We've gotten rid of s1cfg, and now only store
arm_smmu_ctx_desc in the arm_smmu_domain for stage 1 domains.
arm_smmu_domain_finalise_cd is IMO more clear, especially given the
historical baggage around `s1`.
