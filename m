Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE675EF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGXJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:28:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB930F3;
        Mon, 24 Jul 2023 02:28:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so5881922a12.0;
        Mon, 24 Jul 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690190921; x=1690795721;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXYa9beqXqPUJg0PaBQLRhp11/xb4ixeXl57qzkLmb0=;
        b=UEv3Vo8GZkgCvLpu4wjOCdSKdL3A2ZO1v0mIAK1V0GaG3nWE52XumcH3seiwl8ZF3m
         uVnUJenSAXMuAY/fOOUtGhn9s17bgJPk8MYEw/VRl6Z54GNXAQY2OdZn0bUn/V6aBk6x
         ErEYYEIHb7lQ4c2fIHv0FZOwJ+K/ujkz5LU9IWp/33ypRAvInNWCeZ4RbAB7o6qwApP8
         MFF8RmbmTgkEDtW2dCR3Tx/QozcNrves565z3ALmhcPZzs/HEWLXLJQIZmcjyBaFDHbm
         NwUtuvZ/Ot9R5RIxUexZ5iWjFYLuYchvc4zdcDWoCZJzD/CWld3ewwim4SSo0SKusunE
         o73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190921; x=1690795721;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXYa9beqXqPUJg0PaBQLRhp11/xb4ixeXl57qzkLmb0=;
        b=QlDwtSnncXbsTlnyqrM4BQ0gUsBG0cdfn5CGAkhFYWezNjhyTy5ikc/gjcpJPNGjC6
         zw9QkUccEzW4y9MQqGxhQTxJVISKWr03BElxqBXk55l2nxPipBqBxTngRHjvs7i9kHQB
         ktkO2sIJsk0FhLAQ0pg+AWWvKzY9AwDA/4w4+1qf1mgaJEnAv/AdGLFrBeC95Sw3RSCX
         XikE3UgxgSntOeX1RWLniFa/HyvpxLqPybcDGIR+Lx1PkzF62B5hrK2ykuDAIRZmUFTQ
         awCb2J3EOnnZ3tpzxUMCYAa2GbeMcSKkVv08I/dV3+W/gFaWMZWa7vxUeOOEcSMzqlwH
         WJfQ==
X-Gm-Message-State: ABy/qLYxpZGAU7IbSyzRO7wkqW2xvfkCP1mbIVQsig7n9nfwo2cXXzfS
        xmDQIDob7kIEjnNYahAy1gdJmTXNmq8+fWwWmfPU6s5Dx+bv
X-Google-Smtp-Source: APBJJlHCOXiufGwPByxzwVf45ZF9XZBf56fiiQIdD6gG8+M8GbUKvVdTPWhVDxJOWp45y82GYSCV70YcK/+LeQCs7o8=
X-Received: by 2002:a17:906:3082:b0:99b:4aa3:6480 with SMTP id
 2-20020a170906308200b0099b4aa36480mr9663680ejv.40.1690190920481; Mon, 24 Jul
 2023 02:28:40 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Comolli <fabio.comolli@gmail.com>
Date:   Mon, 24 Jul 2023 11:28:04 +0200
Message-ID: <CAC8pb08OPQpekQak-cBin9U_Hv5KGE29=114GG9ug9PUd1z8Zg@mail.gmail.com>
Subject: Many BIOS Errors in dmesg output - no visible effects.
To:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a new (for me) laptop, on which I installed RHEL 9.2 - Every
kernel I tried (stock RHEL and latest stable compiled by the guys at
elrepo.org) show the messages below. Please let me know if you need
more details or if you have boot options I can try.

Thanks,
Fabio

PS. Please CC: me as i'm not subscribed, thank you.

------------------------------------------------

[fcomolli@jepssen][11:15] ~ $ uname -a
Linux jepssen.rhel.local 6.4.5-1.el9.elrepo.x86_64 #1 SMP
PREEMPT_DYNAMIC Sun Jul 23 13:53:28 EDT 2023 x86_64 x86_64 x86_64
GNU/Linux
[fcomolli@jepssen][11:16] ~ $

[fcomolli@jepssen][11:05] ~ $  dmesg|grep 'ACPI.*Error'
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS07._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS03._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS04._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.PC00.LPCB.HEC.PLMX], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method \_TZ.TZ00._TMP
due to previous error (AE_NOT_FOUND) (20230331/psparse-529)
[lun lug 24 10:43:54 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.PC00.LPCB.HEC.PLMX], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:54 2023] ACPI Error: Aborting method \_TZ.TZ00._TMP
due to previous error (AE_NOT_FOUND) (20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS03._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS03._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS04._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.TXHC.RHUB.SS04._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS01._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS02._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS07._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS07._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS05._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:55 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:55 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS06._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:56 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:56 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS07._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)
[lun lug 24 10:43:56 2023] ACPI BIOS Error (bug): Could not resolve
symbol [\_SB.UBTC.RUCC], AE_NOT_FOUND (20230331/psargs-330)
[lun lug 24 10:43:56 2023] ACPI Error: Aborting method
\_SB.PC00.XHCI.RHUB.HS07._PLD due to previous error (AE_NOT_FOUND)
(20230331/psparse-529)

[fcomolli@jepssen][11:11] ~ $ sudo dmidecode -t bios
# dmidecode 3.3
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
Vendor: American Megatrends International, LLC.
Version: 100E
Release Date: 07/19/2022
Address: 0xF0000
Runtime Size: 64 kB
ROM Size: 0 MB
Characteristics:
PCI is supported
BIOS is upgradeable
BIOS shadowing is allowed
Boot from CD is supported
Selectable boot is supported
BIOS ROM is socketed
EDD is supported
ACPI is supported
BIOS boot specification is supported
Targeted content distribution is supported
UEFI is supported
BIOS Revision: 5.19

Handle 0x0017, DMI type 13, 22 bytes
BIOS Language Information
Language Description Format: Long
Installable Languages: 1
en|US|iso8859-1
Currently Installed Language: en|US|iso8859-1

Handle 0x0061, DMI type 13, 22 bytes
BIOS Language Information
Language Description Format: Abbreviated
Installable Languages: 1
enUS
Currently Installed Language: enUS

[fcomolli@jepssen][11:15] ~ $

[fcomolli@jepssen][11:27] ~ $ sudo dmidecode -t system
# dmidecode 3.3
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
Manufacturer: Intel
Product Name: TU45B
Version: Default string
Serial Number: Default string
UUID: 03000200-0400-0500-0006-000700080009
Wake-up Type: Power Switch
SKU Number: Default string
Family: Default string

Handle 0x0016, DMI type 12, 5 bytes
System Configuration Options
Option 1: Default string
Option 2: <BAD INDEX>

Handle 0x0033, DMI type 32, 11 bytes
System Boot Information
Status: No errors detected

Handle 0x0060, DMI type 32, 11 bytes
System Boot Information
Status: No errors detected

[fcomolli@jepssen][11:27] ~ $
