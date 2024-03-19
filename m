Return-Path: <linux-kernel+bounces-107319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5787FB03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754711C21C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE307D098;
	Tue, 19 Mar 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFqela/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAE7CF39;
	Tue, 19 Mar 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841368; cv=none; b=hZNJAM7C3WxdaGFwLwge8ECdyTy4Ihivzo9PzJsmoaqPNPh2gwB1TU4Sz8SF8B5NOF31cZuFwmn8trVwxVyjng8DgMd7GqSFDsfQFhtVQ3bdiAxd2kXmVq0KE+L92esA4h3U4eWI05IJWVzGzdMSfCXJfi9a7I4j5nJ582jQfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841368; c=relaxed/simple;
	bh=VoxZ0wAIPgZvjeJVvx3sbrLqugtTMSD6fOtPdH0GOP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zr8cVZmH4oTIfihWuD1IgqQ79RerKQiTPx+2zDvwRbbJhz22pPcpQLKX566a6BdEM0LtRcV2Ptwn7RAOwU8VGTjrkai2dijTtCACRJE+3dHV2qZUYdLw8c57pPAHjhdPEUnKUw26ab81Urii0Z3vFtYjRNMQo3NIyl/xFyMhxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbFqela/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso152087a12.0;
        Tue, 19 Mar 2024 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841366; x=1711446166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3Jc7JexdJWOSk6A5zgkFucGWbxIC8CCsVzJZltost0=;
        b=YbFqela/BcYU+SFSwJbsO0TWOI+WnM2LZLcqWALh1FWwI+fEATd18n91DXCpZoPu5+
         KDevyjAi4CxC9q3cOxaNQkZsn9isrmX6SW7AxoCmNuMN55dFgkRJWcKxqsaK/4pTPW0/
         i7+RpoguAlNiC+Olv9jk/q+x2FoBOFhBQCTxlJlnbiWoUZYsaCj0Wol0w5M+RG3B+0Cu
         y4SInra0tjAUG56lalpinbCe8b1RMHb9bN8f4pwDkWGQ3qY0WlKmSW/YvkoRtFpy9KTy
         CaE6geJvuvIA3AadFs6hC+aLPX0Z/2bk+72Lew/0g5BxRrcuOANdssnCLDeekMngajrm
         q6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841366; x=1711446166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3Jc7JexdJWOSk6A5zgkFucGWbxIC8CCsVzJZltost0=;
        b=SU9AIkZyqUhTXNdf1m45owMg/mWxg2lmuggF1bD4EqTCfu1zTz1IqGbv8Urn2OpGIX
         U3IdsjX01qmbZfsSEHk3utNE7rPEllog2TIrA9tMMsp9S7rOTs10If/QpIuLbw0uoKN/
         QudUFEzI89kQE6oM3kZ9JlN0RN5C+RJ7vdPqzrgptn5tI3g79whObff1Af/8pMXX1B3U
         V5erRP1DWDcW0RZ1O59EajrCaOx4BRzhVOm6+34dV+xlBfQXe6oVMBe19b2vJd/m8Frf
         qKOlMPMhChJN+eSALbjTHPtkq0wzdK6seOkB809gQFkFpaamyQJn6Nk8faaQnYnOtSQL
         r9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUQNJzG81O7080O8vBAog8mniv2j+PT5iKx3tPWsCiX0lFMSr8/TTJXuCNxRrdCM8xF0cXAR4FHvopV7i61XJenrg/AXi6c
X-Gm-Message-State: AOJu0YyuVnEQf6qe7ryhoRlQHoJTI2R/2BPZA+qgdN/OgdlFXhKbsNCb
	m08v+Ydjzyj5EcV3MortD48Wmx7d0nKG2OYrwZyxlWy5YIDZbtbFtXaWwsmkBcQTTUDLffSVzqS
	tV8zUSYmdECQENNQxVRPFCfqlxPA=
X-Google-Smtp-Source: AGHT+IGc/LLvA9JX6rB7zk19QS3UES3qWoQ1gM/EyNWJ9NfQ7ECIeml/JglEJv8Y/Tz5bUhkWVPcWAbT7RuWFBudizs=
X-Received: by 2002:a17:90a:2ecb:b0:29c:75de:bd04 with SMTP id
 h11-20020a17090a2ecb00b0029c75debd04mr10377073pjs.3.1710841366279; Tue, 19
 Mar 2024 02:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311122401.6549-1-lizheng043@gmail.com> <20240311135117.GA1244788@maili.marvell.com>
 <CAPCnf4zS=FN0MHM2tQV0b468zN0yqRHbaNMsk3cDQ7Vu8wiHKA@mail.gmail.com> <MWHPR1801MB19185089A3147123D1E877D0D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
In-Reply-To: <MWHPR1801MB19185089A3147123D1E877D0D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: James Lee <lizheng043@gmail.com>
Date: Tue, 19 Mar 2024 17:42:34 +0800
Message-ID: <CAPCnf4z0gp47TkxP+PFw3bd_Weh7=jn9Q2t-z6QB654Ckc36Pg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
 connections be established successfully even the ARP table is full
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "jmorris@namei.org" <jmorris@namei.org>, 
	"James.Z.Li@dell.com" <James.Z.Li@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's not an issue, the loopback device can only be created by kernel
itself, loopback neigh entry also can only be created by kernel, one
loopback neigh for ipv4 ,one for ipv6, impossible that the num of
loopback neigh entries exceeds 2.

Ratheesh Kannoth <rkannoth@marvell.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=B8=80 23:36=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: James Lee <lizheng043@gmail.com>
> > Sent: Monday, March 18, 2024 2:09 PM
> > To: Ratheesh Kannoth <rkannoth@marvell.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > nhorman@tuxdriver.com; davem@davemloft.net; jmorris@namei.org;
> > James.Z.Li@dell.com
> > Subject: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
> > connections be established successfully even the ARP table is full
> >
> > Prioritize security for external emails: Confirm sender and content saf=
ety
> > before clicking links or opening attachments
> >
> > ----------------------------------------------------------------------
> > loopback neigh is a special device in the neighbour system which is use=
d by all
> > local communications and state is NUD_NOARP.
> > Any setting value of gc_thresh3 might encounter arp table be full, manu=
ally
> > increasing gc_thresh3 can resolve this issue for every time, but we hop=
e this
> > issue automatically be resolved in Linux kernel for all local communica=
tions
> > whenever ARP table is full, rather than manually operation as a workaro=
und.
>
> Issue is , these are dynamic entries which cannot be removed by gc.  And =
there is no
> Threshold applicable on it.  I feel like, this may be exploited.
>

