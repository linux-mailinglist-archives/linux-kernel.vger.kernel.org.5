Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F9756B02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGQRxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGQRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:53:38 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C91B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:53:36 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48137084a84so1590372e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689616415; x=1690221215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vFofs3943iSVTdX7g+Ij0RCA+3gmMBbIIyZkBj1OkXA=;
        b=ERr18YFzsG/SvYGVCzmYmjcnnPdM5rf+vbwh9Za0AmemltqZkd6bork/eCer2Wuxx5
         lt04ghWzHdI+RYAGk12Sh7/Gi0MuW+CIry5u6wI5vZl+6n5xMSCFv085knt8moaZ1hJw
         NIJQtQa3AoE5JoJ4H1hZ/hl01Q0x8lgwNEgqxSBvDIneU7RVi4UhEoQjDLJ4iGZJes2B
         8odW0pJBlszMBFztGpXJp+wWOtidsw2L/YbV6Hge6NoyJAdxTSAWVGtoI12q1Zxscyqg
         NLGt/VBcxkI54VN0I07c0m75ZR055ngGUNKM8t0rrG55Rea7lwoQskItyH1th9HUvwGX
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689616415; x=1690221215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFofs3943iSVTdX7g+Ij0RCA+3gmMBbIIyZkBj1OkXA=;
        b=hSWnrRSu14mkAF4gBLhY5Pb5xzZ70lWov9Ud3HoRrXBn7GL95qNf1j7Kwl4oHgg+el
         NEksK+zc25kp15seo+kgCjI7aIpSaNHyOoaNavFKjZfNDHNMqqYBMJwgzFA/Upyxtb4c
         lIyqVc+zaCNazDYfTE6UhGdmZxJnGE8ZWSp1xnAUk9YLnjKBR8Efi0Dk4AcW3zo/gZ5R
         iOxiIQgF4KZbgBJHfpICmgkDBDQPiUCHrKVX67U52eeUNaAf9fA+uQygfzEmXuC+M8cP
         /8AFR6H2Gem77HeCOQ+IaIsxMYcrsTS4oWT6h5m2c+m4t2xBNixVJ9TFpqRhFAuq+3AZ
         B/Ww==
X-Gm-Message-State: ABy/qLbTESP3/3pKkYGnhSePFmS6KXBWP5L2CmT9hJ9vkyostqvvdCG/
        OUbEK/QGsq2HEnCSos4GCAF0dEENuLcfs0NhfIpHjA==
X-Google-Smtp-Source: APBJJlEuidatGYmLfJsqEJYVBuLsmXe+VImsGqAeLJarjuy0yVjI5kUdsNb9MZEHyhFCDqh5oWqzbKWigWsV/foSG5E=
X-Received: by 2002:a1f:3f13:0:b0:481:2ff5:c9a9 with SMTP id
 m19-20020a1f3f13000000b004812ff5c9a9mr58017vka.13.1689616415280; Mon, 17 Jul
 2023 10:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230717065535.2065582-1-quic_srichara@quicinc.com>
 <2023071729-shamrock-evidence-b698@gregkh> <2fc238aa-82c1-383a-9dca-72f979ee3c07@quicinc.com>
In-Reply-To: <2fc238aa-82c1-383a-9dca-72f979ee3c07@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 17 Jul 2023 20:53:24 +0300
Message-ID: <CAA8EJpoB6Q5c27-D5HF42+OS7S7bPBGWi_Po0orMxaQ7yx3=1A@mail.gmail.com>
Subject: Re: [PATCH V4] PCI: qcom: Fixing broken pcie bring up for 2_3_3
 configs ops
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
        mani@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 20:16, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
>
>
> On 7/17/2023 7:09 PM, Greg KH wrote:
> > On Mon, Jul 17, 2023 at 12:25:35PM +0530, Sricharan Ramabadhran wrote:
> >> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
> >> 2_3_3 post_init ops. PCIe slave addr size was initially set
> >> to 0x358, but was wrongly changed to 0x168 as a part of
> >> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
> >> register definitions"). Fixing it, by using the right macro
> >> PARF_SLV_ADDR_SPACE_SIZE and remove the unused
> >> PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> >
> > Note, you do have a full 72 columns to use, no need to make it smaller.
>
>   ok sure
>
> >
> >> Without this pcie bring up on IPQ8074 is broken now.
> >
> > I do not understand, something that used to work now breaks, or this is
> > preventing a new chip from being "brought up"?
> >
>
>   yes, ipq8074 pcie which was previously working is broken now.
>   This patch fixes it.

So, you need to describe what is broken and why. Mere "it is broken,
fix it" is not enough.

>
>
> Regards,
>   Sricharan



-- 
With best wishes
Dmitry
