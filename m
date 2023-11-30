Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC27FEA62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjK3IXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjK3IXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:23:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659710C2;
        Thu, 30 Nov 2023 00:23:41 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cc2027f7a2so677111b3a.2;
        Thu, 30 Nov 2023 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701332620; x=1701937420; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhWyxhGscoc+8YUf7VazUjwTIJ5qEgPm9++dFTK6f9M=;
        b=JJ4mOCzCGoJYLQd0VXruI32bjLaXUESMd86DgPJPEz6C6TE5NRasXB81Zd7xwy0co7
         DENGBSe2rMN05r2Xp9G1xX/xbzcy4r58r7j9CPL2udn7fSFUrgV+EoFqlToFVSL17zgn
         sqEHCqhm9ydhfgDDqDAUdvd6WsmnWmrRVEeDbqmhfJcP0wDyzuoHSC9R5UeHmmMop9sZ
         IUG3cCwJWVfTU+LmltM4r+9HBc8+SYD+naMvhRCWtt30exwcFQ5N3TYXHpst2drYRvpt
         1or8g/j0wye/JKmC+t0YMVcPKaXfVQ9ex2/1Njrg/zldZm6ZD8VnohO9lhHV6YT0GHHf
         NA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332620; x=1701937420;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhWyxhGscoc+8YUf7VazUjwTIJ5qEgPm9++dFTK6f9M=;
        b=UbpICsF/prOeQASmYZ6T/rs+DyjhrblUiTcCdMLu0Ct3S/gwiNC1Rees106Uq/O9rc
         Zce427tUa7Ug+Hsgx247mPe8ZWx7aZ0gdtm1iUtODzJwCu2v+7g2bNLIykdX/n4+HbjU
         pHyvqgSvgD0IWzEmjiMuMEhNcebbh2s6xswejJnNO48lq0LLvc9ixMwE90kjoA5qVz20
         TE6M0ulpDFgh73IPcDWk0zxZG5CectMtVkR/snhVXpiCx2/2vYAmugFroDgJa7mHq5rv
         dbn1LAGSpSHrzelIVtDE/HMedthZRqOP/g5n7FkQgmjpuYLagDuASNppgD/DUOiU1lfm
         JIwg==
X-Gm-Message-State: AOJu0YxO/wj2Hi3MXY4VD5b56WTi51l7rKUxr77zNZrBk+Cni3xugs/u
        wSOVZ261UvHDh/ysa0zabfC2YLB9WhzcmQ==
X-Google-Smtp-Source: AGHT+IFlQOkYS3nqSDxysof4ljqlQixDD7eWwtytYdHbrpVCEE6eQ0i/HvyJorIaB7B8xPOQNrTdwA==
X-Received: by 2002:a05:6a21:33aa:b0:188:20e0:2bca with SMTP id yy42-20020a056a2133aa00b0018820e02bcamr23594740pzb.13.1701332619975;
        Thu, 30 Nov 2023 00:23:39 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y63-20020a62ce42000000b006c3069547bfsm678043pfg.79.2023.11.30.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:23:39 -0800 (PST)
Message-ID: <5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com>
Date:   Thu, 30 Nov 2023 15:23:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Eliad Peller <eliad@wizery.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linus Lotz <register+kernelbugzilla@lotz.li>,
        Darrell Enns <darrell@darrellenns.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Rfkilling the iwlwifi can lock up my machine, rfkill will not respond and other networking related things (e.g. ip a or ip r)
