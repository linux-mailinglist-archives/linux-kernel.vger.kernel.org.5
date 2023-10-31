Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3427DC6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbjJaG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjJaG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:58:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6FBB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:58:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso10921768a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1698735492; x=1699340292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kBtDlNTaLjXG7sbj9SNIBUnxTR1itMbkTHq+uN+HFD0=;
        b=j62VMdr9x/z6XaNNVtA7UL5a0JQO7HzC9UrNLQjchAHDJmozQcUiuHkKnc+DzulA7G
         Ao9Gz7B/u4/CQh9U/Eah1TV4AwEmoWATdSpiTSQ2vcdmlHGDxVKW/izdKYpaIUmCWekw
         QYYa0OOwAYGuiHgipjQ+vdGwXEK7QyJ+JCYikHL/AkYlYQSRi4H9a7hbArBYGslGYIt8
         zSAzfIoc/Hi01Soa6CssWUjtJIKBa4e46/IMradSN1v34Giub+XyP1V9CBVV7g9fe/hh
         iUpNtepyceZXWjug/YIS+hla/hjsZowKwD2NT9y4irv3zqszaBdwQQhgOJgu+/A02YDY
         hOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698735492; x=1699340292;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBtDlNTaLjXG7sbj9SNIBUnxTR1itMbkTHq+uN+HFD0=;
        b=W2QByn1GeTyht9faMZEZsHisN6C9J1jfR4cLHhMht8fGTBEouxZuHizvkCkildoIia
         9fIipJyt3XKVE47yj3jUZx8E+RHJl7nptjlTZLsIgKnLBUKVhbNKBtDV3fDFnIc8ILk7
         jIEE4lEQvRFfhlzD4BWbCmN3xe94XNdDvhR2n5Xag6Dsk2PPJwTepPgB9zxBQXmUscyF
         zIUsMvBowAcsnEEtj0ktJXLwGS0ZUVQdnw2+dG5LsMq+QHcDpmopeDIXMlcSrmtUqVLz
         E0CDKYMRstpwU9pYlIm61bfjclsL8mo7U9Mkgthe97x4kC4wIcV6ceQ/jJqB2sYOjvUx
         UTYQ==
X-Gm-Message-State: AOJu0Yw5ZLR50XyZbWa40UpGsIAADgr20hIRXVUwC8pB3K9EdFQAdBMX
        D1XrXPwwa1JyomeW6Gx0uKpOlQ==
X-Google-Smtp-Source: AGHT+IFR/R7Df4JRUdEBDxNg449zOUGC0kmVzaxBpl1Seft9+3D4OL+LjZlTMK+jEnsNpmuaIO676g==
X-Received: by 2002:a50:8757:0:b0:542:e5b1:8762 with SMTP id 23-20020a508757000000b00542e5b18762mr1624240edv.11.1698735492195;
        Mon, 30 Oct 2023 23:58:12 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id e1-20020a50d4c1000000b0054026e95beesm595618edj.76.2023.10.30.23.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:58:11 -0700 (PDT)
Message-ID: <144951b1-b158-4591-ab88-a1c71af51bf2@monstr.eu>
Date:   Tue, 31 Oct 2023 07:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arch/microblaze/kernel/entry.S:945: Error: unknown opcode
 "suspend"
To:     kernel test robot <lkp@intel.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <202310310151.UhB396Qs-lkp@intel.com>
Content-Language: en-US
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
In-Reply-To: <202310310151.UhB396Qs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kedar,

