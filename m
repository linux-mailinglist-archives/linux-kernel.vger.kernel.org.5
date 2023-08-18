Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6B7809DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358700AbjHRKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353582AbjHRKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:16:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068130C2;
        Fri, 18 Aug 2023 03:16:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a7d402fc6fso491998b6e.2;
        Fri, 18 Aug 2023 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692353786; x=1692958586;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvbAo1KAss7BNBvD/CNXaXkip7FZP3AvocbAaItLHM8=;
        b=lf9x65NZVXnpKuFUQXjXJGx4Nc5yQsbfNFTQBdLifu7LxPinM6DOnllJjOdeHHJHl/
         fyDu97T2VRbgK+FU0FX1uWS3vU4W8VvygxPvBnWQ2WAOVrCGCaYLa/1RUGFlWHpIgluQ
         wN9WfLl7iysW/PcV+KEeTZQfCBkIiw0SHKITQwQTyFtd7taRufmlsH4p43CANsviiHab
         77CYE0QbRtIm9BBif80DPInYBEgGH7MdBrV/Ap+qThe9HGsyvSRY5SzokQDk9IQJ2RYB
         WNYKPLrtTKqT/b5uxvuRf9VSXvLCcRkJ5FjyC/AD2kVcqbMsMuQabwaIJNkAAXctZYAS
         sJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353786; x=1692958586;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvbAo1KAss7BNBvD/CNXaXkip7FZP3AvocbAaItLHM8=;
        b=iCLNNYP2Yhm8YxNNmctuseZhhgsEZQdSzh0b4HHNGbhxoc+wYKwQNDF8oonoE6d5Mm
         Ao9kYN0Bgprvd/G2eI97MCTmorPL0xMgKj0GO+fIlC+A99XFrIXF9a+dkGSe9titbJOJ
         u+0F49B/Aq12wzuNzL3H41ExDuFwsej43RR4/7TG4+llPOEJNSES8xlz08EISi89V0Ti
         uh79/pXjrpNjnTUN1wCtCUbSuRzQ7edDX4rkFxoc5TsVx+DQUC5mc1FqwnRSbY7ey39G
         lQbcv58QZRaTJHiU9gM3hUQuo1Uznilm/sGAxG/DiwZdpsxkL9MVJHZlOtuU89PSkQCo
         oWXQ==
X-Gm-Message-State: AOJu0YwnAgJt/E5xJyf5R+gBdyHdeoaoePU4yQiCOEgtQKGaGzFMfYjJ
        /uv4muvKcSm1fKu4JoJNDn0=
X-Google-Smtp-Source: AGHT+IGmtF251XJrS7sIthGQ8UsWvr2QhhHGD9fxGdmeshWzTUFW82YxHtcozmMmazc4oL9AIbl3SA==
X-Received: by 2002:a05:6808:1307:b0:3a4:894a:9f57 with SMTP id y7-20020a056808130700b003a4894a9f57mr2754001oiv.6.1692353786183;
        Fri, 18 Aug 2023 03:16:26 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id w29-20020a63935d000000b00563df2ba23bsm1152497pgm.50.2023.08.18.03.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 03:16:25 -0700 (PDT)
Message-ID: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com>
Date:   Fri, 18 Aug 2023 17:16:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        =?UTF-8?Q?Fran=c3=a7ois_Armand?= <fanf42@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ath11k <ath11k@lists.infradead.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0: Failed to
 send headers (or body or access otp area)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hello,
