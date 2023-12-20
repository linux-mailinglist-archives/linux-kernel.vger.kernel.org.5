Return-Path: <linux-kernel+bounces-7246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B787C81A3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBEBB27C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208A47A45;
	Wed, 20 Dec 2023 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G58HHy6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486454779A;
	Wed, 20 Dec 2023 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d38f03712so4785225e9.2;
        Wed, 20 Dec 2023 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703088371; x=1703693171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKeVtmpby8agEN95u23iRX0G3ZBjcE521MUvPxeI9UQ=;
        b=G58HHy6BzqjqfNo0ikjKnJ+S/2XMwF2ZuQm/yao1EOwtwaSYZSZm3HKQNyv9nkUKBM
         hfm8S/eg30tYWdLojb6yIWGhPIxpueSENk5OMx+8zi3vo72i0VqbbczITrpuZT7g+j70
         tcXqmIZ7QJvwl3A80QDwcriuaewX/4c0Yt/vNZOFUtGTityYQgSX7Lkz9NPuX6UgYVmE
         EI9Tj8rMGuAYad9BmfHATmVt4k2k9+g/KDtkQjh5izTVRhb+tGtnOd/Aux/xkWD4b1Bh
         0bcCOSD40klACRWnj15kJFHZNiyW/eFisTJ6G3EI8ELY/ndW+oLwR5z8eDtCm8WQmO82
         Z0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088371; x=1703693171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKeVtmpby8agEN95u23iRX0G3ZBjcE521MUvPxeI9UQ=;
        b=ei0E24UIuUJtJKuB5MyiXipyhiNGy5ruf5sT+Dj+WzFfnMdtWJKQzcZ6WMWwLNwawk
         rY5E4eu/mtlAqHMekADa9driOJXkoQJXROeLlOVzyWqr1t0xYdT2ZoFk6tb7//MtSUeB
         CJIpotEMTlGdRWxkI6Ah2eS+Dy43bkqxi0rBgfp4KtYfrE50GoLYdYftU2tnMIvHJq/H
         hU6wzQJByM0k9oN0np3gJUNKasgQ/k+2i7+yzuNwojnlgHEa52hvqLjxunjGNnQ50pE4
         yWe9saj+4LAIG3t9hUj5Xt+x8dEl9n32b2BDNbskI9l5UlnBCnVt5BjoBw974aKaDwb2
         uzkg==
X-Gm-Message-State: AOJu0Yyg7+klRfq2uSA/ZDHTithCgpwkW97DP2QMiIjBXq/a75l2Ey52
	umbBs1CITzn7W53ebgO/4uahhKgTPZc=
X-Google-Smtp-Source: AGHT+IHNNUxFFbzwO/+e7nAtjKQOfaHYrOTNtk2WOx0vdtLtwyJsLW3Z8oV9lUYcQHyLmwrAB+58VA==
X-Received: by 2002:a05:600c:1f1a:b0:40c:31f1:145c with SMTP id bd26-20020a05600c1f1a00b0040c31f1145cmr10286149wmb.169.1703088371109;
        Wed, 20 Dec 2023 08:06:11 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id az32-20020a05600c602000b0040cebe1d7f7sm111480wmb.12.2023.12.20.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:06:10 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sean Young <sean@mess.org>
Cc: linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] pwm: bcm2835: Allow PWM driver to be used in atomic context
Date: Wed, 20 Dec 2023 17:06:07 +0100
Message-ID: <170308520275.565566.6645944679194242340.b4-ty@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220142426.1275052-1-sean@mess.org>
References: <20231220142426.1275052-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 20 Dec 2023 14:24:25 +0000, Sean Young wrote:
> clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
> rate changes using clk_rate_exclusive_get().
> 
> 

Applied, thanks!

[1/1] pwm: bcm2835: Allow PWM driver to be used in atomic context
      commit: fcc76072935935082efa127b97c7ddd880d2d793

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>

