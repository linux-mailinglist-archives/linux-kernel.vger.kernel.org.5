Return-Path: <linux-kernel+bounces-13456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29F8206E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B401A1F216B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880699473;
	Sat, 30 Dec 2023 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTfMKHZa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA028F6D;
	Sat, 30 Dec 2023 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d422c9f894so49000605ad.3;
        Sat, 30 Dec 2023 07:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703950331; x=1704555131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aQnswRfvf4BwrZOcbpjhGTjzzT98U1IdJ18XjrAJzU=;
        b=MTfMKHZan78qBzQSC3v6n4B+LpaZB7mmmzXgiwo7K99qJyvinQ45bzOSqxgeiwZB7v
         nDNW3CGYCz9EGZw7PXIT59xR+9cqOPRV2IoSE/37YVZgpj5XVgOBr1eK/LioYjqMy6Gt
         8hcw5+p0qSKLETucYs/eXgEB7WS78DFq4CGKvsOyhSMLixNgK9fQ0bHVQHuqSp5EBhiE
         xphXGHS4IYE61BAWZPDnd3ZTzgw77CZKB5dk5zBCOYMJ4qAA+IQ7hHAWcNxemWzBseiN
         KYXPf89b2vWKN0+J+l+oj8QA0CZKwsaasuVntxLOtJRfMu/62YRuiXoHEP+7/Mn5KvOS
         fxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703950331; x=1704555131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aQnswRfvf4BwrZOcbpjhGTjzzT98U1IdJ18XjrAJzU=;
        b=p7ii6fBj3ni0oVJI+512iPGxJR/eQzqXXRXqPcuMLtHehXinRVa1XH7WsMGQvPW6k0
         cQZGb8A3jKg3AJhGDJfjqXZxRpUbHDEjsDLCorlaEnfi+UC3bNxpCuAsbrIPV1xK9pud
         zrbP0mZRj5jWzfZEtDc3rgdN0ij55h9KHzs4NIcfwpa0VkIcqp/k7myzHIYJj/QFUJi2
         xDEQVd2RxfZuZtfeGSp46IOAmGFm1dv/rU78prdnQN31Vifmcr8h1KZ66nC/5Y8pOdN8
         QCE1ye2JRLBT+uAIpbjVMDLgEDlWvXlwsrCUwrXNVvpI21q62Z4ZH0n2gIEPV7TzYTvv
         NypA==
X-Gm-Message-State: AOJu0YwQMBxRzKfDpUxaprFO3hIxqtuXgECe9O40uZ7Tjeqt8Q4KDIw2
	7LNUSBFcsB4YY3JilcxgbC0=
X-Google-Smtp-Source: AGHT+IHhWDBSzfIZA4m7vsfoPPCYdAoRPfC1FFKRZhMnHzCX2ZKiEcTFknXXcIQJBqto4e5O5sW/Hg==
X-Received: by 2002:a17:902:7590:b0:1d4:1bcd:6bae with SMTP id j16-20020a170902759000b001d41bcd6baemr13040572pll.31.1703950331583;
        Sat, 30 Dec 2023 07:32:11 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:9802:680d:e03a:17cd])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902ee4500b001d3c27e00f2sm17471750plo.284.2023.12.30.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 07:32:11 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: jonas@kwiboo.se
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	sfr@canb.auug.org.au,
	sigmaris@gmail.com
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Sat, 30 Dec 2023 23:31:59 +0800
Message-Id: <20231230153159.3748580-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <97faf49b-0109-439a-accf-251b502ad40b@kwiboo.se>
References: <97faf49b-0109-439a-accf-251b502ad40b@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonas,

On Sat, 30 Dec 2023 12:49:38 +0100, Jonas Karlman <jonas@kwiboo.se> wrote:
>I have only tested this fork of fluster with ffmpeg 6.x, what version of
>ffmpeg did you test with? I was expecting it to also work on ffmpeg 5.x.

I am using ffmpeg 6.0 with v4l2-request patches from libreelec[1].
Ffmpeg v4l2 decoder in fluster fork is using ffmpeg args:
"-hwaccel_device /dev/dri/renderD128"
which make the test fall with hantro g1 on rk3588. After removing it I
can run tests by ffmpeg v4l2-request decoder. 

Rk3566 and rk3588 are sharing the same results:
JVT-AVC_V1 test suite with decoder FFmpeg-H.264-V4L2-request:
 Ran 127/135 tests successfully.
JVT-FR_EXT test suite with decoder FFmpeg-H.264-V4L2-request:
 Ran 44/69 tests successfully.
VP8-TEST-VECTORS test suite with decoder FFmpeg-VP8-V4L2-request:
 Ran 59/61 tests successfully.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Regards,
Jianfeng

