Return-Path: <linux-kernel+bounces-13383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B582043F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0263A1C20C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1943D79;
	Sat, 30 Dec 2023 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0TM8ARL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAF1FCF;
	Sat, 30 Dec 2023 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc076e9e59so1701232a34.2;
        Sat, 30 Dec 2023 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703930620; x=1704535420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvqhNtKIg/MAMCdqwkucMfho19+t3p+RrNQxCyZUIbA=;
        b=F0TM8ARLqCdrCT6aNWgQNbe7wCL5Is873h2iG5vkXtZXfyKgJ86GoPXu0gukuIZ7yF
         bfVi0pkgbkqAY08em8dGtUGkwZr5oZjAsDsd4Y7IXPvS+h/ftQNrsEjD8z/WOfd8kafG
         iDvt7Na0njmgqPfdEVnLp3S919vHm8W+5fZ1XuJ2h1gaJvo0cpwZ9e/8yLNgF5f/euSJ
         WQveYyh6qoU2DKnG8pNa3IRYMpp1cKfssBbp1b9YIc5E+t2mAWhjY5KFitutIm3M2bnI
         w+UHmsxXRvKQSddebrzqkxEkadQPebNzqczB/AxyDoMbu2y8YKEZwRE/tLY8Be20h5Qn
         KyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703930620; x=1704535420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvqhNtKIg/MAMCdqwkucMfho19+t3p+RrNQxCyZUIbA=;
        b=FfNz45s5bvHmFeAVP8n8EsLnUGwB7ftusmefBNVFNi7tucF6KvY7P7OWu3yH/yEXlm
         v8U4vAOj/LdmJ7w1Uak902ruqDbfdAWZoGIs7wzEgOF7M4wb1v5S/YQab8Es7uMewIkZ
         kLEMu81ov+G38h7APplDVPPJNCuJOyk7T7r4qNrY1Cb9+8sy93i2dWNl4JUAfu5Feady
         soaCi31tucFDytWZVTX7upXQ4Isa+ZEEblElBC03/DQWQyLjvbS9Ezl9UNLryQHkWDAv
         yJQZ5kcMQ83xs/KM2tBGihBDIwUzwM3lfq4UTqH9ek9B4u7QYJz5uaIOrtG5NzbOFY2t
         Y11A==
X-Gm-Message-State: AOJu0YzypQZfo2k1BurSwp9kvONoXk2jW5V8HPSGo9EakvPy8azGk4Zx
	HusjB+eHAA6kKHVKEdEQN50=
X-Google-Smtp-Source: AGHT+IEn7DipJTLYCFAcXQ3Ro7QhPViWJmdmErd0O7m5fzvljj6wgo5gwzlt3uD4pm8/WjttJMlgFw==
X-Received: by 2002:a05:6870:e410:b0:203:a854:cbab with SMTP id n16-20020a056870e41000b00203a854cbabmr16237640oag.111.1703930620214;
        Sat, 30 Dec 2023 02:03:40 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:23b7:4d83:3222:c5dd])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b006d9bb753d2esm10087231pfb.166.2023.12.30.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 02:03:39 -0800 (PST)
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
Date: Sat, 30 Dec 2023 18:03:29 +0800
Message-Id: <20231230100329.3740222-1-liujianfeng1994@gmail.com>
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

Jianfeng

