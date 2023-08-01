Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A376B8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHAPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjHAPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:37:36 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4126127;
        Tue,  1 Aug 2023 08:37:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFf8B0wZgz9xGgn;
        Tue,  1 Aug 2023 23:26:02 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.206.119])
        by APP1 (Coremail) with SMTP id LxC2BwA36biWJslk2IYdAA--.14146S2;
        Tue, 01 Aug 2023 16:37:09 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        SHA-cyfmac-dev-list@infineon.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1 0/3] wifi: brcm80211: avoid memcpy warning when CONFIG_FORTIFY_SOURCE=y
Date:   Tue,  1 Aug 2023 17:36:39 +0200
Message-Id: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LxC2BwA36biWJslk2IYdAA--.14146S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUWw4kWFykCF15Gr1rJFb_yoWrKw4Upa
        4fJFyUCr4kXr1a9FWUJr43XFyrta1qy3Z0kF4xtr9avayUur13JF1UKFW0kryUC39rt3y7
        tFyqqFn8tr4DAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
        6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
        BIdaVFxhVjvjDU0xZFpf9x0JU7CzZUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

When built with CONFIG_FORTIFY_SOURCE=3Dy, the brcmfmac module triggers a
memcpy() warning like this:

 ------------[ cut here ]------------
 memcpy: detected field-spanning write (size 76) of single field "&params_l=
e->channel_list[0]" at drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg=
80211.c:1072 (size 2)
 WARNING: CPU: 2 PID: 991 at drivers/net/wireless/broadcom/brcm80211/brcmfm=
ac/cfg80211.c:1072 brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
 Modules linked in: qrtr(E) algif_hash(E) aes_neon_bs(E) aes_neon_blk(E) al=
gif_skcipher(E) af_alg(E) bnep(E) brcmfmac_wcc(E) bcm2835_v4l2(CE) bcm2835_=
mmal_vchiq(CE) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) v=
ideodev(E) hci_uart(E) btsdio(E) videobuf2_common(E) btbcm(E) mc(E) snd_bcm=
2835(CE) bluetooth(E) snd_pcm(E) brcmfmac(E) snd_timer(E) cpufreq_dt(E) snd=
(E) soundcore(E) cfg80211(E) ecdh_generic(E) brcmutil(E) raspberrypi_cpufre=
q(E) rfkill(E) vchiq(CE) bcm2711_thermal(E) leds_gpio(E) fuse(E) efi_pstore=
(E) dmi_sysfs(E) ip_tables(E) x_tables(E) rpcsec_gss_krb5(E) auth_rpcgss(E)=
 nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) fscache(E) netfs(E) af_p=
acket(E) mmc_block(E) xhci_pci(E) xhci_pci_renesas(E) xhci_hcd(E) usbcore(E=
) usb_common(E) clk_raspberrypi(E) gpio_raspberrypi_exp(E) bcm2835_dma(E) c=
rct10dif_ce(E) virt_dma(E) pcie_brcmstb(E) sdhci_iproc(E) gpio_regulator(E)=
 sdhci_pltfm(E) sdhci(E) mmc_core(E) fixed(E) nvmem_rmem(E) sunrpc(E) sg(E)=
 dm_multipath(E) dm_mod(E) efivarfs(E)
 Unloaded tainted modules: aes_ce_cipher(E):1
 CPU: 2 PID: 991 Comm: wpa_supplicant Tainted: G         C  E      6.5.0-rc=
4-dynswiotlb+ #27 2ec0961165cc91fdbec101d9d43b3331ba4f0927
 Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04 04/01=
/2023
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
 lr : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
 sp : ffff8000829ab590
 x29: ffff8000829ab590 x28: 0000000000000000 x27: 0000000000000001
 x26: ffff000105e7e0a4 x25: ffff00010a0bcb48 x24: ffff000101e03800
 x23: ffff000105ec8920 x22: ffff000106332980 x21: ffff00010a0bc0c0
 x20: ffff00010a0bcb90 x19: ffff00010a0bc108 x18: ffffffffffffffff
 x17: 0000000000000000 x16: 0000000000000000 x15: 616f72622f737365
 x14: 6c657269772f7465 x13: 616d666d6372622f x12: 31313230386d6372
 x11: 00000000ffffdfff x10: ffff800081ad3328 x9 : ffff800080130694
 x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
 x5 : ffff0001fef75e00 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00010aa0e000
 Call trace:
  brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac 38c4a81a3b85b4aff1650c67f=
95f20bc542d60c1]
  brcmf_run_escan+0x148/0x1a0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542=
d60c1]
  brcmf_do_escan+0x74/0xe0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d60=
c1]
  brcmf_cfg80211_scan+0xcc/0x298 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc=
542d60c1]
  rdev_scan+0x38/0x158 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54cb8]
  cfg80211_scan+0x134/0x178 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54=
cb8]
  nl80211_trigger_scan+0x3e8/0x768 [cfg80211 8907673111c49ec56be88af3d38994=
cc1cf54cb8]
  genl_family_rcv_msg_doit.isra.0+0xc0/0x130
  genl_rcv_msg+0x1e4/0x278
  netlink_rcv_skb+0x64/0x138
  genl_rcv+0x40/0x60
  netlink_unicast+0x1cc/0x2d8
  netlink_sendmsg+0x1d4/0x448
  sock_sendmsg+0x64/0xc0
  ____sys_sendmsg+0x260/0x2e0
  ___sys_sendmsg+0x88/0xf0
  __sys_sendmsg+0x70/0xd8
  __arm64_sys_sendmsg+0x2c/0x40
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x100/0x130
  do_el0_svc+0x40/0xa8
  el0_svc+0x34/0x138
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x1a8/0x1b0
 ---[ end trace 0000000000000000 ]---

This is in fact a false positive, but the data structures can be improved
to make the checker happy.

Tested on a Raspberry Pi 4 by running scans in a loop while activating and
deactivating the wireless connection in parallel to cause scan aborts.

Petr Tesarik (3):
  wifi: brcm80211: drop struct brcmf_p2p_scan_le
  wifi: brcm80211: separate abort scan param prepare from actual scan
  wifi: brcm80211: change channel_list to a flexible array

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 67 ++++++++++---------
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 14 +++-
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 38 +++--------
 3 files changed, 57 insertions(+), 62 deletions(-)

--=20
2.25.1

