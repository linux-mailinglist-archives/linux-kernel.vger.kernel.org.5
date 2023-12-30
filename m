Return-Path: <linux-kernel+bounces-13527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17178207AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08607B21309
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE640F9F0;
	Sat, 30 Dec 2023 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqTwWEpa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BCCA47;
	Sat, 30 Dec 2023 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so33152b3a.1;
        Sat, 30 Dec 2023 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703957157; x=1704561957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0sr3LHpPxDEQss9RJqBt4liZtpPf5q1yFdjwSQfGEo=;
        b=fqTwWEpaglzD2oHm0sUkmEwA3+ccpMxEmJX3csm8OuFtJKKIzLw1e+0RxHW8xzsPgx
         ZjzTw2nLGMRRZYkKJddZvU/RnXfQy/UUddg2cWQta6H2Nmz71cPjcdDaX6/zFjHeXO9m
         2EiCO8hXb8SFUJOqP/Db9cJGZC8I4676BKeBAtQpxLzucNwkqPhDv8+k1jTykY5+iHkR
         EFBEpofE0AnEY+r37+fx2gr03QkuyXL7ASsNSoxADGdmEZcA3Qh/jAjlBtGAU5OgIuoI
         z2Q97+O3ENYRrAtbe4qVF4lfhnyR928W4kxv3RR8E1H3QPgbiJM5IyfKg2NygCG6lsPs
         MXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703957157; x=1704561957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0sr3LHpPxDEQss9RJqBt4liZtpPf5q1yFdjwSQfGEo=;
        b=WeJA0Fle7WGMzn3PFNyjGdRgLjXQmDWmX7vcL+mek7IU326+hlZ6OtQdsJL9caaguM
         VaWCFaiO0H4xnVSRiQ2WbXMTGpGzl9RGlsmeebbkuftNasEL9iPdM2S3OOtxghPp0hxv
         Ljk/xZC8M3OpN84OhQbtq9mDpE8Hn3pjzi2JdS/37gtgZ702EjSeMlP11rBrbR5ROrwU
         EIdZqzxhE7iWwzchgIGy646bDWdqkc/K5bNnpMW9X//2hUjau36oyMNQL2VQp2zbWBhn
         Kdw18PFXTFXy3J7yVUqsH5A/bK4SwzHcu4l5YDovrFQ/1SxPyJ9rNsNjtW08vuJwgiNx
         lfTA==
X-Gm-Message-State: AOJu0Yz7UxmdtqJThbza50SlQRfSi7COn/jurdixCUDt1FaNL4x/7qeO
	bHL6WyFtX/OZx+ndedKRpgo=
X-Google-Smtp-Source: AGHT+IGjGvbFtEv++bUDLPaSgFlYvimRMwZlfUhk5WKDsnqccExr4RJ+Q81PzbKa1CDbXqPliLSLTA==
X-Received: by 2002:aa7:9839:0:b0:6d9:978e:7625 with SMTP id q25-20020aa79839000000b006d9978e7625mr5679704pfl.32.1703957157229;
        Sat, 30 Dec 2023 09:25:57 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:9802:680d:e03a:17cd])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006d9a6953f08sm12896679pfh.103.2023.12.30.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 09:25:56 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: knaerzche@gmail.com
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
	sfr@canb.auug.org.au
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Sun, 31 Dec 2023 01:23:52 +0800
Message-Id: <20231230172352.3913020-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <35df6456-2bc2-415d-bc61-09e4b440e2ac@gmail.com>
References: <35df6456-2bc2-415d-bc61-09e4b440e2ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Sat, 30 Dec 2023 10:46:42 +0100, Alex Bee <knaerzche@gmail.com> wrote:
>if the RK3568 and RK3588 variants match, patch [1/3] is not necessary. Just
>document a additional compatible in a similar way it's being done for
>rk3188/rk3066 or rk3228/rk3399.
>If there are ever differences we don't know about yet, a additional variant
>can still be added in the driver.
You are right, this way works. I should have encounted a ccache issue which
made me running a devicetree I didn't want.

I will drop patch[1/3] and only add devicetree node and dt-binding in v3.

Best regards,
Jianfeng

