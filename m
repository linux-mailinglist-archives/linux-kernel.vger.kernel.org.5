Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCB7C6E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378572AbjJLMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJLMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:40:05 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19683BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:40:04 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b5fcf9c682so475717241.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697114403; x=1697719203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt8LJtLvFa4Rzelj/hCcBlEMqvvZSzgk6VKh35H7YWM=;
        b=fPAEQabfeDqCVs8GUtBuBzLBBoUIcvL34EsFfMkrUVbVQ8GOjDAgrhfHRx8bWVqK2z
         tCjbp7HxOK86VfpTwja7YMAbmZVy+cdRdR5PbPJaiZabII/Uq7VC9j1HvBWEOUmByZcA
         9C0xmoKighMuAXojl/wGTFuQ/PLmFnJed+KBwbNbsm1zZzxjvkbb+bnSWR3TEksveBZq
         nQFAIpBQdLwkokcS7tLfsSEAbWyNRdEExKMCGWZy/ObI8miWALufWYRgjQ58qmu4zGFs
         /5MMZQ+IclGFarAhoHrh4nF2ZRiSaJahsakhciDGmrBDv82GEixcoIOpJm6wTk02D3Cs
         /twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114403; x=1697719203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt8LJtLvFa4Rzelj/hCcBlEMqvvZSzgk6VKh35H7YWM=;
        b=RtdsOKlj6Q+uB9PIIAJ4JRHp8wRU8Yl+sBCGphp+Q+gkej0Dmv9ckZi0UhtAyKH+iC
         gqmP9nRBiqpr+mrplcgocqEaaABe3AP5Ohmo08H0QC1IyzktmBBVLnMjNHqJMf14G98q
         jD/tigHBPnvhBSOkhZb1s9408eXAZIMQ6hVyj6QkoVxz+9GKhs7eyKPtnxJ4Rt5g8rx5
         E/RDwJAx2f3CLLpBITso1zOCUOrcuEA5N09AUFUBU286tkHf/NQ8AILp/gIycrjNf/ML
         PpjFgIZO1XgvtR0gPvVCqQheZSoyENmnNnvcknYr1VSyZVEKAeUSmdwRDIJBm7QdNlci
         WwcA==
X-Gm-Message-State: AOJu0Yyftt9V+LozROAMJBxHXlRwDOlk3e5Gc78/ekQL6InH8JL9mj4D
        3dJVxsy6Jkid9xi7cxfWJfQuivT6p+JL9rG/nGwCRQ==
X-Google-Smtp-Source: AGHT+IH8F07zsjW2qJRYYsYomNNTFA5ZGGtiXc/akliAtQg2/QM2cVqH2ztjtlh0j8rumFqj96vDeFaycWrenUJQ5SY=
X-Received: by 2002:a05:6102:54a7:b0:457:a915:87ae with SMTP id
 bk39-20020a05610254a700b00457a91587aemr4810545vsb.18.1697114403066; Thu, 12
 Oct 2023 05:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230728134832.326467-1-sumit.garg@linaro.org>
 <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com> <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com>
In-Reply-To: <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 12 Oct 2023 18:09:51 +0530
Message-ID: <CAFA6WYOZPD+y0SOQTCih8qf5_FjX6DWtPTki13MM8J8V8LaHMQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
To:     Jan Kiszka <jan.kiszka@siemens.com>, jens.wiklander@linaro.org
Cc:     op-tee@lists.trustedfirmware.org, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 20:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 29.08.23 13:03, Sumit Garg wrote:
> > Hi Jan,
> >
> > On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Currently supplicant dependent optee device enumeration only registers
> >> devices whenever tee-supplicant is invoked for the first time. But it
> >> forgets to remove devices when tee-supplicant daemon stops running and
> >> closes its context gracefully. This leads to following error for fTPM
> >> driver during reboot/shutdown:
> >>
> >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> >>
> >> Fix this by separating supplicant dependent devices so that the
> >> user-space service can detach supplicant devices before closing the
> >> supplicant. While at it use the global system workqueue for OP-TEE bus
> >> scanning work rather than our own custom one.
> >>
> >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >
> > I see you have marked this issue as resolved. It would be good to have
> > your tested-by tag if it works for you.
> >
>
> Sorry for this very late reply. We finally validated that this works
> fine for us, though only over 6.1, our current test target. I hope we
> can enable tip of tree soon as well. But I think I can still add my
>
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
>

Thanks.

Jens,

Can you queue up this fix?

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
