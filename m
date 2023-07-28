Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB8766B72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjG1LMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjG1LMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:12:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47457FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:12:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40550136e54so267681cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690542742; x=1691147542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UotFYhFco/Iuol2S9aBRnr5uMRdY1d0OsmUPUsVhPM=;
        b=0L3um8XwEDIm9CcfzBp/NYrL85AoBsHWAlMSlr7GgXtEvGgtiWnhtu6EwyGQQ1d7zz
         AriaGx/fxqbCxALqypqcx3XHMvQMPCahpECFIwwG8OJaeZp2KFaxlJ7YaKOgY+NmZiXV
         fiYp+e/DGKkNnFLp7NLmF4U1JnB6t93ATJPlIH/nTRm49efbbJddQOz0p2ZsjJwrdnvW
         pn+8bVAL4J7hLQaz18rq7z4+FXCH8txBA8etD/L6Q4+xvT1Fk+XGYhL5hicUCx/jS7Pd
         TPiQQ/GTdYyYVidRoDWE8C/+kPpwU76KeIIQfF9c49GoFI2QTJQP08uHENC1SKO4QG1l
         /FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542742; x=1691147542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UotFYhFco/Iuol2S9aBRnr5uMRdY1d0OsmUPUsVhPM=;
        b=J7FOZqgKAlq8qvy015UIR4pdwuwPjQA51y/ci41RZhXKa3Kcey5JQttjrBOJzDflSh
         yUuqVrtD7kfVhHAXIMPlc7x4cqtl7++0FMhJNNpDMEJDd4LPwp5x7Z5hxp9VO3RcpVvz
         /lv3z9jHfytDQKgOfwvWZ89dobhhXWCKi+IUdDZ67SVerWDHsa519NYnW58SHM4rCapJ
         mH/XGPsc6qjjS8RuNRZ784eVXqZoFP9Zzt0lkjZKxGlELnimwCyER7W7hmwQDkjM4UBS
         U9bU1h44LHprtW4KtWvcvYgqg3cJV/4SDqQ3P6Nsi9yT1Qb4Vcn9vUHowaLRZ/JcqWAx
         BG8w==
X-Gm-Message-State: ABy/qLaK64O3fuPmGbOvsjixuW5XsVDWI0wfESNbKR9RBE8FMO7wwklz
        vFrpN3Cju9AF6lnbxU/i+DQOp7YBfE56zTbviMFjZw==
X-Google-Smtp-Source: APBJJlEmRPcQvTvFDB4kprRSijQQyenOpD6f2/GYwYu8xjeFnmK2hJdA90/7qhPXaeRigESpHEqLIYuGN4K8DNx9e7g=
X-Received: by 2002:a05:622a:1301:b0:403:affb:3c03 with SMTP id
 v1-20020a05622a130100b00403affb3c03mr201911qtk.10.1690542742215; Fri, 28 Jul
 2023 04:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-8-mshavit@google.com>
 <ZMK60wm3BBk038r7@nvidia.com>
In-Reply-To: <ZMK60wm3BBk038r7@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 19:11:46 +0800
Message-ID: <CAKHBV24QkjnLKXp1Hewo1nTJnBTPdJWxiSfiXdNPZG=zqQWFqQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
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

On Fri, Jul 28, 2023 at 2:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> Then you can put the free in a detach op once the CD table becomes
> empty and it behaves much like it already does.

This turns out to be a bit tricky; the SMMU driver detaches the
currently attached domain whenever a new domain is attached with
attach_dev(). More generally, do we really want to be de-allocating
the table whenever we switch between an S1 domain and other domain
types that don't make use of the table (such as IDENTITY or NESTED)?

One solution is to defer the allocation to the first attach_op, but
only free when the master is freed (this patch's v1 behavior).
