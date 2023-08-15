Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9B77D200
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbjHOSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjHOSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:38:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51B1BF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:38:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdeb022738so13103205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124706; x=1692729506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sF+cwDNQT+uZaPiDDTMoz6OzsKpTvp3erzo3Rj0grKs=;
        b=dv7XIkl+hk3kQfxv13TRju7OfbWc6xtCFh3vJAocizGBFya10lRk+XpWtRfdN+DyI1
         44H0sEMPGXExXkU6incGJ7STzLczFbH5I1sZKjk7rxi+Q1dK4mhmfQU69wTgzXkEI1dP
         qPoT3nsDQP05EqETsqVoVjdNO6N1yg7BjaIlH3tTT+rqTTQ4Zf4Ax5GD0smTlvHNxDps
         W+Pb+lcTnXYWIZuCv4eqaIh05DOh+c2iajzX+TPpZ/BZY1eOygOkJnxKf5JcpQCQD7zs
         3U7myd1FR4JCVPG3Dn8RWGRAB43csZKlbZs053c90bUHTOjWarMGlg5iqBy3jwVrAGEQ
         0QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124706; x=1692729506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF+cwDNQT+uZaPiDDTMoz6OzsKpTvp3erzo3Rj0grKs=;
        b=cbaxiwLgS4KWS54qoGT3QmPNnMY17yT3629afPQ7dikw3WAUlz0J5FPyUe3a5SEXhg
         CUJM7DmR8P6s9h9Q9mYgziFDHfe55nl+e14Aw0AP2jsoBiU3/6VTN6sEjUUbkIMbEm86
         3WYbg+xCTkEjp/kV6z1ZCDVt8rP+Gt4PxFJWdYp3t2rnupeTDeLDJ8Z+lQ6bCYalPZNj
         C0RF1MFPFZ5KYHujoDf9M8QG5g366Am3bc+ZBl7+zl2pUq5WDcOiUkciIV74OKQ01KJ6
         teRr4ngQdsTVnTRprrXz1V5HeiWHN6im9RdHK5qAV2ZagrSznA3cclwkoOxjAnrHcP8V
         6z9g==
X-Gm-Message-State: AOJu0Yx6b+X9QsYbKuVM5oFFdDsgZ1TIMTWzJ3iIyLkLFChvcrqVXNbF
        tkEEEbPqylg1GZy/Q/yeIFi0QA==
X-Google-Smtp-Source: AGHT+IEoy/q9mUWwPMqxGsuzGevjSDRWvRXsimZkzJcdD4KCN2k3JJ/Zgp1nYbrk8s7GE8PQcYr0yQ==
X-Received: by 2002:a17:902:dac4:b0:1ba:fe6a:3845 with SMTP id q4-20020a170902dac400b001bafe6a3845mr3590310plx.11.1692124705743;
        Tue, 15 Aug 2023 11:38:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001bb750189desm11380667pll.255.2023.08.15.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVyvv-007hpI-NM;
        Tue, 15 Aug 2023 15:38:23 -0300
Date:   Tue, 15 Aug 2023 15:38:23 -0300
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
Message-ID: <ZNvGH91EmlOAaxBK@ziepe.ca>
References: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
 <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca>
 <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:28:54AM +0800, Zong Li wrote:
> On Wed, Aug 9, 2023 at 10:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
> >
> > > Perhaps this question could be related to the scenarios in which
> > > devices wish to be in bypass mode when the IOMMU is in translation
> > > mode, and why IOMMU defines/supports this case. Currently, I could
> > > envision a scenario where a device is already connected to the IOMMU
> > > in hardware, but it is not functioning correctly, or there are
> > > performance impacts. If modifying the hardware is not feasible, a
> > > default configuration that allows bypass mode could be provided as a
> > > solution. There might be other scenarios that I might have overlooked.
> > > It seems to me since IOMMU supports this configuration, it would be
> > > advantageous to have an approach to achieve it, and DT might be a
> > > flexible way.
> >
> > So far we've taken the approach that broken hardware is quirked in the
> > kernel by matching OF compatible string pattners. This is HW that is
> > completely broken and the IOMMU doesn't work at all for it.
> >
> > HW that is slow or whatever is not quirked and this is an admin policy
> > choice where the system should land on the security/performance
> > spectrum.
> >
> > So I'm not sure adding DT makes sense here.
> >
> 
> Hi Jason,
> Sorry for being late here, I hadn't noticed this reply earlier. The
> approach seems to address the situation. Could you kindly provide
> information about the location of the patches? I was wondering about
> further details regarding this particular implementation. Thanks

There are a couple versions, eg  
 arm_smmu_def_domain_type()
 qcom_smmu_def_domain_type()

Jason
