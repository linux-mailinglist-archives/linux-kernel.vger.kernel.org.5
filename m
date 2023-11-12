Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DA7E8FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 13:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjKLMNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 07:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLMNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 07:13:46 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131030D0;
        Sun, 12 Nov 2023 04:13:41 -0800 (PST)
Received: from [192.168.0.224] (ip5f5ae847.dynamic.kabel-deutschland.de [95.90.232.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A5CE061E5FE03;
        Sun, 12 Nov 2023 13:13:16 +0100 (CET)
Message-ID: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
Date:   Sun, 12 Nov 2023 13:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ath10k_pci logs errors about missing pre-cal and cal firmware on a
 laptop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Onn the Dell XPS 13 9360 with Debian sid/unstable, Linux 6.5.10 logs the 
error below:

     $ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
     [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 
2023-02-22
     [    0.000000] Linux version 6.5.0-4-amd64 
(debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU 
ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 
6.5.10-1 (2023-11-03)
     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
06/02/2022
     [    0.580689] microcode: Microcode Update Driver: v2.2.

     $ sudo dmesg --level alert,crit,err
     [    0.053566] x86/cpu: SGX disabled by BIOS.
     [    1.942183] psmouse serio1: synaptics: Unable to query device: -5
     [   14.401112] ath10k_pci 0000:3a:00.0: firmware: failed to load 
ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
     [   14.401143] firmware_class: See https://wiki.debian.org/Firmware 
for information about missing firmware
     [   14.401185] ath10k_pci 0000:3a:00.0: firmware: failed to load 
ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
     [   14.401233] ath10k_pci 0000:3a:00.0: firmware: failed to load 
ath10k/cal-pci-0000:3a:00.0.bin (-2)
     [   14.401273] ath10k_pci 0000:3a:00.0: firmware: failed to load 
ath10k/cal-pci-0000:3a:00.0.bin (-2)

As it’s logged with error level, I’d like to address the ath10k_pci 
errors, but I am unable to find the firmware in the Linux firmware 
archive [1].

What can I do about this?


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
