Return-Path: <linux-kernel+bounces-131124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E262989835C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCF1C26ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B871B3A;
	Thu,  4 Apr 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSFBUhrw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2B71753;
	Thu,  4 Apr 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220329; cv=none; b=WDVqEo/j7ampoZj5iavK95SYm1RcTGMuNQUyT/Ka0qbGt5EYx+x00iCJmzxDg33ipwee0hOcbx4TRK1gzoPf70Zp7Jxt0lifgU7pUdzb0vdCK3KVCnc3/XdTuCdgl+dt5/0XMle6fZDmPH5uKChqkEygkgyOtLZrZ+i0U/m6RS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220329; c=relaxed/simple;
	bh=nNjYtJ6W1Mtr1ivn7OkdkKbS7g/qq3oceFOOT1o1db0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNNNEOpzKYYDcSk3Avn+Wm8GRVn5vacx4jDxlFkkBcB4F6kCKWIMgy4za1k1KNYEz118fN0e0nhrSLYLXHQgRA1YbudFdV07Iwskygt7zDZA7JitJwoV/ML4ElH4130jcHeM0+2qjAwl+7DMUdeYN4pVimUA3ajeJuaA1iGpPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSFBUhrw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4162b74f28dso1264275e9.1;
        Thu, 04 Apr 2024 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712220326; x=1712825126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNjYtJ6W1Mtr1ivn7OkdkKbS7g/qq3oceFOOT1o1db0=;
        b=iSFBUhrwuKYqSn5YQCHr6yrUhN1SfDassB/mjveJ9Jd58n9MRCoXJUWqBqeyFb2RhN
         VdbNe4adJHgYtRHgDBLZYDPYLYo+KvNHKpXtyldaJQol8dbXL/q35D5jZvaiYdXLC4QH
         crByPX+ov3O/qBSvfs9qjcMeeu9OVUX8Sh0NRypobpN/3ySDEc+POhL92iXAWcl+/eq0
         Oy5meYwq42v9s0uAxyeukKX8yYweuTa1IQVK5klapUuFdSIDKJhX3gIoIb6xoc3hg29v
         wPzmXImRK/nngjTVC8wDoA/RGqIPglWhJWYKetR55UFNSd9UCSLwbRsQWMl+0vyfU8Kk
         I+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220326; x=1712825126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNjYtJ6W1Mtr1ivn7OkdkKbS7g/qq3oceFOOT1o1db0=;
        b=xT6SQzZuxByvIV1Ym1rPyLMTlbNJBCnrRBqvoEz/sNgZJjIqdYSm1uGUmO483PMsjv
         crAmsAWLZL1vY6y30Tl7J6sF6r/83VZo/rqDQHZh4C+Pdmt/2K+64Gedw86GJmZLsIJX
         mFNpSmzweSaFJtq07jCg5VU5M3FmE9PbI/F+GDwl5SFrpPgkcBfD27Q44QVXw+7foLPN
         QIw9NCNIbiyNbPyXa/pRbr44QFeubk8YtwYL+5oFINlCfqey1RFOcIVU3ucpD+m8ZOWI
         YWsjqsjk39NhwcWNIEzAfuhTNF6nDCv0cyjd832n/9yZJc5VNaTDCYRpYyNR/O7JN5pr
         vb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT7eshOEU12Uo0KvovjYVUFCJMvKkAhzE62Hdq4SvoM6AtJCpu2B8rLnBY95QVSE9KP0LMww+oO/TzESxi538c35qxkk7O6dcZZt35brO5LeoCQPXgcVYtp0ekl8n7z1sNP+TUvezppQ==
X-Gm-Message-State: AOJu0YwQ527DVTlTN/zNSPfX29BjnH8ISmDnY8M4kp8TiypZytez0/wk
	tzGCtu/yZe9kighNG1spojCsM9rsnMwDC/HPJRkLKQKLrjsf1B4/
X-Google-Smtp-Source: AGHT+IFK0eiuIzcxxHIm6H9cFcqoGlHOwosgXeeQW/AkhYd+5IL8TAtp/fI8QWyMKsjgGJmiuHkZew==
X-Received: by 2002:a05:600c:1d19:b0:415:6afa:1d15 with SMTP id l25-20020a05600c1d1900b004156afa1d15mr1373658wms.28.1712220325810;
        Thu, 04 Apr 2024 01:45:25 -0700 (PDT)
Received: from [10.176.235.56] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b004162020cee2sm1930012wmb.4.2024.04.04.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:45:25 -0700 (PDT)
Message-ID: <535d994d8498daee40fda2d044cefeeda33ac38b.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
	 <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche
 <bvanassche@acm.org>,  Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Apr 2024 10:45:23 +0200
In-Reply-To: <20240327071714.757-2-avri.altman@wdc.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
	 <20240327071714.757-2-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 09:17 +0200, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that
> uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.=C2=A0 Thus, remove support of host controllers
> prior
> to UFS2.1.


>=20
> This patch removes some legacy tuning calls that no longer apply.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>


Hi Avri,=20

I think it's safe to remove support for UFS versions < UFS 2.1, but not
100% sure, let me check and give you a solid answer then.

Bean


