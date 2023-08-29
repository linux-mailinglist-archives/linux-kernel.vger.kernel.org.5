Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F878C44B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjH2McP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjH2McL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:32:11 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CEC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:32:09 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-573675e6b43so1946674eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693312328; x=1693917128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/eeGQZOZgf/VFrLfirDtZ7jaPLnwry16F2Zl406iUWw=;
        b=f5nhnLL8+0mo0OICZLWGgBoBmkSgI0vCSvgafFWPOqelteEWNZGk6/ycmZ9V7bRE3S
         dmQIl955d9ezZqXpqQ6oBftVVy5cxNyMUvCCgEKq00dJ4M/6SPLgnmjdpI20+NnSVHDb
         y4r5SmEbvhh5m31AGz1Mc0436ar/lz1U6vXaCmLjdieG/tzTn2lQA0uEO5JfOI1EBpXD
         nbtO3icGy0Piz+32pxN1ndiuk1eUb9M6YkPxz0TxCcV5RF21qBJ7zWFyUk5wC4buI0A/
         C6b9zjO19Kj++rrzAajWB2pidDGJA2r2L8bq4xS6wbfVwbnYn3AWdMrfJ65Tx2LoPb4l
         YIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312328; x=1693917128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eeGQZOZgf/VFrLfirDtZ7jaPLnwry16F2Zl406iUWw=;
        b=CAQTeYY6Jl93UMXrTDaQdByXXs+rWSXcg73/y5idWiIpYtsrOEdzXJlTnjW8zFbCUK
         E+aOY5P7ZSVcEc/dq8mQf8rAw9KMOzSHyghih13tp+Y7fEV8LI0UuDwmcyYWz3TCdESR
         nMG526vq2C/bC2BABN2f9B8a7drJaPtXYSryncd3jdtU6ye2GTHut6jhjLld6UX0wDxz
         6tHbkBA2ChixSVT0RVL0j6ve5gatwLN/K+Ej2x+Ul4U3u/YYfRWoGHY6z1bMtEctIwyq
         w774HSLDYzkB0vhLqyGnjpgGGWZRGwruDGPS1BI1We+mCYQLnkLOKAQkYDMlq7wNiGeA
         kVeg==
X-Gm-Message-State: AOJu0YxcRBrgLMnomo7rFaeIARnGEQFyUUOavHZ5gbRYXx7nLvIEFVrj
        Feystedazb1+S414SEDINggYog7ZUcgxwkUaMEzI7g==
X-Google-Smtp-Source: AGHT+IEy5HlFBzwFRYUGxsn67gMYLLkQqUgpnkLX4wFSOFgSv18K1jKYMlNfiEOsrveXKrBKr09DzbKLVKHnwrLzYJw=
X-Received: by 2002:a05:6358:921:b0:13c:dcbc:375c with SMTP id
 r33-20020a056358092100b0013cdcbc375cmr11309549rwi.21.1693312328578; Tue, 29
 Aug 2023 05:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-4-bartosz.golaszewski@linaro.org> <cc35c729-df33-087b-2df4-95e8cc174ec6@linaro.org>
In-Reply-To: <cc35c729-df33-087b-2df4-95e8cc174ec6@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 29 Aug 2023 14:31:57 +0200
Message-ID: <CACMJSesDZw6i6jb05kY2iN=Qf3Ln5f6Yz5gdrkoFk86NnNv1Gg@mail.gmail.com>
Subject: Re: [PATCH 03/11] firmware: qcom-scm: atomically assign and read the
 global __scm pointer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 09:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/08/2023 21:24, Bartosz Golaszewski wrote:
> > Checking for the availability of SCM bridge can happen from any context.
> > It's only by chance that we haven't run into concurrency issues but with
> > the upcoming SHM Bridge driver that will be initiated at the same
> > initcall level, we need to assure the assignment and readback of the
> > __scm pointer is atomic.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom_scm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 980fcfa20b9f..422de70faff8 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -1331,7 +1331,7 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
> >   */
> >  bool qcom_scm_is_available(void)
> >  {
> > -     return !!__scm;
> > +     return !!READ_ONCE(__scm);
> >  }
> >  EXPORT_SYMBOL(qcom_scm_is_available);
> >
> > @@ -1477,8 +1477,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >       if (ret)
> >               return ret;
> >
> > -     __scm = scm;
> > -     __scm->dev = &pdev->dev;
> > +     scm->dev = &pdev->dev;
> > +     WRITE_ONCE(__scm, scm);
>
> Your re-ordering is not effective here, I think. I don't understand it's
> purpose exactly, but scm->dev assignment is not WRITE_ONCE(), thus it
> can be reordered:
>
> "compiler is also forbidden from reordering successive instances of
> READ_ONCE and WRITE_ONCE" <- so compiler is not forbidden to reorder
> other stuff.
>
> "Ensuring that the compiler does not fold, spindle, or otherwise
> mutilate accesses that either do not require ordering or that interact"
> <- which means you do not require ordering here.
>

Hmm, I had the list_add() implementation in mind as well as examples
from https://www.kernel.org/doc/Documentation/memory-barriers.txt and
was under the impression that WRITE_ONCE() here is enough. I need to
double check it.

Bart
