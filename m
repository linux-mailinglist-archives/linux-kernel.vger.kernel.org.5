Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700017805B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357396AbjHRFf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357111AbjHRFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:35:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5CF210D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:35:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so190731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692336929; x=1692941729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIkvyPStiVOM3BXBPHJZAc578+XILOao7zVTBu9PtEs=;
        b=Cz3m2zl9Hggfk9iQS1J+Ma4o2HgOdSJmoi8Z21q0eZEy6QoF0xpJJy7zD1iSKs8QsI
         /K8LvkszJ8LOM02Axuq/4R19jNVyieCdRb7/UVr/4ofKcveXTJmNJV46LOY00VHMHZia
         DzqvTOjZApRiKTpXi9nroCBCxx30Wz2ClK1LxcJ/nI/D3JxmnhbOSZZlcHecpPDinBU9
         BqqhGn42fPixNS2aPPkItChLr+EXwdE7qkbbVQbyudOc9ZQecxuRr6QfM3lDbvRfQs0k
         y71d4/dJZD2mIyoIlurfFATc31A8Su/gv9sOeiPw/ZkIaG1KvoGlyVGOC0UzLzJJl15I
         FG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692336929; x=1692941729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIkvyPStiVOM3BXBPHJZAc578+XILOao7zVTBu9PtEs=;
        b=VkKnjxoidZsOiBq0X4X88rWulqUJmIWRJhpnfiHlmIYhVwMk847FpWiD4q4tuhonb8
         22TXErEp1lvL3yXvY6OTQ18O8sFbkg1gtOG1SLti1meSpzUIV5cYBW2luAF5i6GwnvjE
         eMtG8Oe/S6Vof17/psUaCifZRfBbSv8EhhbvgDe2KSh8PL9ELcMuoSmLuYLEdL+5PotU
         w4hEM4mX9xSxglC6mKlGJfTx63dVmLF/o8wvJc+g+AIx7BtRGTp6ImDIOaRmKAjfTrg+
         2khjKZz8oM7Z0EdCN7Q3axLBKGTgjmA/e/2Nc6hlTJ6NI7WDaxrvpXSvYJ+E8QI6zl9D
         4/kg==
X-Gm-Message-State: AOJu0Yw+2yN+d9/vZUnsoXby8ZP41rFyOLv1w430CdYmXNgwJKQAQG7E
        nwhdusZ4vRflA7o+J75XKR3AEuEekrTmFV14i3XTzg==
X-Google-Smtp-Source: AGHT+IGyKBjAQDPxPn9PvmYN5kNv4FHlwRnVLyWO7NfNCoa4cOaxZPhMNJfp+Z8/QK9BDYk8mitfSfyXYKhEbzoV2dg=
X-Received: by 2002:ac8:5c13:0:b0:3ef:302c:319e with SMTP id
 i19-20020ac85c13000000b003ef302c319emr157986qti.8.1692336929243; Thu, 17 Aug
 2023 22:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
 <38eea9f2-7c55-86e5-c0e0-e02f419c4331@arm.com>
In-Reply-To: <38eea9f2-7c55-86e5-c0e0-e02f419c4331@arm.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 18 Aug 2023 13:34:53 +0800
Message-ID: <CAKHBV243MUtVN8sf1O+u7Qseq-1YMmSdX-hVx0=t1o-9dni-WQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, jgg@nvidia.com,
        nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org
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

On Fri, Aug 18, 2023 at 3:34=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 19:16, Michael Shavit wrote:
> > Add a new arm_smmu_installed_smmu class to aggregate masters belonging
> > to the same SMMU that a domain is attached to.
> > Update usages of the domain->devices list to first iterate over this
> > parent installed_smmus list.
> >
> > This allows functions that batch commands to an SMMU to first iterate
> > over the list of installed SMMUs before preparing the batched command
> > from the set of attached masters.
>
> I get the feeling that any purpose this serves could be achieved far
> more simply by just keeping the lists sorted by SMMU instance.

I initially tried just that, but then you need more sophisticated code
when iterating over the list to correctly batch operations by SMMU,
which is the more common operation.
That first hunk is very unfortunate though... Let me revive that
version and send it out so we can better compare.
