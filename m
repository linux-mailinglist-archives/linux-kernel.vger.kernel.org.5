Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3B761DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGYPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGYPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:54:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4056A2116
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2680f27b52dso1474611a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690300452; x=1690905252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPT2stxFChZpMg6h3D81cBqzyJBn0I25fZ2MBYv8irM=;
        b=eD7kANSdAAjiTC37YAfsbtVn214CSpat8MudtF+68viBVkhN/n+RrCvV36qnEGHl6Y
         nPebh5ij0FBewMkONhjPgvJZC1dy3YYTeJj/WbGwNjGt//VUvZZnpFFjuOZ+Jxc7x2/Q
         LLaf3ZHb7stUjV+a5Q2DT8P4+CRldCPKRmMD4L8hmsnPTzdQitjoNc+c2p51Whq66UNz
         M5WVBLSdvJ1IOe1y045VZw1aOsQt+Ql4RV1Y9MEanRKF2Y3PSxcQ/ZlZ028Xp4OYNcqw
         ACrcWe+xfjoNI+FnSZNTcGxVsLK54BAtURKW2yGIqMWSZyMWvupBPMHG9Et+JrFPr/YL
         S1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300452; x=1690905252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPT2stxFChZpMg6h3D81cBqzyJBn0I25fZ2MBYv8irM=;
        b=MWLIgog+Llg+Hhf6F9JSGpmCFtKjFP+aT1lhuDdQJpCbvnCniqG/Gdy2muEMOSRtOM
         9uj8e25Pfr/OlHCM+KztlimGWRm2T7kDcF+4uNLvB55HpOI/OPQPu8B4SMnTSB6IS3lr
         Y42zjUunoZlvDPpb5g5OjRe9h39eAzECCDUq1+mu+xRpQlrQtYCTBmu2sD94Qi2vVGlI
         H21slpgjNDiksMBBMQFTq6PUc4MWknM4DanNz4iH7Op3i74j3ecBO+VFog/P4cWRpTAW
         aWs3E2SQUgvgY0+fuiX5XD0GbPs9cwExMLjM1FEiAAfs3C61P4ky2QaEiIaWKK/utkjn
         NuCA==
X-Gm-Message-State: ABy/qLbgHIWi342TRLmbgleZ6FC75T3IuhCARPd61lOZycnw8XItfVim
        cggt8LIkipqkqLSJg8mcgB0WXQ==
X-Google-Smtp-Source: APBJJlH+vInGZEOGDW0JESmSk+/b0VDKB7Yl0EonVeDj+0oEV2iQCQjLxobPmSDkYNEnTf2Bdija5g==
X-Received: by 2002:a17:90b:4c51:b0:263:5702:d4c5 with SMTP id np17-20020a17090b4c5100b002635702d4c5mr11605845pjb.19.1690300452577;
        Tue, 25 Jul 2023 08:54:12 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b00263d15f0e87sm8225180pjb.42.2023.07.25.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:54:12 -0700 (PDT)
Date:   Tue, 25 Jul 2023 08:54:10 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH RFC 4/4] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
Message-ID: <ZL/wIjm4CZh2Ce0N@x1>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
 <20230724-th1520-emmc-v1-4-cca1b2533da2@baylibre.com>
 <ZL/kUPicOEPWz5NP@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL/kUPicOEPWz5NP@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:03:44PM +0800, Jisheng Zhang wrote:
> On Mon, Jul 24, 2023 at 05:59:18PM -0700, Drew Fustini wrote:
> > Add basic support for the T-Head TH1520 SoC mmc controller. The new
> > compatible "thead,th1520-dwcmshc" enables basic support by:
> 
> Hi Drew,
> 
> > 
> >  - Enabling v4 mode to properly communicate with the mmc device
> >  - Setting quirk to disable ADMA
> >  - Setting flag to disable SDMA and force PIO mode
> >  - Turing .reset op into a no-op as the driver does not yet know how to
> >    configure the phy. Rely on the vendor u-boot to have configured the
> >    phy and do not reset the controller in Linux.
> 
> The last three itmes are not acceptable. The controller supports ADMA
> well, can you plz bring in the phy driver? We can't rely on bootloader to
> configure phy.

Yes, that makes sense that this is not acceptable. The T-Head vendor
kernel seems to contain all the necessary information needed to add the
phy configuration to sdhci-of-dwcmshc.

The shipping kernel for the BeagleV Ahead [1] is based on the T-Head SDK
releases. I looked at changes to drivers/mmc and found that key changes
are from Linux_SDK_V0.9.5 [2] and Linux_SDK_V1.0.2 [3].

That kernel contains drivers/mmc/host/sdhci-of-dwcmshc.h [4] which seems
to define information about the phy registers. The version of
drivers/mmc/host/sdhci-of-dwcmshc.h in that kernel defines several
functions for the phy config and controller reset:

sdhci_phy_1_8v_init_no_pull
sdhci_phy_3_3v_init_no_pull
snps_phy_1_8v_init
snps_phy_3_3v_init
snps_sdhci_set_phy
snps_sdhci_reset

I'll look into adapting that code into the upstream sdhci-of-dwcmshc.

Thanks,
Drew

[1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-linux
[2] https://gist.github.com/pdp7/8d85d736dea24957c017eefdeb882668
[3] https://gist.github.com/pdp7/c1d3a18f9b7c25e630573d5953a58c99
[4] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-linux/-/blob/beaglev-v5.10.113-1.1.2/drivers/mmc/host/sdhci-of-dwcmshc.h
[5] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-linux/-/blob/beaglev-v5.10.113-1.1.2/drivers/mmc/host/sdhci-of-dwcmshc.c
