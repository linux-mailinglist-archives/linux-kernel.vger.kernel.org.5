Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62A796FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjIGFIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:08:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003171BC1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 22:08:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so4585155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694063291; x=1694668091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTpublJQEWmNkKUUWMbSglVklWFH/u6FcDa58H4HCfU=;
        b=og3FeQ7I3+auPRzSN+ObBsbJGNEkCskl1L8jNGnPZyRSgDuqP6Aik+HWbmCl7VGcY+
         IrSOYdiPsb1wW1pOi58r9+R9+8ZE6HJhxX4fbD2qUTsmQ6J8srh9wb5MCpn/sT69ePjg
         b+r02Zbp9+h49IAR6Z9u+kP4d+nt6Zp4NdLbX5qsOW6dAbzxnVW0g2RxfV7CwqvdiIu3
         WoNKL034mu/k8/gYLHenNvUXkyO/zVHCX3VwxpNtqgbi5vfVqlJhvTZSGcnjjUuUcRZq
         2npC0BkcQW41M5KIceusnghfo2PD3mvu8wu7584V7X4V16OW1bwsmXgIeagruTGIhgZO
         Z5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694063291; x=1694668091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTpublJQEWmNkKUUWMbSglVklWFH/u6FcDa58H4HCfU=;
        b=Wghxauu6szWDCngWdY4Krkd+C2hDMyPyGCl4Bo1H8dJ768Vd/m+ZObraIiMv3yf9nJ
         t79TMJM6aKf++gGtAgrkDC68oS1fLmLu9FEYrlTZAuZwC3Y/moVsO86sVTa5Y1UdGFu0
         UIgT0Pe6SxDH7E56uA4Kf5f6m6OC/O6TwrbWhLV78UQ1AGv/GGfCQyMTq3gIWKFcDOpi
         xy3F4r1smMb/wYxA+s09NkbSWlceFA5vDJPVegDueNwsLn710dVe7mueQL8zMA1CycYH
         RZm0eKo2ULfZ1HIA7Lhqmo4p5zxNznOE8uwo+6Izag9WpZ/wTsNYQ00Tl0YmUsHJ1Lnr
         yK8g==
X-Gm-Message-State: AOJu0Yzo0SEE1ZTPdRG2aQxrVoCyea9dQALspDlNHufeF4zPY4JJTtEw
        jiDVl3xBX2CIKf4pWSaIh4Z4
X-Google-Smtp-Source: AGHT+IGW66XNpeoWLD1LeZwww4ukiHVoUOVLu//pcgtv90Oo4h6h3LL+fspc7p8qFARIK005PYvWtQ==
X-Received: by 2002:a17:902:a416:b0:1bf:703d:cc6b with SMTP id p22-20020a170902a41600b001bf703dcc6bmr15827822plq.10.1694063291407;
        Wed, 06 Sep 2023 22:08:11 -0700 (PDT)
Received: from thinkpad ([2409:408d:1e1d:62d7:197e:b8bc:8d3d:f8df])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001b243a20f26sm11839325ply.273.2023.09.06.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 22:08:10 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:38:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org, kw@linux.com,
        lpieralisi@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20230907050805.GA3218@thinkpad>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <20230907011828.GA2865@thinkpad>
 <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:13:00AM +0800, Jiaxun Yang wrote:
> 
> 
> 在 2023/9/7 9:18, Manivannan Sadhasivam 写道:
> [...]
> > Why do you need to walk through every single device instead of just bridges?
> > I'm not the maintainer, but my suggestion is to go for Huacai Chen's solution.
> Hi Mani,
> 
> Thanks for your reply, unfortunately Huacai's solution is impractical in
> this case.
> 
> The problem we have, is firmware (or BIOS) setting improper MRRS for devices
> attached under those bridges. So we have to fix up MRRS for every single
> device.
> We can't iterate child device in bridge quirk because there is no guarantee
> that
> bridge will be probed before  it's child device, partly due to hotplug.
> 

Okay, this clarifies and also warrants improvement in commit message.

You could also use pci_walk_bus() after pci_host_probe() to iterate over the
child devices under root bridge and set MRRS. IMO that would look neat.

- Mani

> This quirk has been in tree for a while, until Huacai refactored it and
> broke some
> systems in 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases").
> 
> Also to note that ks_pcie_quirk in drivers/pci/controller/dwc/pci-keystone.c
> uses similar approach.
> > This avoids iterating over bridges/devices two times.
> > 
> > Also, please rename firmware to BIOS, as firmware commonly represents the
> > software running on PCIe endpoint devices.
> Ack, will fix in next reversion.
> 
> Thanks
> - Jiaxun
> > 
> > - Mani
> [...]

-- 
மணிவண்ணன் சதாசிவம்
