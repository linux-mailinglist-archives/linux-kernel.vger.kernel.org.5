Return-Path: <linux-kernel+bounces-88621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C095286E44D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2051F2679F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30A6EF1D;
	Fri,  1 Mar 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rf9/NDu0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631E1C33
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306930; cv=none; b=MfH52uwpiagYScOoMN4EHoTxTAHSdcqss3UtklRK/m/JNLdiW/RC3ty7D+9D12Q0u606MRzcWMhmFFL+XGzjYbU7qeYrVzVcz1ZOHXoDp1cTeQVibxXRTWSRRyrTQcaBkTFZCYtzWGEbaA5NU/PXitNKXfayaT1DOMl8Z7lpOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306930; c=relaxed/simple;
	bh=V79S0AcqOHxYCtN03M3/RNtHhAC92r+ITa1cgvX9Hk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cKbvUZ0yu/jQhJcr7t/iwKrF4pw2xn6dE6sxJG2eLIp4RS7KmqPZWId1TYELl0RQiH1A2WtirSO+OCw1H8+EC10hJBtBuU0bETRYIH4jq7ub9ui4IczG3P4gili7fWS7rLV4KJj7Fl92mIRUBrESOi8Rc0JI3wIucFIETaA87/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rf9/NDu0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so24505591fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709306925; x=1709911725; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNTA2Vl3+hBLcp2L5qFBQu/x5GLlzDoP1qQamQQoMng=;
        b=Rf9/NDu0CxKM2foXY/U8BUASTwSof0VcJGZM//gJye9CZEfGm3LEK2vshzBmcqHAQG
         HI8VG+csv+XhDjX2hJmk5cy10sEoSo+M421we4HJbYtAAM7MGOBd5DEuJ6mAygMcYgQ3
         rzkYpIJM/3Fma+WuSkH30V1VMGCS2e+RIQeJYjYc61QpSmlzvvkKkj13nBBWl2EtVM1y
         E42Rah/IU8IIjlfPNyWjnx0u4wI36iAPYIB+tiTZ5a1qa3Kq20C+48zHdCgMkwXexnXQ
         6sUt4h4X3sN9MNyKsJk/wnMPCEmSxUKxpMXkENGDDwgVsCaLU2Gi2eisvZYfRqROtFyu
         JRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306925; x=1709911725;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNTA2Vl3+hBLcp2L5qFBQu/x5GLlzDoP1qQamQQoMng=;
        b=xDbovwaSqjCv+CeWwKGEXXyiE2y282PA42IjF/li3dfRuMOJVpGidVO1Pmb7EN3/cw
         2UjDrNGHEZG2MEnYOZfwtmZXuNFvwJNx64QuVTc0JjKXrYJwx63yTpQ7idLMbBzldCVs
         /pefQYxZ8GEOIEi3lXGbLV+DfQjoU3vnOs3QXgCC7yhpEmEVpGx6e/uS6VuAZWjHJme7
         SynIylR9GMyJSRWWx/trDc/jTGZ7ic6erDXXLWQfCZhtnGcIEDthTjmPTzPvAe79d5MW
         J9xpbiEexvHLP6eHPHVsFDdPQ1TxXlH0MX9kD1h1zEdookGH1DfUyDYD05VyM7bFQ3ir
         XBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXD6w0WHKhft0aL1L4xF571y67F4VFJcWpIOaQEc1Y75A7twHQrN9lrhilPPfMstntGbeZfmgwDPK+K/7z7GPzDIlbdobS1xFmP7PEm
X-Gm-Message-State: AOJu0YwGVV5pb5w8kgVgeYYmvybmp/7P1khmxOtMz1Wi9LQOwFGr5C6t
	iFC19gykCkRj+OkvDjAFcWWe+7USIsBx5s8bgQzwE+O97oEcgnaKiE60QWYFkJQ=
X-Google-Smtp-Source: AGHT+IFHZBuwnnBlvXg14wNKZlr1xSKzvhRDYI2NQdhhnY/vnXCfkaEB3OLwoodCwFXee+uc2BdxYg==
X-Received: by 2002:a05:6512:311c:b0:512:ec53:5915 with SMTP id n28-20020a056512311c00b00512ec535915mr1334997lfb.15.1709306925008;
        Fri, 01 Mar 2024 07:28:45 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm7674242wmq.8.2024.03.01.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:28:44 -0800 (PST)
Date: Fri, 1 Mar 2024 18:28:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dylan Yudaken <dylany@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Dylan Yudaken <dylany@fb.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] io_uring/net: fix bug in io_recvmsg_mshot_prep()
Message-ID: <7f5d7887-f76e-4e68-98c2-894bfedbf292@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The casting is problematic and could introduce an integer underflow
issue.

Dan Carpenter (2):
  io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
  io_uring/net: remove unnecesary check

 io_uring/net.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.43.0


