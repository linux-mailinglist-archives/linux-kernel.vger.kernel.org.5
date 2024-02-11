Return-Path: <linux-kernel+bounces-60855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BF850A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C13283A64
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA25BAE8;
	Sun, 11 Feb 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpVcS5gG"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484611E506;
	Sun, 11 Feb 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667071; cv=none; b=UDSHj8fVdX2/AoYwvv9d7efOwbJxhJ9YwEaoVNrxKmh6xYqo3s2STWtq5EGTS4VMtG/3lecH69sN67vtV+bwpn+7AYifQqWqJIa9qCcEvg52BssM5rUCh5kZJwQezT0or6tZYWGWEi8vGVxfpPvZrs0TfNJ4cm0ecp1F2FFI8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667071; c=relaxed/simple;
	bh=stmkEqJ1qXcSaTqWdTlvLqtEOfj+D0MgCx9mbqK/hAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CARe4KZ1I3670Z8RAw0z5zALb3gMkzZicz7Ylgec42dd0Emk6yRMFDrSAvtBbaNqPVweJVPxwfj80iSw/+DRO+9OGrhSFC1fasle7rLmdwrpGBj3I75NTx2JQIjv21kyZpAosonXYtBCh6bH0QwaGNzAvqgDPOFCH2IVAqBXO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpVcS5gG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0aabed735so32488101fa.0;
        Sun, 11 Feb 2024 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707667067; x=1708271867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hHa5kUPlIxFb3OXyDNX1LwLohhu/1WXPO430OUtUMM=;
        b=BpVcS5gGzy29AbdSXIEGkJlPB2hKZnX7ErM5olltH8KsH7lbNXupQyvArg1Sudbf2G
         9U2rAAER0jfdYLDBerTLlKnt16zA1p7o1hM30hmMGJhbpP7Oe7LT2tBGKJKSYmu/1znA
         INXAMt5x354fAxLmdJqZsDk5OFxqWROJCLO+QOp8tdWs0Ynh+46ntxZivxCkOYiIRcxz
         Gta+g2m/jSrnNMJzkglUMfeZYpi0DfDEjHCZGPhe4r4sQdOQSFKHvgg8ETtBCvR+be8G
         cCyENBU3ZW2nPAg8rYXz28Q/D1IsolQf9Su6RXphPC6CTP69Jf6armEC1mEQuEYJ1qsf
         jQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707667067; x=1708271867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hHa5kUPlIxFb3OXyDNX1LwLohhu/1WXPO430OUtUMM=;
        b=oIQdN/MQP6hgjCz7+H2b4+ZMkDNV4GoVCOFnNxwPW5J1J3tnPJ9xECIUBNoHiihvhc
         43GLRjcqZXWb1wPB8cKumWiwOppxIUtqjLejUjI+YHB+c/zxFoWfk7SzW2Q8L8akmt0C
         2liKnKe5z+uKe+wYo1VlZfFbe76VwWA7/VYN5DIrDxIrBaHfH0CzwF5GNRYMxOvdxA+M
         5d6oGpiDLyMogdLwzGZMqhdnImS0QTBP6YmhZeVwDXio1ri9jff3oVdW8Bk/cANWEZDo
         f6tqpbbgOvYPLujPl40e1oNWzf7Y2oed2LCCOg7Z18B5MspSdp/tOV7PFEtXu7ji6d+o
         fVGg==
X-Gm-Message-State: AOJu0YwnLxzc66+Gw550v5n1yFN+X/gkZdsE4PUrh9T6SGO8eZml9kh+
	I89tk7vv3IDV7dYFtdgYDsgiopcvZkOLuLzT3a2IbmuqAvAWKSPJinSfnJ+K1HkqQDwj3l8W6nM
	LRj8cgERCZSqNPMi7Y6/eVBMuu93bjzDk
X-Google-Smtp-Source: AGHT+IFhqINxZv3yWOWEeiA1OlbuMFnXjwFNxOQeInzW5VoWqiv0Bxq19H5xDF6jLhd9+hi91q0aWl3V+wZyMjqARdI=
X-Received: by 2002:a2e:8519:0:b0:2cd:5cfd:b19 with SMTP id
 j25-20020a2e8519000000b002cd5cfd0b19mr3062812lji.19.1707667066875; Sun, 11
 Feb 2024 07:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210222226.890031-1-vibhavp@gmail.com>
In-Reply-To: <20240210222226.890031-1-vibhavp@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 11 Feb 2024 10:57:34 -0500
Message-ID: <CABBYNZJx68KUkiHXeZmSnzwpkK2CAB_ASrD5dK+WMocDuwuomQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Bluetooth: mgmt: Add command for getting device IO capabilities.
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vibhav,

On Sat, Feb 10, 2024 at 5:22=E2=80=AFPM Vibhav Pant <vibhavp@gmail.com> wro=
te:
>
> The following patch adds a new command to the bluetooth management interf=
ace,
> GET_DEVICE_IO_CAPABILITY. The command allows userspace to get the IO capa=
bility,
> and the authentication methods supported by a connected device. The comma=
nd is
> necessary in order to implement parts of the Win32 Bluetooth API in the W=
ine,
> specifically the following two structs:
>
> * BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS, which provides IO and auth ca=
pabilities
> info for an incoming authentication request from a device.
>
> * BTH_DEVICE_INFO, which contains flags indicating whether the device sup=
ports
> Simple Secure Pairing and MITM protection. The former is supported throug=
h BlueZ's
> "LegacyPairing" property.
>
> Because the Wine API are implemented on top of BlueZ, I'll also be provid=
ing a
> corresponding patch that uses the newly added management command to expos=
e the
> capabilities through new properties in the org.bluez.Device1 interface.

Interesting, but the IO capability matching logic lives under the
kernel so I wonder how useful this information is if you can't really
do much about the authentication method used? And in case you are
thinking of changing the pairing procedure to just leave it up to the
upper layer to figure it out, I don't think that is a good idea
because that is subject to qualification that would effectively be a
new implementation.

> Thanks,
> Vibhav
>
> Vibhav Pant (1):
>   Bluetooth: mgmt: Add command for getting device IO capabilities.
>
>  include/net/bluetooth/mgmt.h | 19 ++++++++
>  net/bluetooth/mgmt.c         | 89 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