On 10/30/23 18:12, kernel test robot wrote:
> Hi Appana,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
> commit: 88707ebe77e23e856981e597f322cabbf6415662 microblaze: Add custom break vector handler for mb manager
> date:   1 year, 1 month ago
> config: microblaze-buildonly-randconfig-r003-20230509 (https://download.01.org/0day-ci/archive/20231031/202310310151.UhB396Qs-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310151.UhB396Qs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310310151.UhB396Qs-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     arch/microblaze/kernel/entry.S: Assembler messages:
>>> arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"
> 
> 
> vim +/suspend +945 arch/microblaze/kernel/entry.S
> 
>     825	
>     826		/* restore all the tlb's */
>     827		addik	r3, r0, TOPHYS(tlb_skip)
>     828		addik	r6, r0, PT_TLBL0
>     829		addik	r7, r0, PT_TLBH0
>     830	restore_tlb:
>     831		add	r6, r6, r1
>     832		add	r7, r7, r1
>     833		lwi	r2, r6, 0
>     834		mts 	rtlblo, r2
>     835		lwi	r2, r7, 0
>     836		mts	rtlbhi, r2
>     837		addik	r6, r6, 4
>     838		addik	r7, r7, 4
>     839		bgtid	r3, restore_tlb
>     840		addik	r3, r3, -1
>     841	
>     842		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
>     843		lwi	r8, r0, TOPHYS(xmb_manager_reset_callback)
>     844		set_vms
>     845		/* return from reset need -8 to adjust for rtsd r15, 8 */
>     846		addik   r15, r0, ret_from_reset - 8
>     847		rtbd	r8, 0
>     848		nop
>     849	
>     850	ret_from_reset:
>     851		set_bip /* Ints masked for state restore */
>     852		VM_OFF
>     853		/* MS: Restore all regs */
>     854		RESTORE_REGS
>     855		lwi	r14, r1, PT_R14
>     856		lwi	r16, r1, PT_PC
>     857		addik	r1, r1, PT_SIZE + 36
>     858		rtbd	r16, 0
>     859		nop
>     860	
>     861	/*
>     862	 * Break handler for MB Manager. Enter to _xmb_manager_break by
>     863	 * injecting fault in one of the TMR Microblaze core.
>     864	 * FIXME: This break handler supports getting
>     865	 * called from kernel space only.
>     866	 */
>     867	C_ENTRY(_xmb_manager_break):
>     868		/*
>     869		 * Reserve memory in the stack for context store/restore
>     870		 * (which includes memory for storing tlbs (max two tlbs))
>     871		 */
>     872		addik	r1, r1, -PT_SIZE - 36
>     873		swi	r1, r0, xmb_manager_stackpointer
>     874		SAVE_REGS
>     875		swi	r14, r1, PT_R14	/* rewrite saved R14 value */
>     876		swi	r16, r1, PT_PC; /* PC and r16 are the same */
>     877	
>     878		lwi	r6, r0, TOPHYS(xmb_manager_baseaddr)
>     879		lwi	r7, r0, TOPHYS(xmb_manager_crval)
>     880		/*
>     881		 * When the break vector gets asserted because of error injection,
>     882		 * the break signal must be blocked before exiting from the
>     883		 * break handler, below code configures the tmr manager
>     884		 * control register to block break signal.
>     885		 */
>     886		swi	r7, r6, 0
>     887	
>     888		/* Save the special purpose registers  */
>     889		mfs	r2, rpid
>     890		swi	r2, r1, PT_PID
>     891	
>     892		mfs	r2, rtlbx
>     893		swi	r2, r1, PT_TLBI
>     894	
>     895		mfs	r2, rzpr
>     896		swi	r2, r1, PT_ZPR
>     897	
>     898	#if CONFIG_XILINX_MICROBLAZE0_USE_FPU
>     899		mfs	r2, rfsr
>     900		swi	r2, r1, PT_FSR
>     901	#endif
>     902		mfs	r2, rmsr
>     903		swi	r2, r1, PT_MSR
>     904	
>     905		/* Save all the tlb's */
>     906		addik	r3, r0, TOPHYS(tlb_skip)
>     907		addik	r6, r0, PT_TLBL0
>     908		addik	r7, r0, PT_TLBH0
>     909	save_tlb:
>     910		add	r6, r6, r1
>     911		add	r7, r7, r1
>     912		mfs	r2, rtlblo
>     913		swi	r2, r6, 0
>     914		mfs	r2, rtlbhi
>     915		swi	r2, r7, 0
>     916		addik	r6, r6, 4
>     917		addik	r7, r7, 4
>     918		bgtid	r3, save_tlb
>     919		addik	r3, r3, -1
>     920	
>     921		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
>     922		lwi	r8, r0, TOPHYS(xmb_manager_callback)
>     923		/* return from break need -8 to adjust for rtsd r15, 8 */
>     924		addik   r15, r0, ret_from_break - 8
>     925		rtbd	r8, 0
>     926		nop
>     927	
>     928	ret_from_break:
>     929		/* flush the d-cache */
>     930		bralid	r15, mb_flush_dcache
>     931		nop
>     932	
>     933		/*
>     934		 * To make sure microblaze i-cache is in a proper state
>     935		 * invalidate the i-cache.
>     936		 */
>     937		bralid	r15, mb_invalidate_icache
>     938		nop
>     939	
>     940		set_bip; /* Ints masked for state restore */
>     941		VM_OFF;
>     942		mbar	1
>     943		mbar	2
>     944		bri	4
>   > 945		suspend

Older toolchain don't need to have this pseudo code.
What about to change it like this?

mbar 24 /* suspend */

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
