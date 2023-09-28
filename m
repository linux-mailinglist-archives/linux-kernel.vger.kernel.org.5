Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93E7B252D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjI1SXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:23:50 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3636AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:23:48 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4527d436ddfso6307075137.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695925428; x=1696530228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lUaiAsD9uV0//FhVSk6Od3pR7CJd+sOtqQwhqcrEfk=;
        b=xPCPSdZov6JOwl5X9QWXEoqop+2np/fyd6BkgmT+MIEYV8h5RElQ8q8crc8KQC5vr6
         bC3Rbt1+11NIzI7QzTmG5skbCttfSHlrcnwTmTmWNWwDXnEiOiZ0EWwAwocs//OnkfR1
         OQxdRZ4NfLGrHad0WUTNcok2txcRONeUSkxUfoJynysh2TUkIJJjM45+wEOSkplSkeIF
         wRKIkHqT+nCyUXN6+gD5u2SkbiKACi+IE+elN3OQZ3FEvcryQyfAHfuHJK95DQ2xqVNy
         HlMRmTdHctv5QsRvlPlYtzFNkm9FJEcGOpYnmHDVPTb6+NDCd6OHCOz1HIDtd93/RvfU
         svJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925428; x=1696530228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lUaiAsD9uV0//FhVSk6Od3pR7CJd+sOtqQwhqcrEfk=;
        b=ANAtv58fyAvVS3ybYpc1EZTZsLidWaYCcO3rbZk72NLskDZUuGd/uNcReAfyp0ujQj
         NKz44FfuPNdjsb6y7oH5bGBNHAVY0onXv+WdiDaczm8Bhzj+xeRcbOQehHd23cv0pWtU
         QPlODic9ejrYMfxyv9EDYQvZwBZDIuVcTnr85XkorBVkAbzIzRbV7S7yBKq/WY5Nyceb
         rwC/LUwUC1SlTmsT3MAEp5KI/2jb4OBPbvx9r0sPwiP0yqRtL9GPc4Pljqd0iKc3cnKD
         HXfBd9T+YGeIzpFvA/Wm8FbCxbHbDwpmjN2GOkK5ZqJk8P3kLbQVC+TapAxeOevTTLEG
         /OVw==
X-Gm-Message-State: AOJu0YxABFD6csvpv0O9Uorm3xqSAnj9plL3aQz7Dg/1oG8An3UmyC0o
        UpZHaoSjLhdLRdgyN4FOJba62bkpettmR1niscNNsw==
X-Google-Smtp-Source: AGHT+IGJDuok+EkGthTBLrhPMTIfi4D8car2cm/ywKltBjmQ+vwJOCAjivQg7Xfj8u0+3jc8LrVtBF53Amql/LCtMEo=
X-Received: by 2002:a67:f754:0:b0:452:7f81:1502 with SMTP id
 w20-20020a67f754000000b004527f811502mr1905774vso.26.1695925427931; Thu, 28
 Sep 2023 11:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230928092040.9420-1-brgl@bgdev.pl> <20230928092040.9420-3-brgl@bgdev.pl>
 <be27a31c-6c63-43cd-9857-f4b2a9568cf6@quicinc.com>
In-Reply-To: <be27a31c-6c63-43cd-9857-f4b2a9568cf6@quicinc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Sep 2023 20:23:36 +0200
Message-ID: <CAMRc=McCqDLQaDP_ordNgHi3-7bGH2Y6H-JU3Uwyh0SOe_BYkg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] firmware: qcom: scm: add a dedicated SCM memory allocator
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 8:19=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> > +void *qcom_scm_mem_alloc(size_t size, gfp_t gfp)
> > +{
> > +     struct qcom_scm_mem_chunk *chunk;
> > +     unsigned long vaddr;
>
> there are places below where you unnecessarily typecast this to its
> given type
>

Ah, it's a leftover from when this variable was of type void *. Thanks.

> > +     int ret;
> > +
> > +     if (!size)
> > +             return ZERO_SIZE_PTR;
> > +
> > +     size =3D roundup(size, 1 << PAGE_SHIFT);
> > +
> > +     chunk =3D kzalloc(sizeof(*chunk), gfp);
> > +     if (!chunk)
> > +             return NULL;
> > +
> > +     vaddr =3D gen_pool_alloc(qcom_scm_mem.pool, size);
> > +     if (!vaddr) {
> > +             kfree(chunk);
> > +             return NULL;
> > +     }
> > +
> > +     chunk->paddr =3D gen_pool_virt_to_phys(qcom_scm_mem.pool,
> > +                                          (unsigned long)vaddr);
>
> unnecessary typecast?
>
> > +     chunk->size =3D size;
> > +
> > +     scoped_guard(spinlock_irqsave, &qcom_scm_mem.lock) {
>
> my first exposure to this infrastructure..very cool now that I've
> wrapped my head around it! This helped for those also new to this:
> https://lwn.net/Articles/934679/
>

It's amazing but be careful with it. I used it wrong in one place and
got yelled at by Linus Torvalds personally already. :)

Bartosz

> > +             ret =3D radix_tree_insert(&qcom_scm_mem.chunks, vaddr, ch=
unk);
> > +             if (ret) {
> > +                     gen_pool_free(qcom_scm_mem.pool, (unsigned long)v=
addr,
>
> unnecessary typecast?
>
> > +                                   chunk->size);
> > +                     kfree(chunk);
> > +                     return NULL;
> > +             }
> > +     }
> > +
> > +     return (void *)vaddr;
> > +}
>
