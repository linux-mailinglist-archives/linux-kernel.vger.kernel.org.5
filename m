Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D0791D96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbjIDT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:27:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F3CDA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:27:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bed2c786eso998219b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693855669; x=1694460469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWREej5t+eIqMC63lmoGy+XChxC2cKp7ZhM4c1pDWR0=;
        b=Ylatk4oMqX4DLeqkZXR5HOXv27jd4k5xLgL8zKr7OoCdqGTnukdwQUeSh7HbVwzDsq
         ql4qd7gD4XB8/ZXQVItAH45uEG649qttWb+tOEHcDiorrNfC9MopjcskaQQO8ioKVVVN
         hvrHzkYGRB1ZvKFwPI8S0CaeCr9kIoteYcdkxYCjfnu8d1csaY8nqUnMm4r8jXPvCU2r
         tsXz7fwxpeRE7MLdqzbcwsONvs/p5koEYZ7GNynZwY1tFRKTsb1j8cJv3pB2BXMOzO33
         B8EGAx+KV7szKraE1YtKCXtRUn17YHXH19Z6IbrpRkAecT38e6L05LKnX3JeKdBuak89
         5UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855669; x=1694460469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWREej5t+eIqMC63lmoGy+XChxC2cKp7ZhM4c1pDWR0=;
        b=d9o4f5e2EJs59RpObbX58cWVdvGmC6Xuuho1V7xNMtVvf4X6o3myXg5uV2uYe1qvUu
         kQ5A1O8pLlQ+xmRCCVx0nMdnIPx5GaccpL03aijBJ4YvIEoT47iT/r6SRgQFkL9ws6hv
         qFVJTM0pd9sMFTtIBIZVv5zTltBr0FzhF5ZNVElu8AJYPTlBRWJaabfoUB6+7hxs7Ov0
         wMaSIRdr633bpFY+2LykyXzObp26qsJO0wx6E6TGBPeDIpb96q4sXItj21qobErG5rfa
         oO68yzu5Y4PT0vjsb4s3hgo0dquTSQ2nwmciiqfgdWtj69jxRL4pwi1A7SMx9iRekxhv
         oUtA==
X-Gm-Message-State: AOJu0YxEDCZdjBmAmEgLgMu54+ERQuD21O3PbLokXyYun4m09KRv2RRe
        lELgEswwQRpcFjfxCkn1aN0qdg==
X-Google-Smtp-Source: AGHT+IF8jZgXYFF7x4w9/EJ+mUhvyY5RomvN8zh7QIx1a3gn13jt+ZjTcXlJuczNF8kMK83V8bbJpg==
X-Received: by 2002:a05:6a21:4841:b0:14c:c511:387d with SMTP id au1-20020a056a21484100b0014cc511387dmr9713357pzc.9.1693855669066;
        Mon, 04 Sep 2023 12:27:49 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:5de2:2323:20de:e26d])
        by smtp.gmail.com with ESMTPSA id cg11-20020a056a00290b00b0068c9fc82bfbsm6591591pfb.197.2023.09.04.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:27:48 -0700 (PDT)
Date:   Mon, 4 Sep 2023 12:27:46 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZPYvsvCYWibrKXOz@x1>
References: <20230820115353.1962-1-jszhang@kernel.org>
 <ZPUXhe7ogxvaB6Eg@x1>
 <ZPXtl1iWlsYwmixc@xhacker>
 <292198d3915bafbe1c82372da2f2755a1842512f.camel@xry111.site>
 <ZPYZZ4blDwaM8/ru@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPYZZ4blDwaM8/ru@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:52:39AM -0700, Drew Fustini wrote:
