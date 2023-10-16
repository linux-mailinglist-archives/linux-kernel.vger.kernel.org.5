Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739A7CB12C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjJPRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjJPRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:16:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04AE6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:16:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d407bb15so39969135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697476607; x=1698081407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOnkKW9E33HHzsaH2XgU+G+2xfhOZYjGYZoXUL8UE40=;
        b=NHse2qeSscYLnKCIUo3VpbyNi3s7KSQ1S8wxpCHq/Z2uQR/TaSeepBWB7j5seoGVEU
         YwJiWfq/FRUaiLJugaefFL+kOhJQgZL1l23Nxcp7OIjy1h9F4NT/bS+w1DSOIMOOLlqL
         yV58njO7nP5Ng1kHOaZgSu713puXjDNtug9gOB5QlTkEYBKuGYGWW1z7H2VMe9SQpj7N
         k2HAGJqEgrlXHM72GbCcfodl0L/+BVdfj+zwIT7EbT+IuFxQvtlYaEWAZgjS6BPcyS2V
         59tKaORNt0esW1vYBOXFToJ1P09lN4axQLUkNy/cRAqC427G9pb3OqAFWf0x1R7bYkxp
         wbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476607; x=1698081407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOnkKW9E33HHzsaH2XgU+G+2xfhOZYjGYZoXUL8UE40=;
        b=P8mQHzAfRL96iotIxjggyDL9cLzKTp2kU13kdTUFdvKVK75jKhAmZxxC02RQpFrUCn
         DgNnc/mqLHo0oYdzmeFIKxKSthjAcLIVypgG4DeRVFhm0gGmEX11Tph6RYIhXHe/Cr4T
         BoT6uMO9eVINmSordc9QwNEhxsT8494eQkQNszFxY5Duww1RZZkIz7mz7Cj5ysvOawV1
         H+cCSS1oKToyq+qa4waQB1HAMUZCr+us7z3+ne0S4nNo2IOhkaurqataCL5CQpLcTG4a
         6mWT6ZYAO0gnkqSpVOBqQcwOIxuAi9+yMlMwv99S55DpX6FXJhXqpg/L5vvhBCS15wwC
         p58Q==
X-Gm-Message-State: AOJu0YzOYWD8z02dxcJg0TXamK2J0AOXlbBZ2w3NOFrBGRoMHlPq4Muw
        A1D6gelOnAKpv3OTV7NIg6VE
X-Google-Smtp-Source: AGHT+IFho1tjm5iK0/PdZpwOJVLlzh60B+Z1CzCZJ5QivVrZEGbF5FhDL6PPek4KbSf6TWQbtLGYZw==
X-Received: by 2002:a17:903:22c9:b0:1ca:8b74:17ff with SMTP id y9-20020a17090322c900b001ca8b7417ffmr1919597plg.26.1697476606907;
        Mon, 16 Oct 2023 10:16:46 -0700 (PDT)
Received: from thinkpad ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001c62b9a51c0sm8698818plh.103.2023.10.16.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:16:46 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:46:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <20231016171637.GJ39962@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
 <20230930090249.GB3564@thinkpad>
 <ZSVd5GN7lJUfdF8L@lizhi-Precision-Tower-5810>
 <ZS1N0jgGYfmMsgrJ@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS1N0jgGYfmMsgrJ@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:50:58AM -0400, Frank Li wrote:
> On Tue, Oct 10, 2023 at 10:21:24AM -0400, Frank Li wrote:
> > On Sat, Sep 30, 2023 at 11:02:49AM +0200, Manivannan Sadhasivam wrote:
> > > On Wed, Sep 20, 2023 at 05:39:48PM -0400, Frank Li wrote:
> > > > On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> > > > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > > > │            │   │                                   │   │                │
> > > > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > > > │            │   │                                   │   │                │
> > > > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > > > │            │   │                                   │   │                │
> > > > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > > > │ Controller │   │   update doorbell register address│   │                │
> > > > > │            │   │   for BAR                         │   │                │
> > > > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > > > │            │   │                                   │   │                │
> > > > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > > > │            │   │                                   │   │                │
> > > > > │            │   │                                   │   │                │
> > > > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > > > 
> > > > @mani:
> > > > 	Do you have chance to review this patch again?
> > > 
> > > I was on vacation for past few weeks. Will take a look in the coming week.
> > 
> > Ping?
> > 
> > Frank
> 
> @mani: did you have chance to look at this?
> 

Sorry for the long delay. I will take a look tomorrow.

- Mani

> > 
> > > 
> > > - Mani
> > > 
> > > > 
> > > > Frank
> > > > 
> > > > > 
> > > > > This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> > > > > 
> > > > > Original patch only target to vntb driver. But actually it is common
> > > > > method.
> > > > > 
> > > > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > > > 
> > > > > The key point is comments from Thomas Gleixner, who suggest use new
> > > > > PCI/IMS. But arm platform change still not be merged yet.
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > > > 
> > > > > So I still use existed method implement RC to EP doorbell.
> > > > > 
> > > > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > > > and update this patch.
> > > > > 
> > > > > Change from v1 to v2
> > > > > - Add missed patch for endpont/pci-epf-test.c
> > > > > - Move alloc and free to epc driver from epf.
> > > > > - Provide general help function for EPC driver to alloc platform msi irq.
> > > > > - Fixed manivannan's comments.
> > > > > 
> > > > > Frank Li (5):
> > > > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > > > >     controller
> > > > >   PCI: dwc: add doorbell support by use MSI controller
> > > > >   PCI: endpoint: pci-epf-test: add doorbell test
> > > > >   misc: pci_endpoint_test: Add doorbell test case
> > > > >   tools: PCI: Add 'B' option for test doorbell
> > > > > 
> > > > >  drivers/misc/pci_endpoint_test.c              |  48 +++++
> > > > >  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
> > > > >  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
> > > > >  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
> > > > >  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
> > > > >  include/linux/pci-epc.h                       |   6 +
> > > > >  include/linux/pci-epf.h                       |   7 +
> > > > >  include/uapi/linux/pcitest.h                  |   1 +
> > > > >  tools/pci/pcitest.c                           |  16 +-
> > > > >  9 files changed, 373 insertions(+), 2 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