> I see this on 6.5.12 and 6.6.2 (fedora kernel). On 6.5.11 it does not lockup AFAICT, but also shows kernel oops.
> WiFi Hardware: AC 8265
> 
> Kernel oops for 6.5.11:
> Nov 29 10:12:11 hql024707 rfkill[6712]: block set for id 1
> Nov 29 10:12:11 hql024707 NetworkManager[1138]: <info>  [1701249131.5557] manager: rfkill: Wi-Fi now disabled by radio killswitch
> Nov 29 10:12:11 hql024707 kernel: ------------[ cut here ]------------
> Nov 29 10:12:11 hql024707 kernel: Timeout waiting for hardware access (CSR_GP_CNTRL 0x00000008)
> Nov 29 10:12:11 hql024707 kernel: WARNING: CPU: 7 PID: 5222 at drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2190 __iwl_trans_pcie>
> Nov 29 10:12:11 hql024707 kernel: Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer des_generic libdes md4 nf_conntrack_net>
> Nov 29 10:12:11 hql024707 kernel:  snd_hda_intel intel_tcc_cooling x86_pkg_temp_thermal snd_usbmidi_lib intel_powerclamp snd_intel_d>
> Nov 29 10:12:11 hql024707 kernel:  intel_hid int3400_thermal int3403_thermal acpi_pad acpi_thermal_rel sparse_keymap int340x_thermal>
> Nov 29 10:12:11 hql024707 kernel: CPU: 7 PID: 5222 Comm: kworker/7:0 Not tainted 6.5.11-300.fc39.x86_64 #1
> Nov 29 10:12:11 hql024707 kernel: Hardware name: Dell Inc. Latitude 7490/0KP0FT, BIOS 1.33.0 07/06/2023
> Nov 29 10:12:11 hql024707 kernel: Workqueue: events cfg80211_rfkill_block_work [cfg80211]
> Nov 29 10:12:11 hql024707 kernel: RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel: Code: 00 00 00 48 89 df e8 f5 93 fe ff 4c 89 f7 e8 5d c6 d9 d6 eb 8c 89 c6 48 c7 c7 38 14 4d c1 c6>
> Nov 29 10:12:11 hql024707 kernel: RSP: 0018:ffffc014514ebb90 EFLAGS: 00010282
> Nov 29 10:12:11 hql024707 kernel: RAX: 0000000000000000 RBX: ffff9d4c20ee0028 RCX: 0000000000000027
> Nov 29 10:12:11 hql024707 kernel: RDX: ffff9d4f6e5e1548 RSI: 0000000000000001 RDI: ffff9d4f6e5e1540
> Nov 29 10:12:11 hql024707 kernel: RBP: 0000000000000008 R08: 0000000000000000 R09: ffffc014514eba20
> Nov 29 10:12:11 hql024707 kernel: R10: 0000000000000003 R11: ffffffff99345d68 R12: 0000000000000001
> Nov 29 10:12:11 hql024707 kernel: R13: 0000000000000000 R14: ffff9d4c20ee35cc R15: 0000000000000011
> Nov 29 10:12:11 hql024707 kernel: FS:  0000000000000000(0000) GS:ffff9d4f6e5c0000(0000) knlGS:0000000000000000
> Nov 29 10:12:11 hql024707 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 29 10:12:11 hql024707 kernel: CR2: 00007ffb507f74c0 CR3: 00000002fc222001 CR4: 00000000003706e0
> Nov 29 10:12:11 hql024707 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov 29 10:12:11 hql024707 kernel: Timeout waiting for hardware access (CSR_GP_CNTRL 0x00000008)
> Nov 29 10:12:11 hql024707 kernel: WARNING: CPU: 7 PID: 5222 at drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2190 __iwl_trans_pcie>
> Nov 29 10:12:11 hql024707 kernel: Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer des_generic libdes md4 nf_conntrack_net>
> Nov 29 10:12:11 hql024707 kernel:  snd_hda_intel intel_tcc_cooling x86_pkg_temp_thermal snd_usbmidi_lib intel_powerclamp snd_intel_d>
> Nov 29 10:12:11 hql024707 kernel:  intel_hid int3400_thermal int3403_thermal acpi_pad acpi_thermal_rel sparse_keymap int340x_thermal>
> Nov 29 10:12:11 hql024707 kernel: CPU: 7 PID: 5222 Comm: kworker/7:0 Not tainted 6.5.11-300.fc39.x86_64 #1
> Nov 29 10:12:11 hql024707 kernel: Hardware name: Dell Inc. Latitude 7490/0KP0FT, BIOS 1.33.0 07/06/2023
> Nov 29 10:12:11 hql024707 kernel: Workqueue: events cfg80211_rfkill_block_work [cfg80211]
> Nov 29 10:12:11 hql024707 kernel: RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel: Code: 00 00 00 48 89 df e8 f5 93 fe ff 4c 89 f7 e8 5d c6 d9 d6 eb 8c 89 c6 48 c7 c7 38 14 4d c1 c6>
> Nov 29 10:12:11 hql024707 kernel: RSP: 0018:ffffc014514ebb90 EFLAGS: 00010282
> Nov 29 10:12:11 hql024707 kernel: RAX: 0000000000000000 RBX: ffff9d4c20ee0028 RCX: 0000000000000027
> Nov 29 10:12:11 hql024707 kernel: RDX: ffff9d4f6e5e1548 RSI: 0000000000000001 RDI: ffff9d4f6e5e1540
> Nov 29 10:12:11 hql024707 kernel: RBP: 0000000000000008 R08: 0000000000000000 R09: ffffc014514eba20
> Nov 29 10:12:11 hql024707 kernel: R10: 0000000000000003 R11: ffffffff99345d68 R12: 0000000000000001
> Nov 29 10:12:11 hql024707 kernel: R13: 0000000000000000 R14: ffff9d4c20ee35cc R15: 0000000000000011
> Nov 29 10:12:11 hql024707 kernel: FS:  0000000000000000(0000) GS:ffff9d4f6e5c0000(0000) knlGS:0000000000000000
> Nov 29 10:12:11 hql024707 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 29 10:12:11 hql024707 kernel: CR2: 00007ffb507f74c0 CR3: 00000002fc222001 CR4: 00000000003706e0
> Nov 29 10:12:11 hql024707 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov 29 10:12:11 hql024707 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Nov 29 10:12:11 hql024707 kernel: Call Trace:
> Nov 29 10:12:11 hql024707 kernel:  <TASK>
> Nov 29 10:12:11 hql024707 kernel:  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  ? __warn+0x81/0x130
> Nov 29 10:12:11 hql024707 kernel:  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  ? report_bug+0x171/0x1a0
> Nov 29 10:12:11 hql024707 kernel:  ? prb_read_valid+0x1b/0x30
> Nov 29 10:12:11 hql024707 kernel:  ? handle_bug+0x3c/0x80
> Nov 29 10:12:11 hql024707 kernel:  ? exc_invalid_op+0x17/0x70
> Nov 29 10:12:11 hql024707 kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Nov 29 10:12:11 hql024707 kernel:  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  iwl_write_prph_delay+0x27/0x90 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  iwl_fw_dbg_stop_restart_recording+0x128/0x290 [iwlwifi]
> Nov 29 10:12:11 hql024707 kernel:  ? __cancel_work_timer+0xff/0x190
> Nov 29 10:12:11 hql024707 kernel:  iwl_mvm_stop_device+0x3a/0x80 [iwlmvm]
> Nov 29 10:12:11 hql024707 kernel:  __iwl_mvm_mac_stop+0x59/0x120 [iwlmvm]
> Nov 29 10:12:11 hql024707 kernel:  iwl_mvm_mac_stop+0x7f/0xd0 [iwlmvm]
> Nov 29 10:12:11 hql024707 kernel:  drv_stop+0x34/0x100 [mac80211]
> Nov 29 10:12:11 hql024707 kernel:  ieee80211_do_stop+0x5d0/0x890 [mac80211]
> Nov 29 10:12:11 hql024707 kernel:  ieee80211_stop+0x4d/0x180 [mac80211]
> Nov 29 10:12:11 hql024707 kernel:  __dev_close_many+0x9b/0x110
> Nov 29 10:12:11 hql024707 kernel:  dev_close_many+0x8f/0x150
> Nov 29 10:12:11 hql024707 kernel:  dev_close+0x83/0xb0
> Nov 29 10:12:11 hql024707 kernel:  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
> Nov 29 10:12:11 hql024707 kernel:  cfg80211_rfkill_block_work+0x1e/0x30 [cfg80211]
> Nov 29 10:12:11 hql024707 kernel:  process_one_work+0x1de/0x3f0
> Nov 29 10:12:11 hql024707 kernel:  worker_thread+0x51/0x390
> Nov 29 10:12:11 hql024707 kernel:  ? __pfx_worker_thread+0x10/0x10
> Nov 29 10:12:11 hql024707 kernel:  kthread+0xe5/0x120
> Nov 29 10:12:11 hql024707 kernel:  ? __pfx_kthread+0x10/0x10
> Nov 29 10:12:11 hql024707 kernel:  ret_from_fork+0x31/0x50
> Nov 29 10:12:11 hql024707 kernel:  ? __pfx_kthread+0x10/0x10
> Nov 29 10:12:11 hql024707 kernel:  ret_from_fork_asm+0x1b/0x30
> Nov 29 10:12:11 hql024707 kernel:  </TASK>
> Nov 29 10:12:11 hql024707 kernel: ---[ end trace 0000000000000000 ]---
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi transaction failed, dumping registers
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi device config registers:
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000000: 24fd8086 00100406 02800078 00000000 ec000004 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000 00508086 00000000 000000c8 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000040: 00020010 10008ec0 00190c10 0045e811 10110142 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000060: 00000000 00080812 00000405 00000000 00010001 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000080: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 000000a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 000000c0: 00000000 00000000 c823d001 0d000000 00814005 fee007b8 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 000000e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000100: 14010001 00000000 00000000 00462031 00002000 00002000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000120: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000140: 14c10003 ffb58619 a0510bff 15410018 10031003 0001001e 00481e1f 405>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi device memory mapped registers:
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000000: 00080000 00000000 00000000 00000000 00000000 00000000 00000010 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000020: 00000011 00000008 00000230 d55555d5 d55555d5 d55555d5 80008040 001>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi device AER capability structure:
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000000: 14010001 00000000 00000000 00462031 00002000 00002000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi parent port (0000:00:1c.2) config registers:
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000000: 9d128086 00100407 060400f1 00810000 00000000 00000000 00020200 200>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000020: ec00ec00 0001fff1 00000000 00000000 00000000 00000040 00000000 001>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000040: 01428010 00008001 00100000 03724813 70110042 0034b200 01480000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000060: 00000000 00000837 00000400 0000000e 00010003 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000080: 00019005 fee00298 00000000 00000000 0000a00d 081c1028 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000000a0: c8030001 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000000c0: 00000000 00000000 00000000 00000000 07001001 00001842 899e0008 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000000e0: 00630300 00000000 00100016 00000000 00000150 4c000000 08410fb3 030>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000100: 14010001 00000000 00010000 00060011 00000000 00002000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000120: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000140: 2001000d 0000000f 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000160: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000180: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000001a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000001c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 000001e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000200: 2201001e 00b0281f 4058280f
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:02:00.0: iwlwifi root port (0000:00:1c.2) AER cap structure:
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000000: 14010001 00000000 00010000 00060011 00000000 00002000 00000000 000>
> Nov 29 10:12:11 hql024707 kernel: iwlwifi 0000:00:1c.2: 00000020: 00000000 00000000 00000000 00000000 00000000 00000000
> 
> Kernel 6.5.12:
> Nov 28 13:51:50 hql024707 kernel: iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
> Nov 28 13:51:50 hql024707 kernel: iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)
> Nov 28 13:51:50 hql024707 iwd[1160]: rfkill id 1 not found in a RFKILL_OP_CHANGE event
> Nov 28 13:51:50 hql024707 kernel: wlan0: deauthenticating from 4c:71:0d:50:14:0d by local choice (Reason: 3=DEAUTH_LEAVING)
> Nov 28 13:51:50 hql024707 systemd[1]: Starting systemd-rfkill.service - Load/Save RF Kill Switch Status...
> Nov 28 13:51:50 hql024707 systemd[1]: Started systemd-rfkill.service - Load/Save RF Kill Switch Status.
> Nov 28 13:51:50 hql024707 audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='u>
> Nov 28 13:51:52 hql024707 kernel: iwlwifi 0000:02:00.0: fail to flush all tx fifo queues Q 5
> Nov 28 13:51:52 hql024707 kernel: iwlwifi 0000:02:00.0: Queue 5 is active on fifo 3 and stuck for 10000 ms. SW [6, 7] HW [7, 7] FH T>
> Nov 28 13:51:54 hql024707 kernel: iwlwifi 0000:02:00.0: fail to flush all tx fifo queues Q 5
> Nov 28 13:51:54 hql024707 kernel: iwlwifi 0000:02:00.0: Queue 5 is active on fifo 3 and stuck for 10000 ms. SW [6, 7] HW [7, 7] FH T>
> Nov 28 13:51:54 hql024707 kernel: ------------[ cut here ]------------
> Nov 28 13:51:54 hql024707 kernel: WARNING: CPU: 5 PID: 31284 at net/mac80211/sta_info.c:1442 __sta_info_destroy_part2+0x235/0x300 [m>
> Nov 28 13:51:54 hql024707 kernel: Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ump snd_rawmidi r8153_ecm cdc_ether usbnet r8>
> Nov 28 13:51:54 hql024707 kernel:  snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi snd_hda_codec_hdmi snd_soc_core mac80211 sn>
> Nov 28 13:51:54 hql024707 kernel:  processor_thermal_rfim processor_thermal_mbox processor_thermal_rapl intel_pch_thermal intel_xhci>
> Nov 28 13:51:54 hql024707 kernel: CPU: 5 PID: 31284 Comm: kworker/5:0 Not tainted 6.5.12-300.fc39.x86_64 #1
> Nov 28 13:51:54 hql024707 kernel: Hardware name: Dell Inc. Latitude 7490/0KP0FT, BIOS 1.33.0 07/06/2023
> Nov 28 13:51:54 hql024707 kernel: Workqueue: events cfg80211_rfkill_block_work [cfg80211]
> Nov 28 13:51:54 hql024707 kernel: RIP: 0010:__sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 28 13:51:54 hql024707 kernel: Code: bb d4 00 00 00 00 0f 84 68 ff ff ff 45 31 c0 b9 01 00 00 00 48 89 da 4c 89 f6 4c 89 e7 e8 83>
> Nov 28 13:51:54 hql024707 kernel: RSP: 0018:ffffb7cf18e4f958 EFLAGS: 00010282
> Nov 28 13:51:54 hql024707 kernel: RAX: 00000000ffffff92 RBX: ffff8ab318bfc000 RCX: 0000000000000027
> Nov 28 13:51:54 hql024707 kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8ab29fb9a098
> Nov 28 13:51:54 hql024707 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb7cf18e4f4b8
> Nov 28 13:51:54 hql024707 kernel: R10: 0000000000000003 R11: ffffffff9f345d88 R12: ffff8ab29fb98900
> Nov 28 13:51:54 hql024707 kernel: R13: ffff8ab318bfcab8 R14: ffff8ab2a2e149c0 R15: ffff8ab2a2e149c0
> Nov 28 13:51:54 hql024707 kernel: FS:  0000000000000000(0000) GS:ffff8ab5ee540000(0000) knlGS:0000000000000000
> Nov 28 13:51:54 hql024707 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 28 13:51:54 hql024707 kernel: CR2: 000014bad53a7000 CR3: 0000000359222004 CR4: 00000000003706e0
> Nov 28 13:51:54 hql024707 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov 28 13:51:54 hql024707 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Nov 28 13:51:54 hql024707 kernel: Call Trace:
> Nov 28 13:51:54 hql024707 kernel:  <TASK>
> Nov 28 13:51:54 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ? __warn+0x81/0x130
> Nov 28 13:51:54 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ? report_bug+0x171/0x1a0
> Nov 28 13:51:54 hql024707 kernel:  ? handle_bug+0x3c/0x80
> Nov 28 13:51:54 hql024707 kernel:  ? exc_invalid_op+0x17/0x70
> Nov 28 13:51:54 hql024707 kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Nov 28 13:51:54 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ? __sta_info_destroy_part2+0x22d/0x300 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  __sta_info_flush+0x169/0x1f0 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_mlme_down+0x65/0x90 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_netdev_notifier_call+0x141/0x4d0 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  ? iwl_mvm_send_cmd+0x1f/0x60 [iwlmvm]
> Nov 28 13:51:54 hql024707 kernel:  ? iwl_mvm_mc_iface_iterator+0xcd/0xf0 [iwlmvm]
> Nov 28 13:51:54 hql024707 kernel:  ? __iterate_interfaces+0x9d/0x110 [mac80211]
> Nov 28 13:51:54 hql024707 kernel:  ? __pfx_iwl_mvm_mc_iface_iterator+0x10/0x10 [iwlmvm]
> Nov 28 13:51:54 hql024707 kernel:  ? iwl_mvm_send_cmd_pdu+0x62/0xb0 [iwlmvm]
> Nov 28 13:51:54 hql024707 kernel:  ? rtnl_is_locked+0x15/0x20
> Nov 28 13:51:54 hql024707 kernel:  ? inetdev_event+0x3d/0x6f0
> Nov 28 13:51:54 hql024707 kernel:  ? iwl_mvm_recalc_multicast+0x5d/0xa0 [iwlmvm]
> Nov 28 13:51:54 hql024707 kernel:  notifier_call_chain+0x5a/0xd0
> Nov 28 13:51:54 hql024707 kernel:  __dev_close_many+0x5f/0x110
> Nov 28 13:51:54 hql024707 kernel:  dev_close_many+0x8f/0x150
> Nov 28 13:51:54 hql024707 kernel:  dev_close+0x83/0xb0
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  cfg80211_rfkill_block_work+0x1e/0x30 [cfg80211]
> Nov 28 13:51:54 hql024707 kernel:  process_one_work+0x1de/0x3f0
> Nov 28 13:51:54 hql024707 kernel:  worker_thread+0x51/0x390
> Nov 28 13:51:54 hql024707 kernel:  ? __pfx_worker_thread+0x10/0x10
> Nov 28 13:51:54 hql024707 kernel:  kthread+0xe5/0x120
> Nov 28 13:51:54 hql024707 kernel:  ? __pfx_kthread+0x10/0x10
> Nov 28 13:51:54 hql024707 kernel:  ret_from_fork+0x31/0x50
> Nov 28 13:51:54 hql024707 kernel:  ? __pfx_kthread+0x10/0x10
> Nov 28 13:51:54 hql024707 kernel:  ret_from_fork_asm+0x1b/0x30
> Nov 28 13:51:54 hql024707 kernel:  </TASK>
> Nov 28 13:51:54 hql024707 kernel: ---[ end trace 0000000000000000 ]---
> 
> and 6.6.2:
> Nov 29 09:52:43 hql024707 kernel: iwlwifi 0000:02:00.0: fail to flush all tx fifo queues Q 5
> Nov 29 09:52:43 hql024707 kernel: iwlwifi 0000:02:00.0: Queue 5 is active on fifo 3 and stuck for 10000 ms. SW [5, 6] HW [6, 6] FH T>
> Nov 29 09:52:45 hql024707 kernel: iwlwifi 0000:02:00.0: fail to flush all tx fifo queues Q 5
> Nov 29 09:52:45 hql024707 kernel: iwlwifi 0000:02:00.0: Queue 5 is active on fifo 3 and stuck for 10000 ms. SW [5, 6] HW [6, 6] FH T>
> Nov 29 09:52:45 hql024707 kernel: ------------[ cut here ]------------
> Nov 29 09:52:45 hql024707 kernel: WARNING: CPU: 2 PID: 1143 at net/mac80211/sta_info.c:1442 __sta_info_destroy_part2+0x235/0x300 [ma>
> Nov 29 09:52:45 hql024707 kernel: Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer des_generic libdes md4 nf_conntrack_net>
> Nov 29 09:52:45 hql024707 kernel:  snd_compress ac97_bus iwlmvm ee1004 snd_pcm_dmaengine snd_hda_codec_generic kvm mei_wdt dell_rbtn>
> Nov 29 09:52:45 hql024707 kernel:  int3400_thermal acpi_thermal_rel intel_hid int3403_thermal acpi_pad int340x_thermal_zone sparse_k>
> Nov 29 09:52:45 hql024707 kernel: CPU: 2 PID: 1143 Comm: NetworkManager Not tainted 6.6.2-201.fc39.x86_64 #1
> Nov 29 09:52:45 hql024707 kernel: Hardware name: Dell Inc. Latitude 7490/0KP0FT, BIOS 1.33.0 07/06/2023
> Nov 29 09:52:45 hql024707 kernel: RIP: 0010:__sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 29 09:52:45 hql024707 kernel: Code: bb d4 00 00 00 00 0f 84 68 ff ff ff 45 31 c0 b9 01 00 00 00 48 89 da 4c 89 f6 4c 89 e7 e8 83>
> Nov 29 09:52:45 hql024707 kernel: RSP: 0018:ffffc90002663808 EFLAGS: 00010282
> Nov 29 09:52:45 hql024707 kernel: RAX: 00000000ffffff92 RBX: ffff88812954c000 RCX: 0000000000000027
> Nov 29 09:52:45 hql024707 kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888125cfa098
> Nov 29 09:52:45 hql024707 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffffc90002663360
> Nov 29 09:52:45 hql024707 kernel: R10: 0000000000000003 R11: ffffffffaa346088 R12: ffff888125cf8900
> Nov 29 09:52:45 hql024707 kernel: R13: ffff88812954cab8 R14: ffff8881226549c0 R15: ffff8881226549c0
> Nov 29 09:52:45 hql024707 kernel: FS:  00007fb50e081540(0000) GS:ffff88846e480000(0000) knlGS:0000000000000000
> Nov 29 09:52:45 hql024707 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 29 09:52:45 hql024707 kernel: CR2: 000055a6c513e700 CR3: 000000012573a003 CR4: 00000000003706e0
> Nov 29 09:52:45 hql024707 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov 29 09:52:45 hql024707 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Nov 29 09:52:45 hql024707 kernel: Call Trace:
> Nov 29 09:52:45 hql024707 kernel:  <TASK>
> Nov 29 09:52:45 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ? __warn+0x81/0x130
> Nov 29 09:52:45 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ? report_bug+0x171/0x1a0
> Nov 29 09:52:45 hql024707 kernel:  ? handle_bug+0x3c/0x80
> Nov 29 09:52:45 hql024707 kernel:  ? exc_invalid_op+0x17/0x70
> Nov 29 09:52:45 hql024707 kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Nov 29 09:52:45 hql024707 kernel:  ? __sta_info_destroy_part2+0x235/0x300 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ? __sta_info_destroy_part2+0x22d/0x300 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  __sta_info_flush+0x169/0x1f0 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_mlme_down+0x65/0x90 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_netdev_notifier_call+0x141/0x4d0 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  ? iwl_mvm_send_cmd+0x1f/0x60 [iwlmvm]
> Nov 29 09:52:45 hql024707 kernel:  ? iwl_mvm_mc_iface_iterator+0xcd/0xf0 [iwlmvm]
> Nov 29 09:52:45 hql024707 kernel:  ? __iterate_interfaces+0x9d/0x110 [mac80211]
> Nov 29 09:52:45 hql024707 kernel:  ? __pfx_iwl_mvm_mc_iface_iterator+0x10/0x10 [iwlmvm]
> Nov 29 09:52:45 hql024707 kernel:  ? iwl_mvm_send_cmd_pdu+0x62/0xb0 [iwlmvm]
> Nov 29 09:52:45 hql024707 kernel:  ? rtnl_is_locked+0x15/0x20
> Nov 29 09:52:45 hql024707 kernel:  ? inetdev_event+0x3d/0x6f0
> Nov 29 09:52:45 hql024707 kernel:  ? iwl_mvm_recalc_multicast+0x5d/0xa0 [iwlmvm]
> Nov 29 09:52:45 hql024707 kernel:  notifier_call_chain+0x5a/0xd0
> Nov 29 09:52:45 hql024707 kernel:  __dev_close_many+0x5f/0x110
> Nov 29 09:52:45 hql024707 kernel:  dev_close_many+0x8f/0x150
> Nov 29 09:52:45 hql024707 kernel:  dev_close+0x83/0xb0
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  cfg80211_rfkill_set_block+0x2a/0x40 [cfg80211]
> Nov 29 09:52:45 hql024707 kernel:  rfkill_set_block+0x91/0x160 [rfkill]
> Nov 29 09:52:45 hql024707 kernel:  rfkill_fop_write+0x161/0x200 [rfkill]
> Nov 29 09:52:45 hql024707 kernel:  vfs_write+0xef/0x420
> Nov 29 09:52:45 hql024707 kernel:  ? __fget_light+0x99/0x100
> Nov 29 09:52:45 hql024707 kernel:  ksys_write+0xbb/0xf0
> Nov 29 09:52:45 hql024707 kernel:  do_syscall_64+0x5d/0x90
> Nov 29 09:52:45 hql024707 kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> Nov 29 09:52:45 hql024707 kernel:  ? do_syscall_64+0x6c/0x90
> Nov 29 09:52:45 hql024707 kernel:  ? exit_to_user_mode_prepare+0x142/0x1f0
> Nov 29 09:52:45 hql024707 kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> Nov 29 09:52:45 hql024707 kernel:  ? do_syscall_64+0x6c/0x90
> Nov 29 09:52:45 hql024707 kernel:  ? do_syscall_64+0x6c/0x90
> Nov 29 09:52:45 hql024707 kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> Nov 29 09:52:45 hql024707 kernel:  ? do_syscall_64+0x6c/0x90
> Nov 29 09:52:45 hql024707 kernel:  ? do_syscall_64+0x6c/0x90
> Nov 29 09:52:45 hql024707 kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Nov 29 09:52:45 hql024707 kernel: RIP: 0033:0x7fb50f1adc6d
> Nov 29 09:52:45 hql024707 kernel: Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 b8 1d f8 ff 48 8b 55 e8 48 8b 75 f0 41 89>
> Nov 29 09:52:45 hql024707 kernel: RSP: 002b:00007ffe89561910 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> Nov 29 09:52:45 hql024707 kernel: RAX: ffffffffffffffda RBX: 0000000000000029 RCX: 00007fb50f1adc6d
> Nov 29 09:52:45 hql024707 kernel: RDX: 0000000000000008 RSI: 00007ffe89561958 RDI: 0000000000000029
> Nov 29 09:52:45 hql024707 kernel: RBP: 00007ffe89561930 R08: 0000000000000000 R09: 0000000000000007
> Nov 29 09:52:45 hql024707 kernel: R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> Nov 29 09:52:45 hql024707 kernel: R13: 000056426be6f070 R14: 0000000000000000 R15: 000056426be034c0
> Nov 29 09:52:45 hql024707 kernel:  </TASK>
> Nov 29 09:52:45 hql024707 kernel: ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?id=218206
#regzbot rfkill AC 8265 locks up machine

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218206

-- 
An old man doll... just what I always wanted! - Clara
