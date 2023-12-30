Return-Path: <linux-kernel+bounces-13517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB64820790
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDC1C2135B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76ABB672;
	Sat, 30 Dec 2023 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uuphvLNe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32F8F71
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703956231; x=1704215431;
	bh=NGHWs61+ncWjanV4MetpwQRGBeMtvomzoVyjuTfffu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uuphvLNep9YkXlzRYt/PNa1W3PdSm+AMYrDX3JszqNdKlCzDTXVQeJztpke5lgZ4s
	 GEWMBNJ91jBJIU+WM597XmDHu+LQwuMuv2Qex5etCIu1BUPdEs/96rMSpP8VDvoxVr
	 dHdsIU2t9iYhxPK77wcmMfzp285vjUnIfrszWzX0GINMfxYMyGcN9SxoePCe91+jMf
	 QE3iz8dgDBJ4q6M7gUpwHm8p4weFPpjSSXHFnQ+uJu5aB/CWJJSuzCCU4QN8DDevat
	 5chYSPd7KCITMnVmB76QlbzbhUsWh7pCCM+QHZkj9J4v54V9CrwzzWJ8OoGiBFPv8q
	 Z64yJM61+2VzQ==
Date: Sat, 30 Dec 2023 17:10:26 +0000
To: =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 5/5] wifi: b43: Support advertising lack of QoS capability
Message-ID: <87cyunk45e.fsf@protonmail.com>
In-Reply-To: <20231230144523.7df01ff5@barney>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-6-sergeantsagara@protonmail.com> <20231230144523.7df01ff5@barney>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 14:45:23 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> [[PGP Signed Part:Undecided]]
> On Sat, 30 Dec 2023 04:51:51 +0000
> Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:
>
>> bcm4331 appears to lack QoS support.
>
> I think that's rather unlikely.
> The firmware probably is just too old for this device.

I just retested with newer firmware released on 2012-08-15. I still see
the same issue with QoS. This appears to be the newest firmware I can
acquire from http://lwfinger.com/b43-firmware/, which I extract from
broadcom-wl-6.30.163.46.

    [   11.661972] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   11.919942] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   13.717460] [drm] amdgpu kernel modesetting enabled.
    [   13.717705] amdgpu: Virtual CRAT table created for CPU
    [   13.717719] amdgpu: Topology: Add CPU node
    [   13.776896] NET: Registered PF_PACKET protocol family
    [   15.234058] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:=
35:19)
    [   15.319388] wlp3s0b1: authenticate with 1c:87:2c:6f:f4:e0
    [   15.333239] wlp3s0b1: send auth to 1c:87:2c:6f:f4:e0 (try 1/3)
    [   15.341672] wlp3s0b1: authenticated
    [   15.341921] wlp3s0b1: associate with 1c:87:2c:6f:f4:e0 (try 1/3)
    [   15.346912] wlp3s0b1: RX AssocResp from 1c:87:2c:6f:f4:e0 (capab=3D0=
x411 status=3D0 aid=3D3)
    [   15.347255] wlp3s0b1: associated

>
>> +static const u16 b43_no_qos_chip_ids[] =3D {
>> +=09BCMA_CHIP_ID_BCM4331,
>> +=090,
>> +};
>> +
>> +static bool b43_qos_not_supported(struct b43_wldev *dev)
>> +{
>> +=09int idx;
>> +
>> +=09for (idx =3D 0; b43_no_qos_chip_ids[idx]; idx++)
>> +=09=09if (dev->dev->chip_id =3D=3D b43_no_qos_chip_ids[idx])
>> +=09=09=09return true;
>> +
>> +=09return false;
>> +}
>> +
>>  static void b43_wireless_core_exit(struct b43_wldev *dev);
>>  static int b43_wireless_core_init(struct b43_wldev *dev);
>>  static struct b43_wldev * b43_wireless_core_stop(struct b43_wldev *dev)=
;
>> @@ -2587,7 +2603,7 @@ static void b43_request_firmware(struct work_struc=
t *work)
>> =20
>>  start_ieee80211:
>>  =09wl->hw->queues =3D B43_QOS_QUEUE_NUM;
>> -=09if (!modparam_qos || dev->fw.opensource)
>> +=09if (!modparam_qos || dev->fw.opensource || b43_qos_not_supported(wl-=
>current_dev))
>
> This looks a bit over-engineered to me.
> Can we just instead do it like this, please?
>
> =09if (!modparam_qos || dev->fw.opensource || dev->dev->chip_id =3D=3D BC=
MA_CHIP_ID_BCM4331)
>

Ack.

>>  =09=09wl->hw->queues =3D 1;
>> =20
>>  =09err =3D ieee80211_register_hw(wl->hw);

--
Thanks,

Rahul Rameshbabu


