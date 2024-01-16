Return-Path: <linux-kernel+bounces-27018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DB82E940
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C431F23856
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35020101F7;
	Tue, 16 Jan 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afwBrOfJ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D4D524
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so16702975a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1705384345; x=1705989145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyrP6rg7CfIQQ9TBfATPNoqoDnn42W4EH+/Y8OnuaR4=;
        b=afwBrOfJ5x4sxHjo0cEmOEecu9LbztBflGgwtmfQtolGyAbyvUx32+1ynZWS7P0fZt
         hWv+w+plCHusVqMs9k2b7u1A3xHKFhOzfY/qch1o2MYVFdDsDqGGGesEoBqdcqoKbKRx
         cvslVoD10WBAJafdBXZV/FAnoh3ZCmsWf4JtCyjlZvDVWiQbJKThx99IplHQNpM7/wl+
         nyfVvFAD3sQFzxzgT/a5f+ojmuVM5FVUUCE9xj4pMp2OeKbUZmbOTMI6pPND/9IZkeZ/
         kDXv/XlraGZ6jkolfGw+CekcaLJ4qzp40GWIRL/poX1kLWTf/i7ou8NmjDnLu2WUxvrz
         vmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705384345; x=1705989145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyrP6rg7CfIQQ9TBfATPNoqoDnn42W4EH+/Y8OnuaR4=;
        b=Vzyt4q/wzrfHSgtCyHALtdPqH3enRJ59J0BQ94JRDg+MQauDXIwDDk8JPd02jvBxjI
         pwbP2kX2yMkCgEcWaCZNbzuqtl83pnE2EeIHh5H7wM+C3cqUPk4dhUIzuCx3tQiXRF8Z
         uzcdQGogu26KThidcPEYZFHDhhZuBgBg1BU5yM/OtkzHTE0W0/J6qe1J0IZPlMIhQrLZ
         wCI7lVXaArlPVvEgg/dWzvnwga65fvMIaNsnf3/mbO2qux0MHKLaIEmOHlw/evKAQH3i
         hybN1ygwXWASN9Ct93Fd3vdB54jbXzWHAQW4Bz0E80aqxV3r/DyYbBOnC4aNLUxDEZm8
         PE4Q==
X-Gm-Message-State: AOJu0YxV1ZwPhO+1/6wKF4WecxG6KYrOl7JPDeRNz6gTweodpBGQsweE
	IIZsn3jDmtKOjKa1cN1zGxehSU4K4JPmcUr/7IgowK7wfEVFCw==
X-Google-Smtp-Source: AGHT+IFGWmdNBqbaNkNIzAJ0Kkv8Bu1qRc6PqoLCB2lult4xTTtdWVmF6cXPoKoq9s2i1TrtoVPR2eCZ1LFC2IK7sZM=
X-Received: by 2002:aa7:d941:0:b0:559:513a:90ac with SMTP id
 l1-20020aa7d941000000b00559513a90acmr2202592eds.33.1705384345577; Mon, 15 Jan
 2024 21:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com> <20240116045151.3940401-32-lizhijian@fujitsu.com>
In-Reply-To: <20240116045151.3940401-32-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 16 Jan 2024 06:52:14 +0100
Message-ID: <CAMGffEmuxMei55xeuHvt+Z06gbbHhfDt+-9hmtE5zS_9OViYXQ@mail.gmail.com>
Subject: Re: [PATCH 34/42] drivers/scsi/pm8001: Convert snprintf to sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:52=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space=
.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
> > ./drivers/scsi/pm8001/pm8001_ctl.c:883:8-16: WARNING: please use sysfs_=
emit
>
> No functional change intended
>
> CC: Jack Wang <jinpu.wang@cloud.ionos.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm800=
1_ctl.c
> index 5c26a13ffbd2..7b27618fd7b2 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -880,9 +880,9 @@ static ssize_t pm8001_show_update_fw(struct device *c=
dev,
>         if (pm8001_ha->fw_status !=3D FLASH_IN_PROGRESS)
>                 pm8001_ha->fw_status =3D FLASH_OK;
>
> -       return snprintf(buf, PAGE_SIZE, "status=3D%x %s\n",
> -                       flash_error_table[i].err_code,
> -                       flash_error_table[i].reason);
> +       return sysfs_emit(buf, "status=3D%x %s\n",
> +                         flash_error_table[i].err_code,
> +                         flash_error_table[i].reason);
>  }
>  static DEVICE_ATTR(update_fw, S_IRUGO|S_IWUSR|S_IWGRP,
>         pm8001_show_update_fw, pm8001_store_update_fw);
> --
> 2.29.2
>

