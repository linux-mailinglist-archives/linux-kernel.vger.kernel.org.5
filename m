Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129AF771DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjHGKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHGKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:06:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDD134
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:06:38 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA17C413C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691402796;
        bh=tiBd4FV24pTIyw+lEOPD46vPQPAgrmVT10F9gyKM1yo=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=VACVweLbaLO7r+GLA8JnBlZbVKnVtEdaBF8djECwDDZHoT5jGwPzkBaPeMpjcMeDj
         U6qcf9J7U0L+CsP9bYCmhOJ7xjoStQ5KeXp1HNIT4obBQ2AtgID2sIFfYaq56pG118
         f39R6d1+RnyRmdgZXCLvQN6R5Vc2oKRhxe5qbkEXVyQNfO1s2ATV2VqQs/RQCYO1//
         E7diYmThwvcPUxZJt4F7dDuPaZhZeKbRqIkVvTtRqotULP6RGqZAdqwuMDBYkMSoPh
         7TS+hU+ai4XdFy3ch/r4Db8J/slCj/bKSt5i482Z8pZ9Eb3S75S/hkuizAox0zxWuC
         GT9ot+Cv+PL1A==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9dc1bfdd2so45437741fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402793; x=1692007593;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiBd4FV24pTIyw+lEOPD46vPQPAgrmVT10F9gyKM1yo=;
        b=PCOxv0XZS4N9+p9XfjQQ+sVi8z/NmIBNVo740VY5eA78F1RvAk9poOfpJt2/m8p9hX
         SyytUhI+8DXGC9mK9uxwkDSqfXthTD6q1ylj9LZKzES6MCKvSy7jI1MIj2hW3ljLKuMK
         XbQkploaoAlKjZP75BMaCnkQW/P8uTGXPEQdpCUCU/l9atnkBF9+xsNbTh59gFlpqj4p
         9zUn46RhYIAZmki35azF/2OmwArF927w7Sa3NOgoXmmOm9vDzEeXQP7Qe0a2dEeIHCsL
         im3N+U5BGUGeGslinhI44bKmOOw+NPwj/bdw7lNzakrIB3hYs+TreOAk/lJwGYKRI3Ek
         0AAQ==
X-Gm-Message-State: AOJu0YztZH8/p80/dBlCfR5i0DxVtHcHcHWLV97GwYpw8GpGiZpNxr0O
        j6smqiv+sK72tFm8R77Kj31JTTKLK9xGIZC3ttZXjDVpx38swvjmoQnGMdZnSXECX5LRIaFdIzU
        Bz8NuB+GBytcVJIOoGajv1bdsNTD/L3ctN9j9nC1mYQ==
X-Received: by 2002:a05:651c:1030:b0:2b9:e230:25ce with SMTP id w16-20020a05651c103000b002b9e23025cemr5820415ljm.12.1691402793573;
        Mon, 07 Aug 2023 03:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JrQw6Apt/haUT8sfawDGDhXFni9hmPq0KuqW+fbQkSnP6PkyiajBrVGgi+QU0zeG/z7Chw==
X-Received: by 2002:a05:651c:1030:b0:2b9:e230:25ce with SMTP id w16-20020a05651c103000b002b9e23025cemr5820397ljm.12.1691402793109;
        Mon, 07 Aug 2023 03:06:33 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003fbb06af219sm10197710wme.32.2023.08.07.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:06:32 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:06:30 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     <max.chou@realtek.com>
Cc:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <hildawu@realtek.com>, <karenhsu@realtek.com>,
        <kidman@realtek.com>, <vicamo.yang@canonical.com>,
        <Riley.Kao@dell.com>, <stable@vger.kernel.org>,
        <jwboyer@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Message-ID: <20230807120630.79b9e933@smeagol>
