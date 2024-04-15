Return-Path: <linux-kernel+bounces-145426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5038A5600
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F46A1C225DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E057E576;
	Mon, 15 Apr 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uBV7N/na"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3179B84
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193600; cv=none; b=aQbC9NlRw0a3HLnHpgqmaTbI+PFii430OJ9bngDKz2f24oZfa99qh8HmSArae+39O7FkkfPu27g3kTUVueFO/j+S6sGsg+Tz8X8b7axRwYymdsIv8yATc1WWzVoIFBo0pdJ9Me+S7NRaj4nCzVlgAk5ZWRCGytnSOfWb8h4GacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193600; c=relaxed/simple;
	bh=ACwuhXQnvEF/hV0r95JlwFy5n6kf1JPHYsrQCK8Kf6s=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psTXUAz5Q9fO6U2Fem+8DrGNxOzVXwf3/uaArBP7e6TcTHKWx/VY3S+UtaTg8YB1XXa2XhoXJ5zVbW+BjGEGuk68LliabKtWAr/ik7559JNS420XUpev3UpID2n69k3uF7iuhc3XdyYOAGGnc4Yz+nnlDTgYbpTCLsSlST/MOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uBV7N/na; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C058D4031E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713193588;
	bh=ACwuhXQnvEF/hV0r95JlwFy5n6kf1JPHYsrQCK8Kf6s=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uBV7N/naV7RHdasrQ3oFNNc0qqhpyw9peah1xiNzX1nuDV7x/oMauDZ1F+pVwmuaF
	 ZPuAR9vlyv0DJMI40tjQgV3Q6yfZAjc7MDx9p4LqbMenZ6JQ+9eZXwD3Jo4d9w852r
	 yIdozMvZnVjMWn7SbriD3LZos8sHsjNeEUA9t0UIBWUrFRZbjuFRbgZBv3973hqdWW
	 rJZYwtGDlUKj5VFLexp2UQUtstfrey+sOtHA2MPAqO3h9R0QPFGrqdf4kyO9Uipoav
	 srDL5CzfI6nuxNBq1NubVBBzUA0A3BVHvwLx2FSdKLTtN5/J5f2Ksyrv4aUM/sOuNU
	 I45s3uPoLAZYg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4348f151299so44955791cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193588; x=1713798388;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACwuhXQnvEF/hV0r95JlwFy5n6kf1JPHYsrQCK8Kf6s=;
        b=jE/p7Ro+ZsUBj0R/jYD+Nn8i0goh2QKm+Y0VyPCJMpHaXuAmehj7glFrSp5hOIac/d
         Hl/XYMpWTRJt6S0W9K7HMXO5STh9kMrMUey85YqL3CYC+kieGnUsFJ6p/xlJ2S2WG9sI
         VZqouhuTB+OR4OXTZQBcXwIq0qGUUilE0eMApuP/6hRE9TPiwhsTBIYs1gegfHqztFA/
         KLnhayTQoMkLs1XRu3k10c5RjdF9WGAmfU/xSboxMXpCMQXWImk+HEIGlo95HTL+cuDI
         mMthjLtGvRyMVk8omTcGi1CV2xyIQxMd/usKy9yftQtG5jRU/ku1uiynlgNqVzwXGSd8
         Z/rw==
X-Forwarded-Encrypted: i=1; AJvYcCWU/Y4Q/pJRnVTnkqTMicXn+yAKnrzYvAH4OPUdNxBsdXXrvP9O1PlQN2zHFpMH8CEmccFgyZRRZ3ovGxmHwDz7C74L2Wt1UKmDOEIx
X-Gm-Message-State: AOJu0YxV3lgf7RssnsN5H9d/DdEFpLIfMWruEE+zWHtaVm4iBp1jsIED
	CFDO5mAH9T5AcCRnRJ5bVJBAinrrXkV8b+cOYN0al5aFPHJ18EqQVS3OecpoAE1SsbgGAP3CKmT
	VLDJqcAl6alyo1d6vIf8J7RNy4/ZqITygRjgzl7SCqtP6MeTS58aofMjwoC7qoFv/S4n64TpW8R
	pNkPMW+53kGV09l56GGIyoGEOBXKHM0cniPBokRaa0hUtbO0iq3dRX
X-Received: by 2002:a05:622a:4b12:b0:436:b123:55ff with SMTP id et18-20020a05622a4b1200b00436b12355ffmr9754563qtb.49.1713193587815;
        Mon, 15 Apr 2024 08:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAxaLjMo3rAfRURiOBsbEy16nq0/dLKE9lc5CMmTWJgal5h8DTe6WD4CmrcXUb4G//Sa0GxBleowzaGmTznrk=
X-Received: by 2002:a05:622a:4b12:b0:436:b123:55ff with SMTP id
 et18-20020a05622a4b1200b00436b12355ffmr9754533qtb.49.1713193587537; Mon, 15
 Apr 2024 08:06:27 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Apr 2024 08:06:27 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
References: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 15 Apr 2024 08:06:27 -0700
Message-ID: <CAJM55Z9CpGCJ07kJ=eoSCJBg=qpHurq8j_dBMjkTNVsb25VyJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: visionfive 2: Remove
 non-existing hardware
To: Hannah Peuckmann <hannah.peuckmann@canonical.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Walker Chen <walker.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

Hannah Peuckmann wrote:
> This series fixes the device tree for the VisionFive 2 which has nodes for
> non-existing hardware which should have been left to overlays. It also results
> in error on boot when both both the TDM and I2S drivers tries to claim GPIO 44.
>

Thanks! This fixes the error mentioned in the commit messages for me.

For the series:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

/Emil

