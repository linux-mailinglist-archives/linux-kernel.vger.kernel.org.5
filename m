Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D77AEBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjIZLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjIZLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:43:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A6CE;
        Tue, 26 Sep 2023 04:43:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c108e106f0so142569521fa.1;
        Tue, 26 Sep 2023 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695728602; x=1696333402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Jo6O14HRB1lG6y0fYE66EjY1Mf0lwNVNRvWwmPG5M=;
        b=CsMAn8nE1cc9OsROvp76PHu6MmozJbl5DBlc58TMzmhzLMKCZXDR4hEe9cqBst54jF
         NKq1U/SIW5iIarXvks6y67ReNyOEirplHW2iGZkuOf4q6/kthFKSycEtAqLu2cr1m9rq
         3oEkugmj7HMcXlh2HXTe7nZ0k9SjM+17FzCKLFUb+ZMX71zdnQIDimeoQZ2AJ4PY8r4v
         Ep38PHwbjvcgOLSlFIOOZKHkQL/9H4CeJ1pLtoBwtxluqbTV71wcmrQBnYHoepI7Sppt
         Czw1LNaGKE+1rMrHZU5IVlz9VgKI0E32CcBEls2F55m9ST1WMkUprpdE1IKGTIxyviLF
         lcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695728602; x=1696333402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4Jo6O14HRB1lG6y0fYE66EjY1Mf0lwNVNRvWwmPG5M=;
        b=ik0j0RJXW6CmTrgmzoZp+FhDvs9Q70aMZ2xxCoWvwjwvH8utTq3CFn9Zg34iN2CJcO
         M3EqAUkD1FkvEVsyotT+wPlpCgTYA2QB6KHxCtMpR54b5S5Mx1A6UnKlE/Bq2KDMAyxq
         sf4qJZ2HifujbOdx3NkHYLLkHXTwg5n7CS3kClVlD+ADlQHPxOpnIo+SIHK6ZQGcVKA2
         Jq/ZvUaX7eYAndV3CcgsejqSiqG1tOm+TzYU8gpj1qDMqslFpOAZGGPJoUkZ64A3xBFV
         b3CufXj96dlsr30jYoufFSZNB7HIaJIM3YUj/lTEeb69KhtgpzXrb+S9dgkThCJGCcmT
         eqiQ==
X-Gm-Message-State: AOJu0Yw4N2lTQFlQ8Go/qGOyszn98JzWjGCoioMs2WL2IpV7Mmu68mNO
        No3c7KBXz2prqFVuh6LMbZIQj3Yd0J5Kmg==
X-Google-Smtp-Source: AGHT+IH/MS17QN8xe+m37vMDEV0uLfGOO0lTQnOrpBtUvOIUyGxxmjrwjFZUXHSzbrEjc3LbupuBfw==
X-Received: by 2002:a05:6512:2025:b0:503:1d46:6f29 with SMTP id s5-20020a056512202500b005031d466f29mr8151639lfs.37.1695728602373;
        Tue, 26 Sep 2023 04:43:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u2-20020a056512040200b004fb78959218sm2197277lfk.200.2023.09.26.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:43:21 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:43:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        bartosz.golaszewski@linaro.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: platform: fix the incorrect parameter
Message-ID: <mq4q2ku5ephuk7gd4wmh65qqgxawvlb5dncdedyzeifphi3zdq@pk4g7tj5jhpl>
References: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 02:24:43PM +0800, Clark Wang wrote:
> The second parameter of stmmac_pltfr_init() needs the pointer of
> "struct plat_stmmacenet_data". So, correct the parameter typo when calling the
> function.

