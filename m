Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE6763615
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGZMRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGZMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:17:34 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D31BF6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:17:28 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso533430fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690373848; x=1690978648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/0PSB6Q4tQ0VbeXGuwPR8oxpl0KqMEC65BPmeAh9GDM=;
        b=G05f6CZe5H/9IGsFUzRc8wADFR0C472XZD5MzGbH2v3Z9Z0EiZdKBGI5zqU3T3dQCA
         AvCK9JYcta0Jzsvlmo7hAbvSjG0FCtCG9XhV+XFKEdZySfo+1Tk+7Ja+G2eig3OqNtCy
         MdWWpPFPDJI4rm2w5wxnP6qS59yUxxo9v9sIoAxEYeWkR+LTpC8cic+YxfENN0BtJXmE
         rnUCjNbgVhpgF+qYxtHe9DXvPTY9EC93G9QoEF3zJlzgxSLh0Pp7uO//A3gCkIeiLNav
         C+f1t29bNFYt7fPydYq+G50UxWkDGM5m+D0p7DFMD9wr8SlitZ3sHdA7fYyrYe6YS/yy
         7kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373848; x=1690978648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0PSB6Q4tQ0VbeXGuwPR8oxpl0KqMEC65BPmeAh9GDM=;
        b=Vzia2FyJaTXzCCDQBMPKgu698G2Xymh3cxHf/mbBnxZZX48HW36io/GbBFEmBSdhws
         m2PpDg/PA5NLsMnGc2cS41cSFdMUWh6oiX0doGd5jXP4Qlt3pSk/Eyyo2bhlbUBbseL3
         N34z9LMa4pmtT9U+NXu95ZiXdhWUsHNZBXpbROXx2sBaJ22QDNggQZnHadmYoE+QKy5G
         ORbdlmSZlSKPm1zJErJmBcDbzut/IDyx5GhY5s8kB/wLijZihcXtbBmouo5FD31NIyMR
         5WxAapZYd9S3l6/hrah29dHcgto1F/hNcd7OxxJN1hT03L1B85Xl99bz6jiY3MlCuE+/
         TASg==
X-Gm-Message-State: ABy/qLZKG1xbgh/y6PeE6iG4zdiw8CQ1MQcd2AFt7rNZgf8fvc1rjlfs
        aL+p+1zjsmgdu+1KiniwPiQ7vA==
X-Google-Smtp-Source: APBJJlER/vAICvmtsZSZspI3r1Rtl4DeBU/8Xh5ht8tNl2f1NYU+kdczAWKMT7jUT8bkQnv76vuP2g==
X-Received: by 2002:a05:6870:1fc3:b0:1bb:5756:3c06 with SMTP id gp3-20020a0568701fc300b001bb57563c06mr2013185oac.53.1690373847896;
        Wed, 26 Jul 2023 05:17:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w10-20020ac86b0a000000b003f9c6a311e1sm4731716qts.47.2023.07.26.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:17:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qOdSI-000uxy-Jm;
        Wed, 26 Jul 2023 09:17:26 -0300
Date:   Wed, 26 Jul 2023 09:17:26 -0300
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
Message-ID: <ZMEO1kNGfGjN6kZM@ziepe.ca>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:26:14PM +0800, Zong Li wrote:
> On Wed, Jul 26, 2023 at 11:21 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2023/7/24 21:23, Zong Li wrote:
> > >>>>> In RISC-V IOMMU, certain devices can be set to bypass mode when the
> > >>>>> IOMMU is in translation mode. To identify the devices that require
> > >>>>> bypass mode by default, does it be sensible to add a property to
> > >>>>> indicate this behavior?
> > >>>> Bypass mode for a device is a property of that device (similar to dma-coherent)
> > >>>> and not of the IOMMU. Other architectures (ARM and x86) never added such
> > >>>> a device property for bypass mode so I guess it is NOT ADVISABLE to do it.
> > >>>>
> > >>>> If this is REALLY required then we can do something similar to the QCOM
> > >>>> SMMU driver where they have a whitelist of devices which are allowed to
> > >>>> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> > >>>> compatible string and any device outside this whitelist is
> > >>>> blocked by default.

I have a draft patch someplace that consolidated all this quirk
checking into the core code. Generally the expectation is that any
device behind an iommu is fully functional in all modes. The existing
quirks are for HW defects that make some devices not work properly. In
this case the right outcome seems to be effectively blocking them from
using the iommu.

So, you should explain a lot more what "require bypass mode" means in
the RISCV world and why any device would need it.

Jason