> 
> (Sorry by advance if it's not the correct place to discuss that, but I tried other place like my distro kernel forum (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive chat, etc and nobody was able to help).
> 
> [1] == Short summary ==
> 
> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card (which is actually reported by lspci as QCNFA765) and bluetooth never worked on it, failing to load the rampatch with "failed to send header" or "failed to send body" or "Failed to access otp area (-71)".
> 
> Other people reports bluetooth as working (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3) and a work friend has a T16 AMD gen1 which seems to have exactly the same chipset and work flowlessly. So perhaps it's an hardware issue, but I don't know how to qualify it if so.
> 
> => How can this be further qualified/debuged/workarounded?
> 
> Any help, even RTFM pointing to corresponding manuals would be very much appreciated.
> 
> 
> [2] == logs and more details ==
> 
> I have that laptop since october 2022 and use archlinux with the standard kernels. None made bluetooth wroked since then. First install was around linux 6.0.10 and current kernel: 6.4.10-arch1-10.
> 
> There is nothing obvious in bios setting that could lead to that (bluetooth is enabled).
> 
> # LSPCI
> 
> lspci -k -s 01:00.0 
> 01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter (rev 01) 
> Subsystem: Lenovo QCNFA765 Wireless Network Adapter 
> Kernel driver in use: ath11k_pci 
> Kernel modules: ath11k_pci
> 
> 
> # kernel boot log: "Failed to send headers (-71)"
> 
> kernel: thinkpad_acpi: radio switch found; radios are enabled 
> kernel: thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver 
> kernel: thinkpad_acpi: Disabling thinkpad-acpi brightness events by default
> ... 
> kernel: thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked 
> ... 
> rfkill[6774]: unblock set for type bluetooth sudo[6773]: pam_unix(sudo:session): session closed for user root 
> kernel: usb 1-3.1: new full-speed USB device number 3 using xhci_hcd 
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 boltd[935]: probing: started [1000] 
> kernel: Bluetooth: Core ver 2.22 kernel: NET: Registered PF_BLUETOOTH protocol family kernel: Bluetooth: HCI device and connection manager initialized 
> kernel: Bluetooth: HCI socket layer initialized kernel: Bluetooth: L2CAP socket layer initialized 
> kernel: Bluetooth: SCO socket layer initialized kernel: usbcore: registered new interface driver btusb 
> systemd[1328]: Reached target Bluetooth. 
> kernel: Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00130201.bin 
> kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, firmware rome 0x130201 build 0x38e6 
> kernel: Bluetooth: hci0: Failed to send headers (-71) 
> systemd[1]: Starting Bluetooth service... 
> bluetoothd[6866]: Bluetooth daemon 5.66 
> systemd[1]: Started Bluetooth service. 
> systemd[1]: Reached target Bluetooth Support. 
> bluetoothd[6866]: Starting SDP server bluetoothd[6866]: profiles/audio/vcp.c:vcp_init() D-Bus experimental not enabled
> 
> # rfkill status
> 
> sudo rfkill 
> ID TYPE DEVICE SOFT HARD 
> 0 bluetooth tpacpi_bluetooth_sw blocked unblocked 
> 1 wlan phy0 unblocked unblocked 
> 
> # when trying to unlock: "failed to send body at 40 of 142192 (-71)"
> 
> rfkill[105640]: unblock set for type bluetooth 
> sudo[105639]: pam_unix(sudo:session): session closed for user root 
> kernel: usb 1-3.1: new full-speed USB device number 4 using xhci_hcd 
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 
> kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 
> kernel: Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00130201.bin 
> kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, firmware rome 0x130201 build 0x38e6 
> kernel: Bluetooth: hci0: Failed to send body at 40 of 142192 (-71) 
> kernel: usb 1-3.1: USB disconnect, device number 4 
> boltd[935]: probing: started [1000] 
> systemd[1328]: Reached target Bluetooth. 
> systemd[1328]: Stopped target Bluetooth. 
> systemd[1]: Reached target Bluetooth Support. 
> systemd[1]: Stopped target Bluetooth Support. 
> 
> # unloading and loading back kernel related modules (`bluetooth`, `btusb`, etc) and modprobe them back, and I get the same kind of logs after `rfkill unblock bluetoot`:
> 
> rfkill[106483]: unblock set for type bluetooth 
> sudo[106482]: pam_unix(sudo:session): session closed for user root 
> kernel: usb 1-3.1: new full-speed USB device number 5 using xhci_hcd 
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 
> kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 
> kernel: usb 1-3.1: Failed to access otp area (-71) 
> kernel: usb 1-3.1: USB disconnect, device number 5 
> boltd[935]: probing: started [1000] 
> systemd[1328]: Reached target Bluetooth. 
> systemd[1]: Reached target Bluetooth Support. 
> systemd[1328]: Stopped target Bluetooth. 
> systemd[1]: Stopped target Bluetooth Support. 
> boltd[935]: probing: timeout, done: [3001068] (2000000)
> 
> Have a nice day

See Bugzilla for the full thread.

FYI, this is a duplicate of his earlier report [2] that had not seen
any replies. I have added ath11k maintainers to the recipient list
so that this bug can be hopefully addressed.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217805
[2]: https://lore.kernel.org/all/977f687e-533f-ebce-a50c-2dde1e1adb99@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
