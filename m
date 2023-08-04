Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094976FCAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHDI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHDI4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:56:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8672A5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:52:17 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3ADF8417B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691139087;
        bh=eL6i0Yu5+1fsSYGO31dwN5PPO4JP08FAk+2HzglPKyo=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DF9QF5NGvAgJ3/pXodT38basuq9z5rGKxTdwToRH3VraIYHmImfNzE12tpOK9s+Td
         TxMo+gOCQjf3uK/vg0c+Iumbf4GPjGKgnowPqUiGRC6CxobYKnJtTb6j/32lxQzHNf
         M2Lr4FntHuoHq64EyVsdlDHrG/xrsimW7bW+5uV5K7ItFHdtVUTIlR27eWc/2alT36
         CrMIpD59WhxPxSq6iH7hO+WdF7mdOuuJ4AVjSFQA2As+gCf6B3JjAW8XQZ7TDM2zMx
         m6DoLWGB6Wht3w5QozeJvuimiLxiPnMjaNyvi/Svx9HF5viWUbyJ2ZE/KxuDvSPxeA
         RmmfhBT03CWdA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a348facbbso128120266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139087; x=1691743887;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL6i0Yu5+1fsSYGO31dwN5PPO4JP08FAk+2HzglPKyo=;
        b=YmcgO1f5VQAorPtZ2qhMMWEVVLYvA+bgumxtX1gMjOmJX4sutpd60qLXiJ1swkt9Ie
         7IQNbzh8TJMY7f+ko0FXVPKY4NOCvIe27r/+g29zJC3+1O86kc9YQmJzhX4s63o/AEvb
         mz7CS0xxYQq1vFazmRRNC3QPlvuhYvMGPSGDtsiufUgcBYbLi/1i5psreM155ptQclJ7
         iLeThd33x6o4LcR+9z7uUoTUwutzwGgREnArvzgLioAKzaszvAfPiX+Q376QamfcS8pK
         jN0FdWaKRFof9BchrBLeddBrepaW8wIdc1lcMpt+P/ubIHHyEzpQGxpBy6RP2EUeQpc0
         AYbA==
X-Gm-Message-State: AOJu0YwLdUtbni4RGkSoMPy4Kj9HROiIIJMYkfleg+ShMXq7D1b5JYRJ
        JGKsMQ+aLiwz4va9b8o0DQ4iuYf0uCZQohDbOwxDC482bZcqjpcVLLLDLAgAASjjEjSY6ay+7UZ
        E/zIGIyLQv7uL0rIAR5Ti0s1uBoWotLEcp19pISB7Bg==
X-Received: by 2002:a17:906:1001:b0:993:6845:89d6 with SMTP id 1-20020a170906100100b00993684589d6mr950859ejm.47.1691139086894;
        Fri, 04 Aug 2023 01:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMigO0tUwnLUCyMtfQdXJjplH0jLwi32gS4ulT6fONjcEZoRtAV2+9V6vqhthv6m0bXFf+bw==
X-Received: by 2002:a17:906:1001:b0:993:6845:89d6 with SMTP id 1-20020a170906100100b00993684589d6mr950835ejm.47.1691139086314;
        Fri, 04 Aug 2023 01:51:26 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id re15-20020a170906d8cf00b009886aaeb722sm995777ejb.137.2023.08.04.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:51:25 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:51:22 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     <max.chou@realtek.com>
Cc:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <hildawu@realtek.com>, <karenhsu@realtek.com>,
        <kidman@realtek.com>, <vicamo.yang@canonical.com>,
        <Riley.Kao@dell.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Message-ID: <20230804105122.6f41882c@gollum>
In-Reply-To: <20230804055426.6806-1-max.chou@realtek.com>
References: <20230804055426.6806-1-max.chou@realtek.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EhUKuQ0ogF1H9Urt_kBNSs6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EhUKuQ0ogF1H9Urt_kBNSs6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thanks for this Max,

Comments inlined.


