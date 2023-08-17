Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71477FDE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354407AbjHQSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354505AbjHQSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:30:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7D3592
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:29:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so39571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296999; x=1692901799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwYh+kePTjMmxljMAz9Xt13TYo4scp9mgDZ0UyhkoJA=;
        b=A8Oj0MA6eqOQbzanZvqIHAdaiSCKjoFGl6cNKY88LVT0R9Nzi1jbf3TkqeDF8oqfmM
         5i9LWvb+oewmkabEd7USKmAMDaaxNGt3wjL6vV6xiz5NEuCJH0cOdUMSeobbsjQzC3XS
         lq7XRRseqFIov2FzXG4Xvi9t+eP2akaMsNjWQ5vLAnxGueiayEc2iz+Xa5A6mFrM4cVV
         fJIKYuJMP1n7xtm+b4IAiMWc0hzeSCgUiya9XoLOEhfMNJ0Dyn7Km27w4UPwvCQQK2jt
         olSVfXU7FxoDopdHKQaYfc08uIKp5uFvgFk6wGag1nEwuj/iVO1P2tULRs51Ig+zGdfX
         kxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296999; x=1692901799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwYh+kePTjMmxljMAz9Xt13TYo4scp9mgDZ0UyhkoJA=;
        b=F7mzgoWtnAefxTS3Qza/1hQBUDNDDotmCduKXWz9H8Ht9Qip6NuTCmtLnH70RFf//9
         hxo4QiuLxwIQGpGeYHDE50/HIsEEyVa3YeZ9h2oU/qsHPfOjq9xunEfKjxUagguAHymO
         YeLUwW9To4XXjlyp2idnabkqxD09EBnA5EpH6zznMa84V4+SanqQNnoWdFQ/ToY3DTO3
         EC8nikYRiCw8xZdPgk8CfsMttpDwkIj3f2rldGCImMTofjRVsoKx2IQO7Pc0bsYJNTUc
         0YrLEgp68E/Kgeq3ssS4RgkCYBX4HVl8wJeitb1pPCuh+OwXa08AuRkzDzgH2y+kEJ0C
         2JXg==
X-Gm-Message-State: AOJu0YwuZ9uy44WaJtT8W8WZGHcPbL+wcl5V/PBEODhzQFRtZG5NcNyk
        4JbDgdZrLE6aVwoyxsuMt8SmTaSbnIizrcm4EQ3UCA==
X-Google-Smtp-Source: AGHT+IGDDMM5gCD6SYSVcMwn8Bjh/47KrTKCzkFUsgyPorQbeGqAjOh0vvOtUcO4zGG5I/VRexzOoK4u8GPQqhWlwXA=
X-Received: by 2002:ac8:7d03:0:b0:3fd:ad1b:4e8a with SMTP id
 g3-20020ac87d03000000b003fdad1b4e8amr38751qtb.22.1692296998646; Thu, 17 Aug
 2023 11:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
 <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com> <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
 <a8623bd8-1df4-42b7-4993-006316594818@arm.com>
In-Reply-To: <a8623bd8-1df4-42b7-4993-006316594818@arm.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 18 Aug 2023 02:29:22 +0800
Message-ID: <CAKHBV27W+7P_A1DbU0MBxQ9vzRDR+sPH2SyASKXSr5fXvUwyWg@mail.gmail.com>
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

On Fri, Aug 18, 2023 at 2:19=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 18:06, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 12:35=E2=80=AFAM Robin Murphy <robin.murphy@arm=
.com> wrote:
> >>
> >> The reason it's like this is because of arm_smmu_enable_nesting(), whi=
ch
> >> *is* the additional thing that's going on with the stage selection log=
ic.
> >>
> >> Thanks,
> >> Robin.
> >
> > Right, but arm_smmu_enable_nesting isn't involved in this computation
> > at this point in the flow.
> >
> > arm_smmu_enable_nesting returns early if smmu_domain->smmu isn't set,
> > and smmu_domain->smmu is only set after arm_smmu_domain_finalise.
> > So at this point, smmu_domain->stage is being initialized for the
> > first time. If this code is responsible for handling some special
> > nesting case, then it's probably not working as intended.
>
> I think you may have misread that code...

oof, yes, I did indeed misread.

>
> Anyway, the point of the logic here is that it is not "selection", it
> is, as the comment says, "restriction" - i.e. it is checking that the
> already-selected stage is actually supported, and coercing it if not.
> The default selection for a newly-allocated domain is always implicitly
> ARM_SMMU_DOMAIN_S1 (which is explicitly defined as 0 to convey that
> significance), but it may be set to ARM_SMMU_DOMAIN_NESTED before the
> first attach finalises the pagetable format.

Thanks for the explanation, that does make sense :) .

> Obviously this could be clearer, especially for anyone not so familiar
> with all the history, but at this point I honestly don't think it's
> worth doing anything without completely ripping out
> arm_smmu_enable_nesting() as well. Jason already had a patch a while
> ago, and my bus rework is now also very close to the point of finally
> fixing iommu_domain_alloc() to be able to return working domains, such
> that all the "domain_finalise" bodges go away and that whole "modify the
> domain between allocation and attach" paradigm is no longer valid at all.
>
> By this point I'm not too fussed about breaking the current meaning of
> ARM_SMMU_DOMAIN_NESTED any more. But what I definitely don't want to do
> is have a change like this which subtly but decisively breaks it while
> still leaving all the now-dead code in place ;)

Ack, will drop this change.
