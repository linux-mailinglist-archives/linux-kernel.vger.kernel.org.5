Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAE7D3749
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjJWM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjJWM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:56:59 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C533C4;
        Mon, 23 Oct 2023 05:56:58 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1caa7597af9so18185385ad.1;
        Mon, 23 Oct 2023 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065816; x=1698670616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl3nJU5BsEpBWbjRfzF4bwyn1uY9j6EZqMRdgM/vdP8=;
        b=tOgXRdABucc7uusNAGBTBoy5sMmqE5UU6+W2vwnwgx9lZpKIukO6FGpEqu1X0qayRq
         AyyAOqMOqnXczpTcLt6i4SxwyTKChEuAGJ4x9dNmJgD0QO064ein8g8ABOFv11p8I914
         8AXdFvkTqPsg9i30lOJnanj+J0BrGRWIihHthFn9XKa4N9gEfz6eDXJRKimyecufCcaV
         ycy6HVKakb1i/9gxVvkKJ+BRGLC9Lmz+R5ZvWY36i7Ho+SrP4fEJH1oWWSCJjTVqYKNT
         fg+eZlYga0aNvRhlHGDZD4OZo+V0NhqA2gXvqEfjZhhm8gccLqcthdl2cwVCU75d0c65
         jETg==
X-Gm-Message-State: AOJu0Yz+OLQOTUOsbwEhwaK55xf4BpqpmLelP5VHCaJY7PasB7Vi7QuL
        7CfH+i/jOp4WJ+5d3N3VOS8=
X-Google-Smtp-Source: AGHT+IE72a1WPvc0Ersi+tqM0N2+bac0kxkCzj6wOYhc7GhUprhmzmATsoVL33HhwqXtUVKG3SgpQA==
X-Received: by 2002:a17:902:e305:b0:1c9:dd6a:5bee with SMTP id q5-20020a170902e30500b001c9dd6a5beemr5277429plc.52.1698065816412;
        Mon, 23 Oct 2023 05:56:56 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001b8a2edab6asm5850832plh.244.2023.10.23.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:56:55 -0700 (PDT)
Date:   Mon, 23 Oct 2023 21:56:54 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20231023125654.GA701784@rocinante>
References: <20231023110556.6f704b95@canb.auug.org.au>
 <TYBPR01MB5341114CB14098217765790BD8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231023073446.GA593739@rocinante>
 <TYBPR01MB53418269A5C6F1419D007338D8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53418269A5C6F1419D007338D8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > > After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> > > > failed like this:
> > > >
> > > > ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie-rcar-gen4.ko] undefined!
> > [...]
> > 
> > > However, I completely forgot it...
> > 
> > That's OK.  Don't worry. :)
> > 
> > > https://lore.kernel.org/linux-pci/20230926122431.3974714-8-yoshihiro.shimoda.uh@renesas.com/
> > >
> > > I confirmed that the patch above can be applied on the latest pci.git / next branch.
> > 
> > I will take care of it.
> 
> Thank you very much for your support!
[...]

Done.  Applied to the following branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/rcar

Bjorn will push updated next when he has a moment.

[...]
> This is because I added COMPILE_TEST to the Kconfig like below:
> 
> ---
> config PCIE_RCAR_GEN4_HOST
>         tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
>         depends on ARCH_RENESAS || COMPILE_TEST

Ah yes, sorry!  I should have assumed as much. :)  Thank you!

	Krzysztof
