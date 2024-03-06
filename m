Return-Path: <linux-kernel+bounces-94595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD88741E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E343F1C21659
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32841B299;
	Wed,  6 Mar 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiDbFp4U"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633791758D;
	Wed,  6 Mar 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760083; cv=none; b=lJReLbHFKrniIaRlar2vG+9V1J3pJ9ZX76bourC1sfk0OG0H7FonLytmHFQPigUKWMl94BLkaMV2z2g59E23QBtRd7QKu8m/b4vH0HoCUVRCtJ0xrFMPn9kYyLiUB490eWiVA4E4F30dlkCeAPsHbULx7eoP4/6Gyaaizv0DxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760083; c=relaxed/simple;
	bh=e16KdKW/x24Z+zVeyh7H5Yb11YBnCMdLflcI/9rje7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqhAKsYu2luSs2Kj5AvWiz4MRfDSx6xp8z07H+vyS8JnUQk95jTJWZXhp8qPwZSndA06P+rp8VHFfHDPaps0gyc9jrDfSUrmCfApKCxOL17xi6DCAcDqImtqASaRM8aTjAA+HHwOQOC/hmS2C1GuAJ8NhYPh6SmcIP9UKKU3HD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiDbFp4U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso25997766b.0;
        Wed, 06 Mar 2024 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709760080; x=1710364880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e16KdKW/x24Z+zVeyh7H5Yb11YBnCMdLflcI/9rje7w=;
        b=LiDbFp4U6Rvn7IhZNAaEiMKSnjY9HPj7PotQgsysThVNC5dZdk4uNwXyq7zu5zdcaj
         esoCY4Ip2mfE1mFdG+l4uAZ3aLLQ5rz8LCYYGLpNV3xUsZ6wwpqTXwbo79AXUVyFsuZt
         GM5UFGUM025Dr6xc5fmdY4gjdKChYXIcPacOzhW2KfZ6o7qJIK44qZHEkzCEu6c2tFb1
         1CPCOuYfQA+Uul0LmWstf2hMMv4byAfNunbnKBQIr3g8NUZXJ8zw1SHRCcuSSQ37F8pS
         jG3Gh2ok52RQ/Hd6JPt4T/w2/SwtuirEo+pue0Vxlbv9KxIwFauJUhO0ncdSffLhIjWX
         kbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760080; x=1710364880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e16KdKW/x24Z+zVeyh7H5Yb11YBnCMdLflcI/9rje7w=;
        b=nWO8f3n0+Gc23TjfHMqXm8Tvg/NKfVAF+9+t8azKOiLStSE/IxcB/3Mggn3PnhYWip
         1X3f0tpTNB/6kmrJXfbjDoJXfR+ntNXyJ26NWTsfRC5oAKKbs+aGAkWWupUjkJZ3pvsn
         /evgdAozd5YZkFExKH/T2EMN4AYiHOB5zg0l6koEsXIsBme8c+WD+X7brQVEJthIB/LS
         x0hJNw0Up75Dkk0dcF2DHCnb4Vr2jimDfFSxQbjWy3Cd1R64wDmzsvSNPeWLHaqRUzyn
         NoI6r+8H5gNuvoFPwgnBQhLmhUozJX+VWEZVBWGg+gU9Mffy+FOsKTYp+j2OxniupnNV
         F20Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZiFaARP4+LhS3313qlQv/tR3SgYaqTCklq+xgFAEgiF62GcTtIPS7uGjw6GdmjsH5eM3Lulh3ZNcqLOm2z1vOy65YgR8QXcfyVWzkHmuxLZxOcLKdYNrMRdAGmbOAzGZ7HmSfR0GwMQ==
X-Gm-Message-State: AOJu0YzBcbC0l+4eiKu0a3I1i632my20LnZVPOdEnL0OiRmmqvAMUwCw
	VvZEVaLPRdespq20zz17l4YE/6dGTdzIy1px8o43X2PgMEgW4QO8
X-Google-Smtp-Source: AGHT+IE8iWe8jGIKvd6r1qXa4ZrjzK4SAUhcFkBkouJVwwq67MzGTEDhZBJg+ap1jVLcCnAZkDhcww==
X-Received: by 2002:a17:906:19cf:b0:a43:ab98:d376 with SMTP id h15-20020a17090619cf00b00a43ab98d376mr11920510ejd.15.1709760079545;
        Wed, 06 Mar 2024 13:21:19 -0800 (PST)
Received: from p200300c58728635f85ed642449045909.dip0.t-ipconnect.de (p200300c58728635f85ed642449045909.dip0.t-ipconnect.de. [2003:c5:8728:635f:85ed:6424:4904:5909])
        by smtp.gmail.com with ESMTPSA id gc9-20020a170906c8c900b00a4498726bb9sm6393814ejb.173.2024.03.06.13.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:21:19 -0800 (PST)
Message-ID: <9d73b3252a74c0a0c1f7ca269cd91c553ef4f52b.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] scsi: ufs: Re-use device management locking code
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Mar 2024 22:21:18 +0100
In-Reply-To: <20240305210051.10847-2-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-2-avri.altman@wdc.com>
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
> Group those 3 calls that repeat for every device management command
> into
> a lock and unlock handlers.
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>


