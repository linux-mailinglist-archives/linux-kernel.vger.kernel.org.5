Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807C576FD10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHDJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHDJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:16:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D75FD9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:14:19 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 74EFA417BA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691140458;
        bh=8rGo3k1kC3SG0JlA6B0FcgRpR27Y/ljgOCgJUJB3eww=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hhUeh7pifFKY4s1sD6lpLbpZx1kiCMa/ty3cTXBE8bTLW1Vu31Nmd4pnfQx2kFylS
         OF1HFlFge91yJ7afRH4+GVFPIdwok7Gb/MPE0Ng6siBJqf0BHdWLXee2d2ZPy0kU51
         AOOdY2iUipHM7PRmQ20AaWx2WI7MyKKjTu90W5bx8Z1y29V9UO0Y90eEGcDWU6g7Pz
         b6lLKcNbxcMlL4dPXjbppw57BNixPwI8BKQJxBh+ffw3gA/N0/lJxBeK5EUSS2sK+1
         M62f9kRb5QYQ4pMFWrGaWjT10gjkxw1RuEH3M/aAcBq551JU2f6qC/prXNekk5CLYg
         tfHJGjgyQS04w==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so1454847a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140458; x=1691745258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rGo3k1kC3SG0JlA6B0FcgRpR27Y/ljgOCgJUJB3eww=;
        b=QNegTF17/PftKoF1SUqKK0+UgsZ/vYeV6wG6E8CeVq8wEY74N9AIwabmImgfYWecIO
         2aJBFjC3YViU0IEZ6KKIWWdARbfTtaiUjcMwaeAPASC8O41vvSqMZY1Q2qKSu3sq2ITB
         JEYAFFtWJKAwiCr86Y2u6mtfuW5tZso5T/xlm+tTCtiS5yCTV5SGVd0oJ1igV1GiPfxi
         rz+iMth1t9P+iShKwwctzXMFA4q1+Q4U92QVRGVi+ZkCpUzDvVxcFb8rXTzzREIR93F5
         haIsJrkv6lj3+fb/WsCPhCOuWTqJM+5cHJFX4TDIYDvZnT953qzdbG9+Tw1Av7m4tBoG
         MgeQ==
X-Gm-Message-State: AOJu0YzUArNkYWTKmsvHNugiBrPo7XA9tntX0kdH3LHVDdG5aGvYrQMl
        69bhHmAGOd+nH/abn6cMZ5tooqmGTcggInezgbuKnk/pkelWKDLbAsQL1Uk0YjlkVNJlNzG2h+x
        CRBj4XDFTeUg0J9ZohhQpTltKAt8UlOpyOENeWTlCeQgkNlNv5fbeNr+rRQ==
X-Received: by 2002:a05:6402:74f:b0:522:560d:d691 with SMTP id p15-20020a056402074f00b00522560dd691mr1009165edy.25.1691140457904;
        Fri, 04 Aug 2023 02:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqku7xSzPYmc5dC7/kOwNHWqg5sQE1nZEda6zjwqOZ6nmwhGbUJMA/VGl5mwPLtTMMPEMKKT/ny4Xz8neyyQg=
X-Received: by 2002:a05:6402:74f:b0:522:560d:d691 with SMTP id
 p15-20020a056402074f00b00522560dd691mr1009144edy.25.1691140457462; Fri, 04
 Aug 2023 02:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230804055426.6806-1-max.chou@realtek.com>
In-Reply-To: <20230804055426.6806-1-max.chou@realtek.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Fri, 4 Aug 2023 17:14:05 +0800
Message-ID: <CA+rHWAJuO0D3Km+cuyG2FQX45N=q546iVF6n78RV60onqOBKsA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
To:     max.chou@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com, juerg.haefliger@canonical.com,
        Riley.Kao@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, what will you do to linux-firmware commit 53e48f93f
("rtl_bt: Add firmware and config files for RTL8851B")? It is also a
V2 firmware. If it's not subjected to the rename here, there will be
some V2 firmware blobs with V1 names, which may add some more troubles
in the future.

$ hexdump -C rtl_bt/rtl8851bu_fw.bin | head -n1
00000000  52 54 42 54 43 6f 72 65  41 b0 34 01 44 ba 01 00  |RTBTCoreA.4.D.=
..|

