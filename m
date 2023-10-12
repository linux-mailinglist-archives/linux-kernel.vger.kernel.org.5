Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85D7C6B33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377837AbjJLKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377651AbjJLKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:33:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E1B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:33:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ba081173a3so132727366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697106806; x=1697711606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+trYhH6pdvjtTzpwC/GNcRs1Ixqq8ebN0gecPy8EoRE=;
        b=S5WNP29LFGtZvS+T7bFNweVOsMtA4mcF1waPNwO69s7r7oQWvuVA9Jx2Kd2FcqF+XS
         R9Clxu4rUt9m9YlhIqgYUTEijaFVXC26VK66hQaqfwQsJ/bIDqwYO9il21mt+tSmzJ3X
         LH1WiUK71p98w7uyZCowDQ1mnYoVmzTVO8xNA3UUclAbFbgLNgzOMmmofRqqhTEnl6c+
         zQM//QWRMbW82ubCYXEMfaFR2NWfTiZXMzGeMkEdJ7FkSox6Oo+u3G1zGp1g5izf8QRO
         s4cubwYSBVZwJuCvq3dM1D1Q3Rg+47S9OulN5L4VVkRoiJBXDrzzL/fjuNO1xs7AfSxL
         YGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697106806; x=1697711606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+trYhH6pdvjtTzpwC/GNcRs1Ixqq8ebN0gecPy8EoRE=;
        b=hfLOVXmlMX1IUxoJDGrz0W7sMYi5MkNFo1wX8I6J5l1tbYurZ7Omqg0qUy9QHfkQN5
         qjAkFKi8pid+H9094FXFfK3eVdNBVAP76YzGevdwaqmrplIg1nk5AiLkDckUnNv77sjO
         oGG7OlbDGRL5IVut32/cBl4BLPShvxFbpri9uTQPaGKRYzyeaPaHQcO91HTpJZh2LksU
         WZpj/zvlnS8fjdLe088/erB91LLTlJqXrTr1ShXHhMcHuKkcFhyUFiL+qABR+jx26rux
         C0Umj0DS1E8DRmb8VkJaWHP2TPEGkDmsTygQXeF2biFIBBuPw19e9t1/OGiKI2dJOwK2
         mSvQ==
X-Gm-Message-State: AOJu0YwppGGURUKP+jOfj0Ek4Ysf7sxlxs97hCqJoSIEYHZXUor/nboY
        dIq2Heqx/iVaZOebOPNjvph4APUFP2RZ96dyvyM=
X-Google-Smtp-Source: AGHT+IEoaB7SxZK8hFiCbD0c+W1n4JETZOdvrlo3gJ+KsJAs7mMU2QDRBvipZgMugULsUgkZhMfURFQaMQedjh8/nA0=
X-Received: by 2002:a17:906:8b:b0:9b2:bb02:a543 with SMTP id
 11-20020a170906008b00b009b2bb02a543mr23857083ejc.74.1697106805715; Thu, 12
 Oct 2023 03:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230820215320.4187-1-dakr@redhat.com> <20230820215320.4187-3-dakr@redhat.com>
 <0c50ff22-0f11-1e27-c32e-694ce2b1e6c5@shipmail.org> <ZO864yp3UyVEfEjz@pollux>
 <88c45fe6-0942-707c-9ea7-8486c177fcd7@shipmail.org> <ZO9Zq2RhbX8EeHrn@pollux>
 <736b6b6d-9e04-a27d-7d60-0c45d696b304@shipmail.org> <ZPB26A0/oLHTmyqk@cassiopeiae>
 <a8f28d62-daec-927a-a33d-5be3eec6a1ed@shipmail.org> <ZPDk/lao1JlBNGoJ@cassiopeiae>
 <8a8253ae-0b85-df90-b480-64eeebfafc6d@shipmail.org> <CAPM=9tz3o-m+8VJJ6hxWhykat0kpp1UE7dBJE3X91aHHo1Y2VA@mail.gmail.com>
 <76963abd-77a1-4bbd-9537-7b230e648a90@amd.com>
In-Reply-To: <76963abd-77a1-4bbd-9537-7b230e648a90@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 12 Oct 2023 20:33:13 +1000
Message-ID: <CAPM=9twSHGRoSoXxG+hz1T8iBX2VgPFvFsNCDnK_nHW9WJYBtw@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize
 dma_resv/extobj handling and GEM validation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Danilo Krummrich <dakr@redhat.com>,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 17:07, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 10.10.23 um 22:23 schrieb Dave Airlie:
> >> I think we're then optimizing for different scenarios. Our compute
> >> driver will use mostly external objects only, and if shared, I don't
> >> forsee them bound to many VMs. What saves us currently here is that in
> >> compute mode we only really traverse the extobj list after a preempt
> >> fence wait, or when a vm is using a new context for the first time. So
> >> vm's extobj list is pretty large. Each bo's vma list will typically be
> >> pretty small.
> > Can I ask why we are optimising for this userspace, this seems
> > incredibly broken.
> >
> > We've has this sort of problem in the past with Intel letting the tail
> > wag the horse, does anyone remember optimising relocations for a
> > userspace that didn't actually need to use relocations?
> >
> > We need to ask why this userspace is doing this, can we get some
> > pointers to it? compute driver should have no reason to use mostly
> > external objects, the OpenCL and level0 APIs should be good enough to
> > figure this out.
>
> Well that is pretty normal use case, AMD works the same way.
>
> In a multi GPU compute stack you have mostly all the data shared between
> different hardware devices.
>
> As I said before looking at just the Vulcan use case is not a good idea
> at all.
>

It's okay, I don't think anyone is doing that, some of the these
use-cases are buried in server land and you guys don't communicate
them very well.

multi-gpu compute would I'd hope be moving towards HMM/SVM type
solutions though?

I'm also not into looking at use-cases that used to be important but
might not as important going forward.

Dave.


> Christian.
>
> >
> > Dave.
>
