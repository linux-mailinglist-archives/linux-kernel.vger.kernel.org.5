Return-Path: <linux-kernel+bounces-95570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F3874F99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D811F23677
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7612BF37;
	Thu,  7 Mar 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIjudYMx"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9747F7DB;
	Thu,  7 Mar 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816798; cv=none; b=IU5NH9FG8jscOyAW8Yrwoqs+/j87/lkP+pLNjNr8n7eG2k6ZPoeFXoPeyoDcEWquRmGHuSoLH3qcLZNJ9lMrAP8HvWkHyr2hxaV5glngwjuLByk9m+V96IK60QJ+/ujXoD0QXbOb2rZFHZMqk8kMium+Ut5UacsMRwQYCucaxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816798; c=relaxed/simple;
	bh=RiU+yV9otIE+FfiUJCTFmjpI6TQk1VsgwIYafXgJGQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOjQ4ZoCaYydxnQ/YF7rlMorNk6cjRFpHdLH4b0vzVb32K8E0q0SGC4zEbEyUemtjHz5jmYurhwQdNBo5/MP8rDSt0I+H9r3a0H5aQ4/rvoyLZW5M8CC/vUbKverMBRJl4zmbt0Z0pYBng5v1bOOE4r2nuKP/RrrzDQ1BV/d6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIjudYMx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so10110001fa.3;
        Thu, 07 Mar 2024 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709816795; x=1710421595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6b0dP2x9JgNOkZdWVMwZj4fWH+1O5YM+rCuFRVEaBss=;
        b=XIjudYMxAdrtzEeesINsrnICKWEFPDkCn2sDSdhwGfXrjdK79QJ1Am0IekA32z1J4P
         M5zSdDumaLoYMDMeIzZ2RSzkwzDmEyklIYw9eWRJ9NoK1CGFTLNImJSLQPEKi+4JYuAo
         XU1XpntF7LpThIxtcYKPJc26TJUioTvZDDRQ4l4Y247lUiHVZ1A868AOzN/WGJNbSG2Q
         M6m17wTuukVOKKRa+S+whk2vgbpQ5hsYVbi2v+kLAYI2cmFlC410TzbcRPOSM/xkRTwC
         Upf63Gw3EYcs9e1FS9TE9pn1AXOSFMsyEAmp6XmbHgR8ku3rA3HRw64GVKb0DmJryfP3
         49VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709816795; x=1710421595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b0dP2x9JgNOkZdWVMwZj4fWH+1O5YM+rCuFRVEaBss=;
        b=soYbJYHsZ+Cl9w8QbIJ5ODAgJv8zxesXv97yBwGIabZFvQ/+WTMCdYI4WjlH1okUbq
         4bTkABbj0//p5AM5v3yjVrwN0at3S5iCrdJqZN9A/envihbzibj8P1IGEnbxLgnOw9Tq
         JL56S4dIf0JRy4z2l7PWYBZZH821k2LhTIyCHWHf/5yro4Y419N2nfWSMjcO9xdj+HYM
         jelrp6r5Xms5mv/Il9s5F4078kYB9eeqCUqJpya9mXiccRHXmMqRWpM1/ucJKp1w1Kep
         CPUioyshW5OSiE1OHMiYI89l72UoeB/RGofTlzE54kAQ/clDCL9btuBLYadn61t78liu
         +yYw==
X-Forwarded-Encrypted: i=1; AJvYcCX8dj0Ulo1M8fmyZX2eW81IKJwOrtA1VgqgXmMekWhguCLONI/RBPSo1OgWyvhVmRERanlYc9Y8Gg+HT8wyMZovQOkuaO3LzC13pxEo6kszvV6mtecxKqT809I5ZeyriblJionirjMx2w==
X-Gm-Message-State: AOJu0YxECdRweFzxiZqAg1Ots4LGf4StxxPy5hDagdcn/YCrB8tTcsRQ
	Zc0sEB3QpLjYZeeVi7QwvKc3qIlh/oM4QQw2bdpn145ZOUYMPjLt
X-Google-Smtp-Source: AGHT+IEJOLHABL7/l7Gi0d4ejmJvati3k9LbR/a70UY0ZQiL7MIms3UjinQtd5hBKUSTzNSALocD6g==
X-Received: by 2002:a2e:2414:0:b0:2d3:365e:9cfe with SMTP id k20-20020a2e2414000000b002d3365e9cfemr1232600ljk.22.1709816794664;
        Thu, 07 Mar 2024 05:06:34 -0800 (PST)
Received: from [10.176.235.119] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b00567f39a8b55sm1592159edb.39.2024.03.07.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:06:34 -0800 (PST)
Message-ID: <6826cdb060609f81c970fc21b2050535f7c5a810.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] scsi: ufs: Re-use compose_devman_upiu
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Mar 2024 14:06:33 +0100
In-Reply-To: <20240305210051.10847-5-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-5-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 23:00 +0200, Avri Altman wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index c9c2b7f99758..a39a2b34ee2b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2710,18 +2710,27 @@ static void ufshcd_disable_intr(struct
> ufs_hba *hba, u32 intrs)
> =C2=A0/**
> =C2=A0 * ufshcd_prepare_req_desc_hdr - Fill UTP Transfer request
> descriptor header according to request
> =C2=A0 * descriptor according to request
> + * @hba: per adapter instance
> =C2=A0 * @lrbp: pointer to local reference block
> =C2=A0 * @upiu_flags: flags required in the header
> =C2=A0 * @cmd_dir: requests data direction
> =C2=A0 * @ehs_length: Total EHS Length (in 32=E2=80=90bytes units of all =
Extra
> Header Segments)
> + * @scsi: scsi or device management`
				      ^  '`'

> =C2=A0 */
> -static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp, u8
> *upiu_flags,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0enum dma_data_direction
> cmd_dir, int ehs_length)
> +static void
> +ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba, struct ufshcd_lrb
> *lrbp,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 *upiu_flags, enum dma_data_direction
> cmd_dir,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int ehs_length, bool scsi)

Why not directly pass UTP_CMD_TYPE_SCSI or UTP_CMD_TYPE_DEV_MANAGE
instead of using below ?: logic?


> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct utp_transfer_req_d=
esc *req_desc =3D lrbp-
> >utr_descriptor_ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct request_desc_heade=
r *h =3D &req_desc->header;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum utp_data_direction d=
ata_direction;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hba->ufs_version <=3D ufsh=
ci_version(1, 1))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0lrbp->command_type =3D scsi ? UTP_CMD_TYPE_SCSI :
> UTP_CMD_TYPE_DEV_MANAGE;