On Fri, Aug 4, 2023 at 1:54=E2=80=AFPM <max.chou@realtek.com> wrote:
>
> From: Max Chou <max.chou@realtek.com>
>
> In the commit of linux-firmware project, rtl8852cu_fw.bin is updated as
> FW v2 format[1]. Consider the case that if driver did not be updated for
> FW v2 supported[2], it can not use FW v2.
> By Canonical's suggestion, older driver should be able to load FW v1,
> so rtl8852cu_fw.bin will be revert to the previous commit as FW v1 and
> add rtl8852cu_fw_v2.bin as FW v2. This item will be started on
> linux-firmware project.
>
> In this commit, the driver prefers to load FW v2 if available. Fallback t=
o
> FW v1 otherwise.
>
> To do on linux-firmware project.
> rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF)
> rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained)
>
> [1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
> [2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>     to 0x040D_7225")'
>
> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 68 +++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index ddae6524106d..8bfa86dd12f7 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -104,7 +104,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D false,
> -         .fw_name =3D "rtl_bt/rtl8723a_fw.bin",
> +         .fw_name =3D "rtl_bt/rtl8723a_fw",
>           .cfg_name =3D NULL,
>           .hw_info =3D "rtl8723au" },
>
> @@ -112,7 +112,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723bs_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723bs_fw",
>           .cfg_name =3D "rtl_bt/rtl8723bs_config",
>           .hw_info  =3D "rtl8723bs" },
>
> @@ -120,7 +120,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723b_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723b_fw",
>           .cfg_name =3D "rtl_bt/rtl8723b_config",
>           .hw_info  =3D "rtl8723bu" },
>
> @@ -132,7 +132,7 @@ static const struct id_table ic_id_table[] =3D {
>           .hci_bus =3D HCI_UART,
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723cs_cg_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723cs_cg_fw",
>           .cfg_name =3D "rtl_bt/rtl8723cs_cg_config",
>           .hw_info  =3D "rtl8723cs-cg" },
>
> @@ -144,7 +144,7 @@ static const struct id_table ic_id_table[] =3D {
>           .hci_bus =3D HCI_UART,
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723cs_vf_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723cs_vf_fw",
>           .cfg_name =3D "rtl_bt/rtl8723cs_vf_config",
>           .hw_info  =3D "rtl8723cs-vf" },
>
> @@ -156,7 +156,7 @@ static const struct id_table ic_id_table[] =3D {
>           .hci_bus =3D HCI_UART,
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723cs_xx_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723cs_xx_fw",
>           .cfg_name =3D "rtl_bt/rtl8723cs_xx_config",
>           .hw_info  =3D "rtl8723cs" },
>
> @@ -164,7 +164,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723d_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723d_fw",
>           .cfg_name =3D "rtl_bt/rtl8723d_config",
>           .hw_info  =3D "rtl8723du" },
>
> @@ -172,7 +172,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
>           .config_needed =3D true,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8723ds_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8723ds_fw",
>           .cfg_name =3D "rtl_bt/rtl8723ds_config",
>           .hw_info  =3D "rtl8723ds" },
>
> @@ -180,7 +180,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8821a_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8821a_fw",
>           .cfg_name =3D "rtl_bt/rtl8821a_config",
>           .hw_info  =3D "rtl8821au" },
>
> @@ -189,7 +189,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8821c_fw",
>           .cfg_name =3D "rtl_bt/rtl8821c_config",
>           .hw_info  =3D "rtl8821cu" },
>
> @@ -198,7 +198,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8821cs_fw",
>           .cfg_name =3D "rtl_bt/rtl8821cs_config",
>           .hw_info  =3D "rtl8821cs" },
>
> @@ -206,7 +206,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8761a_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8761a_fw",
>           .cfg_name =3D "rtl_bt/rtl8761a_config",
>           .hw_info  =3D "rtl8761au" },
>
> @@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8761b_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8761b_fw",
>           .cfg_name =3D "rtl_bt/rtl8761b_config",
>           .hw_info  =3D "rtl8761btv" },
>
> @@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] =3D {
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
>           .config_needed =3D false,
>           .has_rom_version =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8761bu_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8761bu_fw",
>           .cfg_name =3D "rtl_bt/rtl8761bu_config",
>           .hw_info  =3D "rtl8761bu" },
>
> @@ -232,7 +232,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8822cs_fw",
>           .cfg_name =3D "rtl_bt/rtl8822cs_config",
>           .hw_info  =3D "rtl8822cs" },
>
> @@ -241,7 +241,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8822cs_fw",
>           .cfg_name =3D "rtl_bt/rtl8822cs_config",
>           .hw_info  =3D "rtl8822cs" },
>
> @@ -250,7 +250,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8822cu_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8822cu_fw",
>           .cfg_name =3D "rtl_bt/rtl8822cu_config",
>           .hw_info  =3D "rtl8822cu" },
>
> @@ -259,7 +259,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8822b_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8822b_fw",
>           .cfg_name =3D "rtl_bt/rtl8822b_config",
>           .hw_info  =3D "rtl8822bu" },
>
> @@ -268,7 +268,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8852au_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8852au_fw",
>           .cfg_name =3D "rtl_bt/rtl8852au_config",
>           .hw_info  =3D "rtl8852au" },
>
> @@ -277,7 +277,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D true,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8852bs_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8852bs_fw",
>           .cfg_name =3D "rtl_bt/rtl8852bs_config",
>           .hw_info  =3D "rtl8852bs" },
>
> @@ -286,7 +286,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8852bu_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8852bu_fw",
>           .cfg_name =3D "rtl_bt/rtl8852bu_config",
>           .hw_info  =3D "rtl8852bu" },
>
> @@ -295,7 +295,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D true,
> -         .fw_name  =3D "rtl_bt/rtl8852cu_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8852cu_fw",
>           .cfg_name =3D "rtl_bt/rtl8852cu_config",
>           .hw_info  =3D "rtl8852cu" },
>
> @@ -304,7 +304,7 @@ static const struct id_table ic_id_table[] =3D {
>           .config_needed =3D false,
>           .has_rom_version =3D true,
>           .has_msft_ext =3D false,
> -         .fw_name  =3D "rtl_bt/rtl8851bu_fw.bin",
> +         .fw_name  =3D "rtl_bt/rtl8851bu_fw",
>           .cfg_name =3D "rtl_bt/rtl8851bu_config",
>           .hw_info  =3D "rtl8851bu" },
>         };
> @@ -1045,10 +1045,12 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev,
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *resp;
>         struct hci_command_hdr *cmd;
> +       char fw_name[40];
>         char cfg_name[40];
>         u16 hci_rev, lmp_subver;
>         u8 hci_ver, lmp_ver, chip_type =3D 0;
>         int ret;
> +       int fw_load_retry =3D 0;
>         u8 reg_val[2];
>
>         btrtl_dev =3D kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> @@ -1154,9 +1156,26 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>                         goto err_free;
>         }
>
> -       btrtl_dev->fw_len =3D rtl_load_file(hdev, btrtl_dev->ic_info->fw_=
name,
> +fw_name_load:
> +       if (btrtl_dev->ic_info->fw_name) {
> +               if (lmp_subver =3D=3D RTL_ROM_LMP_8852A && hci_rev =3D=3D=
 0x000c &&
> +                                 fw_load_retry =3D=3D 0) {
> +                       fw_load_retry =3D 1;
> +                       snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
> +                                btrtl_dev->ic_info->fw_name);
> +               } else {
> +                       fw_load_retry =3D 0;
> +                       snprintf(fw_name, sizeof(fw_name), "%s.bin",
> +                                btrtl_dev->ic_info->fw_name);
> +               }
> +               btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
>                                           &btrtl_dev->fw_data);
> +       }
> +
>         if (btrtl_dev->fw_len < 0) {
> +               if (fw_load_retry =3D=3D 1)
> +                       goto fw_name_load;
> +
>                 rtl_dev_err(hdev, "firmware file %s not found",
>                             btrtl_dev->ic_info->fw_name);
>                 ret =3D btrtl_dev->fw_len;
> @@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
> --
> 2.34.1
>


--=20
Regards,
You-Sheng Yang
