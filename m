Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3174B76BBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHAR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHAR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:56:09 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8191BF6;
        Tue,  1 Aug 2023 10:56:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFj9n5hVsz9xFrn;
        Wed,  2 Aug 2023 01:42:37 +0800 (CST)
Received: from [10.81.206.119] (unknown [10.81.206.119])
        by APP1 (Coremail) with SMTP id LxC2BwAn27oNR8lkleUeAA--.35429S2;
        Tue, 01 Aug 2023 18:55:42 +0100 (CET)
Message-ID: <e12fcf9b-d122-7c42-1516-27e03a99270a@huaweicloud.com>
Date:   Tue, 1 Aug 2023 19:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] wifi: brcm80211: change channel_list to a flexible
 array
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
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
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <SHA-cyfmac-dev-list@infineon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
 <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
 <87pm46wtno.fsf@kernel.org>
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <87pm46wtno.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAn27oNR8lkleUeAA--.35429S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4ruF1fuFWrtF18uF1xKrg_yoW7Xw43pa
        4fJFyUKr4kXr1jqF17JF43tFyrKa1qy3Z8KF4xKryavayUWr1fJF18Gay0kryDA39rt347
        tryqqryqyF4rAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUoj
        jgUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 7:37 PM, Kalle Valo wrote:
> Petr Tesarik <petrtesarik@huaweicloud.com> writes:
> 
>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>
>> The channel list is in fact a flexible array, but it has a length of 1 to
>> make sure there is enough room for the special chanspec -1 when the struct
>> is allocated on stack to abort a scan.
>>
>> Move the single array member to newly declared struct brcmf_scan_abort_le
>> and struct brcmf_scan_abort_v2_le and make channel_list in struct
>> brcmf_scan_params_le and struct brcmf_scan_params_v2_le a flexible array.
>>
>> This fixes this annoying (though harmless) warning when the kernel is built
>> with CONFIG_FORTIFY_SOURCE=y:
>>
>> ------------[ cut here ]------------
>> memcpy: detected field-spanning write (size 76) of single field
>> "&params_le->channel_list[0]" at
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size
>> 2)
>> WARNING: CPU: 2 PID: 991 at
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072
>> brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
>> Modules linked in: qrtr(E) algif_hash(E) aes_neon_bs(E)
>> aes_neon_blk(E) algif_skcipher(E) af_alg(E) bnep(E) brcmfmac_wcc(E)
>> bcm2835_v4l2(CE) bcm2835_mmal_vchiq(CE) videobuf2_vmalloc(E)
>> videobuf2_memops(E) videobuf2_v4l2(E) videodev(E) hci_uart(E)
>> btsdio(E) videobuf2_common(E) btbcm(E) mc(E) snd_bcm2835(CE)
>> bluetooth(E) snd_pcm(E) brcmfmac(E) snd_timer(E) cpufreq_dt(E) snd(E)
>> soundcore(E) cfg80211(E) ecdh_generic(E) brcmutil(E)
>> raspberrypi_cpufreq(E) rfkill(E) vchiq(CE) bcm2711_thermal(E)
>> leds_gpio(E) fuse(E) efi_pstore(E) dmi_sysfs(E) ip_tables(E)
>> x_tables(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E)
>> nfs(E) lockd(E) grace(E) fscache(E) netfs(E) af_packet(E) mmc_block(E)
>> xhci_pci(E) xhci_pci_renesas(E) xhci_hcd(E) usbcore(E) usb_common(E)
>> clk_raspberrypi(E) gpio_raspberrypi_exp(E) bcm2835_dma(E)
>> crct10dif_ce(E) virt_dma(E) pcie_brcmstb(E) sdhci_iproc(E)
>> gpio_regulator(E) sdhci_pltfm(E) sdhci(E) mmc_core(E) fixed(E)
>> nvmem_rmem(E) sunrpc(E) sg(E) dm_multipath(E) dm_mod(E) efivarfs(E)
>> Unloaded tainted modules: aes_ce_cipher(E):1
>> CPU: 2 PID: 991 Comm: wpa_supplicant Tainted: G C E
>> 6.5.0-rc4-dynswiotlb+ #27 2ec0961165cc91fdbec101d9d43b3331ba4f0927
>> Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04 04/01/2023
>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
>> lr : brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac]
>> sp : ffff8000829ab590
>> x29: ffff8000829ab590 x28: 0000000000000000 x27: 0000000000000001
>> x26: ffff000105e7e0a4 x25: ffff00010a0bcb48 x24: ffff000101e03800
>> x23: ffff000105ec8920 x22: ffff000106332980 x21: ffff00010a0bc0c0
>> x20: ffff00010a0bcb90 x19: ffff00010a0bc108 x18: ffffffffffffffff
>> x17: 0000000000000000 x16: 0000000000000000 x15: 616f72622f737365
>> x14: 6c657269772f7465 x13: 616d666d6372622f x12: 31313230386d6372
>> x11: 00000000ffffdfff x10: ffff800081ad3328 x9 : ffff800080130694
>> x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
>> x5 : ffff0001fef75e00 x4 : 0000000000000000 x3 : 0000000000000027
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00010aa0e000
>> Call trace:
>>  brcmf_scan_params_v2_to_v1+0xd4/0x118 [brcmfmac
>> 38c4a81a3b85b4aff1650c67f95f20bc542d60c1]
>>  brcmf_run_escan+0x148/0x1a0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d60c1]
>>  brcmf_do_escan+0x74/0xe0 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d60c1]
>>  brcmf_cfg80211_scan+0xcc/0x298 [brcmfmac 38c4a81a3b85b4aff1650c67f95f20bc542d60c1]
>>  rdev_scan+0x38/0x158 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54cb8]
>>  cfg80211_scan+0x134/0x178 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54cb8]
>>  nl80211_trigger_scan+0x3e8/0x768 [cfg80211 8907673111c49ec56be88af3d38994cc1cf54cb8]
>>  genl_family_rcv_msg_doit.isra.0+0xc0/0x130
>>  genl_rcv_msg+0x1e4/0x278
>>  netlink_rcv_skb+0x64/0x138
>>  genl_rcv+0x40/0x60
>>  netlink_unicast+0x1cc/0x2d8
>>  netlink_sendmsg+0x1d4/0x448
>>  sock_sendmsg+0x64/0xc0
>>  ____sys_sendmsg+0x260/0x2e0
>>  ___sys_sendmsg+0x88/0xf0
>>  __sys_sendmsg+0x70/0xd8
>>  __arm64_sys_sendmsg+0x2c/0x40
>>  invoke_syscall+0x78/0x100
>>  el0_svc_common.constprop.0+0x100/0x130
>>  do_el0_svc+0x40/0xa8
>>  el0_svc+0x34/0x138
>>  el0t_64_sync_handler+0x120/0x130
>>  el0t_64_sync+0x1a8/0x1b0
>> ---[ end trace 0000000000000000 ]---
>>
>> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> Is this the same issue as Hans patch fixes?
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230729140500.27892-1-hdegoede@redhat.com/

Yes, I wasn't aware of this other patch (I'm not subscribed to
linux-wireless). I see, Hans approach is less intrusive.

Petr T