> From: Max Chou <max.chou@realtek.com>
>=20
> In the commit of linux-firmware project, rtl8852cu_fw.bin is updated as
> FW v2 format[1]. Consider the case that if driver did not be updated for
> FW v2 supported[2], it can not use FW v2.
> By Canonical's suggestion, older driver should be able to load FW v1,
> so rtl8852cu_fw.bin will be revert to the previous commit as FW v1 and
> add rtl8852cu_fw_v2.bin as FW v2. This item will be started on
> linux-firmware project.
>=20
> In this commit, the driver prefers to load FW v2 if available. Fallback to
> FW v1 otherwise.
>=20
> To do on linux-firmware project.
> rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF)
> rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained)
>=20
> [1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
> [2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>     to 0x040D_7225")'
>=20
> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 68 +++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index ddae6524106d..8bfa86dd12f7 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -104,7 +104,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D false,
> -	  .fw_name =3D "rtl_bt/rtl8723a_fw.bin",
> +	  .fw_name =3D "rtl_bt/rtl8723a_fw",
>  	  .cfg_name =3D NULL,
>  	  .hw_info =3D "rtl8723au" },
> =20
> @@ -112,7 +112,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723bs_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723bs_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723bs_config",
>  	  .hw_info  =3D "rtl8723bs" },
> =20
> @@ -120,7 +120,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723b_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723b_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723b_config",
>  	  .hw_info  =3D "rtl8723bu" },
> =20
> @@ -132,7 +132,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .hci_bus =3D HCI_UART,
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723cs_cg_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723cs_cg_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723cs_cg_config",
>  	  .hw_info  =3D "rtl8723cs-cg" },
> =20
> @@ -144,7 +144,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .hci_bus =3D HCI_UART,
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723cs_vf_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723cs_vf_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723cs_vf_config",
>  	  .hw_info  =3D "rtl8723cs-vf" },
> =20
> @@ -156,7 +156,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .hci_bus =3D HCI_UART,
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723cs_xx_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723cs_xx_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723cs_xx_config",
>  	  .hw_info  =3D "rtl8723cs" },
> =20
> @@ -164,7 +164,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723d_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723d_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723d_config",
>  	  .hw_info  =3D "rtl8723du" },
> =20
> @@ -172,7 +172,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8723ds_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8723ds_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8723ds_config",
>  	  .hw_info  =3D "rtl8723ds" },
> =20
> @@ -180,7 +180,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8821a_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8821a_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8821a_config",
>  	  .hw_info  =3D "rtl8821au" },
> =20
> @@ -189,7 +189,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8821c_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8821c_config",
>  	  .hw_info  =3D "rtl8821cu" },
> =20
> @@ -198,7 +198,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8821cs_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8821cs_config",
>  	  .hw_info  =3D "rtl8821cs" },
> =20
> @@ -206,7 +206,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8761a_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8761a_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8761a_config",
>  	  .hw_info  =3D "rtl8761au" },
> =20
> @@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8761b_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8761b_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8761b_config",
>  	  .hw_info  =3D "rtl8761btv" },
> =20
> @@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] =3D {
>  	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8761bu_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8761bu_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8761bu_config",
>  	  .hw_info  =3D "rtl8761bu" },
> =20
> @@ -232,7 +232,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8822cs_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8822cs_config",
>  	  .hw_info  =3D "rtl8822cs" },
> =20
> @@ -241,7 +241,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8822cs_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8822cs_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8822cs_config",
>  	  .hw_info  =3D "rtl8822cs" },
> =20
> @@ -250,7 +250,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8822cu_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8822cu_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8822cu_config",
>  	  .hw_info  =3D "rtl8822cu" },
> =20
> @@ -259,7 +259,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8822b_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8822b_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8822b_config",
>  	  .hw_info  =3D "rtl8822bu" },
> =20
> @@ -268,7 +268,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8852au_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8852au_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8852au_config",
>  	  .hw_info  =3D "rtl8852au" },
> =20
> @@ -277,7 +277,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D true,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8852bs_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8852bs_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8852bs_config",
>  	  .hw_info  =3D "rtl8852bs" },
> =20
> @@ -286,7 +286,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8852bu_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8852bu_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8852bu_config",
>  	  .hw_info  =3D "rtl8852bu" },
> =20
> @@ -295,7 +295,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D true,
> -	  .fw_name  =3D "rtl_bt/rtl8852cu_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8852cu_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8852cu_config",
>  	  .hw_info  =3D "rtl8852cu" },
> =20
> @@ -304,7 +304,7 @@ static const struct id_table ic_id_table[] =3D {
>  	  .config_needed =3D false,
>  	  .has_rom_version =3D true,
>  	  .has_msft_ext =3D false,
> -	  .fw_name  =3D "rtl_bt/rtl8851bu_fw.bin",
> +	  .fw_name  =3D "rtl_bt/rtl8851bu_fw",
>  	  .cfg_name =3D "rtl_bt/rtl8851bu_config",
>  	  .hw_info  =3D "rtl8851bu" },
>  	};
> @@ -1045,10 +1045,12 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev,
>  	struct sk_buff *skb;
>  	struct hci_rp_read_local_version *resp;
>  	struct hci_command_hdr *cmd;
> +	char fw_name[40];
>  	char cfg_name[40];
>  	u16 hci_rev, lmp_subver;
>  	u8 hci_ver, lmp_ver, chip_type =3D 0;
>  	int ret;
> +	int fw_load_retry =3D 0;
>  	u8 reg_val[2];
> =20
>  	btrtl_dev =3D kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> @@ -1154,9 +1156,26 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>  			goto err_free;
>  	}
> =20
> -	btrtl_dev->fw_len =3D rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
> +fw_name_load:
> +	if (btrtl_dev->ic_info->fw_name) {
> +		if (lmp_subver =3D=3D RTL_ROM_LMP_8852A && hci_rev =3D=3D 0x000c &&
> +				  fw_load_retry =3D=3D 0) {
> +			fw_load_retry =3D 1;
> +			snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
> +				 btrtl_dev->ic_info->fw_name);
> +		} else {
> +			fw_load_retry =3D 0;
> +			snprintf(fw_name, sizeof(fw_name), "%s.bin",
> +				 btrtl_dev->ic_info->fw_name);
> +		}
> +		btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
>  					  &btrtl_dev->fw_data);
> +	}
> +
>  	if (btrtl_dev->fw_len < 0) {
> +		if (fw_load_retry =3D=3D 1)
> +			goto fw_name_load;
> +
>  		rtl_dev_err(hdev, "firmware file %s not found",
>  			    btrtl_dev->ic_info->fw_name);
>  		ret =3D btrtl_dev->fw_len;

This makes my head hurt ;-) Can we make this more readable, something like
(untested):

