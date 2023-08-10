Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD107774A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHJJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjHJJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:34:31 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593B26A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:34:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so173511cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691660069; x=1692264869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09uuo1ZPo0trOooZ9N2aLprRug+RrXt+K+nt06yCzbc=;
        b=RRBD145T1zT2odnIQEQhlWRI7J8Xc1aCZk0Dg3j3ogcccaxjEOo/ABl0bZAXvODwxM
         OAcQA431t/WWpS+2upKOkX+dFXyRv/n6bXZuYPWHkG2Sn4R+pFx3SjK8Khy4do7aemvZ
         Pk7b8Pi6K+SYogTsPnqtjOiJy/iD9HHd1vpL1FFoYB9cYsTsEDExS4DNtHmZwCd7jwt+
         0/30r0dTvcsqib3vvoSJyqvXerw1Cwm6+MEjTYduwq8V9YhcUVBXksvUHSh7clIxneQU
         fUsbmTQi8X5O8aFyqYmXSk+p7khf/m6Xa444Q3JaKsy1YjBlbC/WXGYmQW8jVrYBmwTX
         BeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660069; x=1692264869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09uuo1ZPo0trOooZ9N2aLprRug+RrXt+K+nt06yCzbc=;
        b=dpp/CfR5RMtYnRET6gn2fuQiU/9pBQzkLpoVQEU11+KADhSZWjL6UR5gO82Wm4RQFm
         pCRVJojh4MJ3M8YdEuthAyoTnljouzfdV2/3k6d6/7RuQONKDYO1j9b/i0g6d0obIMXo
         Gpo5syRmLhhEYRaEEsNNGJXPIQkUkRZIfTken8ZRY4d+LTbnCEnamDRMJI2Ywz/foBFJ
         ZBzlm5NY1ls2OwhhC/eojmKLtF68hwYJwIDQe7m9K0p2riqpw1nJ1FJOYzXTqv9WnjFb
         9rHO3rt0rcy6kn4kgoDtoB0Msqd5ZIBJwrEn9YRXQYhepUCNMko5dRdtDwnrhHgKspB/
         PAhg==
X-Gm-Message-State: AOJu0Yz5A9tNiDREE3JKuXGHj7BXhreizf+q93XWk9bSOtSaNVlrm292
        K+8aQzXYje+LYSY60rMJTWVQHkcHXESUBlYqos4lMg==
X-Google-Smtp-Source: AGHT+IE9AMqIHgN46i95yHR5exOXafGwkQUVSYrKIROqaRv9TnVs9lB4RDlHgQS363gh4fYk6DBYuLFHvkZ6Qp1vL70=
X-Received: by 2002:a05:622a:206:b0:3ef:302c:319e with SMTP id
 b6-20020a05622a020600b003ef302c319emr389160qtx.8.1691660069457; Thu, 10 Aug
 2023 02:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck> <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck> <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck> <ZNO+QVkXcHG78KG3@nvidia.com> <20230809162749.GA4663@willie-the-truck>
In-Reply-To: <20230809162749.GA4663@willie-the-truck>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 10 Aug 2023 17:33:53 +0800
Message-ID: <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
To:     Will Deacon <will@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

> > > Sounds a lot like the existing s1fmt field. Can we keep it?
> >
> > If you are OK with the dead code, I don't object. But let's put it in
> > the struct arm_smmu_ctx_desc_cfg.
>
> Ok, we have a deal!

What dead code? Is the deal here that we keep the field, but still
infer the value to write from (cd_table->l1_desc == null) in
arm_smmu_write_strtab_ent??
