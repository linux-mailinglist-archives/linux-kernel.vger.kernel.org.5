Return-Path: <linux-kernel+bounces-11950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EDA81EE18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526361C2175C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47AC2D039;
	Wed, 27 Dec 2023 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="aQ3WQS3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tu2//lgY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604C2C6AA;
	Wed, 27 Dec 2023 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4CC8A3200A4A;
	Wed, 27 Dec 2023 05:11:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 27 Dec 2023 05:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1703671914; x=1703758314; bh=XVSXiOw8grD64P8JYTC8B1bQFxnox8Fw
	eiXoeYvGRWo=; b=aQ3WQS3nScvCyZJBUuz9FJUBwHbe9Okn2bE66AuaNsNnlhTu
	oNOuweRdHp04NRkCWyueGpErNtlvRmT1gr3nP58qacKdlfEfFA6RciJan+v4cev/
	b1EWNvI837pgWEK2rZ1r6WQl72WBx14c/l3MFc511FCnZezTFod51gh5XJf/zApy
	xvXevV+4CLSOYmlbHqRmQUQiJ/0/fuvEtB9vwquFjNUoAbrTLqdv7aJegO4O3y74
	zT8zxQYSswmi64tLj69sNU7Byy7fn2uTO8mCKc30gop51/N5njfQdRlFDWrrlSE1
	a+z8FoCrSfBGiqEszttNFqCIcSJCsyMwSEhUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703671914; x=
	1703758314; bh=XVSXiOw8grD64P8JYTC8B1bQFxnox8FweiXoeYvGRWo=; b=t
	u2//lgYOWLPF43Gr0eVJXt76PK3wETXY5YxvQaAk4SjYc/jEtDZ9hR4fD1zSDVEx
	DA6vXviNc03VEQz8r1qwGvykn7x84l1d+TsAZo8ccplHe1CmcyNAZM6jkz9l+KiB
	jiavxJD205AD0q8HPaEnTrxuDrD1MkWGU/kqhZeWhgIV+WkCdN1qur6+O/ho4FNq
	wM+w993L5CBFxPe4D894es8OPB98efhv2jfgMgo+bx4+E1apL0IIOiQo3G1xGN2x
	nUDwer2YN/3Zuy/Z2dJsbTXI4Yh7T1zFTOQoDbbsDWF9OCCXX0fHbQYGmjY6gCce
	Vwyr97ZQ/JazgF/DgkFrw==
X-ME-Sender: <xms:afiLZSg-dCtDWvc97WA4baEz7FRPfhut_f7PYEUVZmPknjlWOJPmHQ>
    <xme:afiLZTCDLDW8O8Unz8ICXMdTsLgeUQWZ6K-wUYkVWEFfKgs1QOVuIChEuXvH-m3c4
    X_kv8Uo5nZ8AM0gHaQ>
X-ME-Received: <xmr:afiLZaFTcSmI_GZSAb4M6gY3ZMq16ahpSMQKaOc5If82st750hH0bbJq72J2nm7J84eb_4CDz44AtzNN_sh0aqyV0Wr4EKRLbRQ1NmshMyGKwwqduvq57Dsirtaf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtgfgguffhjgevfffkfhfvofesth
    hqmhdthhdtjeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhp
    vghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpeevueeghfejkeehkeefieejudetje
    ehgfehfeejtdevleekkeejgfevfeffieefleenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:afiLZbStsnEF58oB0TqNmzwqB-UYQfudwJzAok1jU0inn4JxBo2rtg>
    <xmx:afiLZfxxV2fhu38vNpMytzMhwkUO-9BHUCcWWPknEYcreuBRy4IU1Q>
    <xmx:afiLZZ6M2q3g8AEu3JSetgPWIIU97gHRxBeh9uqvNZh0Z-UWGb7SKw>
    <xmx:aviLZUJJQf70cKA1rhy-D9Qfq9t7D-pB2OJ_CwtgzeB5FiW_dY06zg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Dec 2023 05:11:53 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
From: Sven Peter <sven@svenpeter.dev>
In-Reply-To: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 marcan@marcan.st, bagasdotme@gmail.com, alyssa@rosenzweig.io,
 marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 orlandoch.dev@gmail.com, kekrby@gmail.com, admin@kodeit.net, j@jannau.net,
 gargaditya08@live.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 27 Dec 2023 11:11:41 +0100
Message-Id: <1AA36F4A-DF73-4876-9848-48997ABAF443@svenpeter.dev>
References: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
To: Felix Zhang <mrman@mrman314.tech>
X-Mailer: iPhone Mail (21B101)

Hi,


> On 25. Dec 2023, at 21:21, Felix Zhang <mrman@mrman314.tech> wrote:
> =EF=BB=BFStarting v6.5, Bluetooth does not work at all on my T2
> MacBookAir9,1 with the BCM4377 chip.  When I boot up the computer,
> go into bluetoothctl, and then try to run commands like scan on,
> show, list, it returns "No default controller available."  I have
> tried reloading the kernel module, in which the log outputs
> "{Added,Removed} hci0 (unconfigured)."  With this patch, I
> am able to use Bluetooth as normal without any errors regarding
> hci0 being unconfigured.  However, an issue is still present
> where sometimes hci_bcm4377 will have to be reloaded in order to
> get bluetooth to work.  I believe this was still present before
> the previously mentioned commit.
> I would also like to thank Kerem Karabay <kekrby@gmail.com> for
> assisting me with this patch.
>=20
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Felix Zhang <mrman@mrman314.tech>
> ---

Thanks a lot for debugging and fixing this! The diff looks good to me.

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Best,

Sven

> v4:
> * Adjust the format to pass the CI (again).
> * Shorten description
> ---
>  drivers/bluetooth/hci_bcm4377.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/hci_bcm4377.c
> b/drivers/bluetooth/hci_bcm4377.c
> index a61757835695..5c6fef1aa0f6 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -513,6 +513,7 @@ struct bcm4377_hw {
>      unsigned long broken_ext_scan : 1;
>      unsigned long broken_mws_transport_config : 1;
>      unsigned long broken_le_coded : 1;
> +    unsigned long use_bdaddr_property : 1;
> =20
>      int (*send_calibration)(struct bcm4377_data *bcm4377);
>      int (*send_ptb)(struct bcm4377_data *bcm4377,
> @@ -2368,5 +2369,6 @@ static int bcm4377_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>      hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
>      hdev->setup =3D bcm4377_hci_setup;
> =20
> -    set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +    if (bcm4377->hw->use_bdaddr_property)
> +        set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>      if (bcm4377->hw->broken_mws_transport_config)
> @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] =3D {
>          .has_bar0_core2_window2 =3D true,
>          .broken_mws_transport_config =3D true,
>          .broken_le_coded =3D true,
> +        .use_bdaddr_property =3D true,
>          .send_calibration =3D bcm4378_send_calibration,
>          .send_ptb =3D bcm4378_send_ptb,
>      },
> @@ -2479,6 +2482,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] =3D {
>          .clear_pciecfg_subsystem_ctrl_bit19 =3D true,
>          .broken_mws_transport_config =3D true,
>          .broken_le_coded =3D true,
> +        .use_bdaddr_property =3D true,
>          .send_calibration =3D bcm4387_send_calibration,
>          .send_ptb =3D bcm4378_send_ptb,
>      },
> --=20
> 2.43.0


