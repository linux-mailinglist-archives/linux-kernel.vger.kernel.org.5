Return-Path: <linux-kernel+bounces-10661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63081D85D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC2F282863
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5020F5;
	Sun, 24 Dec 2023 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBz1Aw8z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0558469F;
	Sun, 24 Dec 2023 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso1071970a91.1;
        Sun, 24 Dec 2023 00:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703406693; x=1704011493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF1DD09dZn8IrqD2IJLNhX2krFG9zQiZrQ6+UB0+0gc=;
        b=MBz1Aw8zM6njO6JExiJzO3ALTjldWo9G4+B3H0DWHnL/RVy4bIjzHs4JE1aNY6wmrw
         SLg7aswknT8yOFzClvu0guRpFR6uiScyOCjvllBvKZmfv/BJAXcGKPBqUvVuphzMAQt+
         JE6d2z7iCuDs+VELKJGaKZb59V7R5Lm2ksGoCKcE5GPf88kCm7mMudcd0GoMmNvW7mgh
         fl2TWI2IQHi1WDz52IYlG0nowm8oBupQBdZXOxZbnkazzOPcNJuJiiJYlEdplWNgVFfE
         8uWcF2tUzrzQDxD/+ZR+FRHn6lqhkxsAj+aCOiJxMWKKC1ZAqXnKJ18tFnh6NvC7xgV1
         MwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703406693; x=1704011493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF1DD09dZn8IrqD2IJLNhX2krFG9zQiZrQ6+UB0+0gc=;
        b=rFbqfndZhH0lOfrNoy86PTz8LATtTBO++0JTgzg0f7G4HKhFGJEf0BLMPq2Bw4XS00
         uItmQcS4Sn0RVXy1HIS/SAmlTYE1wTMhwz6SBgYY/omhoEK1nQD2pU7aI97ATDehH5og
         B1Tyc11M7lkGTLXKhVivUkoIPl74MB7AU97p8CgVS1GZJkRLwsZVc4LvMqrdKBhz8FsB
         +E9ywnAli4leuRLq9kEZSRMDDBLeqo1xFFTCTe3g8ScP+lTka1kUZmhexpJNkFFROFd7
         7c90H5crQzXSW6ZjE1uKS4TXmO/xaC43zDnTl+VWHAUuvmvHoplvpN1Q4We5gLCy+z8+
         P4CA==
X-Gm-Message-State: AOJu0Yyw2gw8aY6IKxlAG8O90q3Oi0915Ro0I1cSmDOARBS7gR1bUCni
	4vA6MrFGiP371TJwhkKJRrI=
X-Google-Smtp-Source: AGHT+IGrNyVsAY/DLv1pFBieRz6RrZRBAeGTkQ4nM/wkYsOwgy46d63T3nbFqV95UQ0560LW8cLLgA==
X-Received: by 2002:a17:90b:e91:b0:28b:be76:f774 with SMTP id fv17-20020a17090b0e9100b0028bbe76f774mr4763436pjb.21.1703406692836;
        Sun, 24 Dec 2023 00:31:32 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:765c:936e:ea43:6046])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a2a4700b0028bcbee2badsm7006517pjg.10.2023.12.24.00.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:31:32 -0800 (PST)
Date: Sun, 24 Dec 2023 00:31:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	rydberg@bitmath.org, linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com, u.kleine-koenig@pengutronix.de,
	heiko@sntech.de, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] Input: zforce_ts: Accept standard touchscreen
 properties
Message-ID: <ZYfsYW2527_nT9DA@google.com>
References: <20231223221213.774868-1-andreas@kemnade.info>
 <20231223221213.774868-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223221213.774868-4-andreas@kemnade.info>

On Sat, Dec 23, 2023 at 11:12:12PM +0100, Andreas Kemnade wrote:
> Only driver-specific properties were accepted, change it
> to use the now-available standard properties.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thank you.

-- 
Dmitry

