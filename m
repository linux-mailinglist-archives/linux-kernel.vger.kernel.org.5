Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E374C77631E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHIO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjHIO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:57:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18EDC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:57:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-406b9bcad5dso35653511cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691593070; x=1692197870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMhr6QD+95gO3zovNgjrpdIT5cUPg1o1tOLgZJnwGY=;
        b=hLXQVlNLelozyJU+bMnYuq1dfWyKA32ocR+Yqn1lylxJDEsL6wr0oakubcd0IMsOhS
         NVqoyF2vVCIqlBuVQrG5aJE7INO9gJqQzauN7dyqUmmVUcqx9L+3sgjIjFX2QO2ClYJy
         rvFmhdqeL9nEFIvBLrUZ3m3uEBjmQRBpk9XK/ms2KoLHID/+dtoBpdjBErcu/OLHrQF1
         HyXFnoMmG2QhzyiCj0Z4W99t1UYCtTkmO79eup9BPRlQ0s+SFxkHR9C9+/n9yTI5x4Rz
         dtMyCPqw9hxolBatOIPRnHBRQHeBxUpZC/rydY1bBkD4SD8ZCtZv8QeM/QOAd6D+yhC0
         YY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593070; x=1692197870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpMhr6QD+95gO3zovNgjrpdIT5cUPg1o1tOLgZJnwGY=;
        b=kWJ1PCiVdHW1DYZr+6c5SzeI87W2HjUyhPeorz2G1YwviFO5HDIF5vAP1UvKZgHuX3
         +yX0vjdQtXXdGJEECPqxOjHuACY00GJjRm9W6g63qMBUHUGvMpPaEbBu+qv1lp7Jksuv
         Vf5p5D7T877c++wayStmDrk+fDbDzS3GRJn5Nv92A+olfvVN5EjXgp5C8mr7Fc6an7vn
         DBd6DeFjIA3iGuN6ujrLUvInofkdcUg8Cf8wFZvfoO0oHiO04YmfYMlp4wMpkqb7o6Zw
         Rq2JAJ/VaU4YXGQy6I8O2lmRHRXleFDObstW7cB3kKqo7nEsTfx7Me0Hvdv13kwvOIaf
         HsiA==
X-Gm-Message-State: AOJu0YwrzxsUzaxLDNVel3wSz8dEwIAFMqgLylIxBO81vxyHVRpLTGBr
        NWhYFoRTpnpJwuI/VhKestyOtQ==
X-Google-Smtp-Source: AGHT+IF/Eb2IIrd1xEjQy4quw86/nLSkYTOnDYFOrxCFoJ5y6Vyhcm86eTM1GOzIdk8SC98VBkH6Aw==
X-Received: by 2002:ac8:4e47:0:b0:405:3dcf:1182 with SMTP id e7-20020ac84e47000000b004053dcf1182mr3857027qtw.50.1691593070645;
        Wed, 09 Aug 2023 07:57:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a148c00b007671b599cf5sm4017361qkj.40.2023.08.09.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:57:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTkdB-0053kn-JN;
        Wed, 09 Aug 2023 11:57:49 -0300
Date:   Wed, 9 Aug 2023 11:57:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zong Li <zong.li@sifive.com>
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
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Message-ID: <ZNOpbac4i5zfmHj4@ziepe.ca>
References: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
 <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:

> Perhaps this question could be related to the scenarios in which
> devices wish to be in bypass mode when the IOMMU is in translation
> mode, and why IOMMU defines/supports this case. Currently, I could
> envision a scenario where a device is already connected to the IOMMU
> in hardware, but it is not functioning correctly, or there are
> performance impacts. If modifying the hardware is not feasible, a
> default configuration that allows bypass mode could be provided as a
> solution. There might be other scenarios that I might have overlooked.
> It seems to me since IOMMU supports this configuration, it would be
> advantageous to have an approach to achieve it, and DT might be a
> flexible way.

So far we've taken the approach that broken hardware is quirked in the
kernel by matching OF compatible string pattners. This is HW that is
completely broken and the IOMMU doesn't work at all for it.

HW that is slow or whatever is not quirked and this is an admin policy
choice where the system should land on the security/performance
spectrum.

So I'm not sure adding DT makes sense here.

Jason
