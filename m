Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9837A71B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjITE5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjITE5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:57:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72495;
        Tue, 19 Sep 2023 21:57:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c09673b006so48313585ad.1;
        Tue, 19 Sep 2023 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695185849; x=1695790649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxIW1XMSQJ3ljMkGeAO/gplcSvpjzJd0q4yu7/aJdkI=;
        b=BuOdw9Tudmmih35V8PaBoE2+NKEbjWV1QT9UKk89E+9EcUxDkrs5aQlMmWwaxaqho9
         cuTQphEmbBuNJ4HtzW43Cl1o8qokg9O7i4jqavfqW8B0gur9Ww2pV65ov3RNc4+Cm78c
         folDrxPI0dZksOSUP8g/132qobeccqnMcAqN6z7+Hs0PiZegkyiByC1n5lXcg68bJNfm
         3jehrSbS1vCoFMVrrBpKdhk68E/s01N/MKkCR91b0OpaFJcfYixvjKEVrlA3zDdmVh00
         ExRPoqY8GzQgWEvfM4SQpu7KGsOGrJdmUNGoJOo742hiji70zQbXjSB0iwAwcoiHqnZS
         C14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695185849; x=1695790649;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIW1XMSQJ3ljMkGeAO/gplcSvpjzJd0q4yu7/aJdkI=;
        b=E3hHr9jDWG+sOgrSFHpRPEwGLVXIHl87A7avbaFxnwi20xQVWIp9iCPq9IIkNnOvDi
         JYCrYoRN0raqAWNzHxuexzTORWOSZJ46Jzll23ixrcvG0iTaZussUNFOsepEfG4UyI8j
         5d3RKzgCcKg5lUEKITqdwKSskF3aPsv2yX2VwLhIVgk5E7CshGt95VDPAu+PbC8WTlv9
         Toqjm4rXnkBAiZGjCn+IfUFsru7wWw65rPfrlq/EunIXqVwj3xT45GJX1kRfGXqZvyvI
         VjoH6j2uK8w5y7z7spMDW4JwsOvMXVnIl/MQfU+U3AduHdLbb5m3dG80QhjwjdJJytE6
         HmpA==
X-Gm-Message-State: AOJu0YxlcusONzuqnTwxo4DDNszXyGfFFgAphlSztTKl/Up3P1avyoHZ
        ntCyzpuN7jh+vDE0vxgYBtQ=
X-Google-Smtp-Source: AGHT+IGsfKUZaDmlGyBv/ddpa5bIRy+jSZ9BEpT7Mg3RrOAPvHUlAGNGcGiA8fyCsGtIbqixYC7PVg==
X-Received: by 2002:a17:902:e5d1:b0:1c5:82bb:223e with SMTP id u17-20020a170902e5d100b001c582bb223emr1469472plf.67.1695185848494;
        Tue, 19 Sep 2023 21:57:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001b9de4fb749sm10930246plb.20.2023.09.19.21.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 21:57:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
Date:   Tue, 19 Sep 2023 21:57:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230917191101.035638219@linuxfoundation.org>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 12:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

chromeos-5.10 locks up in configfs_lookup() after the merge of v5.10.195.

I am a bit puzzled because I see

c709c7ca020a configfs: fix a race in configfs_lookup()

in v5.10.195 but not in the list of commits below. I guess I must be
missing something.

Either case, the code now looks as follows.

configfs_lookup()
{
     ...
     spin_lock(&configfs_dirent_lock);
     ...
         err = configfs_attach_attr(sd, dentry);
     ...
     spin_unlock(&configfs_dirent_lock);
     ...
}

and

configfs_attach_attr(...)
{
     ...
     spin_lock(&configfs_dirent_lock);
     ...
}

which unless it is way too late here and I really need to go to sleep
just won't work.

