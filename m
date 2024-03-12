Return-Path: <linux-kernel+bounces-100445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09C8797AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BDE1F21ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E627C0BC;
	Tue, 12 Mar 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akKK4m7q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667507C09F;
	Tue, 12 Mar 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257665; cv=none; b=Br1XWhqq6C5jZG1a9hrwhrM6C6thPSeWWLZLvKIkHucIh/0ZfqA3hgliK4k4snKFsv3jccM7BRpjXFAEnAlsPnO587KO9MNeGNIheh0D2OAmEqXi9ZluBkjmOxpWVzDIbdhrRPiPNOcGIO6benxNM43wsrTTFvnTtvVYAwv9hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257665; c=relaxed/simple;
	bh=NTT4vZyCf045pq+UcdflHRXPoL5Hj1INbxxNA9aOAc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSobOu3Yi07XO1bicVqUbr/1wjdXmMU5zxcu4xkU+ZacfMPkjJyTmtoCtjXXHLfuMvEyZVtK/qwdOfIurk1v7IajRtPL5AgozPE5tKecUCCkf+eS0jVe688z09dQwrnAKyz+WOc7i8cVCHq0bwElfCoonngCQno0ygk5J9zMuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akKK4m7q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e66601f082so21803b3a.0;
        Tue, 12 Mar 2024 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710257664; x=1710862464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NTT4vZyCf045pq+UcdflHRXPoL5Hj1INbxxNA9aOAc0=;
        b=akKK4m7qPlU704LiVpA8ZDTk0sY4CCtdg6RczQ5VWlyOH1OaF0yBgQMUOSy6bCdiVi
         d2DQgmk4e1SvnnzFITKIjnk4DCpZmY5DPL7BYA/kHeLKCdUCJ9O2jhz725t9TUC+VfeH
         9HPnAZWekYbJXIgBdLNHv/AMA62xxR6yVO3eFacb1WxyT4wh3pVMo0CKSLi6/zUAH5MK
         D4c/MFbi5IOtU+2+Rs4Sf5TbzlwOsdu9yqVhe/0UxceeqZwzxV5oS42JsJzTTw71AVGD
         OSU3VIKao5pB3rOvT0zlc/uOZ+OwrynzL6SF67J+koHKdy20Xakw0hIBuPPATOeGqknN
         eunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257664; x=1710862464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTT4vZyCf045pq+UcdflHRXPoL5Hj1INbxxNA9aOAc0=;
        b=lhxBr94v9AC5kcqiRhtLKq/QRBuaqRzzhYJ577bhEcR4fLSSzdY0uycaK87M+yedPl
         OGn2LOyJo2PXWU7VCgxUrzM81AGQLxBWwPeftD0gS1/csm2rcrZ7mS5zHv24ZJxFky3T
         VCliozdjS0fYhBo6twJ9MvZlFHDfNvdtHEPi02ecDh9nNhKxZ19wX8ssJiTpREapn+tR
         lGn9A88ub9ke61xNte4ddh7p+WDYDjNSItaiQDiNa1JNSOZzdmrqShfyrMYGFcwy0FPo
         EDfK1gqJx6AHM+NtWgFZ4qzhS0QegZQI1Cj2dERHP4WRu2vPy47WTk7TAj/E0DT5FTax
         L4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNUGHxShXKG5wnzl3RsF+5pXL+sO+fU/MEk+AiC8CHv1esD0FSCgtG97QN1is+Ltc4/kPi7YG72Cf3n336GMI2VRdfL098NVIvd2mNSiQfTpwkr48OyYks5G6s216q/ORVfXPlpAKcw==
X-Gm-Message-State: AOJu0YytN7lMF42wPcKLMqKvrB7jhEyy/6/+3PnAp6pJ6HmLncO7JoMn
	nlVUKIiWHX6+3RjfET1SMd2MAEkGZaa34j6bJIMOkIvpCTamZsOk
X-Google-Smtp-Source: AGHT+IELxK3b+RbuazNAVgYXGg12TX0E4AVimgM1jUeXX9liCsI2uPkLhdxekrEAmkmTh4vVcqyVxw==
X-Received: by 2002:a05:6a00:1acc:b0:6e6:a3ed:76a3 with SMTP id f12-20020a056a001acc00b006e6a3ed76a3mr718338pfv.11.1710257663536;
        Tue, 12 Mar 2024 08:34:23 -0700 (PDT)
Received: from [10.176.235.119] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id gu20-20020a056a004e5400b006e55a21ac02sm450580pfb.152.2024.03.12.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:34:23 -0700 (PDT)
Message-ID: <950c5f7f1350ca333972040a660bbedfcf6682a6.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] scsi: ufs: Re-use compose_devman_upiu
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
	 <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Mar 2024 16:34:19 +0100
In-Reply-To: <20240309081104.5006-5-avri.altman@wdc.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
	 <20240309081104.5006-5-avri.altman@wdc.com>
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
> Move some code fragments into ufshcd_prepare_req_desc_hdr so it can
> be used throughout.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