> On Tue, Sep 05, 2023 at 12:28:41AM +0800, Xi Ruoyao wrote:
> > On Mon, 2023-09-04 at 22:45 +0800, Jisheng Zhang wrote:
> > > On Sun, Sep 03, 2023 at 04:32:21PM -0700, Drew Fustini wrote:
> > > > On Sun, Aug 20, 2023 at 07:53:53PM +0800, Jisheng Zhang wrote:
> > > > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > > > dma coherent, so set dma-noncoherent to reflect this fact.
> > > > > 
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > ---
> > > > >  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > index 56a73134b49e..58108f0eb3fd 100644
> > > > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > @@ -139,6 +139,7 @@ soc {
> > > > >                 interrupt-parent = <&plic>;
> > > > >                 #address-cells = <2>;
> > > > >                 #size-cells = <2>;
> > > > > +               dma-noncoherent;
> > > > >                 ranges;
> > > > >  
> > > > >                 plic: interrupt-controller@ffd8000000 {
> > > > > -- 
> > > > > 2.40.1
> > > > > 
> > > > 
> > > > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > > > 
> > > > I tried this on the BeagleV Ahead. They system booted as expected and I
> > > > did not notice any problems in the boot log.
> > > > 
> > > > Are there other patches such as the dwmac series that I should test this
> > > > with?
> > > 
> > > Hmm, this patch is necessary to test dwmac, emmc ;)
> > 
> > Drew: does this fix the "broken DMA" issue you've mentioned in the EMMC
> > support patch?
> 
> After I sent my reply yesterday, I then tried applying this patch on top
> of my eMMC series. I removed SDHCI_QUIRK_BROKEN_DMA and I discovered
> that SDMA did not immediately break and the mmcblk0 partitions appeared
> in /dev [1]. Note - I am using CONFIG_INITRAMFS_SOURCE set to my
> buidlroot rootfs.cpio so that the system will boot okay regardless of
> the emmc.
> 
> I was able to mount the emmc boot partition /dev/mmcblk0p2. However,
> after unmounting it, I noticed that I could not mount it again:
> 
>   # mount /dev/mmcblk0p2 /mnt/p2 
>   [   41.684899] EXT4-fs (mmcblk0p2): mounted filesystem 6ea98ccf-2178-48a9-a1ad-0eb454f57268 r/w with ordered data mode
>   # ls -la /mnt/p2
>   total 22696
>   drwxr-xr-x    5 root     root          4096 Sep  4  2023 .
>   drwxr-xr-x    4 root     root             0 Jan  1 00:00 ..
>   -rw-rw-r--    1 1000     1000      26455552 Sep  4  2023 Image
>   drwxr-xr-x    2 root     root          4096 Jul 29  2023 extlinux
>   <snip>
>   # umount /mnt/p2
>   [   52.101003] EXT4-fs (mmcblk0p2): unmounting filesystem 6ea98ccf-2178-48a9-a1ad-0eb454f57268.
>   # mount /dev/mmcblk0p2 /mnt/p2
>   [   58.826078] JBD2: no valid journal superblock found
>   [   58.831041] EXT4-fs (mmcblk0p2): Could not load journal inode
>   mount: mounting /dev/mmcblk0p2 on /mnt/p2 failed: Invalid argument
> 
> I was completely unable to mount the root fs partition /dev/mmcblk0p3:
> 
>   # mount /dev/mmcblk0p2 /mnt/p2
>   [   58.826078] JBD2: no valid journal superblock found
>   [   58.831041] EXT4-fs (mmcblk0p2): Could not load journal inode
>   mount: mounting /dev/mmcblk0p2 on /mnt/p2 failed: Invalid argument
>   # umount /mnt/p2
>   umount: can't unmount /mnt/p2: Invalid argument
> 
> I suspect there is some corruption of the buffers happening. I see there
> are also these patch series from Jisheng so I will try applying them and
> see if there is any difference:
> 
>   [PATCH v2 0/2] riscv: errata: improve T-Head CMO
>   [PATCH] riscv: mm: update T-Head memory type definitions

Good news, I applied "riscv: errata: improve T-Head CMO" [1] and SDMA is
now working correctly. I can mount both boot and rootfs paritions and
then is no problem umounting and then remounting [2].

Note - I didn't 'riscv: mm: update T-Head memory type definitions' yet
but I will do that next and make sure everything is still working.

I'll post an update to my eMMC series.

-Drew

[1] https://lore.kernel.org/all/20230827090813.1353-1-jszhang@kernel.org/
[2] https://gist.github.com/pdp7/c72c91530c46ef560f4d1940ea1964c9

