Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA77A9DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjIUTnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjIUTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:43:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFE113627;
        Thu, 21 Sep 2023 12:33:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5031426b626so2214027e87.3;
        Thu, 21 Sep 2023 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695324787; x=1695929587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ETENORjJD3BdXIlQEVNl80EXV3xmfXC8vbPWv5JUEE=;
        b=YL1pXbKk6oxrhkasrUynXFqBG2Ynf3dGKwhApuAM4pKhLu19xTh/A+Y/Od/bstc1kG
         ME7ITQceeQRT/BaGVcBuknnshADs/Enem6+/Ypj5LQqsccsjseB9sdzgjUAzY/haUxlh
         boLoA5w8bNUr/eafxGgybgdxcOHLGGjupVAMzAb/7VrfZHPOX8mRRHmpldoi/X8LqT4/
         pVZNsfiOfKkTvnuLU8tnDYZurFIGGYaz4nRxHu1MyIQHDeOtIwMHxjn8eo3whVPpHnXO
         Wfkit6/pt/9KhOQ/JLv7MzFmulOH8DH4tKa+/0HpXTfyxkuGNRmmQuFvV5RKFxNZMf0S
         TOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324787; x=1695929587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ETENORjJD3BdXIlQEVNl80EXV3xmfXC8vbPWv5JUEE=;
        b=qC6tCGr6is7hz7beeeckvMRgFZwMnIRVPwLXoPQEgV9sBIAyng9NohYUGr/FlRg1vy
         +M2Ws5uZvva7w1HnMtKLVhoZUv+mEM53CNgyZ3lZ8GkQVJQshSB3CWvXLyzaTqqpKBXm
         nUAm72sN5m9VV0YHHOpmUhmlxdOS3Zq6MWKTUVnZch83EW5JCbiepdTg+91/wLmKs/5p
         04EFVh+FqYGj4RqOK2paEsoVRHU3GryhGS3JW5H8hWCDHVkWoTqyZ7fCxbs3zJ4kILSm
         vsihzeA7MRocYWOMNzTyFRSZmReAe9M8hfWLLOzZ9dAKiEa6O+qqjp0jHV9t9W0/1q9n
         vYtw==
X-Gm-Message-State: AOJu0YyaVxZs1epDV3epDh4FmUcBpaMXcNCT4BNKYO8KybKAuh37mfVr
        EMZarGwnqoo+q+ne7iQHz7wdyK0pr8rWsA==
X-Google-Smtp-Source: AGHT+IF1JJ2qfAWVlu5vNDhjWgUG2Yv8wTLqMSg0GWoQ1ILCPCoEqPFu/fKr98lyEKQwzFO+stj6Dw==
X-Received: by 2002:a19:e051:0:b0:4fe:94a1:da84 with SMTP id g17-20020a19e051000000b004fe94a1da84mr4903398lfj.5.1695324786887;
        Thu, 21 Sep 2023 12:33:06 -0700 (PDT)
Received: from mobilestation ([85.26.235.28])
        by smtp.gmail.com with ESMTPSA id r27-20020ac25a5b000000b004fdd6b72bfdsm401659lfn.117.2023.09.21.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:33:06 -0700 (PDT)
Date:   Thu, 21 Sep 2023 22:32:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     kernel test robot <lkp@intel.com>
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
Subject: Re: [PATCH v4 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to
 separate driver
Message-ID: <wioy72js2tahlcyjmghpne3gbfwd53xx7bvzmg7rnsckjod7ci@6gkewkhagvom>
References: <20230920191059.28395-17-fancer.lancer@gmail.com>
 <202309211954.M7wyhXyv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309211954.M7wyhXyv-lkp@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 07:26:04PM +0800, kernel test robot wrote:
> Hi Serge,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.5]
> [also build test WARNING on next-20230921]
> [cannot apply to linus/master v6.6-rc2 v6.6-rc1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-synopsys-Fix-ECC-status-data-and-IRQ-disable-race-condition/20230921-031420
> base:   v6.5
> patch link:    https://lore.kernel.org/r/20230920191059.28395-17-fancer.lancer%40gmail.com
> patch subject: [PATCH v4 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230921/202309211954.M7wyhXyv-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309211954.M7wyhXyv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309211954.M7wyhXyv-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/edac/zynq_edac.c:194: warning: expecting prototype for handle_error(). Prototype was for zynq_handle_error() instead
> >> drivers/edac/zynq_edac.c:233: warning: expecting prototype for check_errors(). Prototype was for zynq_check_errors() instead

Hi, kind roBot.

Thanks for pointing out to the problem. I'll fix it in v5.)

-Serge(y)

> 
> 
> vim +194 drivers/edac/zynq_edac.c
> 
>    185	
>    186	/**
>    187	 * handle_error - Handle Correctable and Uncorrectable errors.
>    188	 * @mci:	EDAC memory controller instance.
>    189	 * @p:		Zynq ECC status structure.
>    190	 *
>    191	 * Handles ECC correctable and uncorrectable errors.
>    192	 */
>    193	static void zynq_handle_error(struct mem_ctl_info *mci, struct zynq_ecc_status *p)
>  > 194	{
>    195		struct zynq_edac_priv *priv = mci->pvt_info;
>    196		struct zynq_ecc_error_info *pinf;
>    197	
>    198		if (p->ce_cnt) {
>    199			pinf = &p->ceinfo;
>    200	
>    201			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
>    202				 "Row %d Bank %d Col %d Bit %d Data 0x%08x",
>    203				 pinf->row, pinf->bank, pinf->col,
>    204				 pinf->bitpos, pinf->data);
>    205	
>    206			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
>    207					     p->ce_cnt, 0, 0, 0, 0, 0, -1,
>    208					     priv->message, "");
>    209		}
>    210	
>    211		if (p->ue_cnt) {
>    212			pinf = &p->ueinfo;
>    213	
>    214			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
>    215				 "Row %d Bank %d Col %d",
>    216				 pinf->row, pinf->bank, pinf->col);
>    217	
>    218			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
>    219					     p->ue_cnt, 0, 0, 0, 0, 0, -1,
>    220					     priv->message, "");
>    221		}
>    222	
>    223		memset(p, 0, sizeof(*p));
>    224	}
>    225	
>    226	/**
>    227	 * check_errors - Check controller for ECC errors.
>    228	 * @mci:	EDAC memory controller instance.
>    229	 *
>    230	 * Check and post ECC errors. Called by the polling thread.
>    231	 */
>    232	static void zynq_check_errors(struct mem_ctl_info *mci)
>  > 233	{
>    234		struct zynq_edac_priv *priv = mci->pvt_info;
>    235		int status;
>    236	
>    237		status = zynq_get_error_info(priv);
>    238		if (status)
>    239			return;
>    240	
>    241		zynq_handle_error(mci, &priv->stat);
>    242	}
>    243	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
