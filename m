Return-Path: <linux-kernel+bounces-100443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AA8797A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51A81F2110E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDD7D076;
	Tue, 12 Mar 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzuU5doD"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C17D063;
	Tue, 12 Mar 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257603; cv=none; b=ZewO/jmCZACHxssy4sAYX6JpQfOOp+/0nOljrgC2NU3Mt+ER8EsmHs+t+kDhkqc1D0WheJ+y7E88MVQzqUvEfJugR4R5C1m6fbkSsgQKkCyTKpG0IVdVTE0OC9RNtbtYHwv9rSDf7NFlLVOPK1+1Yk5RVw0S2RG2ztJQZ1yy3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257603; c=relaxed/simple;
	bh=j53OhaUdNor3mQ/LpX8s3IrNzFb3Okutcd5V/IJzIh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcfXfcYZsBtkwLBq/30qRAkVaQiF8KusiAi1y1848C6m5UP76rZhBqtABp1cyBSirI2OC8+eQsI/tAtaxXbJtqp9dnyJV7cTaWFuYakgjVVBb6gjGT/IZ/M19slAer0Kt9WgQU59BlrQNSc0vObefEyaSl7sQthAKlxxpbk8y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzuU5doD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d26227d508so85530241fa.2;
        Tue, 12 Mar 2024 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710257599; x=1710862399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j53OhaUdNor3mQ/LpX8s3IrNzFb3Okutcd5V/IJzIh8=;
        b=CzuU5doDnsWrCtBTxkxGb+T6J8v3EIN5LYPaOjmVWizd+Jz/Ibmf9UnEHyWf710GUR
         LbWQZc8m4ax6fJOBHZ192/ItA7+Qog4VCFpmfwK3Y3azI4qTRVcfAv+7YyfsEOSh9nrH
         XkJKguPrePjIxNwr+zjIifUnXr8gnVaYJ5wUaKw3r3R8SRvtRxncolyTuUyl0fEr56ey
         FBeHgxZ/k6CPBsViFJ9NF72ED7fJdNfvfO1+QOAMagnCRl34KPMsoIuzwl9FB5UW4/LN
         OZYvvvj1x2j7fTAFcCkBrky0lMnE9+cqL6fdDg0Z/4XGZQyyT2/bINIwJTsQkVN4KD5W
         xCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257599; x=1710862399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j53OhaUdNor3mQ/LpX8s3IrNzFb3Okutcd5V/IJzIh8=;
        b=PvP8J+3Krz6+YjNKcsFpf+3rJu4ry3m3wX5hroXGBYiIxOLXZ4FtECxi91LLa3Aj7c
         nxZeRb0qCT87MdWwXeO8fVt73TkwzUhan/gjE3SqU8mmkWkjAXmorfsySOpuLVNyHKXR
         AOEG8kCc28dcDnwqGj967jqQdoq4Uxqdd5zgiebicbAEhZHm2dTKt+9yKNqwU71kO24b
         FTYdRTUhpVxVwR9gPDGjr8s2dfiHwiNZYqaUE8UXKFC7QJstGqno6iVaqPUwApLDquEj
         Kib1fp7I51MEQc1ZHrrQjMSqJqg3nIqhVVoK4vGuJu+o+zG3NSGigaT5zksIvwUOq9p0
         j+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKY67THNwy4iMl8UtRc61GFIvrRbaK3i39q/Ood2OAEih6qijW113TOyBJepNJJFnHx2W0e20IPL/Fbx/LS2GzCTTxzhbYQkULVMmwowD4TpTi7ZTxJ1aLUP87C87LdF2JGaBSD1hjbQ==
X-Gm-Message-State: AOJu0Yx3F9nRFr2+CoWtTO80Zq7ABrm3qT2cCIrKOS2QcsIAmgH3L0mG
	y58LrYfYmqiutq+62y/mMLzJKds7HJ5YZZpeqIeMUDDo3JkfnuVY
X-Google-Smtp-Source: AGHT+IH+GYdHn43KNybwuLnriIBfr5ACpdRFrQf1mgqFq8tNNQ+vL1aYSJJzyxkQYXKDSNlgc7iZ/A==
X-Received: by 2002:a05:651c:211a:b0:2d4:6815:fc6f with SMTP id a26-20020a05651c211a00b002d46815fc6fmr495703ljq.30.1710257599065;
        Tue, 12 Mar 2024 08:33:19 -0700 (PDT)
Received: from [10.176.235.119] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id s21-20020a50ab15000000b00568699d4b83sm1384635edc.44.2024.03.12.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:33:18 -0700 (PDT)
Message-ID: <4aa7761173875ccfac57b18c9f002c4078358631.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] scsi: ufs: Re-use exec_dev_cmd
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
	 <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Mar 2024 16:33:17 +0100
In-Reply-To: <20240309081104.5006-3-avri.altman@wdc.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
	 <20240309081104.5006-3-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-09 at 10:11 +0200, Avri Altman wrote:
> Move out the actual command issue from exec_dev_cmd so it can be used
> elsewhere.=C2=A0 While at it, remove a redundant "lrbp->cmd =3D NULL"
> assignment.
>=20
> Also, the device management commands that are originated from the
> ufs-bsg code path, are being traced now, which wasn't the case
> before.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>


