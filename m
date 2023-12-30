Return-Path: <linux-kernel+bounces-13386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7182044E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1BB2150A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADA2567;
	Sat, 30 Dec 2023 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkf0Dl1L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68023A0;
	Sat, 30 Dec 2023 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e84fded7so36906645ad.1;
        Sat, 30 Dec 2023 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703931637; x=1704536437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XaXtsrgSXYum/vGa7ZpC/g8Y8EoPoiL6Ss51LA99lM=;
        b=Lkf0Dl1LGuLJE3EdwO570C3cRXZ0tRBHCg5MMATMJGzCTY32pA/n8cCTHC/1buxgbY
         6KvXtG6nOqfMITz33xDgiHhjHQ8Sod7X+pOtr0tsBjoLgVfJGY9AH+xJD6G+Am+mTe5S
         jK7WugMMHh+ryxVKFq3xkDqdnHMRLj7h7v/RWHDwUtLAiEe65aM2LpzTP72kQBJYgU9p
         zV285hBzGVx9Wf0C+1aPgeCvg9RxzVkkVvttR8ZpoudHmDjA1oORWBtzeUlVHHFBfRBt
         KkZK3BLQ7Wbhir6im60+bz7Ou8eKogpYX0bNtRR2X1WCPJbKvKe4nROiRVUJwiapSao+
         3IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703931637; x=1704536437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XaXtsrgSXYum/vGa7ZpC/g8Y8EoPoiL6Ss51LA99lM=;
        b=FkVXCINLtvBnrY2l7q/KoAaJnk2NSA0Ct/4zZO1Z9yXL4WDLqb4Otqjr8xPjFHSN+O
         wE7lW1IyiEzARqSW8fFkjejt55NnlNQL673WyH8v3lRV445l49CLjyghx3jqjBLdxCzG
         JreN98f/LchR2L0jRcEFJjZ4WT1zFQnsp4bDKoIJdinQhNivmrdOotbOJ29aMNlchURc
         +Of3GcXzn38rnMGwFEjwI/UtsVERyWcfrKvp+yrorEzZqy0MYpEQyLOOb2VQH79KqK+q
         jBY0n5m5ZPic7fpRwwGaWV20sjRUqizzH6o/CQueEhB52YDzg4RqKXE4fN4WveEQdSNi
         VjfA==
X-Gm-Message-State: AOJu0YymFXcIv1M4doMCuWboG01IC9fClGISXDKKZc5WVv2cdrtPOr/h
	BWRIbVTj/vwrUDk2H31RvBA=
X-Google-Smtp-Source: AGHT+IHtd3W1hmJqeHzjse7BNVqjjzNfPExVuEDemRsdmZbWPy4wmQhiPx0NDD/Ifvyn7rdVCRojUw==
X-Received: by 2002:a17:90b:101:b0:286:6cc1:2cce with SMTP id p1-20020a17090b010100b002866cc12ccemr4180950pjz.88.1703931637268;
        Sat, 30 Dec 2023 02:20:37 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:23b7:4d83:3222:c5dd])
        by smtp.gmail.com with ESMTPSA id ok13-20020a17090b1d4d00b0028aea6c24bcsm22160649pjb.53.2023.12.30.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 02:20:36 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: sigmaris@gmail.com
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
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Sat, 30 Dec 2023 18:20:25 +0800
Message-Id: <20231230102025.3740749-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAXNxMRkpM+dSV3azDFgm07ygJrXyS=Htz_h8Z_WMmeG0YZ+ig@mail.gmail.com>
References: <CAAXNxMRkpM+dSV3azDFgm07ygJrXyS=Htz_h8Z_WMmeG0YZ+ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 Dec 2023 11:02:08 +0000, Hugh Cole-Baker <sigmaris@gmail.com> wrote:
>The node name should be video-codec@fdb50000 to match the reg address.

Hi,
Thanks a lot for youre review, I will change the node name in v3.

Jianfeng

