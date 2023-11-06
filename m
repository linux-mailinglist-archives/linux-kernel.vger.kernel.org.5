Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F747E2303
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjKFNHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjKFNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:07:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4381B2;
        Mon,  6 Nov 2023 05:07:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04336C433C8;
        Mon,  6 Nov 2023 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276066;
        bh=5n6d9K2WTvGgLN57M3uAvjix+OKzc8blRkVWpq1IXyk=;
        h=From:To:Cc:Subject:Date:From;
        b=cPcKiy6zfdIGi9Qt3KvrNaUcdvGB93hWESVKq/Lmp1GPrMj//DR3g2U+b/weOqvtv
         tD7nJ+B+nxEBXDhcY7Bsndg2j6a5FDpmRpXlaXKzCCGfuL2fWq0ejY+UvzJ/b5AOSX
         2gNBqX1d0w5Rs9DupoeWONNpe0wmzv17Fk7PmQV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.6 00/30] 6.6.1-rc1 review
Date:   Mon,  6 Nov 2023 14:03:18 +0100
Message-ID: <20231106130257.903265688@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.1-rc1
X-KernelTest-Deadline: 2023-11-08T13:02+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.6.1 release.
There are 30 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.1-rc1

Mark Hasemeyer <markhas@chromium.org>
    ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Mark Hasemeyer <markhas@chromium.org>
    ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection

Tony Lindgren <tony@atomide.com>
    serial: core: Fix runtime PM handling for pending tx

Siddharth Vadapalli <s-vadapalli@ti.com>
    misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Francesco Dolcini <francesco.dolcini@toradex.com>
    dt-bindings: serial: rs485: Add rs485-rts-active-high

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IX cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes PX cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Fix up PX-803/PX-857

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Fix port count of PX-257

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Intashield IS-100

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for Brainboxes UP cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Add support for additional Brainboxes UC cards

Cameron Williams <cang1@live.co.uk>
    tty: 8250: Remove UC-257 and UC-431

Daniel Starke <daniel.starke@siemens.com>
    tty: n_gsm: fix race condition in status line change on dead connections

Janne Grunau <j@jannau.net>
    Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Andrey Konovalov <andreyknvl@gmail.com>
    usb: raw-gadget: properly handle interrupted requests

Jimmy Hu <hhhuuu@google.com>
    usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tcpm: Add additional checks for contaminant

LihaSika <lihasika@gmail.com>
    usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Vicki Pfau <vi@endrift.com>
    PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Max McCarthy <mmccarthy@mcintoshlabs.com>
    ALSA: usb-audio: add quirk flag to enable native DSD for McIntosh devices

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Use simple_recursive_removal() to clean up dentries

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Delete eventfs_inode when the last dentry is freed

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Save ownership and mode

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Remove "is_freed" union with rcu head

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have trace_event_file have ref counters

Ian Rogers <irogers@google.com>
    perf evlist: Avoid frequency mode for the dummy event

Kai-Heng Feng <kai.heng.feng@canonical.com>
    power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Don't use fsleep for PSR exit waits


-------------

Diffstat:

 .../devicetree/bindings/serial/rs485.yaml          |   4 +
 Makefile                                           |   4 +-
 drivers/bluetooth/hci_bcm4377.c                    |   5 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   3 +-
 drivers/misc/pci_endpoint_test.c                   |   4 +
 drivers/pci/quirks.c                               |   8 +-
 drivers/power/supply/power_supply_core.c           |   8 +-
 drivers/tty/n_gsm.c                                |   2 +
 drivers/tty/serial/8250/8250_pci.c                 | 327 ++++++++++++++++++++-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  26 +-
 drivers/usb/storage/unusual_cypress.h              |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   5 +
 fs/tracefs/event_inode.c                           | 288 +++++++++++-------
 include/linux/pci_ids.h                            |   1 +
 include/linux/power_supply.h                       |   2 +-
 include/linux/trace_events.h                       |   4 +
 kernel/trace/trace.c                               |  15 +
 kernel/trace/trace.h                               |   3 +
 kernel/trace/trace_events.c                        |  31 +-
 kernel/trace/trace_events_filter.c                 |   3 +
 sound/hda/intel-dsp-config.c                       |   6 +
 sound/soc/sof/sof-pci-dev.c                        |   7 +
 sound/usb/quirks.c                                 |   2 +
 tools/perf/util/evlist.c                           |   5 +-
 26 files changed, 624 insertions(+), 146 deletions(-)


