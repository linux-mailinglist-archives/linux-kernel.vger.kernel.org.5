Return-Path: <linux-kernel+bounces-17605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2460F82500D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5361F23BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87517219FF;
	Fri,  5 Jan 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+A6PDIe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76F21352;
	Fri,  5 Jan 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dac8955af0so789245b3a.0;
        Fri, 05 Jan 2024 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704443573; x=1705048373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9jZ4O8Nl6KvZdW4tm+S82pkeKGiql/OUXCg3IyA1J0=;
        b=O+A6PDIepjBH/KZvRW1nsv6n3WFsKcGswoyagIsyvp/Qd7ucZvGkMNsk0RRSMb/IIP
         f8NJWnvFtSumGb4iiVtoZopikeWV3DU60weNXPavLOso2uRKSicGwk0r/WzNbnPKMPw4
         5F/BXildNmj+5SCrkOTnASPfFwC0I3Cx79Q/Sxc+TRrOx3sc64dxluWDhc0GaKpGLiM6
         U63EukNJK4B84ARDedxs4edIDfbIWbkYfbdfBo5bpTuP7qRrQJL1RQmC180HyR4o8USK
         l8Bmx1C2a/qH3zESBlRWSQcAkNRfASGfMGNcQp3MxYJEIH1pSh5gfE884t9Qs8FEMABy
         WDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443573; x=1705048373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9jZ4O8Nl6KvZdW4tm+S82pkeKGiql/OUXCg3IyA1J0=;
        b=XpBfWR7XZxE8nKZK4BxcbfyNhCvaL7GRsNaC/kjTDrQhpp5Pd6FlAsDMGhEow1dfqV
         5AZWk6wy0f97f1Y5z5iSo8qv6TQ37sNd/NKrkiecEZs0w7Ah5ZF6PmkoWg7I9Yr6xwdB
         C2smBR7kZWSzvxa+x9cSnaZDADs+jcdn67yYTdPJRbqSFt9dvNEbeABbF9bL5bNhxebv
         jZKjPLJSysSJXdl+x6KZ/fTPfYpF1a1wZVJ67V7ftFFq37UGRth/KK2+Ldt/BKiujptx
         nigogt8I/2u/oseahdeNN4fpd3NrCqIACOkobyvp/6Yq0nA7n6d8UhW1wQAuQzvodXK2
         3P3g==
X-Gm-Message-State: AOJu0YzQutcgan2rsmaW5481kqfd/FIJerH+CQqzvB91htCVBtAbY+5U
	766aPd/+rl6XHGvL1QPIBZnemjrSGNo=
X-Google-Smtp-Source: AGHT+IH1ntvac/AMVVtGorelLMeSht6kafEX1MLRbtgDmlXtQYlOHmqusemNFYtOX6nqGar4a9adRQ==
X-Received: by 2002:a05:6a00:8cf:b0:6d9:8e15:e678 with SMTP id s15-20020a056a0008cf00b006d98e15e678mr2041816pfu.6.1704443573117;
        Fri, 05 Jan 2024 00:32:53 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c9-20020a62f849000000b006d9b2694b0csm855986pfm.200.2024.01.05.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:32:52 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: linux/pwm.h: fix Excess kernel-doc description warning
Date: Fri,  5 Jan 2024 09:32:43 +0100
Message-ID: <170444355222.3793632.7146783192930134759.b4-ty@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223050621.13994-1-rdunlap@infradead.org>
References: <20231223050621.13994-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Dec 2023 21:06:20 -0800, Randy Dunlap wrote:
> Remove the @pwm: line to prevent the kernel-doc warning:
> 
> include/linux/pwm.h:87: warning: Excess struct member 'pwm' description in 'pwm_device'
> 
> 

Applied, thanks!

[1/1] pwm: linux/pwm.h: fix Excess kernel-doc description warning
      commit: 2c396fceac256ee30f7f45b24d2e3bb64f0c9294

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

