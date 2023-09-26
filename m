Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B867AE372
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjIZBss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIZBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:48:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67110A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=6n/iVOHu7K4pJh0jvc9g+3qkLyem9PzZiGB1CU+MKUU=; b=b32WnrOZG8VfQlbz85g2/Hjkji
        RRkM16Uxxtse/ljXQFgq5fUJWzl2QKxkeSNbvSwcFZiZD6I6NWjyIvJwfx/6sPy2NXUWJd1zPO5q6
        +MRTKPvnOM2iL+1mJZ8de6hLQSYR9gZT/qCjHIOh7BxX/FEkv2L2LWnU3zooz6WxcxrEphDaKsZWH
        Nvq/vdbpgkvFQLW2qcPb1dhyBOEUtf/5nAg1VzsgycK9qglUvi8fGtZM7pc+lSLI3MRB74voTs8Ul
        yG3iziYUyx+1cnf1nh0VdbTvVXvqv5QmP27ipMt9MCLBVNwlrdrui04LQM6eYaaBl3uNoINqh5aJw
        RONMxs7g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkxBo-00FN17-1L;
        Tue, 26 Sep 2023 01:48:40 +0000
Message-ID: <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
Date:   Mon, 25 Sep 2023 18:48:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ryzen 9 7950x sound module does not not build
To:     sboyce@blueyonder.co.uk,
        LKML Mailing List <linux-kernel@vger.kernel.org>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/25/23 18:20, Sid Boyce wrote:
> Machine:
>  Type: Desktop System: ASUS product: N/A v: N/A serial: N/A
>  Mobo: ASUSTeK model: PRIME B650M-A WIFI II v: Rev 1.xx
>    serial: 221214156800233 UEFI: American Megatrends v: 1634 date: 07/21/2023
> CPU:
>  Info: 16-core model: AMD Ryzen 9 7950X bits: 64 type: MT MCP cache:
>    L2: 16 MiB
> slipstream:/usr/src/linux-6.6.0-rc3 # grep CONFIG_SND_SOC_AMD_RPL_ACP6x=m .config
> CONFIG_SND_SOC_AMD_RPL_ACP6x=m
> 
> 
> This module never gets built, so only USB audio works.
> # dmesg -T|grep snd
> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Disabling MSI
> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:0b:00.6: enabling device (0000 -> 0002)
> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops nv50_audio_component_bind_ops [nouveau])
> [Sun Sep 24 23:48:08 2023] usbcore: registered new interface driver snd-usb-audio
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    dig-out=0x11/0x0
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    inputs:
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Front Mic=0x19
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Rear Mic=0x18
> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Line=0x1a
> 
> 
> # fuser -v /dev/snd/*
>                     USER        PID ACCESS COMMAND
> /dev/snd/controlC0:  lancelot   3738 F.... wireplumber
> /dev/snd/controlC1:  lancelot   3738 F.... wireplumber
> /dev/snd/controlC2:  lancelot   3738 F.... wireplumber
> /dev/snd/pcmC0D0p:   lancelot   3737 F...m pipewire
> /dev/snd/seq:        lancelot   3737 F.... pipewire
> 
> Regards
> 
> Sid.

It builds for me:

  CC [M]  sound/soc/amd/rpl/rpl-pci-acp6x.o
  LD [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.o
  CC [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.mod.o
  LD [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko

and the object file subdirectory contains:

-rw-r--r-- 1 rdunlap rdunlap    34 Sep 25 18:37 snd-rpl-pci-acp6x.mod
-rw-r--r-- 1 rdunlap rdunlap  9360 Sep 25 18:37 rpl-pci-acp6x.o
-rw-r--r-- 1 rdunlap rdunlap  9616 Sep 25 18:37 snd-rpl-pci-acp6x.o
-rw-r--r-- 1 rdunlap rdunlap    38 Sep 25 18:37 modules.order
-rw-r--r-- 1 rdunlap rdunlap   777 Sep 25 18:38 snd-rpl-pci-acp6x.mod.c
-rw-r--r-- 1 rdunlap rdunlap  3104 Sep 25 18:38 snd-rpl-pci-acp6x.mod.o
-rw-r--r-- 1 rdunlap rdunlap 11816 Sep 25 18:38 snd-rpl-pci-acp6x.ko


You might need to post your failing .config file.

-- 
~Randy
