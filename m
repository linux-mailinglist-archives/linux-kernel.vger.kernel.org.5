Return-Path: <linux-kernel+bounces-139106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18A89FE97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C64A1C22934
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AA17F373;
	Wed, 10 Apr 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMYCZLem"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641717BB38;
	Wed, 10 Apr 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770414; cv=none; b=dac+r4lnhu7i+pzBDOE5mV6Sf8zrB7QoLAtH83C7n4iCp00uQhg0B1Ia9Wcj7Eq6uepjboKhH4/ptWG0+7cLHM+iKL1dmPmVQNQ4poSe4iaHbYzeEP+LfTiMXhh1QxjFx8XWr/Wzw9JicccHLTdwpamiqcAUjd9uKWClYg4+wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770414; c=relaxed/simple;
	bh=xODv+YwTcyoEbclY4dNpd4xlX4hgVswy/9vscvUzER4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMC2uDIoZpECghYlmPpSnJmM6f36zxtJZm2Oi/BwGqdly6OW3OZOb7A5sM0lgSD4m0q8gruKBMRHV+t0Gwsfs8x3gHRhwe2ImV5wOaX9OfEvg3r9IaREroSK2iIdfiERCPOeU/t2HwAtkN2wJmwnMzASVzlELmRxuE1eP27le2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMYCZLem; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1316481b3a.1;
        Wed, 10 Apr 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712770412; x=1713375212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xODv+YwTcyoEbclY4dNpd4xlX4hgVswy/9vscvUzER4=;
        b=jMYCZLemxw4iXNlVzxS+N/GHl1gIPU8LsY1ebbJAsnqoPMg7ldMK3RDiK/X6B+Sz8X
         +o0npeNg78bU56EgOTPA/qubLciDirIK5z2lYJySspE3uceRY8MR5ks4w10pgUbIcI5N
         s/j1d+oGx84vJ2t9zMipQt+9jGmzVY/lcvi+i+DHoUOyFlFOVojDmpBh+aTyUpjDLieR
         tQcWvAvplFfKsrRiRsRbq3GHoRHJBPaaOLLy5nRGxvXjHQ6LvG3hqPhQQdkydFHUPrVj
         QqrkCuDlUu9+N9sXtmtQNlzZkDFH59pAQMokjg8ypwhSMoiQVcrbDaR7eF6abuSPcWaj
         cnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770412; x=1713375212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xODv+YwTcyoEbclY4dNpd4xlX4hgVswy/9vscvUzER4=;
        b=ja9vwtomusHityqXKSoPRMtQZ4LKx5L8gUCD4QqjtOV+OGQL+06t0Hi0giPlSXEFme
         rNtvGrMgPELUFXqaxDDWVS3L6CzoaYG6u9LSoRMeq6+d0YbdrUJFvDgk5c5/XKDpewQo
         trxbiAcwoN+6pj07G7gttqgTVdV0rzc+Hvu/Nqn/5f7jcO2er96JAchXbEbHNnnlmOYG
         /G9xDyrqBo1Ca+Q3Smbg/5k7Y2ddhYmoJlwf4Bm1qgieasb0dU5Uc2IL3/5K2gAZVgP8
         iXnO33VPHgcvCm3pABrSeOQw7D99TxXcqtQ2PA+/CQW6q2FY5Sq3mxnho2LCWaDrsbIy
         XYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5fmpROaPx+PWaJ+KAQw1rvIu6F8XrKDRRTtwOD5YZHhEaAht4hnun+Bc2OTPJWr8yJizvpQNlO+jsEHE4IOMTr3PDYiy/Bm0W+3CjV7cgo8vNVbIdrqzS472wnNLFrhcAlw1riDdKWQ==
X-Gm-Message-State: AOJu0YxeJf+9amTynn0vlaO2EcXjwtviAw1evBPuRNCQuS02YpeSDbXj
	V0/mzw2kpcz0h126BPAr0RTK7njjSdhr3nn2BJDNj/PxhkInkObxM0NW5EnEgmLMuzRJ
X-Google-Smtp-Source: AGHT+IF2oPoMCMFjgJy0pGIOQEvZP1Lg66viYwlG9lUpHiDsZ3hIOK2G/eMecblgfcS5fb9E29wX9g==
X-Received: by 2002:a05:6a21:2d8c:b0:1a7:590e:1fc8 with SMTP id ty12-20020a056a212d8c00b001a7590e1fc8mr3376025pzb.17.1712770411655;
        Wed, 10 Apr 2024 10:33:31 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id v13-20020a170903238d00b001e49428f327sm3640303plh.176.2024.04.10.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:33:30 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: shawn.lin@rock-chips.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from vcc3v3_pcie2x1l0 on rock-5b
Date: Thu, 11 Apr 2024 01:33:20 +0800
Message-Id: <20240410173320.191923-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>
References: <432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shawn,

Wed, 10 Apr 2024 14:30:16 +0800, Shawn Lin wrote:
>Could you help try this patch to checkout if it works for you?

This patch works for me. Thank you for pointing me to the right path!
Looking forward to your fix.

Jianfeng

