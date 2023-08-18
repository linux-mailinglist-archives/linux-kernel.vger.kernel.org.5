Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31387804EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357758AbjHRDpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357754AbjHRDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:45:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1153590
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:45:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-407db3e9669so109601cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692330331; x=1692935131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH4LP9L3QrJT8d+/R2AdJ28zLhHHmQV+XH1lBPN3qj4=;
        b=VVklt4MBTiZJmwuT732hKQfOnMpKb5FP5g3NY2XwyNITm28HJT/ojjxSqQAKZgYKDJ
         WmK6sy/T+2/J7foKATsAuvm6TQ6Ao3CAZRNbAkovxxn6GLkdatFn7JUran80V2bB8Pbj
         YYyKeQ3ZCehFggvSZgiip0VacxYxJkGI7NRzIffbmjH1AQ9I59PoUw+HtsMbJ22NVUtK
         5HGbWn8cJIzYPQSNw1rgsKFLA+0FllhM8X8UoJBXXMA8EZXskI/BRNmk8Ngi0FSuX7sL
         rnqaD6Mhzx3SRdE9rV4LJlEaUjfzzyPkmPMIzVKFuZwcXyc77Id3P/hteYlVcM/v4NRp
         pDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692330331; x=1692935131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH4LP9L3QrJT8d+/R2AdJ28zLhHHmQV+XH1lBPN3qj4=;
        b=XrjyIQ/bEgjz6RE004Wwset8uV2tg/Rkjz4SYPlRDrIy4Jz0GBWRs/pKzJYZ0P0Z0S
         Z0GG6Fi1DnJRaeLFm33yDmTWZR5C1MVM06w1bHat/NQ2OE8ENUTDmzj1q8yFK42tOHD8
         KhKA+gQW5kB8CzV0u8rAAsPKoAjuewZuzaj+PnW1I5XdrJXJ5U5VcUqR0qiVA1+wATku
         108YW4r28XUZF2gQHrBsf60zEb4RJD2bL1T46bHLKHU4Q+r7J+CmYFyQXi278Rn7GQ1b
         3bHUx+8roAQ/nMJXvPmdLAOfL7VExUmfDDGNINf49KdCQcorDOU16Q6/IHo4ygkXfbCc
         embg==
X-Gm-Message-State: AOJu0YzazrwpoIN2JJV1keFUGilmKung4CSI/kOtl2+eY1Rg1ubjUCEx
        Z7zN6uVKN6Pr+DnfSLJIMo6ws3i1JIY+RNhwtlT9zQ==
X-Google-Smtp-Source: AGHT+IG/BMhxtfee9/cPpC2ZS18i+DFAlUZhyeGLDN74YZh7dgXIhsHPN7BhDqccdIT0wEHPat+IQEQUgA28CM2ZhkQ=
X-Received: by 2002:a05:622a:1316:b0:403:aa88:cf7e with SMTP id
 v22-20020a05622a131600b00403aa88cf7emr89675qtk.29.1692330331033; Thu, 17 Aug
 2023 20:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
In-Reply-To: <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 18 Aug 2023 11:44:55 +0800
Message-ID: <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
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

On Fri, Aug 18, 2023 at 3:41=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 20:20, Jason Gunthorpe wrote:
> > It is certainly wrong to skip invalidations generated for any other
> > reason.
> >
> >  From what I can tell SVA domains should have their CD table entry
> > programmed with "ASET=3D0" and normal paging domains should be
> > programmed with "ASET=3D1". This causes only the SVA domains to listen
> > to the BTM invalidations.
>
> Correct.
>
> Thanks,
> Robin.

Would it be fair to rename arm_smmu_tlb_inv_asid (or move into
arm-smmu-v3-sva) to make it explicit that it shouldn't be used outside
of SVA then? Or add a parameter such as skip_btm_capable_devices.
