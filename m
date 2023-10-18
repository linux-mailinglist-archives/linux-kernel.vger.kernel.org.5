Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D77CE075
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjJRO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjJRO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:56:00 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12935EA;
        Wed, 18 Oct 2023 07:55:59 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MBmM4-1qh0TB2c6m-00C7Sb;
 Wed, 18 Oct 2023 16:55:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Date:   Wed, 18 Oct 2023 16:55:39 +0200
Message-Id: <20231018145540.34014-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231018145540.34014-1-marcel@ziswiler.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oD583C4O4S6hnR07PJUQUB5+5AhFERDWRI2YEgFT3hEsd0Y7Z16
 zng+0NB95NXnii7QtK7MGtW5+oGlXXyMqmakuPuhQ+ZNv0KoKF4QwDxGqsSuB9xOVk2am2/
 nS8XZWrSHrlk1WxuK7t4DSN5tfHB1Boq6rWinPEQ9hHbdyeZZmdF4L8a3vcNDgEC0SzKUDc
 nV+Gsmp2/fVxi0/b+Gmwg==
UI-OutboundReport: notjunk:1;M01:P0:JxOcFXgpLkk=;86okk4k9JdGmfwTX1JGkSHdKOMV
 CYMQlQsOwkRcgTn0xgsf6uqICTXdC7c2g1rl0gZAUjF197c/8pnKDCHeKQj8IpZ1gs//qvtxy
 u+WtUhvKxMjwWyHcKFK4Myz+iBAlRsndg5dxKbz0+7fNpjMU7qKIXEbX1fMpHVd2sDckDeEdS
 mnU3LIw1CFXRFxY6yhAMMZAKlkJBXn/aCIT/Pv2Ek/ZcrcgtfKaUk5P9ptLyRjrQ+PfCFY9LS
 abDDXwNeIeIBFAzTYMh2+whyjl0HbAQoUzXXbP50hp14wLOVkOQa0znfNNjiaaSkqWcLhRtOB
 ARnfqQItLMTUEQ+8LFHMJCbQKGbudU3ha7k1jeeGc7KB/9cJaZexg0vu2jmVKMjbCDhLUsCZL
 +ExEwnTAPMNgCI8Hs7VaMnT5017cXohTdlekv8RxBmAhv1TVY8BXnpel9O0M9GvfUUxZ7j1vo
 nFI/NyUjljgrH1WSXIP9IdFVtgK82o+b6NHSejmA7b5ZUNFB6mppcnqE5zGNtOe0/Yb7RWjkh
 pYLGAwMEd4PbG2nZ2nCGQKElaOI1E5MvmIZbK7PK4F82Yl0jtUixXLinM5VUvHxRY1/C+qz4X
 u9fkhOoiGqm3hMr278Zl1Xj3tyK8YbglLczwDCwQ5WNt2P+h0lSZqiuLlYVywuSoKxm0F9BeS
 42gm8sfPzkOGrNbxYZxsOkLo4lR8FUhF4mplwCHcyOBhyHLCYwjCPKeo6FvEat605sFnZPLAJ
 /G6xg6SQbFkbXUMB0e6t7BXm9gBNk8RqOpfoIsCHg1Azx8dNeXHcy3NmCMiblW/MXYiNqMran
 vsNuyJhKezOKYZ+pqHFdt4Pcz+9An5qpkz0M8iBMNUfpH51IcK/NU+oF7YdEsdSgBlyGNrK9C
 JE+Kf/rvHakdB9w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Unfortunately, btnxpuart_close() may trigger a BUG: scheduling while
