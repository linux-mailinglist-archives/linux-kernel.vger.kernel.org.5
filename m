Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEB780445
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357478AbjHRDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354995AbjHRDOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:14:49 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4232D56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:14:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40a47e8e38dso104921cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692328487; x=1692933287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtKRWgsVYEk0AE4kXRg/bBTMvFeVJKaONok/07eRRfk=;
        b=e/ppolFHXl/w4/fZqOofZftT1+guGIUrHqLDGQvNmOH84d1gVNbvskv7YSNzONyR5K
         IHEBAWxt4LUNiq9xpHQyZxH7k70dRPsruyTkBvebx69lHDVB9N2kjcOZq2ewsHFiponN
         avEYBSjXHk3wHMdAdEb6fRc+kK4D3Cc1Y/TM+EcC5HBBroe0yR0eXvJVIXC/f+h35RBE
         GfkJFH6sYe+otEwwyumQwFNMrl2D/fCTPpDIrFnD3sq31A28XrwHTdQ8XYSu388ELOlD
         FYr2W23FCrQYBv2OJtB074n4TXwkrdcxJAXtrrVGvSguOdU+22gCyO68EvaRV9fbT+ap
         HxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692328487; x=1692933287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtKRWgsVYEk0AE4kXRg/bBTMvFeVJKaONok/07eRRfk=;
        b=Y0rlopZG+EE3uwYtva4yy01kE0gi15HgN4yLd4mnFSQIg/7lkPbotG2NDTHtrWcQjU
         UEwzeZ5qCCGOSd3uTFlcIU3BPc0RMUTjUwaJL3RgMOSDB/kBOX08VKQ9xrWpIxxfMqcE
         f+BqiZwYP6F1oiXHkFq9pyapeDGZk6jMgR38dmZkTEbIafJpMhraWOrH9Evgkxl6vocw
         JZfMXTt23w0Jq9MtITxy3xaI4guuAejU36VGr+Ap1kWr2wxWcuvxEDbahhyEm6XUwYpK
         MkWH+6nYP6TvJglJFMIqzXTWRyO+mWzYWMxoTeaG0BbrbiDHb2szCQGU2+bh2JdnAOYl
         aoEQ==
X-Gm-Message-State: AOJu0YzUPj1f4feWr8Rw4kLTc82LABL6tD5LyocyMxVwWvmjx9t5Aeqv
        uhxGtjZKSPsWkhUelofnSWW+z1v5ASLsghHg4Q7ziA==
X-Google-Smtp-Source: AGHT+IEdemrJerkEcXSt7+cE13JSwoldzgu3SXHNXtW9xol//Bv/TIibebBEZGjN41Gg8Ave2V7feet9RAbbEAKB5WE=
X-Received: by 2002:ac8:5914:0:b0:410:8114:1077 with SMTP id
 20-20020ac85914000000b0041081141077mr14560qty.4.1692328487455; Thu, 17 Aug
 2023 20:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
 <3fc6ba4b-1e40-b835-06b9-b6d40f916d75@arm.com>
In-Reply-To: <3fc6ba4b-1e40-b835-06b9-b6d40f916d75@arm.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 18 Aug 2023 11:14:11 +0800
Message-ID: <CAKHBV27xxvzK55C7nT8HgcF2G6SpF7ssxYK7D0+t_dS6PODE5A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/8] iommu/arm-smmu-v3: check smmu compatibility on attach
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

On Fri, Aug 18, 2023 at 3:17=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 19:16, Michael Shavit wrote:
> > Record the domain's pgtbl_cfg when it's being prepared so that it can
> > later be compared to the features an smmu supports.
>
> What's wrong with retrieving the existing config from the
> io_pgtable_ops, same as all the other io-pgtable code does?
>

I didn't think accessing the io_pgtable struct outside of io-pgtable
code would be ok, but now that you mention it I do see usages of
io_pgtable_ops_to_pgtable in iommu drivers.

Will change.
