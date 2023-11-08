Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE107E5AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjKHQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:05:41 -0500
X-Greylist: delayed 503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 08:05:38 PST
Received: from box.opentheblackbox.net (box.opentheblackbox.net [172.105.151.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B71BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:05:38 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id 556323EAA2;
        Wed,  8 Nov 2023 10:57:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1699459032; bh=/zJc7QxiGPLgHqFAVKKHeKo/oHD/FJUZU93CejHGqyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxpMd8vXpZwrgr54RIGwM3ly2AHuL5LI+R8NHocmlnr2PMF43YsL1B6hanImeAcin
         eQKCKh+4Lkh5ZF7kuz3pt+fcWO/do6/R7JwGYiACGqcAbgoSpUd8tSgxWDsS6vcqe5
         NXd3qSrflL1NQLdeePxJ22XmSOn2QJI13fx25Oix/dJC2G2u1RKyiCW0/MmVkFRJqP
         e7V0aGTG2yPihCKMdIiWgpziGr6IfQ1galX/yvSi/dMMvh8nAGIotRyTj4wayw0HUZ
         MiaiDU9rykvGEtxlSlMREODD152LBMG2ofO+lFRROnKtxgD41Puv8/Hq3HzGfUI2vG
         oKuZW4IRqhGXQ==
Date:   Wed, 8 Nov 2023 10:57:11 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SM_GCC_8550 when selected by SM_CAMCC_8550
Message-ID: <20231108155711.tulvsq5ajpyhwyzk@work.work.opentheblackbox.net>
References: <202311062309.XugQH7AH-lkp@intel.com>
 <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
 <ZUoxYETfECoiqooN@rli9-mobl>
 <756c9659-5c7d-4e29-b5d1-76b26dd3e0c8@infradead.org>
 <ZUr7rrlrowHC3+9b@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUr7rrlrowHC3+9b@yujie-X299>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023, Yujie Liu wrote:
> On Tue, Nov 07, 2023 at 08:00:33AM -0800, Randy Dunlap wrote:
> > Hi Philip,
> > 
> > On 11/7/23 04:45, Philip Li wrote:
> > > On Tue, Nov 07, 2023 at 11:11:54AM +0100, Geert Uytterhoeven wrote:
> > >> Hi Robot,
> > >>
> > >> On Mon, Nov 6, 2023 at 4:06 PM kernel test robot <lkp@intel.com> wrote:
> > >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >>> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> > >>> commit: ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4 clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
> > >>> date:   7 weeks ago
> > >>> config: arm-kismet-CONFIG_SM_GCC_8550-CONFIG_SM_CAMCC_8550-0-0 (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config)
> > >>> reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce)
> > >>>
> > >>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > >>> the same patch/commit), kindly add following tags
> > >>> | Reported-by: kernel test robot <lkp@intel.com>
> > >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
> > >>>
> > >>> kismet warnings: (new ones prefixed by >>)
> > >>>>> kismet: WARNING: unmet direct dependencies detected for SM_GCC_8550 when selected by SM_CAMCC_8550
> > >>>    .config:7280:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
> > >>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >> Where is this coming from? I have seen this warning in several build
> > >> reports (earliest 2023-01-31), but cannot reproduce it with the provided
> > >> commit and config.
> > > 
> > 
> > I'm pretty sure that what Geert is asking about here is the warning (".config:7280:...") with
> > the truncated kconfig symbol 'ONFIG_ARCH_MMAP_RND_BITS_MI'.  I have also seen several of these.
> > Is this a bug in kismet or a bug in the robot or something else?
> 
> Hi Randy, Hi Geert,
> 
> We looked into this case and found that it is likely to be a kismet bug.
> We have created an issue ticket at [1].
> 
> [1] https://github.com/paulgazz/kmax/issues/239
> 
> Hi Paul, could you please help take a look?
> 
> Thanks,
> Yujie

Hi Yujie, Randy, and Geert,

Thanks for reporting this.  It was indeed a bug in how some
non-Boolean config options get set when kismet generates .config files
for bug validation.  kismet v4.5.1 now includes the fix, and the
symbol value warning no longer appears when I replicate with Philip
and Yujie's steps.

The unmet dependency bug for SM_GCC_8550, however, still appears and
looks to be to be genuine.  Jagadeesh's patch seems to fix that.

Best,
Paul
