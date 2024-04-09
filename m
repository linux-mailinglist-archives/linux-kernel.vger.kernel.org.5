Return-Path: <linux-kernel+bounces-136340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B088989D2DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18971C21AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC627B3FD;
	Tue,  9 Apr 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="n22DMnwC"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BD6A012
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646739; cv=none; b=Vz3l1EddbG4BN739D2KXK52VzsJ1c+kIQXgYuWA7vglg9wHo2LYeokLqDLDGbRcTNXSFnVA0vvJzt5RZG0bGPnv/9T73j4OE4zsG/b0Bec4MzcBG52DP1fu/+Q4qfCaqh6QS9QlnrvsaZd28mUwxA4uQeXGlBXN8Z4Adh2IGDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646739; c=relaxed/simple;
	bh=Ho8UuDKDn3dJomXIyDB+aaax60ogHDfzU1mNE6Decww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/y9B490BFxBD4QU1gbIZlcevG4c9DY3gWsefe1uP2+VZDxSrnUewsZmyXlQdhPeGKd5sIgBYIrMcDq7Z0KXJ+JodcvNmU9lkun1Su5bJuaqMQ8ZBDN6DPzq+ISYqYtUdOIaxLtsm+kWd6WahrfdE9mNloX46mkWKCbAEBjPWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=n22DMnwC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6151d79db7bso60414267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712646736; x=1713251536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwdl6n9vid2pyIfyEa4g1TqkRuZa9yIoK4Qc9NMFsP8=;
        b=n22DMnwCs1PEEVheGAw8UAD5e/X8NWSNkhbpzfaBufCKbSyeiyEEPYikK07QihWM1v
         u9H3jZT5aEoN+8iRSRzd2djA4X3FZhWzydvznEWJ793n2H5WOqikfn6WcmrS595/9mFG
         4IUIWPzHYFshdIh8StBCiH7uALxa9ECI8cVipPCK3ixnzr7+NHMANuboj21WdOAnKNKf
         V1N8MCTBMd5yxeHN0VkuCB4bji8xl83/VmEAjUs1/R7LwGFIOJvzc7Lsr9vpG3K7oC5p
         EcovvdFGlaopmO1jQf9B/uXnhCHtbxRNBoMzqa0GVzdpqD1DX+hcgsONa3M7zVSxtYDL
         3LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646736; x=1713251536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zwdl6n9vid2pyIfyEa4g1TqkRuZa9yIoK4Qc9NMFsP8=;
        b=WCcKYTDmJ+x9gu6Q0BslzaHgzzzc1YQbdWrI0jme2I6MyajcSArbpTU85Of+nDuhK9
         a/n5iStlfK0lSzM3rkpTmYu67YHxI8KlQa8DwGD7/nJf2Bhpwn+8RvAiYu1Z8sxTGwcM
         QVR2epb5cJ+nqnTMzeMM0PtUq5E51r/oOJFOv9ljkTzmT5A18jJYWTorqiNLaNfd5P0r
         wZPLGCYCpTXAudReKKq/stq8XkY6iGcoGKHeNQJAeDWwTfLW2NRSFREe+n1g9GY9diBk
         4U33uOUKrx0u8YvZs9rhCSHGrIWMTHo9ei03W5uXFiEevqEG6GUDJy70GtLFFaRA+eCT
         V5YA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ys22XcO2ZG3Eyq6n/JR5fjhqiViHBB37bLfYtIDI6ME4GNz9tIDEH+PLWgnrcP6Ca+NuRIZ0CGJWw4tuV2XYw47nbRUGBg/boThW
X-Gm-Message-State: AOJu0YxzvygGH0r48oU9DtTZhc6Mqt2k+9lT+jO1h52kIBhTZSQBCnHV
	kNxmcrlEsfiA9q6xXRZt+S3RGg0mXpNijUvnRAypxFp3unQoqKT8kD0RZHDRlTamhu7mLr1F9jd
	x+pcromsxCqncgOAKKsQHDcvJ2qzA/LXVX+E6uw==
X-Google-Smtp-Source: AGHT+IFat9CYqWKiYnLWAs0EVd6FZ7PSZb9/eXaufs/Tvltb/meSM8Aog6IPhuwAY3wADjmm83qe3Ul9tXpVm7VB6CA=
X-Received: by 2002:a81:a18b:0:b0:615:378a:1130 with SMTP id
 y133-20020a81a18b000000b00615378a1130mr10371259ywg.17.1712646735554; Tue, 09
 Apr 2024 00:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408100505.1732370-1-lei.chen@smartx.com> <e0179895-5d06-4c47-98f2-635175a05cf7@oracle.com>
 <CAKcXpBxp4ziNBTeNco9sxwE3TH2=GFJ4tGdapy8DGpnZjV_1qA@mail.gmail.com>
In-Reply-To: <CAKcXpBxp4ziNBTeNco9sxwE3TH2=GFJ4tGdapy8DGpnZjV_1qA@mail.gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Tue, 9 Apr 2024 15:12:03 +0800
Message-ID: <CAKcXpBxZWxVY4dmBQWOv9_oACY1u4NZLCrmpxeorQZeCtM2imw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: megaraid_sas: make module parameter
 scmd_timeout writable
To: John Garry <john.g.garry@oracle.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the non plain text format.

On Mon, Apr 8, 2024 at 8:30=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 08/04/2024 11:05, Lei Chen wrote:
> > When an scmd times out, block layer calls megasas_reset_timer to
> > make further decisions. scmd_timeout indicates when an scmd is really
> > timed-out.
>
> What does really timed-out mean?

scsi_times_out will call eh_timed_out (in megaraid driver, this
indicates megasas_reset_timer),
megasas_reset_timer determines whether a scmd is timed out. If not, it
will return
BLK_EH_RESET_TIMER to tell the block layer to reset the timer and do nothin=
g.
>
>
> > If we want to make this process more fast, we can decrease
> > this value. This patch allows users to change this value in run-time.
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > ---
> >   drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/m=
egaraid/megaraid_sas_base.c
> > index 3d4f13da1ae8..2a165e5dc7a3 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> > +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> > @@ -91,7 +91,7 @@ module_param(dual_qdepth_disable, int, 0444);
> >   MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth featu=
re. Default: 0");
> >
> >   static unsigned int scmd_timeout =3D MEGASAS_DEFAULT_CMD_TIMEOUT;
> > -module_param(scmd_timeout, int, 0444);
> > +module_param(scmd_timeout, int, 0644);
> >   MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), defaul=
t 90s. See megasas_reset_timer.");
> >
> >   int perf_mode =3D -1;
>
> I don't know why megaraid_sas has special handling here (and bypasses
> SCSI midlayer).
>
> If the host is overloaded and you get a time-out as a command simply
> could not be handled in time, can you alternatively try reducing the
> scsi device queue depth?


Yeah, scsi layer and drivers already have some methods to control the
queue depth. For megaraid driver,
it will throttle queue depth in megasas_reset_timer. But since scsi
disks on the same megaraid card share
 the queue depth,  that will impact other scsi disks.
In most cases, a scsi disk is more likely to be misworking than a RAID
card, which makes scmd wrong and retry.
We want to adjust scmd_timeout without reloading the driver to make
scmds against abnormal scsi disks completed faster.

