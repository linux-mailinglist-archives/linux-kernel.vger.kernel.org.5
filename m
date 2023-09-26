Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E27AE863
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjIZI4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:56:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42663DD;
        Tue, 26 Sep 2023 01:56:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435ad51bbso11346234e87.2;
        Tue, 26 Sep 2023 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695718572; x=1696323372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gjw7VpIsI24FsGpgI1LIRHokyuddV6bL4UWQKqi1zo=;
        b=Yj7j9YGbANxoc9aBer3oUOXOr4RfYPxGBCdVpdSru3IjydOkHCHulSyLD9tkc9k4GF
         s5B8jPIxmp6A/teqTbqRcNhp1VjlNzHRDyqnMMMrpL+wi3JwPyv0xKH9x01HkaDNWxeU
         eD14m3c3i49D5JeDXh7csBqLVt4aX6kBnPO2wJOFTyMvOwUiC5Sz44KmatY3uemwGBm/
         d989AYEB/coy7JVLoVSMPXAfjgaG+gFculfTqBRXJ51OaoBEC/+6BX//+ozHTjnZtZti
         p0SnMDWMOH29YZbtg+Waa7Yf6TXiXxEW/ztadDjtXLH2FBfDBiwFnEmCxIUCV79vrxUa
         pUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695718572; x=1696323372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gjw7VpIsI24FsGpgI1LIRHokyuddV6bL4UWQKqi1zo=;
        b=BmAvk7j9OD/Dja21+kIMDqSpBHUMUFN19QC5M6yd1VUJhhM1PDKZLMeRUCGOjqcJYV
         DZwl0efud+I6fMLOPQfg4R8VM7mmAhOBjKOx7ODYRNjFzp60N50ASnVsMhVk3OnXZn7m
         +f2glsxKYGG1CfYgKrpxswL+OmyuODTas8AOoWTsc2fEWc5youON7itrGAdyMwoephim
         Xd9yiMadJIEKmc5ShsvAXVYcFS+n7VlIljCKZEQzIhy+j8jln5TS1Iu0sS56DVJUwi/5
         JrgBO3bYRa2+ZeKPtJ2Roknj8k3bE4aeonbnYkyPmH4pTv2Dz26uqu872oCaMiQXf2AB
         LcZQ==
X-Gm-Message-State: AOJu0YxbX6JFjv6Rqz0YSdg1rN/WlnsaxaMJ2BArJVabCKO58pZy76A0
        lOk8Xkkwa9qViKcCoalwrhd239gFXfH4cg==
X-Google-Smtp-Source: AGHT+IFe/z24ooLWaNmEm2q+tfoIOpZ0ZitAPQIFlC7dpmZD0mw6bI5lxv0spRkMJKW0xNl0wCj9ig==
X-Received: by 2002:a19:6905:0:b0:503:26b0:e126 with SMTP id e5-20020a196905000000b0050326b0e126mr6168408lfc.59.1695718572192;
        Tue, 26 Sep 2023 01:56:12 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a7-20020a19f807000000b004fe36b790a1sm2153202lff.128.2023.09.26.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 01:56:11 -0700 (PDT)
Date:   Tue, 26 Sep 2023 11:56:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/18] EDAC/synopsys: Add DDRC basic parameters
 infrastructure
Message-ID: <pd3loh247nevscvcajxx2xyugfve3lhu6ydf3gmzsedwlbixrc@ng7bv2adqv2d>
References: <20230920192806.29960-6-fancer.lancer@gmail.com>
 <202309241117.1QIu7Ipb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309241117.1QIu7Ipb-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:07:49PM +0800, kernel test robot wrote:
> Hi Serge,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on ras/edac-for-next]
> [also build test WARNING on linus/master v6.6-rc2 next-20230921]
> [cannot apply to xilinx-xlnx/master bp/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-synopsys-Convert-sysfs-nodes-to-debugfs-ones/20230921-035302
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
> patch link:    https://lore.kernel.org/r/20230920192806.29960-6-fancer.lancer%40gmail.com
> patch subject: [PATCH v4 05/18] EDAC/synopsys: Add DDRC basic parameters infrastructure
> config: arm64-randconfig-003-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241117.1QIu7Ipb-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241117.1QIu7Ipb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/r/202309241117.1QIu7Ipb-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/edac/synopsys_edac.c:224: warning: Enum value 'SNPS_DQ_32' not described in enum 'snps_dq_width'
> >> drivers/edac/synopsys_edac.c:224: warning: Enum value 'SNPS_DQ_64' not described in enum 'snps_dq_width'
> 
> 
> vim +224 drivers/edac/synopsys_edac.c
> 
> c85ef1323d2330 Serge Semin 2023-09-20  215  
> 9e617225f1d8ba Serge Semin 2023-09-20  216  /**
> 9e617225f1d8ba Serge Semin 2023-09-20  217   * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
> 9e617225f1d8ba Serge Semin 2023-09-20  218   * SNPS_DQ_32:	32-bit memory data width.
> 9e617225f1d8ba Serge Semin 2023-09-20  219   * SNPS_DQ_64:	64-bit memory data width.
> 
> a @ char is required in front of each name
> 
> 9e617225f1d8ba Serge Semin 2023-09-20  220   */
> 9e617225f1d8ba Serge Semin 2023-09-20  221  enum snps_dq_width {
> 9e617225f1d8ba Serge Semin 2023-09-20  222  	SNPS_DQ_32 = 2,
> 9e617225f1d8ba Serge Semin 2023-09-20  223  	SNPS_DQ_64 = 3,
> 9e617225f1d8ba Serge Semin 2023-09-20 @224  };
> 9e617225f1d8ba Serge Semin 2023-09-20  225  

Got it. Thank you kind kernel roBot. I'll fix it in v5.

-Serge(y)

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
