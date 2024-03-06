Return-Path: <linux-kernel+bounces-94627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10687425B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB51FB20D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0B61BC2C;
	Wed,  6 Mar 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/cT+ymp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9551B941;
	Wed,  6 Mar 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762718; cv=none; b=XOmNFa1Ls0XVchqOOLUD1FBF8K3MmvXB/71Tu2c544yOw5NolOvU/7sE+4X3P4yHgwWKgPqQQ3p1mIMgOcaDDrcgM3S0UpCjpWxpN4wXnxBvjddsJhuQABiqnE3Jv2Uo8+SSBRBjIRzvAaIekQZyhmBadj4W2TXunyFxeETe/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762718; c=relaxed/simple;
	bh=S39nLjr8vUhAkwYfZaJ21Wp7XOABo31SGFbLvNClb6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EA2vkvEz+RHWxVgMYrvUe/OTb0mQJhCjSyVERiGK9ybvwM6iraWqUtLDrLQtLJKMjFoZRjwBOaefVbdErBtz5NgDQ9rszEB0zKHuKnQeXqveWoce6DPgbyplMWcZh/aV7j/8Ie4aSA9oY+a9u6otefbVBStWICwL0pL+ucvXyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/cT+ymp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so257313a12.0;
        Wed, 06 Mar 2024 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709762715; x=1710367515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S39nLjr8vUhAkwYfZaJ21Wp7XOABo31SGFbLvNClb6o=;
        b=d/cT+ympDhyFcyftHD4rcIei0OfEB/4oTHqtKNsE/z/CXgi1oCB/l5t40f4Bmu1Ylt
         dt6AAz8jIZWQ+15iCZMK5hgjkWQ7mHL0bGQyFfPhgqZ/hyne9WZKmcxQXtgDg8OSmGPP
         nMp+RCLcgk7beZe60ewTL4GbHfLAI7iBrSaDVxtoDsy9f4PTvLmVZe6LdKFu6IqqK0d2
         OdAhrZcnFIf72A1k0aqX8gK/hZWyU0X0ZBOEk1BdOANgtczOKoNV1n2zjW3awB8p2mik
         7cCqEFHoIHnk7A3jybw9LGNqPMuGqKA8YuomVlN3DIopbd8irYtpOMqcfGEo1KFfHXg4
         1YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762715; x=1710367515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S39nLjr8vUhAkwYfZaJ21Wp7XOABo31SGFbLvNClb6o=;
        b=NrpIoipGNw26zTGO6p122wIY7hCTKHEjqlSR1mW0PhS560qFHkcZVONkWjVubsndY0
         q80LPznI26ovkxKjP2ASdNHOgWz551GIWF9ldjjpO7lSLgwHQtAb1WLCJOH0aJMcG8Nx
         W7S03EssKZNSHhYe9DOJkU3Gl+qvicD1avE03Mx7RKlC/eutP2I7f9GrKLeyI/IHePTY
         q8q4fd9fBJy8SO+U7Oa+unKIghzfJKSunLXpNFr++z1igoUw3F2x0GicJlwCoBFT5HD1
         uTDX0ZcrUtwyKFwiG+hPG/5Z6z0HyBkjCcXwv5d+4wBiER2YNtQOe7yZUIozPRXNMG8R
         1wmg==
X-Forwarded-Encrypted: i=1; AJvYcCWbiRe4VtLyMGqdEJjHkDzRUxTagBegqXApk5tMb+gDbJNOTVZ5lRQUGnPux0HyDTujYJvev5PkhDwPDhGtr0uVsLWSWPEgiV/ro2JIuimZJgssBk7u456dImtHSla9Vr5ad3URwkd4jQ==
X-Gm-Message-State: AOJu0YzrFrzJjBQMBGF9Z2iqxiNjtQ5NICJhGDa8mcLnMV9mv1WY9bw3
	U46o6BPXYw+r+htp0lGsetjQ2R+yg7x3VnkA7FWGFdFlY3SQpKTn
X-Google-Smtp-Source: AGHT+IGB2ZQ6CV3Dgb9Plcw39baYRs2294dWUkYQFCPbAtSa6a9RS9YTHjl/5lEIe5SL+Wygssej1A==
X-Received: by 2002:a50:cac7:0:b0:566:d28c:e627 with SMTP id f7-20020a50cac7000000b00566d28ce627mr11490259edi.36.1709762715031;
        Wed, 06 Mar 2024 14:05:15 -0800 (PST)
Received: from p200300c58728635f85ed642449045909.dip0.t-ipconnect.de (p200300c58728635f85ed642449045909.dip0.t-ipconnect.de. [2003:c5:8728:635f:85ed:6424:4904:5909])
        by smtp.gmail.com with ESMTPSA id j16-20020aa7c0d0000000b00562149c7bf4sm7365155edp.48.2024.03.06.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:05:14 -0800 (PST)
Message-ID: <6c75ce4cc05c6983137e954043d5ae7323a96172.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Mar 2024 23:05:13 +0100
In-Reply-To: <20240305210051.10847-3-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-3-avri.altman@wdc.com>
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
> Move out the actual command issue from exec_dev_cmd so it can be used
> elsewhere.=C2=A0 While at it, remove a redundant "lrbp->cmd =3D NULL"
> assignment.=C2=A0 Also, as a free bonus, call the upiu trace if it
> doesn't.


This statement is a bit strange, what it is "if it doesn't"?

from the change, the patch refactors command issue for broader usage
and enhance UPIU tracing, isolate the command issuance logic from
`ufshcd_exec_dev_cmd` to allow reuse across different contexts.


