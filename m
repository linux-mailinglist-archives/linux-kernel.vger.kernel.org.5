Return-Path: <linux-kernel+bounces-86472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD986C5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138BDB28347
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A80626CD;
	Thu, 29 Feb 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXZS2Fr8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E1626A1;
	Thu, 29 Feb 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200021; cv=none; b=iyuMCC+XgHBZXKTqLphe2NXfk1qmkh6d9VR/RA5Fo5Z32trSH6c2U2UAgdCohHZoPj+4TFbEwXjwFMJjaGE2w8EAfStEkq6jtJf57SH03ctiy8w2IAeWBv8Nv/OytEbF57BsesE9Y9jrEE/fO8Wgkk6igss3LPhakwh6CyfFMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200021; c=relaxed/simple;
	bh=ZKF6CGDxJo7aTCOVRYbPvZuJuMOfRD8zOUkDxs6+UMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJlWhsBDf5P3JfOwq4T+gsZ5KaPL5M+ljjACnpl8mBSyDecedOIjEAL+pWnx+Wa/3vo9XaP8Zj2YWC/ZCmMx1sXQ/O016fFjJj2GOgRia7Mxtvyl0fCApUB8YkvY8eeiJ+q301CuwNFNlKlVnzgXlVk05S50hScJvQrqrc7HZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXZS2Fr8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so1088941a12.1;
        Thu, 29 Feb 2024 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709200018; x=1709804818; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKF6CGDxJo7aTCOVRYbPvZuJuMOfRD8zOUkDxs6+UMc=;
        b=fXZS2Fr8GU6zZmElBl0wcyJq/8r7yc3OkayucqHxD03QSf5zVizvf7p2VZzEishF0h
         r9Vd/a2xrvIG7vHW7ckX3w0BlezkPiiPcLZLsW44EiAavGhbph/3iJk9SoJc6LVh2v/C
         JYFXQCz1e424kQSRUf7psF1k5Zr3t6rnh+2KOQ1TtHwNmIdrts5fyyTq65Jb58hYRM5x
         5VmT44hUg71Xz7/6D81uC5sAWR2dN8AYo/tJ/PfevNGGQ15JQvF4a6t/WEDaFhdGH2Uw
         rNh/ARLm60AzI9aiSOHOoUs1wrx3T+OoeoNLB5w/wKpFzsjp83o0QiNqsQZuiRmXF+it
         54Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200018; x=1709804818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKF6CGDxJo7aTCOVRYbPvZuJuMOfRD8zOUkDxs6+UMc=;
        b=Cm6TmziVUidAN8bSfn5Zwo+c/nOC07+YnzQwa3GopPUhn0qFYA0xgkrsxp2V3Sd8Jw
         9yL2tyH6wKFcHpQZOKmvi97++19JwD8BoTDnLb3aFWKgEp5B3WJM212qqzAcHl6Tq+Ie
         6pb2qZ4FI3dey7Z0a2PY/cUljk6M3SDIzuzAlCfpwqNhx6VuNSeEXUevR1Mg0qor7osK
         bnqhJYEEiz2G5Puf3tfvpN+hz3NU1VK4CcGytoFzeoCronq1JRcgKwqERhNl1VoKerqA
         mdNtUxq9FMpuhRO+1MFTUOuuMvgzQfReLRjYLwtIEh2mxrVY7eEpFBIDtEHXjPMidIpW
         6YnA==
X-Forwarded-Encrypted: i=1; AJvYcCXLcsJ3IRrDBRXfZ0TQKmkG+/rDsfkZ47+7uMRKvqlWpQIwFvoC/dZ+uWoNlr7xHhCrm+oA4FkMRPcVeMKIG0EcsSVr9RP8Yg37QqGIiwvmJbS4JAhGMtiM7uthaduEVlnLT3L9Qc2fkG5q4sXf3UStiDybo+9S6pXaE7tbJFG7qQ==
X-Gm-Message-State: AOJu0YyNi3vsXlUMBiNg5j3F7twhnt/MnvvhHjR8oufkBaVYSZv0arIG
	0lbza+NQuhA1vUFZgxqFXOJxvHuJE2R0yIE7nF5ai6jy5+j9F0Tm
X-Google-Smtp-Source: AGHT+IGYn6hgKhooP5suk6LbV9V/eMI1wmp/BB2frmjgHS/QPCx3g8SNZ5X3gedy+bkNYy/MkSi2qQ==
X-Received: by 2002:a05:6402:26d3:b0:566:6e4e:cb8c with SMTP id x19-20020a05640226d300b005666e4ecb8cmr1379117edd.38.1709200017706;
        Thu, 29 Feb 2024 01:46:57 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id d19-20020a05640208d300b0056650cd0156sm446013edz.66.2024.02.29.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:46:57 -0800 (PST)
Message-ID: <c2b830bb4a4cf76dec8783f38b2477120edb1a15.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 10:50:21 +0100
In-Reply-To: <20240229083953.607569-3-herve.codina@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
	 <20240229083953.607569-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 09:39 +0100, Herve Codina wrote:
> In the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
>=20
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>=20
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_overlay_remove() with the
> devlink removals.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/of/overlay.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 2ae7e9d24a64..99659ae9fb28 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c

In the cover, you mention device.h inclusion but I'm not seeing it? This is
clearly up to the DT maintainers to decide but, IMHO, I would very much pre=
fer
to see fwnode.h included in here rather than directly device.h (so yeah,
renaming the function to fwnode_*). But yeah, I might be biased by own seri=
es :)

- Nuno S=C3=A1



