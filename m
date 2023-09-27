Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3227AFD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjI0IEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjI0IEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:04:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED0191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:04:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bffa8578feso178523101fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695801881; x=1696406681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HK/8Dajte472KzlqsoW1YYI86LGqovc35i9+35GKRvo=;
        b=UJo9Dx6EqyAYAUBmNa3UMbh8yRolRwSGuN7RYptpBdwanv3UuYKhL/F+gMOpadwm6H
         edTrMYnwkhc71Wuk+MvXjLCUacuzhQf3trj7n1j3aSZJwaz5chLDBUpcrtjUM0dXSM4D
         AIck4CJvF6h2eHcpfd1eGb0s7fjamVkiglUZx/9txk9byIDhSC2VGnxgI4tFFAeEZgMA
         MADM67NKTP4Ltg4iwOiPB91UwnJIyNRvC43BMnf3WjoKivykYQESMJh5ZmDalvJekKt6
         gD3vEirm/ctzvVJl8w7gxa4Cq8BDIvtRrDA9/WhMCPZ7jXBRj7L81BWDPYNI71TvAYto
         rvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801881; x=1696406681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK/8Dajte472KzlqsoW1YYI86LGqovc35i9+35GKRvo=;
        b=mgTGC7t4TVcS1E0SSaM9xXgrehE9MLl0N8ozaVdF1R0piSfM/DSha8oX9N9zsJ05TC
         CG415uLBxuuNG7aP5oz5wsF8XOibPwOfEmTr4fCocTQfXj5lhTTg7JLDlxg16PUgMU8v
         1uZr+NIwQXqmUbniF+IynHoxJIPaZMvkzTtzptqaxoVduTApaE0+h3yog3aMsDQVwiUb
         mb4pB65LACoIJz+2RqnLMoSX6qRPXkPQYT07L5Xky4guewULF/iS4MCnEtscugxa7kcF
         mKnGV4EADKFN/VdcHOfCVwJPb5GhFFUxZJ8dsteyHkTFPKtb1ch24g90t+x8bcRgzuen
         1j/g==
X-Gm-Message-State: AOJu0YzefEIDSNfiRvlGolt4IbeWKMb7IpEA+KatSqNWC4VSP9pYocqs
        oY47z6LVTftdt8TMbk2TOcnen+UmnnqgkMlc1g6SdYR/Y/r6lBoj1sHVsQ==
X-Google-Smtp-Source: AGHT+IEZiqCCfFdYdxhBJFji3jZg8flP+hiyvqepe1yVonPxH26q/oTC8hEiCRjYYWJvK9nVjA8/SrSKyVrYJv72jJM=
X-Received: by 2002:a2e:a230:0:b0:2c0:2b44:6eb7 with SMTP id
 i16-20020a2ea230000000b002c02b446eb7mr1300087ljm.35.1695801881296; Wed, 27
 Sep 2023 01:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com> <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
In-Reply-To: <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
From:   Thomas Fossati <thomas.fossati@linaro.org>
Date:   Wed, 27 Sep 2023 10:04:25 +0200
Message-ID: <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> On 9/25/2023 9:17 PM, Dan Williams wrote:
> > +++ b/include/linux/tsm.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TSM_H
> > +#define __TSM_H
> > +
> > +#include <linux/sizes.h>
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +
> > +#define TSM_INBLOB_MAX 64

I guess @inblob is supposed to (possibly) accommodate nonces from a
challenger, correct?
If so, 64 bytes may not be enough for attesters that produce
EAT-formatted reports -- see [1], and [2].

[1] https://www.ietf.org/archive/id/draft-ietf-rats-eat-21.html#section-4.1-5
[2] https://github.com/ietf-rats-wg/eat/pull/421/files

cheers, thanks