Right. Thanks for fixing this.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Otherwise, it may cause this alignment exception when doing suspend/resume.
> [   49.067201] CPU1 is up
> [   49.135258] Internal error: SP/PC alignment exception: 000000008a000000 [#1] PREEMPT SMP
> [   49.143346] Modules linked in: soc_imx9 crct10dif_ce polyval_ce nvmem_imx_ocotp_fsb_s400 polyval_generic layerscape_edac_mod snd_soc_fsl_asoc_card snd_soc_imx_audmux snd_soc_imx_card snd_soc_wm8962 el_enclave snd_soc_fsl_micfil rtc_pcf2127 rtc_pcf2131 flexcan can_dev snd_soc_fsl_xcvr snd_soc_fsl_sai imx8_media_dev(C) snd_soc_fsl_utils fuse
> [   49.173393] CPU: 0 PID: 565 Comm: sh Tainted: G         C         6.5.0-rc4-next-20230804-05047-g5781a6249dae #677
> [   49.183721] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> [   49.189190] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   49.196140] pc : 0x80800052
> [   49.198931] lr : stmmac_pltfr_resume+0x34/0x50
> [   49.203368] sp : ffff800082f8bab0
> [   49.206670] x29: ffff800082f8bab0 x28: ffff0000047d0ec0 x27: ffff80008186c170
> [   49.213794] x26: 0000000b5e4ff1ba x25: ffff800081e5fa74 x24: 0000000000000010
> [   49.220918] x23: ffff800081fe0000 x22: 0000000000000000 x21: 0000000000000000
> [   49.228042] x20: ffff0000001b4010 x19: ffff0000001b4010 x18: 0000000000000006
> [   49.235166] x17: ffff7ffffe007000 x16: ffff800080000000 x15: 0000000000000000
> [   49.242290] x14: 00000000000000fc x13: 0000000000000000 x12: 0000000000000000
> [   49.249414] x11: 0000000000000001 x10: 0000000000000a60 x9 : ffff800082f8b8c0
> [   49.256538] x8 : 0000000000000008 x7 : 0000000000000001 x6 : 000000005f54a200
> [   49.263662] x5 : 0000000001000000 x4 : ffff800081b93680 x3 : ffff800081519be0
> [   49.270786] x2 : 0000000080800052 x1 : 0000000000000000 x0 : ffff0000001b4000
> [   49.277911] Call trace:
> [   49.280346]  0x80800052
> [   49.282781]  platform_pm_resume+0x2c/0x68
> [   49.286785]  dpm_run_callback.constprop.0+0x74/0x134
> [   49.291742]  device_resume+0x88/0x194
> [   49.295391]  dpm_resume+0x10c/0x230
> [   49.298866]  dpm_resume_end+0x18/0x30
> [   49.302515]  suspend_devices_and_enter+0x2b8/0x624
> [   49.307299]  pm_suspend+0x1fc/0x348
> [   49.310774]  state_store+0x80/0x104
> [   49.314258]  kobj_attr_store+0x18/0x2c
> [   49.318002]  sysfs_kf_write+0x44/0x54
> [   49.321659]  kernfs_fop_write_iter+0x120/0x1ec
> [   49.326088]  vfs_write+0x1bc/0x300
> [   49.329485]  ksys_write+0x70/0x104
> [   49.332874]  __arm64_sys_write+0x1c/0x28
> [   49.336783]  invoke_syscall+0x48/0x114
> [   49.340527]  el0_svc_common.constprop.0+0xc4/0xe4
> [   49.345224]  do_el0_svc+0x38/0x98
> [   49.348526]  el0_svc+0x2c/0x84
> [   49.351568]  el0t_64_sync_handler+0x100/0x12c
> [   49.355910]  el0t_64_sync+0x190/0x194
> [   49.359567] Code: ???????? ???????? ???????? ???????? (????????)
> [   49.365644] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 97117eb51ec8 ("net: stmmac: platform: provide stmmac_pltfr_init()")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 0d9b2138b60a..3c6fd9027934 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -900,7 +900,7 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  
> -	ret = stmmac_pltfr_init(pdev, priv->plat->bsp_priv);
> +	ret = stmmac_pltfr_init(pdev, priv->plat);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.34.1
> 
> 