In-Reply-To: <20230807014415.12358-1-max.chou@realtek.com>
References: <20230807014415.12358-1-max.chou@realtek.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ycLv.MY4m=zxGSdbwkiRmra";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ycLv.MY4m=zxGSdbwkiRmra
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Aug 2023 09:44:15 +0800
<max.chou@realtek.com> wrote:

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
> Note that the driver has supported to extract the data for v1 and v2
> since the commit[1].
> The previous FW format of RTL8852C is v1. After the commit[2], the FW
> format was changed to v2. Only RTL8852C suffered the different FW formats,
> so we will use rtl8852cu_fw.bin for the original commit as FW v1 and
> rtl8852cu_fw_v2.bin for the future maintained as FW v2. Other Realtek
> chips will not been impacted by this patch.
>=20
> To do on linux-firmware project after this commit.
> 1. revert '55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>    to 0x040D_7225")'
>    =3D> rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF) =20
> 2. Add a new commit for rtl8852cu_fw_v2.bin
>    =3D>rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained) =20
>=20
> Reference:
> [1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
> [2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>     to 0x040D_7225")'

IMO this commit message is too confusing. I don't think you need nor should
refer to linux-firmware commits and what happened in that repo. This commit
simply fixes the v2 support by trying to load a v2 file for certain chips
with a fall-back if fw is not found (or failed to load). That's all that
needs to be mentioned in the commit message.

> Fixes: '9a24ce5e29b ("Bluetooth: btrtl: Firmware format v2 support")'

No '' quotes.

...Juerg


> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
>=20
> ---
> Changes in v2:
> - Fix commit log for CheckPatch FAIL
>=20
> Changes in v2:
> - Tuning the code for more readable. Thanks Juerg!
> - Modify the commit log.
> ---
>  drivers/bluetooth/btrtl.c | 70 +++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index ddae6524106d..84c2c2e1122f 100644
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
> @@ -1045,6 +1045,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>  	struct sk_buff *skb;
>  	struct hci_rp_read_local_version *resp;
>  	struct hci_command_hdr *cmd;
> +	char fw_name[40];
>  	char cfg_name[40];
>  	u16 hci_rev, lmp_subver;
>  	u8 hci_ver, lmp_ver, chip_type =3D 0;
> @@ -1154,8 +1155,26 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>  			goto err_free;
>  	}
> =20
> -	btrtl_dev->fw_len =3D rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
> -					  &btrtl_dev->fw_data);
> +	if (!btrtl_dev->ic_info->fw_name) {
> +		ret =3D -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	btrtl_dev->fw_len =3D -EIO;
> +	if (lmp_subver =3D=3D RTL_ROM_LMP_8852A && hci_rev =3D=3D 0x000c) {
> +		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
> +				btrtl_dev->ic_info->fw_name);
> +		btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
> +				&btrtl_dev->fw_data);
> +	}
> +
> +	if (btrtl_dev->fw_len < 0) {
> +		snprintf(fw_name, sizeof(fw_name), "%s.bin",
> +				btrtl_dev->ic_info->fw_name);
> +		btrtl_dev->fw_len =3D rtl_load_file(hdev, fw_name,
> +				&btrtl_dev->fw_data);
> +	}
> +
>  	if (btrtl_dev->fw_len < 0) {
>  		rtl_dev_err(hdev, "firmware file %s not found",
>  			    btrtl_dev->ic_info->fw_name);
> @@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");


--Sig_/ycLv.MY4m=zxGSdbwkiRmra
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmTQwiYACgkQD9OLCQum
Qrdl1xAAh9eK8IPvSD/Id5Kvfl7sJ3IiKybrK09SXp9H+V4EPuMELlHIjjuZ1FDU
EeTJSeP0vy3ron+Ckgs4NlGEY1oZhdNb6XMNhbzSS/uRaswO/K5LJg8f+PujfQ7B
/RaxTAcNU+DBO4vUaFT9/2QEsa9xRz7dKP87Sfca00HxgBkw20EvFQ1x9Go1AkKD
mH/ms1XQ9C9eC7j5N0Co3M3Sp13m9stxZqDVXQAqziIiKk/t7EsRc0lLHFRhndtA
DxhMojzyscGq4uEcXD7nBM4U7IP4hXOQhUtnoLIa0U6Hp8pO8wgOvP574XWjgWKu
qfDBhKr/cbjFhJKsfXDbYtbOUI+PT7a+lfyu+Hnjq5cxlirg9HO+UP+CBjrEL7q4
2icumMW/QVCBZZryMOUd92JS/52SlcuJj9Gnf2GEOnz8ppfiNltzwVUGPQaxydBD
D7wE8SlZzlZM9TnS/y59+A15YhCKrKU9CP5LxxXsNHKtjMH7LoM4BuMbpYcJtaic
D48YVwpTZ4bJTyRWOaNbKIYkoHjqe0tB/ZI6phePNwjnDajc1LNzwx7dpWd+hW/+
AjPE2hN2AW3A4nNr2q7AFygkYCHxI6jLNXpDVWJ6ouv81UqwZEieneE4K+ifWXUA
vYKUl5JLcKTe0PNU2SeG9SMCe0g9NDgm8lS9Ih+wHcSop4vxiXY=
=9qNN
-----END PGP SIGNATURE-----

--Sig_/ycLv.MY4m=zxGSdbwkiRmra--