Guenter

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 5.10.195-rc1
> 
> Helge Deller <deller@gmx.de>
>      parisc: Drop loops_per_jiffy from per_cpu struct
> 
> Wesley Chalmers <wesley.chalmers@amd.com>
>      drm/amd/display: Fix a bug when searching for insert_above_mpcc
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
> 
> Vadim Fedorenko <vadim.fedorenko@linux.dev>
>      ixgbe: fix timestamp configuration code
> 
> Eric Dumazet <edumazet@google.com>
>      ipv6: fix ip6_sock_set_addr_preferences() typo
> 
> Liu Jian <liujian56@huawei.com>
>      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()
> 
> Liming Sun <limings@nvidia.com>
>      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames
> 
> Liming Sun <limings@nvidia.com>
>      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
> 
> Shigeru Yoshida <syoshida@redhat.com>
>      kcm: Fix memory leak in error path of kcm_sendmsg()
> 
> Hayes Wang <hayeswang@realtek.com>
>      r8152: check budget for r8152_poll()
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>      hsr: Fix uninit-value access in fill_frame_info()
> 
> Hangyu Hua <hbh25y@gmail.com>
>      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
> 
> Hangyu Hua <hbh25y@gmail.com>
>      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
> 
> Guangguan Wang <guangguan.wang@linux.alibaba.com>
>      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add
> 
> Björn Töpel <bjorn@rivosinc.com>
>      kselftest/runner.sh: Propagate SIGTERM to runner child
> 
> SeongJae Park <sjpark@amazon.de>
>      selftests/kselftest/runner/run_one(): allow running non-executable files
> 
> Liu Jian <liujian56@huawei.com>
>      net: ipv4: fix one memleak in __inet_del_ifa()
> 
> Qiang Yu <quic_qianyu@quicinc.com>
>      bus: mhi: host: Skip MHI reset if device is in RDDM
> 
> Aleksey Nasibulin <alealexpro100@ya.ru>
>      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2
> 
> Paul Cercueil <paul@crapouillou.net>
>      ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Flush mailbox commands on chip reset
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Fix crash in PCIe error handling
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Consolidate zio threshold setting for both FCP & NVMe
> 
> Saurav Kashyap <skashyap@marvell.com>
>      scsi: qla2xxx: If fcport is undergoing deletion complete I/O with retry
> 
> D Scott Phillips <scott@os.amperecomputing.com>
>      arm64: sdei: abort running SDEI handlers during crash
> 
> Shuai Xue <xueshuai@linux.alibaba.com>
>      ACPI: APEI: explicit init of HEST and GHES in apci_init()
> 
> Namhyung Kim <namhyung@kernel.org>
>      perf hists browser: Fix the number of entries for 'e' key
> 
> Namhyung Kim <namhyung@kernel.org>
>      perf tools: Handle old data in PERF_RECORD_ATTR
> 
> Namhyung Kim <namhyung@kernel.org>
>      perf hists browser: Fix hierarchy mode header
> 
> Hamza Mahfooz <hamza.mahfooz@amd.com>
>      drm/amd/display: prevent potential division by zero errors
> 
> William Zhang <william.zhang@broadcom.com>
>      mtd: rawnand: brcmnand: Fix potential false time out warning
> 
> William Zhang <william.zhang@broadcom.com>
>      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
> 
> William Zhang <william.zhang@broadcom.com>
>      mtd: rawnand: brcmnand: Fix crash during the panic_write
> 
> Anand Jain <anand.jain@oracle.com>
>      btrfs: use the correct superblock to compare fsid in btrfs_validate_super
> 
> Filipe Manana <fdmanana@suse.com>
>      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
> 
> ruanmeisi <ruan.meisi@zte.com.cn>
>      fuse: nlookup missing decrement in fuse_direntplus_link
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: pata_ftide010: Add missing MODULE_DESCRIPTION
> 
> Damien Le Moal <dlemoal@kernel.org>
>      ata: sata_gemini: Add missing MODULE_DESCRIPTION
> 
> Wang Jianjian <wangjianjian0@foxmail.com>
>      ext4: add correct group descriptors and reserved GDT blocks to system zone
> 
> Petr Tesarik <petr.tesarik.ext@huawei.com>
>      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()
> 
> Yisen Zhuang <yisen.zhuang@huawei.com>
>      net: hns3: fix the port information display when sfp is absent
> 
> Wander Lairson Costa <wander@redhat.com>
>      netfilter: nfnetlink_osf: avoid OOB read
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>      net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>      net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
> 
> Eric Dumazet <edumazet@google.com>
>      ip_tunnels: use DEV_STATS_INC()
> 
> Ariel Marcovitch <arielmarcovitch@gmail.com>
>      idr: fix param name in idr_alloc_cyclic() doc
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      s390/zcrypt: don't leak memory if dev_set_name() fails
> 
> Olga Zaborska <olga.zaborska@intel.com>
>      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80
> 
> Olga Zaborska <olga.zaborska@intel.com>
>      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
> 
> Olga Zaborska <olga.zaborska@intel.com>
>      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
> 
> Shigeru Yoshida <syoshida@redhat.com>
>      kcm: Destroy mutex in kcm_exit_net()
> 
> valis <sec@valis.email>
>      net: sched: sch_qfq: Fix UAF in qfq_dequeue()
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      af_unix: Fix data race around sk->sk_err.
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      af_unix: Fix data-races around sk->sk_shutdown.
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      af_unix: Fix data-race around unix_tot_inflight.
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      af_unix: Fix data-races around user->unix_inflight.
> 
> Alex Henrie <alexhenrie24@gmail.com>
>      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
> 
> Liang Chen <liangchen.linux@gmail.com>
>      veth: Fixing transmit return status for dropped packets
> 
> Corinna Vinschen <vinschen@redhat.com>
>      igb: disable virtualization features on 82580
> 
> Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>      ipv4: ignore dst hint for multipath routes
> 
> Sean Christopherson <seanjc@google.com>
>      drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()
> 
> Colin Xu <colin.xu@intel.com>
>      drm/i915/gvt: Save/restore HW status to support GVT suspend/resume
> 
> Eric Dumazet <edumazet@google.com>
>      net: read sk->sk_family once in sk_mc_loop()
> 
> Eric Dumazet <edumazet@google.com>
>      ipv4: annotate data-races around fi->fib_dead
> 
> Eric Dumazet <edumazet@google.com>
>      sctp: annotate data-races around sk->sk_wmem_queued
> 
> Eric Dumazet <edumazet@google.com>
>      net/sched: fq_pie: avoid stalls in fq_pie_timer()
> 
> Vladimir Zapolskiy <vz@mleia.com>
>      pwm: lpc32xx: Remove handling of PWM channels
> 
> Raag Jadav <raag.jadav@intel.com>
>      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()
> 
> Sean Christopherson <seanjc@google.com>
>      x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>      perf annotate bpf: Don't enclose non-debug code with an assert()
> 
> Ying Liu <victor.liu@nxp.com>
>      backlight: gpio_backlight: Drop output GPIO direction check for initial power state
> 
> Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>      kconfig: fix possible buffer overflow
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>      NFS: Fix a potential data corruption
> 
> Chris Lew <quic_clew@quicinc.com>
>      soc: qcom: qmi_encdec: Restrict string length in decode
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock
> 
> Ahmad Fatoum <a.fatoum@pengutronix.de>
>      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      dt-bindings: clock: xlnx,versal-clk: drop select:false
> 
> Raag Jadav <raag.jadav@intel.com>
>      pinctrl: cherryview: fix address_space_handler() argument
> 
> Helge Deller <deller@gmx.de>
>      parisc: led: Reduce CPU overhead for disk & lan LED computation
> 
> Helge Deller <deller@gmx.de>
>      parisc: led: Fix LAN receive and transmit LEDs
> 
> Andrew Donnellan <ajd@linux.ibm.com>
>      lib/test_meminit: allocate pages up to order MAX_ORDER
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      drm/ast: Fix DRAM init on AST2200
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
> 
> Manish Rangankar <mrangankar@marvell.com>
>      scsi: qla2xxx: Remove unsupported ql2xenabledif option
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Turn off noisy message log
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Fix erroneous link up failure
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: fix inconsistent TMF timeout
> 
> Quinn Tran <qutran@marvell.com>
>      scsi: qla2xxx: Fix deletion race condition
> 
> Pavel Begunkov <asml.silence@gmail.com>
>      io_uring: break iopolling on signal
> 
> Pavel Begunkov <asml.silence@gmail.com>
>      io_uring: break out of iowq iopoll on teardown
> 
> Pavel Begunkov <asml.silence@gmail.com>
>      io_uring: always lock in io_apoll_task_func
> 
> Quan Tian <qtian@vmware.com>
>      net/ipv6: SKB symmetric hash should incorporate transport ports
> 
> Tom Rix <trix@redhat.com>
>      udf: initialize newblock to 0
> 
> Yu Kuai <yukuai3@huawei.com>
>      md/md-bitmap: remove unnecessary local variable in backlog_store()
> 
> Brian Foster <bfoster@redhat.com>
>      tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY
> 
> Marco Felsch <m.felsch@pengutronix.de>
>      usb: typec: tcpci: clear the fault status bit
> 
> Alan Stern <stern@rowland.harvard.edu>
>      USB: core: Fix oversight in SuperSpeed initialization
> 
> Alan Stern <stern@rowland.harvard.edu>
>      USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()
> 
> Alan Stern <stern@rowland.harvard.edu>
>      USB: core: Change usb_get_device_descriptor() API
> 
> Alan Stern <stern@rowland.harvard.edu>
>      USB: core: Unite old scheme and new scheme descriptor reads
> 
> RD Babiera <rdbabiera@google.com>
>      usb: typec: bus: verify partner exists in typec_altmode_attention
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
> 
> Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>      crypto: stm32 - fix loop iterating through scatterlist for DMA
> 
> Sven Schnelle <svens@linux.ibm.com>
>      s390/ipl: add missing secure/has_secure file to ipl type 'unknown'
> 
> Enlin Mu <enlin.mu@unisoc.com>
>      pstore/ram: Check start of empty przs during init
> 
> Eric Biggers <ebiggers@google.com>
>      fsverity: skip PKCS#7 parser when keyring is empty
> 
> Nicolas Dichtel <nicolas.dichtel@6wind.com>
>      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
> 
> Thore Sommer <public@thson.de>
>      X.509: if signature is unsupported skip validation
> 
> Jann Horn <jannh@google.com>
>      dccp: Fix out of bounds access in DCCP error handler
> 
> Alexander Aring <aahringo@redhat.com>
>      dlm: fix plock lookup when using multiple lockspaces
> 
> Yafang Shao <laoar.shao@gmail.com>
>      bpf: Fix issue in verifying allow_ptr_leaks
> 
> Helge Deller <deller@gmx.de>
>      parisc: Fix /proc/cpuinfo output for lscpu
> 
> Aleksa Sarai <cyphar@cyphar.com>
>      procfs: block chmod on /proc/thread-self/comm
> 
> Bjorn Helgaas <bhelgaas@google.com>
>      Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"
> 
> Dave Jiang <dave.jiang@intel.com>
>      ntb: Fix calculation ntb_transport_tx_free_entry()
> 
> Dave Jiang <dave.jiang@intel.com>
>      ntb: Clean up tx tail index on link down
> 
> Dave Jiang <dave.jiang@intel.com>
>      ntb: Drop packets when qp link is down
> 
> Ranjan Kumar <ranjan.kumar@broadcom.com>
>      scsi: mpt3sas: Perform additional retries if doorbell read returns 0
> 
> Nilesh Javali <njavali@marvell.com>
>      Revert "scsi: qla2xxx: Fix buffer overrun"
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      media: dvb: symbol fixup for dvb_attach()
> 
> Will Deacon <will@kernel.org>
>      arm64: csum: Fix OoB access in IP checksum code for negative lengths
> 
> Max Filippov <jcmvbkbc@gmail.com>
>      xtensa: PMU: fix base address for the newer hardware
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      backlight/lv5207lp: Compare against struct fb_info.device
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      backlight/bd6107: Compare against struct fb_info.device
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>      backlight/gpio_backlight: Compare against struct fb_info.device
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
> 
> Yi Yang <yiyang13@huawei.com>
>      ipmi_si: fix a memleak in try_smi_init()
> 
> Bart Van Assche <bvanassche@acm.org>
>      scsi: core: Fix the scsi_set_resid() documentation
> 
> Kees Cook <keescook@chromium.org>
>      printk: ringbuffer: Fix truncating buffer size min_t cast
> 
> Takashi Iwai <tiwai@suse.de>
>      ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl
> 
> Boris Brezillon <boris.brezillon@collabora.com>
>      PM / devfreq: Fix leak in devfreq_dev_release()
> 
> Radoslaw Tyl <radoslawx.tyl@intel.com>
>      igb: set max size RX buffer when store bad packet is enabled
> 
> Mohamed Khalfella <mkhalfella@purestorage.com>
>      skbuff: skb_segment, Call zero copy functions before using skbuff frags
> 
> Wander Lairson Costa <wander@redhat.com>
>      netfilter: xt_sctp: validate the flag_info count
> 
> Wander Lairson Costa <wander@redhat.com>
>      netfilter: xt_u32: validate user space input
> 
> Kyle Zeng <zengyhkyle@gmail.com>
>      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c
> 
> Eric Dumazet <edumazet@google.com>
>      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
> 
> Yuan Yao <yuanyaogoog@chromium.org>
>      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> 
> Liao Chang <liaochang1@huawei.com>
>      cpufreq: Fix the race condition while updating the transition_task of policy
> 
> ruanjinjie <ruanjinjie@huawei.com>
>      dmaengine: ste_dma40: Add missing IRQ check in d40_probe
> 
> Randy Dunlap <rdunlap@infradead.org>
>      um: Fix hostaudio build errors
> 
> Yi Yang <yiyang13@huawei.com>
>      mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()
> 
> Hsin-Yi Wang <hsinyi@chromium.org>
>      mtd: spi-nor: Check bus width while setting QE bit
> 
> Marek Behún <kabel@kernel.org>
>      leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      rpmsg: glink: Add check for kstrdup
> 
> Jonas Karlman <jonas@kwiboo.se>
>      phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write
> 
> Zheng Yang <zhengyang@rock-chips.com>
>      phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate
> 
> Jonas Karlman <jonas@kwiboo.se>
>      phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
> 
> William Zhang <william.zhang@broadcom.com>
>      mtd: rawnand: brcmnand: Fix mtd oobsize
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      tracing: Fix race issue between cpu buffer write and swap
> 
> Dave Hansen <dave.hansen@linux.intel.com>
>      x86/speculation: Mark all Skylake CPUs as vulnerable to GDS
> 
> Rahul Rameshbabu <sergeantsagara@protonmail.com>
>      HID: multitouch: Correct devm device reference for hidinput input_dev name
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>      HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()
> 
> Guoqing Jiang <guoqing.jiang@linux.dev>
>      RDMA/siw: Correct wrong debug message
> 
> Guoqing Jiang <guoqing.jiang@linux.dev>
>      RDMA/siw: Balance the reference of cep->kref in the error path
> 
> Leon Romanovsky <leon@kernel.org>
>      Revert "IB/isert: Fix incorrect release of isert connection"
> 
> Peng Fan <peng.fan@nxp.com>
>      amba: bus: fix refcount leak
> 
> Yi Yang <yiyang13@huawei.com>
>      serial: tegra: handle clk prepare error in tegra_uart_hw_init()
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
> 
> Tony Battersby <tonyb@cybernetics.com>
>      scsi: core: Use 32-bit hostnum in scsi_host_lookup()
> 
> Lu Jialin <lujialin4@huawei.com>
>      cgroup:namespace: Remove unused cgroup_namespaces_init()
> 
> Hans de Goede <hdegoede@redhat.com>
>      media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors
> 
> Hans de Goede <hdegoede@redhat.com>
>      media: ov2680: Fix vflip / hflip set functions
> 
> Hans de Goede <hdegoede@redhat.com>
>      media: ov2680: Fix ov2680_bayer_order()
> 
> Hans de Goede <hdegoede@redhat.com>
>      media: ov2680: Remove auto-gain and auto-exposure controls
> 
> Dave Stevenson <dave.stevenson@raspberrypi.com>
>      media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
> 
> Marek Vasut <marex@denx.de>
>      media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()
> 
> Alan Stern <stern@rowland.harvard.edu>
>      USB: gadget: f_mass_storage: Fix unused variable warning
> 
> Colin Ian King <colin.i.king@gmail.com>
>      media: go7007: Remove redundant if statement
> 
> Yanfei Xu <yanfei.xu@intel.com>
>      iommu/vt-d: Fix to flush cache of PASID directory table
> 
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      iommu/qcom: Disable and reset context bank before programming
> 
> Eddie James <eajames@linux.ibm.com>
>      fsi: aspeed: Reset master errors after CFAM reset
> 
> Xiang Yang <xiangyang3@huawei.com>
>      IB/uverbs: Fix an potential error pointer dereference
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      driver core: test_async: fix an error code
> 
> Rob Clark <robdclark@chromium.org>
>      dma-buf/sync_file: Fix docs syntax
> 
> Ruidong Tian <tianruidong@linux.alibaba.com>
>      coresight: tmc: Explicit type conversions to prevent integer overflow
> 
> Oleksandr Natalenko <oleksandr@redhat.com>
>      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly
> 
> Oleksandr Natalenko <oleksandr@redhat.com>
>      scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
> 
> Oleksandr Natalenko <oleksandr@redhat.com>
>      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
> 
> Randy Dunlap <rdunlap@infradead.org>
>      x86/APM: drop the duplicate APM_MINOR_DEV macro
> 
> Chunyan Zhang <chunyan.zhang@unisoc.com>
>      serial: sprd: Fix DMA buffer leak issue
> 
> Chunyan Zhang <chunyan.zhang@unisoc.com>
>      serial: sprd: Assign sprd_port after initialized to avoid wrong access
> 
> Lin Ma <linma@zju.edu.cn>
>      scsi: qla4xxx: Add length check when parsing nlattrs
> 
> Lin Ma <linma@zju.edu.cn>
>      scsi: be2iscsi: Add length check when parsing nlattrs
> 
> Lin Ma <linma@zju.edu.cn>
>      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
> 
> Lin Ma <linma@zju.edu.cn>
>      scsi: iscsi: Add length check for nlattr payload
> 
> Wenchao Hao <haowenchao@huawei.com>
>      scsi: iscsi: Rename iscsi_set_param() to iscsi_if_set_param()
> 
> Bart Van Assche <bvanassche@acm.org>
>      scsi: RDMA/srp: Fix residual handling
> 
> Xu Yang <xu.yang_2@nxp.com>
>      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()
> 
> Irui Wang <irui.wang@mediatek.com>
>      media: mediatek: vcodec: Return NULL if no vdec_fb is found
> 
> Benjamin Gaignard <benjamin.gaignard@collabora.com>
>      media: rkvdec: increase max supported height for H.264
> 
> Xingui Yang <yangxingui@huawei.com>
>      scsi: hisi_sas: Fix normally completed I/O analysed as failed
> 
> Xingui Yang <yangxingui@huawei.com>
>      scsi: hisi_sas: Fix warnings detected by sparse
> 
> Xingui Yang <yangxingui@huawei.com>
>      scsi: hisi_sas: Modify v3 HW SATA completion error processing
> 
> Xingui Yang <yangxingui@huawei.com>
>      scsi: hisi_sas: Modify v3 HW SSP underflow error processing
> 
> Bart Van Assche <bvanassche@acm.org>
>      scsi: libsas: Introduce more SAM status code aliases in enum exec_status
> 
> Luo Jiaxing <luojiaxing@huawei.com>
>      scsi: hisi_sas: Print SAS address for v3 hw erroneous completion print
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>      media: cx24120: Add retval check for cx24120_message_send()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>      media: dib7000p: Fix potential division by zero
> 
> Dongliang Mu <dzm91@hust.edu.cn>
>      drivers: usb: smsusb: fix error handling code in smsusb_init_device
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      media: i2c: tvp5150: check return value of devm_kasprintf()
> 
> Hans de Goede <hdegoede@redhat.com>
>      media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tables
> 
> Olga Kornievskaia <kolga@netapp.com>
>      NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ
> 
> Benjamin Coddington <bcodding@redhat.com>
>      NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN
> 
> Chuck Lever <chuck.lever@oracle.com>
>      NFSD: da_addr_body field missing in some GETDEVICEINFO replies
> 
> Su Hui <suhui@nfschina.com>
>      fs: lockd: avoid possible wrong NULL parameter
> 
> Alexei Filippov <halip0503@gmail.com>
>      jfs: validate max amount of blocks before allocation.
> 
> Russell Currey <ruscur@russell.cc>
>      powerpc/iommu: Fix notifiers being shared by PCI and VIO buses
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      nfs/blocklayout: Use the passed in gfp flags
> 
> Russell Currey <ruscur@russell.cc>
>      powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT
> 
> Michael Ellerman <mpe@ellerman.id.au>
>      powerpc: Don't include lppaca.h in paca.h
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      wifi: ath10k: Use RMW accessors for changing LNKCTL
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      net/mlx5: Use RMW accessors for changing LNKCTL
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      drm/radeon: Use RMW accessors for changing LNKCTL
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      drm/amdgpu: Use RMW accessors for changing LNKCTL
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>      powerpc/perf: Convert fsl_emb notifier to state machine callbacks
> 
> Sourabh Jain <sourabhjain@linux.ibm.com>
>      powerpc/fadump: reset dump area size if fadump memory reserve fails
> 
> Stefan Hajnoczi <stefanha@redhat.com>
>      vfio/type1: fix cap_migration information leak
> 
> Ahmad Fatoum <a.fatoum@pengutronix.de>
>      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
> 
> Marco Felsch <m.felsch@pengutronix.de>
>      clk: imx8mp: fix sai4 clock
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      PCI/ASPM: Use RMW accessors for changing LNKCTL
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      PCI: pciehp: Use RMW accessors for changing LNKCTL
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>      pinctrl: mcp23s08: check return value of devm_kasprintf()
> 
> Wu Zongyong <wuzongyong@linux.alibaba.com>
>      PCI: Mark NVIDIA T4 GPUs to avoid bus reset
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>      clk: qcom: reset: Use the correct type of sleep/delay based on length
> 
> Patrick Whewell <patrick.whewell@sightlineapplications.com>
>      clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>      clk: qcom: gcc-sm8250: use ARRAY_SIZE instead of specifying num_parents
> 
> Kemeng Shi <shikemeng@huaweicloud.com>
>      ext4: correct grp validation in ext4_mb_good_group
> 
> David Wronek <davidwronek@gmail.com>
>      clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>      clk: qcom: gcc-sc7180: use ARRAY_SIZE instead of specifying num_parents
> 
> Zhang Jianhua <chris.zjh@huawei.com>
>      clk: sunxi-ng: Modify mismatched function name
> 
> Minjie Du <duminjie@vivo.com>
>      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
> 
> Corey Minyard <minyard@acm.org>
>      ipmi:ssif: Fix a memory leak when scanning for an adapter
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      ipmi:ssif: Add check for kstrdup
> 
> Su Hui <suhui@nfschina.com>
>      ALSA: ac97: Fix possible error value of *rac97
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      of: unittest: Fix overlay type in apply/revert check
> 
> Tony Lindgren <tony@atomide.com>
>      bus: ti-sysc: Fix cast to enum warning
> 
> Sui Jingfeng <suijingfeng@loongson.cn>
>      drm/mediatek: Fix potential memory leak if vmap() fail
> 
> Tony Lindgren <tony@atomide.com>
>      bus: ti-sysc: Fix build warning for 64-bit build
> 
> Gaosheng Cui <cuigaosheng1@huawei.com>
>      audit: fix possible soft lockup in __audit_inode_child()
> 
> Fabio Estevam <festevam@denx.de>
>      drm/msm/a2xx: Call adreno_gpu_init() earlier
> 
> Yang Wang <kevinyang.wang@amd.com>
>      drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      smackfs: Prevent underflow in smk_set_cipso()
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>      firmware: meson_sm: fix to avoid potential NULL pointer dereference
> 
> Daniel Vetter <daniel.vetter@ffwll.ch>
>      drm/msm/mdp5: Don't leak some plane state
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>      drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask
> 
> Nayna Jain <nayna@linux.ibm.com>
>      ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig
> 
> Marek Vasut <marex@denx.de>
>      drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      drm/armada: Fix off-by-one error in armada_overlay_get_property()
> 
> Ruan Jinjie <ruanjinjie@huawei.com>
>      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()
> 
> Yangtao Li <frank.li@vivo.com>
>      drm/tegra: dpaux: Fix incorrect return value of platform_get_irq
> 
> Tan Zhongjun <tanzhongjun@yulong.com>
>      drm/tegra: Remove superfluous error messages around platform_get_irq()
> 
> Yu Kuai <yukuai3@huawei.com>
>      md/md-bitmap: hold 'reconfig_mutex' in backlog_store()
> 
> Guoqing Jiang <guoqing.jiang@linux.dev>
>      md/bitmap: don't set max_write_behind if there is no write mostly device
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>      drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>      arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>      arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM53573: Fix Ethernet info for Luxul devices
> 
> Bogdan Togorean <bogdan.togorean@analog.com>
>      drm: adv7511: Fix low refresh rate register for ADV7533/5
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
> 
> Krzysztof Kozlowski <krzk@kernel.org>
>      ARM: dts: s5pv210: adjust node names to DT spec
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>      ARM: dts: s3c64xx: align pinctrl with dtschema
> 
> Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>      x86/mm: Fix PAT bit missing from page protection modify mask
> 
> Lucas Stach <l.stach@pengutronix.de>
>      drm/etnaviv: fix dumping of active MMU context
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM53573: Add cells sizes to PCIe node
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM53573: Drop nonexistent #usb-cells
> 
> Rafał Miłecki <rafal@milecki.pl>
>      ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch
> 
> Serge Semin <Sergey.Semin@baikalelectronics.ru>
>      ARM: dts: BCM5301X: Harmonize EHCI/OHCI DT nodes name
> 
> Arnd Bergmann <arnd@arndb.de>
>      drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>      arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller
> 
> Luca Weiss <luca@z3ntu.xyz>
>      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
> 
> Luca Weiss <luca@z3ntu.xyz>
>      soc: qcom: ocmem: Add OCMEM hardware version print
> 
> Randy Dunlap <rdunlap@infradead.org>
>      ASoC: stac9766: fix build errors with REGMAP_AC97
> 
> Baokun Li <libaokun1@huawei.com>
>      quota: fix dqput() to follow the guarantees dquot_srcu should provide
> 
> Baokun Li <libaokun1@huawei.com>
>      quota: add new helper dquot_active()
> 
> Baokun Li <libaokun1@huawei.com>
>      quota: rename dquot_active() to inode_quota_active()
> 
> Baokun Li <libaokun1@huawei.com>
>      quota: factor out dquot_write_dquot()
> 
> Marek Vasut <marex@denx.de>
>      drm/bridge: tc358764: Fix debug print parameter order
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      netrom: Deny concurrent connect().
> 
> Budimir Markovic <markovicbudimir@gmail.com>
>      net/sched: sch_hfsc: Ensure inner classes have fsc curve
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>      hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()
> 
> Vadim Pasternak <vadimp@nvidia.com>
>      mlxsw: i2c: Limit single transaction buffer size
> 
> Vadim Pasternak <vadimp@nvidia.com>
>      mlxsw: i2c: Fix chunk size setting in output mailbox buffer
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>      net: arcnet: Do not call kfree_skb() under local_irq_disable()
> 
> Wang Ming <machel@vivo.com>
>      wifi: ath9k: use IS_ERR() with debugfs_create_dir()
> 
> Jinjie Ruan <ruanjinjie@huawei.com>
>      Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>      wifi: mwifiex: avoid possible NULL skb pointer dereference
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      wifi: ath9k: protect WMI command response buffer replacement with a lock
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
> 
> Daniel T. Lee <danieltimlee@gmail.com>
>      samples/bpf: fix broken map lookup probe
> 
> Polaris Pi <pinkperfect2021@gmail.com>
>      wifi: mwifiex: Fix missed return in oob checks failed path
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
> 
> Artem Chernyshev <artem.chernyshev@red-soft.ru>
>      fs: ocfs2: namei: check return value of ocfs2_add_entry()
> 
> Yan Zhai <yan@cloudflare.com>
>      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly
> 
> Yan Zhai <yan@cloudflare.com>
>      lwt: Fix return values of BPF xmit ops
> 
> Florian Fainelli <florian.fainelli@broadcom.com>
>      hwrng: iproc-rng200 - Implement suspend and resume calls
> 
> Gaurav Jain <gaurav.jain@nxp.com>
>      crypto: caam - fix unchecked return value error
> 
> Przemek Kitszel <przemyslaw.kitszel@intel.com>
>      ice: ice_aq_check_events: fix off-by-one check when filling buffer
> 
> Yipeng Zou <zouyipeng@huawei.com>
>      selftests/bpf: Clean up fmod_ret in bench_rename test script
> 
> Menglong Dong <imagedong@tencent.com>
>      net: tcp: fix unexcepted socket die when snd_wnd is 0
> 
> Min Li <lm0963hack@gmail.com>
>      Bluetooth: Fix potential use-after-free when clear keys
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>      crypto: api - Use work queue in crypto_destroy_instance
> 
> Eric Biggers <ebiggers@google.com>
>      crypto: blake2b - sync with blake2s implementation
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>      crypto: stm32 - Properly handle pm_runtime_get failing
> 
> Alan Maguire <alan.maguire@oracle.com>
>      selftests/bpf: fix static assert compilation issue for test_cls_*.c
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
> 
> Polaris Pi <pinkperfect2021@gmail.com>
>      wifi: mwifiex: Fix OOB and integer underflow when rx packets
> 
> Marc Kleine-Budde <mkl@pengutronix.de>
>      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>      spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
> 
> Lin Ma <linma@zju.edu.cn>
>      wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
> 
> Lorenz Bauer <lmb@isovalent.com>
>      bpf: reject unhashed sockets in bpf_sk_assign
> 
> Lorenz Bauer <lmb@isovalent.com>
>      udp: re-score reuseport groups when connected sockets are present
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      regmap: rbtree: Use alloc_flags for memory allocations
> 
> Martin Kaiser <martin@kaiser.cx>
>      hwrng: nomadik - keep clock enabled while hwrng is registered
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: tcp_enter_quickack_mode() should be static
> 
> Yafang Shao <laoar.shao@gmail.com>
>      bpf: Clear the probe_addr for uprobe
> 
> Alexander Lobakin <alobakin@pm.me>
>      bpftool: Use a local bpf_perf_event_value to fix accessing its fields
> 
> Liao Chang <liaochang1@huawei.com>
>      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
> 
> Mikel Rychliski <mikel@mikelr.com>
>      x86/efistub: Fix PCI ROM preservation in mixed mode
> 
> Holger Dengler <dengler@linux.ibm.com>
>      s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs
> 
> Holger Dengler <dengler@linux.ibm.com>
>      s390/pkey: fix/harmonize internal keyblob headers
> 
> Xu Yang <xu.yang_2@nxp.com>
>      perf/imx_ddr: don't enable counter0 if none of 4 counters are used
> 
> Ard Biesheuvel <ardb@kernel.org>
>      x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      selftests/resctrl: Close perf value read fd on errors
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      selftests/resctrl: Don't leak buffer in fill_cache()
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
> 
> Waiman Long <longman@redhat.com>
>      refscale: Fix uninitalized use of wait_queue_head_t
> 
> Kees Cook <keescook@chromium.org>
>      selftests/harness: Actually report SKIP for signal tests
> 
> Christian Brauner <brauner@kernel.org>
>      tmpfs: verify {g,u}id mount options correctly
> 
> Wang Ming <machel@vivo.com>
>      fs: Fix error checking for d_hash_and_lookup()
> 
> Wen Yang <wenyang.linux@foxmail.com>
>      eventfd: prevent underflow for eventfd semaphores
> 
> David Woodhouse <dwmw@amazon.co.uk>
>      eventfd: Export eventfd_ctx_do_read()
> 
> Matthew Wilcox <willy@infradead.org>
>      reiserfs: Check the return value from __getblk()
> 
> Sabrina Dubroca <sd@queasysnail.net>
>      Revert "net: macsec: preserve ingress frame ordering"
> 
> Jan Kara <jack@suse.cz>
>      udf: Handle error when adding extent to a file
> 
> Vladislav Efanov <VEfanov@ispras.ru>
>      udf: Check consistency of Space Bitmap Descriptor
> 
> Jordan Rife <jrife@google.com>
>      net: Avoid address overwrite in kernel_connect
> 
> Shih-Yi Chen <shihyic@nvidia.com>
>      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>      tracing: Introduce pipe_cpumask to avoid race on trace_pipes
> 
> Takashi Iwai <tiwai@suse.de>
>      ALSA: seq: oss: Fix racy open/close of MIDI devices
> 
> Michael Kelley <mikelley@microsoft.com>
>      scsi: storvsc: Always set no_report_opcodes
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      sctp: handle invalid error codes without calling BUG()
> 
> David Christensen <drc@linux.vnet.ibm.com>
>      bnx2x: fix page fault following EEH recovery
> 
> Dmitry Mastykin <dmastykin@astralinux.ru>
>      netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
> 
> Baoquan He <bhe@redhat.com>
>      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
> 
> Martin Kohn <m.kohn@welotec.com>
>      net: usb: qmi_wwan: add Quectel EM05GV2
> 
> Ani Sinha <anisinha@redhat.com>
>      vmbus_testing: fix wrong python syntax for integer value comparison
> 
> Baoquan He <bhe@redhat.com>
>      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>      kprobes: Prohibit probing on CFI preamble symbol
> 
> Christian Göttsche <cgzones@googlemail.com>
>      security: keys: perform capable check only on privileged operations
> 
> Minjie Du <duminjie@vivo.com>
>      ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
> 
> Eric Snowberg <eric.snowberg@oracle.com>
>      ovl: Always reevaluate the file signature for IMA
> 
> Leo Chen <sancchen@amd.com>
>      drm/amd/display: Exit idle optimizations before attempt to access PHY
> 
> Konstantin Shelekhin <k.shelekhin@ftml.net>
>      platform/x86: huawei-wmi: Silence ambient light sensor
> 
> Hans de Goede <hdegoede@redhat.com>
>      platform/x86: intel: hid: Always call BTNL ACPI method
> 
> Guiting Shen <aarongt.shen@gmail.com>
>      ASoC: atmel: Fix the 8K sample parameter in I2SC master
> 
> Edgar <ljijcj@163.com>
>      ASoc: codecs: ES8316: Fix DMIC config
> 
> Winston Wen <wentao@uniontech.com>
>      fs/nls: make load_nls() take a const parameter
> 
> Stefan Haberland <sth@linux.ibm.com>
>      s390/dasd: fix hanging device after request requeue
> 
> Stefan Haberland <sth@linux.ibm.com>
>      s390/dasd: use correct number of retries for ERP requests
> 
> Ben Hutchings <benh@debian.org>
>      m68k: Fix invalid .section syntax
> 
> Jiri Benc <jbenc@redhat.com>
>      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      ethernet: atheros: fix return value check in atl1c_tso_csum()
> 
> Dmytro Maluka <dmy@semihalf.com>
>      ASoC: da7219: Check for failure reading AAD IRQ events
> 
> Dmytro Maluka <dmy@semihalf.com>
>      ASoC: da7219: Flush pending AAD IRQ when suspending
> 
> Dominique Martinet <asmadeus@codewreck.org>
>      9p: virtio: make sure 'offs' is initialized in zc_request
> 
> Nikolay Burykin <burikin@ivk.ru>
>      media: pci: cx23885: fix error handling for cx23885 ATSC boards
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>      media: pulse8-cec: handle possible ping error
> 
> Adrien Thierry <athierry@redhat.com>
>      phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code
> 
> Xiaolei Wang <xiaolei.wang@windriver.com>
>      ARM: dts: imx: Set default tuning step for imx7d usdhc
> 
> Stefan Wahren <stefan.wahren@i2se.com>
>      ARM: dts: imx: Adjust dma-apbh node name
> 
> Marek Vasut <marex@denx.de>
>      ARM: dts: imx7s: Drop dma-apb interrupt-names
> 
> Joy Zou <joy.zou@nxp.com>
>      ARM: dts: imx: update sdma node name format
> 
> Oder Chiou <oder_chiou@realtek.com>
>      ASoC: rt5682: Fix a problem with error handling in the io init function of the soundwire
> 
> Mario Limonciello <mario.limonciello@amd.com>
>      pinctrl: amd: Don't show `Invalid config param` errors
> 
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>      nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse
> 
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
> 
> Juerg Haefliger <juerg.haefliger@canonical.com>
>      fsi: master-ast-cf: Add MODULE_FIRMWARE macro
> 
> Wang Ming <machel@vivo.com>
>      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
> 
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>      serial: sc16is7xx: fix bug when first setting GPIO direction
> 
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>      serial: sc16is7xx: fix broken port 0 uart init
> 
> Johan Hovold <johan+linaro@kernel.org>
>      serial: qcom-geni: fix opp vote on shutdown
> 
> Sishuai Gong <sishuai@purdue.edu>
>      configfs: fix a race in configfs_lookup()
> 
> Zheng Wang <zyytlz.wz@163.com>
>      Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> Nam Cao <namcaov@gmail.com>
>      staging: rtl8712: fix race condition
> 
> Aaron Armstrong Skomra <aaron.skomra@wacom.com>
>      HID: wacom: remove the battery when the EKR is off
> 
> Xu Yang <xu.yang_2@nxp.com>
>      usb: chipidea: imx: improve logic if samsung,picophy-* parameter is 0
> 
> Luke Lu <luke.lu@libre.computer>
>      usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
> 
> Slark Xiao <slark_xiao@163.com>
>      USB: serial: option: add FOXCONN T99W368/T99W373 product
> 
> Martin Kohn <m.kohn@welotec.com>
>      USB: serial: option: add Quectel EM05G variant (0x030e)
> 
> Christoph Hellwig <hch@lst.de>
>      modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
> 
> Christoph Hellwig <hch@lst.de>
>      rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
> 
> Christoph Hellwig <hch@lst.de>
>      net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
> 
> Christoph Hellwig <hch@lst.de>
>      mmc: au1xmmc: force non-modular build and remove symbol_get usage
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: pxa: remove use of symbol_get()
> 
> Gao Xiang <hsiangkao@linux.alibaba.com>
>      erofs: ensure that the post-EOF tails are all zeroed
> 
> 
> -------------
> 
> Diffstat:
> 
>   .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   2 -
>   Documentation/scsi/scsi_mid_low_api.rst            |   4 +-
>   Makefile                                           |   4 +-
>   arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts    |   3 +-
>   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |  13 +
>   arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |  13 +
>   arch/arm/boot/dts/bcm5301x.dtsi                    |   4 +-
>   arch/arm/boot/dts/bcm53573.dtsi                    |  27 +-
>   arch/arm/boot/dts/bcm947189acdbmr.dts              |   6 +-
>   arch/arm/boot/dts/exynos4210-i9100.dts             |   4 +-
>   arch/arm/boot/dts/imx23.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx25.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx28.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx31.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx35.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx50.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx51.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx53.dtsi                       |   2 +-
>   arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +-
>   arch/arm/boot/dts/imx6sl.dtsi                      |   2 +-
>   arch/arm/boot/dts/imx6sx.dtsi                      |   4 +-
>   arch/arm/boot/dts/imx6ul.dtsi                      |   4 +-
>   arch/arm/boot/dts/imx7s.dtsi                       |  11 +-
>   arch/arm/boot/dts/s3c6410-mini6410.dts             |   6 +-
>   arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 210 ++++++-------
>   arch/arm/boot/dts/s5pv210-aquila.dts               |  12 +-
>   arch/arm/boot/dts/s5pv210-aries.dtsi               |   4 +-
>   arch/arm/boot/dts/s5pv210-goni.dts                 |  14 +-
>   arch/arm/boot/dts/s5pv210-smdkv210.dts             |  30 +-
>   arch/arm/mach-omap2/powerdomain.c                  |   2 +-
>   arch/arm/mach-pxa/sharpsl_pm.c                     |   2 -
>   arch/arm/mach-pxa/spitz.c                          |  14 +-
>   arch/arm64/boot/dts/qcom/msm8996.dtsi              |   3 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
>   arch/arm64/include/asm/sdei.h                      |   6 +
>   arch/arm64/kernel/entry.S                          |  27 +-
>   arch/arm64/kernel/sdei.c                           |   3 +
>   arch/arm64/kernel/smp.c                            |   8 +-
>   arch/arm64/lib/csum.c                              |   2 +-
>   arch/m68k/fpsp040/skeleton.S                       |   4 +-
>   arch/m68k/ifpsp060/os.S                            |   4 +-
>   arch/m68k/kernel/relocate_kernel.S                 |   4 +-
>   arch/mips/alchemy/devboards/db1000.c               |   8 +-
>   arch/mips/alchemy/devboards/db1200.c               |  19 +-
>   arch/mips/alchemy/devboards/db1300.c               |  10 +-
>   arch/parisc/include/asm/led.h                      |   4 +-
>   arch/parisc/include/asm/processor.h                |   1 -
>   arch/parisc/kernel/processor.c                     |  18 +-
>   arch/powerpc/include/asm/lppaca.h                  |  13 +-
>   arch/powerpc/include/asm/paca.h                    |   6 +-
>   arch/powerpc/include/asm/paravirt.h                |   1 +
>   arch/powerpc/include/asm/plpar_wrappers.h          |   1 +
>   arch/powerpc/kernel/fadump.c                       |   1 +
>   arch/powerpc/kernel/iommu.c                        |  17 +-
>   arch/powerpc/kvm/book3s_hv_ras.c                   |   1 +
>   arch/powerpc/mm/book3s64/slb.c                     |   1 +
>   arch/powerpc/perf/core-fsl-emb.c                   |   8 +-
>   arch/powerpc/platforms/pseries/lpar.c              |  10 +-
>   arch/powerpc/platforms/pseries/lparcfg.c           |   4 +-
>   arch/powerpc/platforms/pseries/setup.c             |   2 +-
>   arch/powerpc/xmon/xmon.c                           |   1 +
>   arch/s390/crypto/paes_s390.c                       |   2 +-
>   arch/s390/kernel/ipl.c                             |   2 +
>   arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
>   arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
>   arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
>   arch/sh/boards/mach-migor/setup.c                  |   2 +-
>   arch/sh/boards/mach-se/7724/setup.c                |   6 +-
>   arch/um/configs/i386_defconfig                     |   1 +
>   arch/um/configs/x86_64_defconfig                   |   1 +
>   arch/um/drivers/Kconfig                            |  16 +-
>   arch/um/drivers/Makefile                           |   2 +-
>   arch/x86/boot/compressed/head_64.S                 |  30 +-
>   arch/x86/include/asm/pgtable_types.h               |  11 +-
>   arch/x86/include/asm/virtext.h                     |   6 -
>   arch/x86/kernel/apm_32.c                           |   6 -
>   arch/x86/kernel/cpu/common.c                       |   8 +-
>   arch/xtensa/include/asm/core.h                     |   9 +
>   arch/xtensa/kernel/perf_event.c                    |  17 +-
>   crypto/algapi.c                                    |  16 +-
>   crypto/asymmetric_keys/x509_public_key.c           |   5 +
>   crypto/blake2b_generic.c                           | 226 +++----------
>   drivers/acpi/apei/ghes.c                           |  19 +-
>   drivers/acpi/bus.c                                 |   2 +
>   drivers/acpi/pci_root.c                            |   3 -
>   drivers/amba/bus.c                                 |   1 +
>   drivers/ata/pata_arasan_cf.c                       |   3 +-
>   drivers/ata/pata_ftide010.c                        |   1 +
>   drivers/ata/sata_gemini.c                          |   1 +
>   drivers/base/regmap/regcache-rbtree.c              |  10 +-
>   drivers/base/test/test_async_driver_probe.c        |   2 +-
>   drivers/bluetooth/btsdio.c                         |   1 +
>   drivers/bluetooth/btusb.c                          |   2 +-
>   drivers/bluetooth/hci_nokia.c                      |   6 +-
>   drivers/bus/mhi/host/pm.c                          |   5 +
>   drivers/bus/ti-sysc.c                              |   2 +-
>   drivers/char/hw_random/iproc-rng200.c              |  25 ++
>   drivers/char/hw_random/nomadik-rng.c               |  12 +-
>   drivers/char/ipmi/ipmi_si_intf.c                   |   5 +
>   drivers/char/ipmi/ipmi_ssif.c                      |   7 +-
>   drivers/clk/Kconfig                                |   1 +
>   drivers/clk/imx/clk-composite-8m.c                 |  12 +-
>   drivers/clk/imx/clk-imx8mp.c                       |   5 -
>   drivers/clk/imx/clk-pll14xx.c                      |   2 -
>   drivers/clk/keystone/pll.c                         |   2 +-
>   drivers/clk/qcom/gcc-mdm9615.c                     |   2 +-
>   drivers/clk/qcom/gcc-sc7180.c                      |  33 +-
>   drivers/clk/qcom/gcc-sm8250.c                      |  93 +++---
>   drivers/clk/qcom/reset.c                           |   3 +-
>   drivers/clk/sunxi-ng/ccu_mmc_timing.c              |   2 +-
>   drivers/cpufreq/brcmstb-avs-cpufreq.c              |   6 +-
>   drivers/cpufreq/cpufreq.c                          |   2 +
>   drivers/cpufreq/powernow-k8.c                      |   3 +-
>   drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
>   drivers/crypto/caam/caampkc.c                      |   4 +-
>   drivers/crypto/stm32/stm32-hash.c                  |   9 +-
>   drivers/devfreq/devfreq.c                          |   1 +
>   drivers/dma/Kconfig                                |   2 +
>   drivers/dma/ste_dma40.c                            |   4 +
>   drivers/firmware/Kconfig                           |   1 +
>   drivers/firmware/arm_sdei.c                        |  32 +-
>   drivers/firmware/efi/libstub/x86-stub.c            |   2 +-
>   drivers/firmware/meson/meson_sm.c                  |   2 +
>   drivers/firmware/stratix10-svc.c                   |   2 +-
>   drivers/fsi/fsi-master-aspeed.c                    |   2 +
>   drivers/fsi/fsi-master-ast-cf.c                    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  14 +-
>   drivers/gpu/drm/amd/amdgpu/cik.c                   |  36 +--
>   drivers/gpu/drm/amd/amdgpu/si.c                    |  36 +--
>   .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   5 +-
>   .../drm/amd/display/modules/freesync/freesync.c    |   9 +-
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  10 +-
>   drivers/gpu/drm/armada/armada_overlay.c            |   6 +-
>   drivers/gpu/drm/ast/ast_post.c                     |   2 +-
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   9 +-
>   drivers/gpu/drm/bridge/tc358764.c                  |   2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_dump.c             |  14 +-
>   drivers/gpu/drm/i915/gvt/gtt.c                     |  68 +++-
>   drivers/gpu/drm/i915/gvt/gtt.h                     |   5 +-
>   drivers/gpu/drm/i915/gvt/gvt.c                     |   9 +
>   drivers/gpu/drm/i915/gvt/gvt.h                     |   3 +
>   drivers/gpu/drm/i915/gvt/handlers.c                |  44 ++-
>   drivers/gpu/drm/i915/gvt/mmio.h                    |   4 +
>   drivers/gpu/drm/i915/intel_gvt.c                   |  15 +
>   drivers/gpu/drm/i915/intel_gvt.h                   |   5 +
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   6 +-
>   drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   8 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   3 +-
>   drivers/gpu/drm/panel/panel-simple.c               |   4 +-
>   drivers/gpu/drm/radeon/cik.c                       |  36 +--
>   drivers/gpu/drm/radeon/si.c                        |  37 +--
>   drivers/gpu/drm/tegra/dpaux.c                      |   6 +-
>   drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |   4 +-
>   drivers/hid/hid-logitech-dj.c                      |   5 +-
>   drivers/hid/hid-multitouch.c                       |  13 +-
>   drivers/hid/wacom.h                                |   1 +
>   drivers/hid/wacom_sys.c                            |  25 +-
>   drivers/hid/wacom_wac.c                            |   1 +
>   drivers/hid/wacom_wac.h                            |   1 +
>   drivers/hwmon/tmp513.c                             |   2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etf.c    |   2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c    |   5 +-
>   drivers/hwtracing/coresight/coresight-tmc.h        |   2 +-
>   .../infiniband/core/uverbs_std_types_counters.c    |   2 +
>   drivers/infiniband/sw/siw/siw_cm.c                 |   1 -
>   drivers/infiniband/sw/siw/siw_verbs.c              |   2 +-
>   drivers/infiniband/ulp/isert/ib_isert.c            |   2 +
>   drivers/infiniband/ulp/srp/ib_srp.c                |   4 -
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   7 +
>   drivers/iommu/intel/pasid.c                        |   2 +-
>   drivers/leds/led-core.c                            |   8 +-
>   drivers/md/md-bitmap.c                             |  28 +-
>   drivers/media/cec/usb/pulse8/pulse8-cec.c          |   7 +-
>   drivers/media/dvb-frontends/ascot2e.c              |   2 +-
>   drivers/media/dvb-frontends/atbm8830.c             |   2 +-
>   drivers/media/dvb-frontends/au8522_dig.c           |   2 +-
>   drivers/media/dvb-frontends/bcm3510.c              |   2 +-
>   drivers/media/dvb-frontends/cx22700.c              |   2 +-
>   drivers/media/dvb-frontends/cx22702.c              |   2 +-
>   drivers/media/dvb-frontends/cx24110.c              |   2 +-
>   drivers/media/dvb-frontends/cx24113.c              |   2 +-
>   drivers/media/dvb-frontends/cx24116.c              |   2 +-
>   drivers/media/dvb-frontends/cx24120.c              |   6 +-
>   drivers/media/dvb-frontends/cx24123.c              |   2 +-
>   drivers/media/dvb-frontends/cxd2820r_core.c        |   2 +-
>   drivers/media/dvb-frontends/cxd2841er.c            |   4 +-
>   drivers/media/dvb-frontends/cxd2880/cxd2880_top.c  |   2 +-
>   drivers/media/dvb-frontends/dib0070.c              |   2 +-
>   drivers/media/dvb-frontends/dib0090.c              |   4 +-
>   drivers/media/dvb-frontends/dib3000mb.c            |   2 +-
>   drivers/media/dvb-frontends/dib3000mc.c            |   2 +-
>   drivers/media/dvb-frontends/dib7000m.c             |   2 +-
>   drivers/media/dvb-frontends/dib7000p.c             |   4 +-
>   drivers/media/dvb-frontends/dib8000.c              |   2 +-
>   drivers/media/dvb-frontends/dib9000.c              |   2 +-
>   drivers/media/dvb-frontends/drx39xyj/drxj.c        |   2 +-
>   drivers/media/dvb-frontends/drxd_hard.c            |   2 +-
>   drivers/media/dvb-frontends/drxk_hard.c            |   2 +-
>   drivers/media/dvb-frontends/ds3000.c               |   2 +-
>   drivers/media/dvb-frontends/dvb-pll.c              |   2 +-
>   drivers/media/dvb-frontends/ec100.c                |   2 +-
>   drivers/media/dvb-frontends/helene.c               |   4 +-
>   drivers/media/dvb-frontends/horus3a.c              |   2 +-
>   drivers/media/dvb-frontends/isl6405.c              |   2 +-
>   drivers/media/dvb-frontends/isl6421.c              |   2 +-
>   drivers/media/dvb-frontends/isl6423.c              |   2 +-
>   drivers/media/dvb-frontends/itd1000.c              |   2 +-
>   drivers/media/dvb-frontends/ix2505v.c              |   2 +-
>   drivers/media/dvb-frontends/l64781.c               |   2 +-
>   drivers/media/dvb-frontends/lg2160.c               |   2 +-
>   drivers/media/dvb-frontends/lgdt3305.c             |   2 +-
>   drivers/media/dvb-frontends/lgdt3306a.c            |   2 +-
>   drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
>   drivers/media/dvb-frontends/lgs8gxx.c              |   2 +-
>   drivers/media/dvb-frontends/lnbh25.c               |   2 +-
>   drivers/media/dvb-frontends/lnbp21.c               |   4 +-
>   drivers/media/dvb-frontends/lnbp22.c               |   2 +-
>   drivers/media/dvb-frontends/m88ds3103.c            |   2 +-
>   drivers/media/dvb-frontends/m88rs2000.c            |   2 +-
>   drivers/media/dvb-frontends/mb86a16.c              |   2 +-
>   drivers/media/dvb-frontends/mb86a20s.c             |   2 +-
>   drivers/media/dvb-frontends/mt312.c                |   2 +-
>   drivers/media/dvb-frontends/mt352.c                |   2 +-
>   drivers/media/dvb-frontends/nxt200x.c              |   2 +-
>   drivers/media/dvb-frontends/nxt6000.c              |   2 +-
>   drivers/media/dvb-frontends/or51132.c              |   2 +-
>   drivers/media/dvb-frontends/or51211.c              |   2 +-
>   drivers/media/dvb-frontends/s5h1409.c              |   2 +-
>   drivers/media/dvb-frontends/s5h1411.c              |   2 +-
>   drivers/media/dvb-frontends/s5h1420.c              |   2 +-
>   drivers/media/dvb-frontends/s5h1432.c              |   2 +-
>   drivers/media/dvb-frontends/s921.c                 |   2 +-
>   drivers/media/dvb-frontends/si21xx.c               |   2 +-
>   drivers/media/dvb-frontends/sp887x.c               |   2 +-
>   drivers/media/dvb-frontends/stb0899_drv.c          |   2 +-
>   drivers/media/dvb-frontends/stb6000.c              |   2 +-
>   drivers/media/dvb-frontends/stb6100.c              |   2 +-
>   drivers/media/dvb-frontends/stv0288.c              |   2 +-
>   drivers/media/dvb-frontends/stv0297.c              |   2 +-
>   drivers/media/dvb-frontends/stv0299.c              |   2 +-
>   drivers/media/dvb-frontends/stv0367.c              |   6 +-
>   drivers/media/dvb-frontends/stv0900_core.c         |   2 +-
>   drivers/media/dvb-frontends/stv090x.c              |   2 +-
>   drivers/media/dvb-frontends/stv6110.c              |   2 +-
>   drivers/media/dvb-frontends/stv6110x.c             |   2 +-
>   drivers/media/dvb-frontends/tda10021.c             |   2 +-
>   drivers/media/dvb-frontends/tda10023.c             |   2 +-
>   drivers/media/dvb-frontends/tda10048.c             |   2 +-
>   drivers/media/dvb-frontends/tda1004x.c             |   4 +-
>   drivers/media/dvb-frontends/tda10086.c             |   2 +-
>   drivers/media/dvb-frontends/tda665x.c              |   2 +-
>   drivers/media/dvb-frontends/tda8083.c              |   2 +-
>   drivers/media/dvb-frontends/tda8261.c              |   2 +-
>   drivers/media/dvb-frontends/tda826x.c              |   2 +-
>   drivers/media/dvb-frontends/ts2020.c               |   2 +-
>   drivers/media/dvb-frontends/tua6100.c              |   2 +-
>   drivers/media/dvb-frontends/ves1820.c              |   2 +-
>   drivers/media/dvb-frontends/ves1x93.c              |   2 +-
>   drivers/media/dvb-frontends/zl10036.c              |   2 +-
>   drivers/media/dvb-frontends/zl10039.c              |   2 +-
>   drivers/media/dvb-frontends/zl10353.c              |   2 +-
>   drivers/media/i2c/ad5820.c                         |   2 -
>   drivers/media/i2c/ov2680.c                         | 246 +++------------
>   drivers/media/i2c/ov5640.c                         |   4 +-
>   drivers/media/i2c/tvp5150.c                        |   4 +
>   drivers/media/pci/bt8xx/dst.c                      |   2 +-
>   drivers/media/pci/bt8xx/dst_ca.c                   |   2 +-
>   drivers/media/pci/cx23885/cx23885-dvb.c            |  12 -
>   drivers/media/pci/ddbridge/ddbridge-dummy-fe.c     |   2 +-
>   .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |   5 +-
>   drivers/media/tuners/fc0011.c                      |   2 +-
>   drivers/media/tuners/fc0012.c                      |   2 +-
>   drivers/media/tuners/fc0013.c                      |   2 +-
>   drivers/media/tuners/max2165.c                     |   2 +-
>   drivers/media/tuners/mc44s803.c                    |   2 +-
>   drivers/media/tuners/mt2060.c                      |   2 +-
>   drivers/media/tuners/mt2131.c                      |   2 +-
>   drivers/media/tuners/mt2266.c                      |   2 +-
>   drivers/media/tuners/mxl5005s.c                    |   2 +-
>   drivers/media/tuners/qt1010.c                      |   2 +-
>   drivers/media/tuners/tda18218.c                    |   2 +-
>   drivers/media/tuners/xc4000.c                      |   2 +-
>   drivers/media/tuners/xc5000.c                      |   2 +-
>   drivers/media/usb/dvb-usb/m920x.c                  |   5 +-
>   drivers/media/usb/go7007/go7007-i2c.c              |   2 -
>   drivers/media/usb/siano/smsusb.c                   |  21 +-
>   drivers/media/v4l2-core/v4l2-fwnode.c              |  18 +-
>   drivers/mmc/host/Kconfig                           |   5 +-
>   drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  45 ++-
>   drivers/mtd/nand/raw/fsmc_nand.c                   |   7 +-
>   drivers/mtd/spi-nor/core.c                         |  19 +-
>   drivers/net/arcnet/arcnet.c                        |   2 +-
>   drivers/net/can/usb/gs_usb.c                       |   5 +-
>   drivers/net/dsa/sja1105/sja1105_main.c             |  38 ++-
>   drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   7 +-
>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   9 +-
>   drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |   2 +-
>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
>   drivers/net/ethernet/intel/ice/ice_main.c          |  13 +-
>   drivers/net/ethernet/intel/igb/igb.h               |   4 +-
>   drivers/net/ethernet/intel/igb/igb_main.c          |  16 +-
>   drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
>   drivers/net/ethernet/intel/igc/igc.h               |   4 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +-
>   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
>   drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   9 +-
>   drivers/net/ethernet/mellanox/mlxsw/i2c.c          |   5 +-
>   drivers/net/macsec.c                               |   3 +-
>   drivers/net/usb/qmi_wwan.c                         |   1 +
>   drivers/net/usb/r8152.c                            |   3 +
>   drivers/net/veth.c                                 |   4 +-
>   drivers/net/vxlan/vxlan_core.c                     |  58 ++--
>   drivers/net/wireless/ath/ath10k/pci.c              |   9 +-
>   drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
>   drivers/net/wireless/ath/ath9k/wmi.c               |  20 +-
>   drivers/net/wireless/marvell/mwifiex/debugfs.c     |   9 +-
>   drivers/net/wireless/marvell/mwifiex/pcie.c        |  25 +-
>   drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  12 +-
>   drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  30 +-
>   drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
>   drivers/net/wireless/mediatek/mt76/testmode.c      |   1 +
>   drivers/ntb/ntb_transport.c                        |  19 +-
>   drivers/of/unittest.c                              |  12 +-
>   drivers/opp/core.c                                 |   2 +-
>   drivers/parisc/led.c                               |   4 +-
>   drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
>   drivers/pci/pcie/aspm.c                            |  30 +-
>   drivers/perf/fsl_imx8_ddr_perf.c                   |  24 +-
>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |   6 +-
>   drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |  18 +-
>   drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
>   drivers/pinctrl/pinctrl-amd.c                      |   4 +-
>   drivers/pinctrl/pinctrl-mcp23s08_spi.c             |  10 +
>   drivers/platform/mellanox/mlxbf-tmfifo.c           |  91 ++++--
>   drivers/platform/x86/huawei-wmi.c                  |   2 +
>   drivers/platform/x86/intel-hid.c                   |  21 +-
>   drivers/pwm/pwm-lpc32xx.c                          |  16 +-
>   drivers/rpmsg/qcom_glink_native.c                  |   4 +
>   drivers/rtc/rtc-ds1685.c                           |   2 +-
>   drivers/s390/block/dasd.c                          | 125 +++-----
>   drivers/s390/block/dasd_3990_erp.c                 |   2 +-
>   drivers/s390/crypto/pkey_api.c                     |   2 +-
>   drivers/s390/crypto/zcrypt_api.c                   |   1 +
>   drivers/s390/crypto/zcrypt_ep11misc.c              |   4 +-
>   drivers/s390/crypto/zcrypt_ep11misc.h              |   9 +-
>   drivers/scsi/aic94xx/aic94xx_task.c                |   2 +-
>   drivers/scsi/be2iscsi/be_iscsi.c                   |   4 +
>   drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |   8 +-
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |  19 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  62 ++--
>   drivers/scsi/hosts.c                               |   4 +-
>   drivers/scsi/isci/request.c                        |  10 +-
>   drivers/scsi/isci/task.c                           |   2 +-
>   drivers/scsi/libsas/sas_ata.c                      |   7 +-
>   drivers/scsi/libsas/sas_expander.c                 |   2 +-
>   drivers/scsi/libsas/sas_task.c                     |   4 +-
>   drivers/scsi/mpt3sas/mpt3sas_base.c                |  46 ++-
>   drivers/scsi/mpt3sas/mpt3sas_base.h                |   1 +
>   drivers/scsi/mvsas/mv_sas.c                        |  10 +-
>   drivers/scsi/pm8001/pm8001_hwi.c                   |  16 +-
>   drivers/scsi/pm8001/pm8001_sas.c                   |   4 +-
>   drivers/scsi/pm8001/pm80xx_hwi.c                   |  14 +-
>   drivers/scsi/qedf/qedf_dbg.h                       |   2 +
>   drivers/scsi/qedf/qedf_debugfs.c                   |  35 ++-
>   drivers/scsi/qedi/qedi_main.c                      |   5 +-
>   drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
>   drivers/scsi/qla2xxx/qla_dbg.c                     |  18 +-
>   drivers/scsi/qla2xxx/qla_def.h                     |  12 +-
>   drivers/scsi/qla2xxx/qla_gbl.h                     |   3 +
>   drivers/scsi/qla2xxx/qla_init.c                    |  68 ++--
>   drivers/scsi/qla2xxx/qla_inline.h                  |  46 +++
>   drivers/scsi/qla2xxx/qla_iocb.c                    |  60 +++-
>   drivers/scsi/qla2xxx/qla_isr.c                     |  16 +-
>   drivers/scsi/qla2xxx/qla_mbx.c                     |   7 +-
>   drivers/scsi/qla2xxx/qla_nvme.c                    |  12 +-
>   drivers/scsi/qla2xxx/qla_os.c                      | 223 +++++++------
>   drivers/scsi/qla2xxx/qla_target.c                  |  14 +-
>   drivers/scsi/qla4xxx/ql4_os.c                      |  15 +
>   drivers/scsi/scsi_transport_iscsi.c                |  80 +++--
>   drivers/scsi/storvsc_drv.c                         |   2 +
>   drivers/soc/qcom/ocmem.c                           |  14 +-
>   drivers/soc/qcom/qmi_encdec.c                      |   4 +-
>   drivers/spi/spi-tegra20-sflash.c                   |   6 +-
>   drivers/staging/media/rkvdec/rkvdec.c              |   2 +-
>   drivers/staging/rtl8712/os_intfs.c                 |   1 +
>   drivers/staging/rtl8712/usb_intf.c                 |   1 -
>   drivers/tty/serial/qcom_geni_serial.c              |   5 +
>   drivers/tty/serial/sc16is7xx.c                     |  17 +-
>   drivers/tty/serial/serial-tegra.c                  |   6 +-
>   drivers/tty/serial/sprd_serial.c                   |  30 +-
>   drivers/usb/chipidea/ci_hdrc_imx.c                 |  10 +-
>   drivers/usb/chipidea/usbmisc_imx.c                 |   6 +-
>   drivers/usb/core/hcd.c                             |  10 +-
>   drivers/usb/core/hub.c                             | 349 ++++++++++++---------
>   drivers/usb/core/message.c                         |  29 +-
>   drivers/usb/core/usb.h                             |   4 +-
>   drivers/usb/dwc3/dwc3-meson-g12a.c                 |   6 +
>   drivers/usb/gadget/function/f_mass_storage.c       |   2 +-
>   drivers/usb/phy/phy-mxs-usb.c                      |  10 +-
>   drivers/usb/serial/option.c                        |   7 +
>   drivers/usb/typec/bus.c                            |  12 +-
>   drivers/usb/typec/tcpm/tcpci.c                     |   4 +
>   drivers/usb/typec/tcpm/tcpci.h                     |   1 +
>   drivers/usb/typec/tcpm/tcpm.c                      |   3 +-
>   drivers/vfio/vfio_iommu_type1.c                    |   2 +-
>   drivers/video/backlight/bd6107.c                   |   2 +-
>   drivers/video/backlight/gpio_backlight.c           |   5 +-
>   drivers/video/backlight/lv5207lp.c                 |   2 +-
>   drivers/video/fbdev/ep93xx-fb.c                    |   1 -
>   drivers/virtio/virtio_ring.c                       |   2 +-
>   drivers/watchdog/intel-mid_wdt.c                   |   1 +
>   fs/btrfs/disk-io.c                                 |   5 +-
>   fs/btrfs/transaction.c                             |   7 +-
>   fs/configfs/dir.c                                  |   2 +
>   fs/dlm/plock.c                                     |   6 +-
>   fs/erofs/zdata.c                                   |   2 +
>   fs/eventfd.c                                       |   7 +-
>   fs/ext4/balloc.c                                   |  15 +-
>   fs/ext4/block_validity.c                           |   8 +-
>   fs/ext4/ext4.h                                     |   2 +
>   fs/ext4/mballoc.c                                  |   2 +-
>   fs/fuse/readdir.c                                  |  10 +-
>   fs/jfs/jfs_extent.c                                |   5 +
>   fs/lockd/mon.c                                     |   3 +
>   fs/namei.c                                         |   2 +-
>   fs/nfs/blocklayout/dev.c                           |   4 +-
>   fs/nfs/direct.c                                    |  20 +-
>   fs/nfs/nfs2xdr.c                                   |   2 +-
>   fs/nfs/nfs3xdr.c                                   |   2 +-
>   fs/nfs/nfs42proc.c                                 |   5 +-
>   fs/nfs/pnfs_dev.c                                  |   2 +-
>   fs/nfsd/blocklayoutxdr.c                           |   9 +
>   fs/nfsd/flexfilelayoutxdr.c                        |   9 +
>   fs/nfsd/nfs4xdr.c                                  |  25 +-
>   fs/nilfs2/alloc.c                                  |   3 +-
>   fs/nilfs2/inode.c                                  |   7 +-
>   fs/nilfs2/segment.c                                |   5 +
>   fs/nls/nls_base.c                                  |   4 +-
>   fs/ocfs2/namei.c                                   |   4 +
>   fs/overlayfs/super.c                               |   2 +-
>   fs/proc/base.c                                     |   3 +-
>   fs/pstore/ram_core.c                               |   2 +-
>   fs/quota/dquot.c                                   | 174 ++++++----
>   fs/reiserfs/journal.c                              |   4 +-
>   fs/udf/balloc.c                                    |  31 +-
>   fs/udf/inode.c                                     |  45 ++-
>   fs/verity/signature.c                              |  16 +
>   include/acpi/apei.h                                |   4 +-
>   include/crypto/algapi.h                            |   3 +
>   include/crypto/blake2b.h                           |  67 ++++
>   include/crypto/internal/blake2b.h                  | 115 +++++++
>   include/linux/arm_sdei.h                           |   4 +
>   include/linux/eventfd.h                            |   6 +
>   include/linux/if_arp.h                             |   4 +
>   include/linux/nls.h                                |   2 +-
>   include/linux/trace_events.h                       |   3 +-
>   include/linux/usb/typec_altmode.h                  |   2 +-
>   include/net/ip.h                                   |   1 +
>   include/net/ip_tunnels.h                           |  15 +-
>   include/net/ipv6.h                                 |   2 +-
>   include/net/lwtunnel.h                             |   5 +-
>   include/net/tcp.h                                  |   1 -
>   include/scsi/libsas.h                              |  12 +-
>   include/scsi/scsi_host.h                           |   2 +-
>   include/uapi/linux/sync_file.h                     |   2 +-
>   io_uring/io-wq.c                                   |  10 +
>   io_uring/io-wq.h                                   |   1 +
>   io_uring/io_uring.c                                |   9 +-
>   kernel/auditsc.c                                   |   2 +
>   kernel/bpf/verifier.c                              |  17 +-
>   kernel/cgroup/namespace.c                          |   6 -
>   kernel/kprobes.c                                   |  14 +-
>   kernel/module.c                                    |  15 +-
>   kernel/printk/printk_ringbuffer.c                  |   2 +-
>   kernel/rcu/refscale.c                              |   3 +-
>   kernel/trace/bpf_trace.c                           |   2 +-
>   kernel/trace/trace.c                               |  72 ++++-
>   kernel/trace/trace.h                               |   2 +
>   kernel/trace/trace_uprobe.c                        |   3 +-
>   lib/idr.c                                          |   2 +-
>   lib/test_meminit.c                                 |   2 +-
>   mm/shmem.c                                         |  28 +-
>   net/9p/trans_virtio.c                              |   2 +-
>   net/bluetooth/hci_core.c                           |  16 +-
>   net/core/filter.c                                  |   2 +
>   net/core/flow_dissector.c                          |   3 +-
>   net/core/lwt_bpf.c                                 |   7 +-
>   net/core/skbuff.c                                  |  34 +-
>   net/core/sock.c                                    |   9 +-
>   net/dccp/ipv4.c                                    |  13 +-
>   net/dccp/ipv6.c                                    |  15 +-
>   net/hsr/hsr_forward.c                              |   1 +
>   net/ipv4/devinet.c                                 |  10 +-
>   net/ipv4/fib_semantics.c                           |   5 +-
>   net/ipv4/fib_trie.c                                |   3 +-
>   net/ipv4/igmp.c                                    |   3 +-
>   net/ipv4/ip_input.c                                |   3 +-
>   net/ipv4/ip_output.c                               |   2 +-
>   net/ipv4/route.c                                   |   1 +
>   net/ipv4/tcp_input.c                               |   3 +-
>   net/ipv4/tcp_timer.c                               |  18 +-
>   net/ipv4/udp.c                                     |  20 +-
>   net/ipv6/addrconf.c                                |   2 +-
>   net/ipv6/ip6_output.c                              |   2 +-
>   net/ipv6/udp.c                                     |  19 +-
>   net/kcm/kcmsock.c                                  |  15 +-
>   net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 +
>   net/netfilter/nfnetlink_osf.c                      |   8 +
>   net/netfilter/xt_sctp.c                            |   2 +
>   net/netfilter/xt_u32.c                             |  21 ++
>   net/netlabel/netlabel_kapi.c                       |   3 +-
>   net/netrom/af_netrom.c                             |   5 +
>   net/sched/sch_fq_pie.c                             |  27 +-
>   net/sched/sch_hfsc.c                               |   4 +
>   net/sched/sch_plug.c                               |   2 +-
>   net/sched/sch_qfq.c                                |  22 +-
>   net/sctp/proc.c                                    |   2 +-
>   net/sctp/sm_sideeffect.c                           |   5 +-
>   net/sctp/socket.c                                  |  10 +-
>   net/smc/smc_core.c                                 |   2 +
>   net/socket.c                                       |   6 +-
>   net/tls/tls_sw.c                                   |   4 +-
>   net/unix/af_unix.c                                 |   2 +-
>   net/unix/scm.c                                     |   6 +-
>   samples/bpf/tracex6_kern.c                         |  17 +-
>   scripts/kconfig/preprocess.c                       |   3 +
>   security/integrity/ima/Kconfig                     |  12 -
>   security/keys/keyctl.c                             |  11 +-
>   security/smack/smackfs.c                           |   2 +-
>   sound/Kconfig                                      |   2 +-
>   sound/core/pcm_compat.c                            |   8 +-
>   sound/core/seq/oss/seq_oss_midi.c                  |  35 ++-
>   sound/pci/ac97/ac97_codec.c                        |   5 +-
>   sound/soc/atmel/atmel-i2s.c                        |   5 +-
>   sound/soc/codecs/Kconfig                           |   1 +
>   sound/soc/codecs/da7219-aad.c                      |  12 +-
>   sound/soc/codecs/es8316.c                          |   2 +-
>   sound/soc/codecs/rt5682-sdw.c                      |   7 +-
>   tools/bpf/bpftool/skeleton/profiler.bpf.c          |  27 +-
>   tools/hv/vmbus_testing                             |   4 +-
>   tools/perf/builtin-top.c                           |   1 +
>   tools/perf/ui/browsers/hists.c                     |  60 ++--
>   tools/perf/util/annotate.c                         |  10 +-
>   tools/perf/util/header.c                           |  11 +-
>   .../selftests/bpf/benchs/run_bench_rename.sh       |   2 +-
>   .../selftests/bpf/progs/test_cls_redirect.h        |   9 +
>   tools/testing/selftests/kselftest/runner.sh        |  29 +-
>   tools/testing/selftests/kselftest_harness.h        |  11 +-
>   tools/testing/selftests/resctrl/cache.c            |  18 +-
>   tools/testing/selftests/resctrl/fill_buf.c         |   3 +-
>   tools/testing/selftests/resctrl/resctrl.h          |   1 +
>   555 files changed, 3750 insertions(+), 2444 deletions(-)
> 
> 

