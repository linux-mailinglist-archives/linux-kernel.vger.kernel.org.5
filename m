Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCB7AE34A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjIZBZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZBZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:25:31 -0400
X-Greylist: delayed 275 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 18:25:24 PDT
Received: from dsmtpq3-prd-nl1-vmo.edge.unified.services (dsmtpq3-prd-nl1-vmo.edge.unified.services [84.116.6.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5310A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:25:23 -0700 (PDT)
Received: from csmtpq2-prd-nl1-vmo.edge.unified.services ([84.116.50.37])
        by dsmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1qkwko-002S4S-KI
        for linux-kernel@vger.kernel.org; Tue, 26 Sep 2023 03:20:46 +0200
Received: from csmtp4-prd-nl1-vmo.nl1.unified.services ([100.107.82.18] helo=csmtp4-prd-nl1-vmo.edge.unified.services)
        by csmtpq2-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1qkwkl-009iDH-Fa
        for linux-kernel@vger.kernel.org; Tue, 26 Sep 2023 03:20:43 +0200
Received: from [192.168.10.244] ([82.32.17.210])
        by csmtp4-prd-nl1-vmo.edge.unified.services with ESMTPA
        id kwklqpw6EwQmmkwklqCJG9; Tue, 26 Sep 2023 03:20:43 +0200
X-SourceIP: 82.32.17.210
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=RNt1Xau+ c=1 sm=1 tr=0 ts=651231eb cx=a_exe
 a=xwbGgp66NgX51+oEeDXSrg==:117 a=xwbGgp66NgX51+oEeDXSrg==:17
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=x7bEGLp0ZPQA:10
 a=Y7mfnwH9bYDW1qaE_8sA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1695691243;
        bh=58HFE+xwz+9b8BZaLacVtNU4NH8U4lYejEifF4GdxSE=;
        h=Date:Reply-To:To:From:Subject;
        b=jqdj/ST0EnNWlwp1mkgu4GMdI1M6jin7MDU9Zz+LoCIssihEtQ5wKokCTf8F5PRKJ
         b+K+IaNOW1SRM6fS9pydqkxq4kGxgjhBx3tRG0JPL+wshy5mCTWgmgHUmSaibIjCc/
         VGav200RtzDtpq+jzkxvWQ1p/Q8w+fUqf/9578Tbwmuu6DVzolLHVHvC8mGVFROC2K
         94xUynrbLUWfLU5K//CflrLGsgLJFwNRG5ODUmZVBI5aAm6709SQ4XzT8rOOu7jZhy
         duikLA9lJqXx7i8ezjC6xo0uXLHpwEX5FhuewlvNAjsI2ZqOFO68sBVpDi0ARh6yNp
         JyxB8jxgvXOLw==
Message-ID: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
Date:   Tue, 26 Sep 2023 02:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sboyce@blueyonder.co.uk
Content-Language: en-GB
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Ryzen 9 7950x sound module does not not build
Organization: blueyonder.co.uk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDQqgDofddURkrwgklO386YLaACXVdsS+nafH0REt0UeHHcU+2hvozHF0oFX8r3sgcgNRqXk6w2K0mSgNu45L6GyLxzynez3TA3VlaZXZSTDjgykUYmy
 Y6kvED8kDPSCzLI9K7dGktKy6oEItx5THVlBXPKX8L/y35er9aKuChuUWGsVTweyUXsGEibtwPOdP+tG+jV9gn/Rzl0y1g1xp9w=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine:
  Type: Desktop System: ASUS product: N/A v: N/A serial: N/A
  Mobo: ASUSTeK model: PRIME B650M-A WIFI II v: Rev 1.xx
    serial: 221214156800233 UEFI: American Megatrends v: 1634 date: 
07/21/2023
CPU:
  Info: 16-core model: AMD Ryzen 9 7950X bits: 64 type: MT MCP cache:
    L2: 16 MiB
slipstream:/usr/src/linux-6.6.0-rc3 # grep 
CONFIG_SND_SOC_AMD_RPL_ACP6x=m .config
CONFIG_SND_SOC_AMD_RPL_ACP6x=m


This module never gets built, so only USB audio works.
# dmesg -T|grep snd
[Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Disabling MSI
[Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Handle 
vga_switcheroo audio client
[Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:0b:00.6: enabling device 
(0000 -> 0002)
[Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: bound 
0000:01:00.0 (ops nv50_audio_component_bind_ops [nouveau])
[Sun Sep 24 23:48:08 2023] usbcore: registered new interface driver 
snd-usb-audio
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: autoconfig 
for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: 
    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: 
    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    mono: 
mono_out=0x0
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: 
    dig-out=0x11/0x0
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    inputs:
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Front 
Mic=0x19
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Rear 
Mic=0x18
[Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: 
      Line=0x1a


# fuser -v /dev/snd/*
                     USER        PID ACCESS COMMAND
/dev/snd/controlC0:  lancelot   3738 F.... wireplumber
/dev/snd/controlC1:  lancelot   3738 F.... wireplumber
/dev/snd/controlC2:  lancelot   3738 F.... wireplumber
/dev/snd/pcmC0D0p:   lancelot   3737 F...m pipewire
/dev/snd/seq:        lancelot   3737 F.... pipewire

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

