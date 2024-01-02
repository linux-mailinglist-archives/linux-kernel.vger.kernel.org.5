Return-Path: <linux-kernel+bounces-14723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7548822136
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF41F22785
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21015ADF;
	Tue,  2 Jan 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlGORd3S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9915ACF;
	Tue,  2 Jan 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccae380df2so81894541fa.1;
        Tue, 02 Jan 2024 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220811; x=1704825611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi/vkiq78X0yzEwfWzDqipOcXVRGcQevtOptU3VRDoU=;
        b=PlGORd3SSRdQOinhtutvv1Bl6ZWkuxX7X+KItUPBBDHXCM3QrfQf2pTlK2+RpRgHw1
         J5zCUXKCUHgLp9UJ2/iIT+DLCQodiCzXYK/nDHst7w6UV7x09siJ8i5wO5ktmMQc2ATP
         Dq79SBNK7qCCfAzcXlySn4EBw4yuJCdKV7PzxvVIZsGk2i1N8hfQvmljgNfpYcGieJMm
         TyJEcMd16bs+s9OfJtV8e3z5cTTeEdJg1gMdaXaBvJBww6Oisx9zuVty6ns7VcEmNYu5
         d6r8kfaqLrhCIuD07DjwTTlns9TuZgnc6H4x2oWDZDPDPFLlJE0KrfL4GaCf8sdXsrjo
         p7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220811; x=1704825611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi/vkiq78X0yzEwfWzDqipOcXVRGcQevtOptU3VRDoU=;
        b=rnVShICkL7TDbOefUZ4UxUvTl0a5S0Fc/jocyd74vXosSx5VwdS2EK0Y8ujdiL7SLY
         7XBu/QyueTucI18K2WoI3nOCFw1rbf/EgM13X1F07ZKuh6jtzLurA/eXRZlEUMD0BH2W
         ZxuVag/DDJ5deGEuiJfvvaWLM8y5l2F1/kc2u2xnCYkTxZzA4rGdkVBqgqwxnH8FTPhr
         lDofEZ/Q6KeS+z0dFkmbTw2Tq4erDNyLv000a/cZWdaNkTdcDp7zP9S2KKk6CfMVBTYE
         yxegEt0Ktc4A2jgJ+WBwMqqxIdNLxR3m6Mm2pmoCOD4He/laOczLbWDlwGFgVF4xph1m
         7/qw==
X-Gm-Message-State: AOJu0Yzw+sTwLfPNmeTeTBk0uIbpg5SAJVaOG12g0/XY4tdAZzaF2cDy
	WEQeMHuHi2JWv+SZOUWlv+oatEY1UBdyUrbhTEM=
X-Google-Smtp-Source: AGHT+IEucWctf1n9df5Yb6yWXLi6BW+gSmfIgPxnXufEaYgrcM35uHM13oukW9MfN5nEiH6X3XJLisPQ5YnD8SB+11I=
X-Received: by 2002:a2e:b791:0:b0:2cc:7a2e:28f4 with SMTP id
 n17-20020a2eb791000000b002cc7a2e28f4mr7346388ljo.88.1704220810795; Tue, 02
 Jan 2024 10:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102181946.57288-1-verdre@v0yd.nl>
In-Reply-To: <20240102181946.57288-1-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jan 2024 13:39:58 -0500
Message-ID: <CABBYNZ+sTko6reoJO43W2LHGW58f0kK_8Zgc3mep7xki355=iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Power off HCI devices before rfkilling them
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Tue, Jan 2, 2024 at 1:19=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> In theory the firmware is supposed to power off the bluetooth card
> when we use rfkill to block it. This doesn't work on a lot of laptops
> though, leading to weird issues after turning off bluetooth, like the
> connection timing out on the peripherals which were connected, and
> bluetooth not connecting properly when the adapter is turned on again
> quickly after rfkilling.
>
> This series hooks into the rfkill driver from the bluetooth subsystem
> to send a HCI_POWER_OFF command to the adapter before actually submitting
> the rfkill to the firmware and killing the HCI connection.
>
> ---
>
> v1 -> v2: Fixed commit message title to make CI happy
>
> Jonas Dre=C3=9Fler (4):
>   Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>   Bluetooth: mgmt: Remove leftover queuing of power_off work
>   Bluetooth: Add new state HCI_POWERING_DOWN
>   Bluetooth: Queue a HCI power-off command before rfkilling adapters

Apart from the assumption of RFKILL actually killing the RF
immediately or not, I'm fine with these changes, that said it would be
great if we can have some proper way to test the behavior of rfkill,
perhaps via mgmt-tester, since it should behave like the
MGMT_OP_SET_POWERED.

>  include/net/bluetooth/hci.h |  2 +-
>  net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
>  net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>  net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>  4 files changed, 56 insertions(+), 25 deletions(-)
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