atomic. Fix this by properly purging the transmit queue and freeing the
receive skb.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
This is the kernel trace this commit fixes:
[   29.270685] BUG: scheduling while atomic: kworker/u3:0/55/0x00000002
[   29.277062] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils crct10dif_ce btnxpuart usb_f_ncm u_ether rtc_ti_k3 k3_j72xx_bandgap mwifiex_sdio mwifiex snd_soc_davinci_mcasp snd_soc_ti_udma sa2ul snd_soc_ti_edma snd_soc_ti_sdma authenc ina2xx snd_soc_nau8822 tps65219_pwrbutton at24 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 rtc_ds1307 spi_omap2_mcspi 8021q garp mrp stp llc cfg80211 bluetooth ecdh_generic ecc rfkill libcomposite fuse drm backlight ipv6
[   29.319532] CPU: 0 PID: 55 Comm: kworker/u3:0 Not tainted 6.6.0-rc5-next-20231010-dirty #35
[   29.327883] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[   29.335450] Workqueue: hci0 hci_power_off [bluetooth]
[   29.340775] Call trace:
[   29.343220]  dump_backtrace+0x98/0x118
[   29.346984]  show_stack+0x18/0x24
[   29.350303]  dump_stack_lvl+0x48/0x60
[   29.353971]  dump_stack+0x18/0x24
[   29.357287]  __schedule_bug+0x50/0x68
[   29.360953]  __schedule+0x7f0/0xa94
[   29.364446]  schedule+0x34/0xc8
[   29.367588]  rpm_resume+0x170/0x6c8
[   29.371083]  __pm_runtime_resume+0x4c/0x90
[   29.375182]  omap8250_set_mctrl+0x2c/0xbc
[   29.379198]  serial8250_set_mctrl+0x20/0x40
[   29.383387]  uart_update_mctrl+0x58/0x78
[   29.387311]  uart_dtr_rts+0x104/0x114
[   29.390975]  tty_port_shutdown+0xd4/0xdc
[   29.394903]  tty_port_close+0x40/0xbc
[   29.398567]  uart_close+0x34/0x9c
[   29.401882]  ttyport_close+0x50/0x94
[   29.405460]  serdev_device_close+0x40/0x50
[   29.409557]  btnxpuart_close+0x48/0xbc [btnxpuart]
[   29.414364]  hci_dev_close_sync+0x2ec/0x754 [bluetooth]
[   29.419747]  hci_dev_do_close+0x2c/0x70 [bluetooth]
[   29.424772]  hci_power_off+0x20/0x64 [bluetooth]
[   29.429536]  process_one_work+0x138/0x244
[   29.433551]  worker_thread+0x320/0x438
[   29.437302]  kthread+0x114/0x118
[   29.440533]  ret_from_fork+0x10/0x20
[   29.445838] BUG: scheduling while atomic: kworker/u3:0/55/0x00000000
[   29.453556] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils crct10dif_ce btnxpuart usb_f_ncm u_ether rtc_ti_k3 k3_j72xx_bandgap mwifiex_sdio mwifiex snd_soc_davinci_mcasp snd_soc_ti_udma sa2ul snd_soc_ti_edma snd_soc_ti_sdma authenc ina2xx snd_soc_nau8822 tps65219_pwrbutton at24 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 rtc_ds1307 spi_omap2_mcspi 8021q garp mrp stp llc cfg80211 bluetooth ecdh_generic ecc rfkill libcomposite fuse drm backlight ipv6
[   29.496085] CPU: 0 PID: 55 Comm: kworker/u3:0 Tainted: G        W          6.6.0-rc5-next-20231010-dirty #35
[   29.505912] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[   29.513478] Workqueue: hci0 hci_power_off [bluetooth]
[   29.518787] Call trace:
[   29.521232]  dump_backtrace+0x98/0x118
[   29.524993]  show_stack+0x18/0x24
[   29.528312]  dump_stack_lvl+0x48/0x60
[   29.531980]  dump_stack+0x18/0x24
[   29.535296]  __schedule_bug+0x50/0x68
[   29.538961]  __schedule+0x7f0/0xa94
[   29.542452]  schedule+0x34/0xc8
[   29.545593]  rpm_resume+0x170/0x6c8
[   29.549087]  __pm_runtime_resume+0x4c/0x90
[   29.553186]  omap_8250_pm+0x28/0x110
[   29.556766]  serial8250_pm+0x18/0x3c
[   29.560347]  uart_tty_port_shutdown+0xa4/0x114
[   29.564792]  tty_port_shutdown+0x84/0xdc
[   29.568718]  tty_port_close+0x40/0xbc
[   29.572382]  uart_close+0x34/0x9c
[   29.575697]  ttyport_close+0x50/0x94
[   29.579275]  serdev_device_close+0x40/0x50
[   29.583373]  btnxpuart_close+0x48/0xbc [btnxpuart]
[   29.588179]  hci_dev_close_sync+0x2ec/0x754 [bluetooth]
[   29.593562]  hci_dev_do_close+0x2c/0x70 [bluetooth]
[   29.598587]  hci_power_off+0x20/0x64 [bluetooth]
[   29.603353]  process_one_work+0x138/0x244
[   29.607369]  worker_thread+0x320/0x438
[   29.611119]  kthread+0x114/0x118
[   29.614352]  ret_from_fork+0x10/0x20

 drivers/bluetooth/btnxpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..9cb7529eef09 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1234,6 +1234,9 @@ static int btnxpuart_close(struct hci_dev *hdev)
 
 	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
+	skb_queue_purge(&nxpdev->txq);
+	kfree_skb(nxpdev->rx_skb);
+	nxpdev->rx_skb = NULL;
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
-- 
2.36.1

