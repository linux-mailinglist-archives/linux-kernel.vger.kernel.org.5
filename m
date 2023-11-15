Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E22F7ED1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjKOUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbjKOUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931892;
        Wed, 15 Nov 2023 12:04:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16500C433C8;
        Wed, 15 Nov 2023 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078664;
        bh=y94wvkErK1mY+ytYGtaU4iMCYmBU1wMgbTOQ+AxMJII=;
        h=From:To:Cc:Subject:Date:From;
        b=LFExHG4/+NKa0ltQ+HwMhKA6E+OKGcdOW4QDaFqD+YBCT7aSjXkBz0mC3pHNRT+w4
         YaSdl0F0WOPt3gVTVsBhzXw5NeBH7KV7M2a3yaVPhwxc2opji99cMrmiwnYp921giI
         QWkgvf1tkWFfSGx1sWN7d/pmMZamwiNdgZ1KIFgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/45] 4.14.330-rc1 review
Date:   Wed, 15 Nov 2023 14:32:37 -0500
Message-ID: <20231115191419.641552204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.330-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.330-rc1
X-KernelTest-Deadline: 2023-11-17T19:14+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.330 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.330-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.330-rc1

Filipe Manana <fdmanana@suse.com>
    btrfs: use u64 for buffer sizes in the tree search ioctls

Dominique Martinet <dominique.martinet@atmark-techno.com>
    Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Arnd Bergmann <arnd@arndb.de>
    fbdev: fsl-diu-fb: mark wr_reg_wa() static

Maciej Żenczykowski <zenczykowski@gmail.com>
    netfilter: xt_recent: fix (increase) ipv6 literal buffer length

George Shuklin <george.shuklin@gmail.com>
    tg3: power down device only on SYSTEM_POWER_OFF

Kuniyuki Iwashima <kuniyu@amazon.com>
    dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kuniyuki Iwashima <kuniyu@amazon.com>
    dccp: Call security_inet_conn_request() after setting IPv4 addresses.

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

Willem de Bruijn <willemb@google.com>
    llc: verify mac len before reading mac header

Florian Fainelli <florian.fainelli@broadcom.com>
    pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: dvb-usb-v2: af9035: fix missing unlock

Katya Orlova <e.orlova@ispras.ru>
    media: s3c-camif: Avoid inappropriate kfree()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix refcount leak in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: cs: fix possible hung task and memory leak pccardd()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()

Jonas Blixt <jonas.blixt@actia.se>
    USB: usbip: fix stub_dev hub disconnect

Jinjie Ruan <ruanjinjie@huawei.com>
    misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Dan Carpenter <dan.carpenter@linaro.org>
    dmaengine: ti: edma: handle irq_of_parse_and_map() errors

Jia-Ju Bai <baijiaju@buaa.edu.cn>
    usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Yi Yang <yiyang13@huawei.com>
    tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    mfd: dln2: Fix double put in dln2_probe

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: bios: Revive earlyprintk support

Leon Romanovsky <leonro@nvidia.com>
    RDMA/hfi1: Workaround truncation compilation error

Gou Hao <gouhao@uniontech.com>
    ext4: move 'ix' sanity check to corrent position

Kursad Oney <kursad.oney@broadcom.com>
    ARM: 9321/1: memset: cast the constant byte to unsigned char

Jonas Gorski <jonas.gorski@gmail.com>
    hwrng: geode - fix accessing registers

Dhruva Gole <d-gole@ti.com>
    firmware: ti_sci: Mark driver as non removable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/radeon: possible buffer overflow

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix probe failure when failing to register WMI devices

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data

Dan Carpenter <dan.carpenter@linaro.org>
    clk: keystone: pll: fix a couple NULL vs IS_ERR() checks

Devi Priya <quic_devipriy@quicinc.com>
    clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Yan Zhai <yan@cloudflare.com>
    ipv6: avoid atomic fragment on GSO packets

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()

Dan Carpenter <dan.carpenter@linaro.org>
    thermal: core: prevent potential string overflow

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtlwifi: fix EDCA limit set by BT coexistence

Eric Dumazet <edumazet@google.com>
    tcp_metrics: do not create an entry from tcp_init_metrics()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix potential memory leaks in i40e_remove()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 14 +++----
 arch/arm/lib/memset.S                              |  1 +
 arch/sh/Kconfig.debug                              | 11 ++++++
 drivers/acpi/device_sysfs.c                        | 10 +++--
 drivers/char/hw_random/geode-rng.c                 |  6 ++-
 drivers/clk/keystone/pll.c                         | 15 ++++---
 drivers/clk/mediatek/clk-mt2701.c                  |  8 ++++
 drivers/clk/mediatek/clk-mt6797.c                  |  6 +++
 drivers/clk/qcom/clk-rcg2.c                        | 14 ++-----
 drivers/dma/edma.c                                 |  4 +-
 drivers/dma/pxa_dma.c                              |  1 -
 drivers/firmware/ti_sci.c                          | 46 +---------------------
 drivers/gpu/drm/radeon/evergreen.c                 |  7 ++--
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 15 ++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  3 +-
 drivers/infiniband/hw/hfi1/efivar.c                |  2 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |  6 +--
 drivers/media/usb/dvb-usb-v2/af9035.c              | 13 ++++--
 drivers/mfd/dln2.c                                 |  1 -
 drivers/misc/ti-st/st_core.c                       |  7 ++--
 drivers/mmc/core/mmc.c                             |  2 +-
 drivers/net/ethernet/broadcom/tg3.c                |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 10 +++--
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |  2 +-
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |  2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |  2 +-
 drivers/pcmcia/cs.c                                |  1 +
 drivers/pcmcia/ds.c                                | 14 ++++---
 drivers/platform/x86/wmi.c                         | 16 ++++----
 drivers/pwm/pwm-brcmstb.c                          |  4 +-
 drivers/thermal/thermal_core.c                     |  6 ++-
 drivers/tty/tty_jobctrl.c                          | 17 +++++---
 drivers/usb/dwc2/hcd.c                             |  2 +-
 drivers/usb/usbip/stub_dev.c                       |  9 ++++-
 drivers/video/fbdev/fsl-diu-fb.c                   |  2 +-
 fs/btrfs/ioctl.c                                   | 10 ++---
 fs/ext4/extents.c                                  | 10 ++---
 net/dccp/ipv4.c                                    |  6 +--
 net/dccp/ipv6.c                                    |  6 +--
 net/ipv4/tcp_metrics.c                             | 11 +++---
 net/ipv6/ip6_output.c                              |  8 +++-
 net/ipv6/syncookies.c                              |  7 ++--
 net/llc/llc_input.c                                | 10 ++++-
 net/llc/llc_s_ac.c                                 |  3 ++
 net/llc/llc_station.c                              |  3 ++
 net/netfilter/xt_recent.c                          |  2 +-
 net/tipc/netlink.c                                 |  4 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |  1 +
 49 files changed, 202 insertions(+), 165 deletions(-)