@@ -1154,8 +1155,26 @@ struct btrtl_device_info *btrtl_initialize(struct hc=
i_dev *hdev,
                        goto err_free;
        }
=20
-       btrtl_dev->fw_len =3D rtl_load_file(hdev, btrtl_dev->ic_info->fw_na=
me,
-                                         &btrtl_dev->fw_data);
+       if (!btrtl_dev->ic_info->fw_name) {
+               ret =3D -ENOMEM;
+               goto err_free;
+       }
+
+       btrtl_dev->fw_len =3D -EIO;
+       if (lmp_subver =3D=3D RTL_ROM_LMP_8852A && hci_rev =3D=3D 0x000c) {
+               snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
+                        btrtl_dev->ic_info->fw_name);
+               btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
+                                                 &btrtl_dev->fw_data);
+       }
+
+       if (btrtl_dev->fw_len < 0) {
+               snprintf(fw_name, sizeof(fw_name), "%s.bin",
+                        btrtl_dev->ic_info->fw_name);
+               btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
+                                                 &btrtl_dev->fw_data);
+       }
+
        if (btrtl_dev->fw_len < 0) {
                rtl_dev_err(hdev, "firmware file %s not found",
                            btrtl_dev->ic_info->fw_name);


...Juerg


> @@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");


--Sig_/EhUKuQ0ogF1H9Urt_kBNSs6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmTMvAoACgkQD9OLCQum
Qrd5OBAAgFwuya6641qIQn5XRm2hqJUUCJ2XIpwOeBTS32Q68B5UEs243c2ovqOd
EnmsAl0PcsPhdBWQfbmtFhthNZHLAhZsWcIWY+q8LDNukma66LicUvimZtR0zPFx
TByazSswOFwEnSZr44bBlnhFdfbYsjQuewhVllzGV5/W+DYeQK/D7Dsb9Dj8PWoH
3QQ4alLnV1wKX9d+swnKVwXroN8RWi0BQMb8DBkyD667jPO8l1jinEXdCMXLCb5I
B1xGx6O6kb8IrMmyXEB+56Lo8FyLIOLw5S1jjNsW1uV39ISLPEzS7o9qg8ACPCM8
Bp1H7Nq2I6mWT5P5nOZY8XqawIEK8G3Y+ZOZWpBUJTM9tSWYOZ7ZWjUuqXzCk6ow
bUWAF20xLOwLytJ52ovM+HP05hPg2JC0bVBSyeMcQp1+qaVbRgCi9Vi7/hWkup4Q
dwUxcCEesIhjQTA1SxbVlRj/Fx02sQblJtIEFjJZISEXHqLuk7OLKXCVmPeA/8+g
+LW84tUC3ZIYRRS849/3XN0MGh1CAuc1rhv8EiyqrlSbRDmDJmPUvBiQAurndqJ+
zwmrDvZU0/VrxoNCL/Cxv0L2OeJzTyeAqswcMQ0S5Kow6E9coNi31EOeCUEMuwsB
XzMr8eQCyY4BJNTtKiLzkUCtyxWj8qBo/y2EyJJ63+2I4DCogZU=
=nmUV
-----END PGP SIGNATURE-----

--Sig_/EhUKuQ0ogF1H9Urt_kBNSs6--
