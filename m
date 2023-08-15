Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964477C517
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjHOB3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjHOB3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:29:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A810D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:29:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34aa1a16b14so5678145ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692062945; x=1692667745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7/FNZ+/kn2EN/jZotOHGG2mqO/LoJv2hq7cxgzJU0c=;
        b=lbhrr8uBFXl29L3W+33eTVbMaroAQxnceIFgwppNlBLVMefUy7eDcjWUt4KIW83CMQ
         xs0wxbuqj4QYKrrG3jEbYQxLkNBB8xhyzZJ0lKO+QmbpnDKQ9M3trfWfW5wHK5qfY/Lp
         v9FjwaPH7p249FyuVU1mP8raMsabFvcGvXifimINyHSEWHtcBS9gix8/LRVIO6ed/ekV
         fWjo4sFNJPaFLF9CPk2HCX2nWWfdLtpT4ROFxZ7Bi3nCMQzwFGIqBhkZuTutvViH5wtV
         YOq481ZyyK2m1eDDb/M1cqyOjmErgvSVcyTBfV6BW1bjkGl8smhMibEvhRXkxdRaFXXr
         rKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692062945; x=1692667745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7/FNZ+/kn2EN/jZotOHGG2mqO/LoJv2hq7cxgzJU0c=;
        b=DSjoXA6Mskk5nzyHFHB9TydlkMA2/nWhz4fN6elGDiJ64wcvX2Z6k/vO824qOIHC7n
         2Z1XnbtDO5rgXri4jKiv0sLh9qBrBXZXhvY1FXgZ2SdNgNBvwruiM5b4v3sqdgEbRi5m
         raxEJSQM7xnU8df0OBgRvLSOjURz1yvBGEYTkiaj9RbUxLd8M6zF/VNWT5blzkBBVUC5
         x6VNnUoQOfG9j2Ix0HgV7fWIMF1syJGz98Gi9sCWe68UGvZkGVVyFvJ0Gjjglx85Gmqw
         BhaBzVcdUb2rexCQ2avIf+6IQ6s43slV74H/+Dkf1bNBgPchVpammalrYME33olt9VT1
         SFTA==
X-Gm-Message-State: AOJu0YwuYefmIoFb0xuaKgWW07wB1GcltXGQ/p2nFBT+KK70c4tRLbkI
        nsOjb5+nMUOT2xYUx130qDpDLsXjbKoTjUBTP+E1Tw==
X-Google-Smtp-Source: AGHT+IH9fTgdlitNkb6EBHqBlRxGk0okfJiotZadNreJXeHoK0oyZVb3KFtPGjg2dfY+aKFJWqcw0nu5oBMqLfit85w=
X-Received: by 2002:a05:6e02:1d18:b0:349:862e:a862 with SMTP id
 i24-20020a056e021d1800b00349862ea862mr18151358ila.20.1692062945654; Mon, 14
 Aug 2023 18:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com> <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca> <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca>
In-Reply-To: <ZNOpbac4i5zfmHj4@ziepe.ca>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 15 Aug 2023 09:28:54 +0800
Message-ID: <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 10:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
>
> > Perhaps this question could be related to the scenarios in which
> > devices wish to be in bypass mode when the IOMMU is in translation
> > mode, and why IOMMU defines/supports this case. Currently, I could
> > envision a scenario where a device is already connected to the IOMMU
> > in hardware, but it is not functioning correctly, or there are
> > performance impacts. If modifying the hardware is not feasible, a
> > default configuration that allows bypass mode could be provided as a
> > solution. There might be other scenarios that I might have overlooked.
> > It seems to me since IOMMU supports this configuration, it would be
> > advantageous to have an approach to achieve it, and DT might be a
> > flexible way.
>
> So far we've taken the approach that broken hardware is quirked in the
> kernel by matching OF compatible string pattners. This is HW that is
> completely broken and the IOMMU doesn't work at all for it.
>
> HW that is slow or whatever is not quirked and this is an admin policy
> choice where the system should land on the security/performance
> spectrum.
>
> So I'm not sure adding DT makes sense here.
>

Hi Jason,
Sorry for being late here, I hadn't noticed this reply earlier. The
approach seems to address the situation. Could you kindly provide
information about the location of the patches? I was wondering about
further details regarding this particular implementation. Thanks

> Jason
