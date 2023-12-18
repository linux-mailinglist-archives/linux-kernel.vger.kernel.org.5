Return-Path: <linux-kernel+bounces-4326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6C817B80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE56BB2387D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84073492;
	Mon, 18 Dec 2023 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJZOCTDl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA57347A;
	Mon, 18 Dec 2023 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2340c803c6so225641966b.0;
        Mon, 18 Dec 2023 11:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702929391; x=1703534191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSOucPhy8Uq24Amn7av5EziiKi3zQUdPVY+HVNazcmw=;
        b=NJZOCTDl/o7CzK2E9auv4LDse1Ad12gXRf9weGmeJCfKdu2BjMPiODyzIFZ//pfXHm
         C9i+xO1msJ4+nut8sVzIVEFSF7XrWydkr5BYIjWHxRPlfq5Nmpx9u4y88BuFcCR0SbPu
         BuUYQwZVBZLF5AM97XtCvO/4ItgTxKC5yOhvt9ykcFZ5Oq9mDVVRHTPkLFypMlE4bMy0
         tOoI9VJZf9Va1gtjypgrOMfWiLyCD1427GeSjCH5A7fdAfxOMqwE6S9dqNOM9r4+2Pfp
         2foKed5XNjUlbY4mbvKQsaVRA8eRb2XFWnuyaVX7DiyXz+Tu9V/QUWss5Q/SonhTMMFR
         YbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702929391; x=1703534191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSOucPhy8Uq24Amn7av5EziiKi3zQUdPVY+HVNazcmw=;
        b=eq9f7ISPga56/AkoIMW/i5yKPaYC0z6msH0wtdnvvtWYa2w8f9OQw3JkgUXm/TKOJU
         2BT9N4cW07bMob/AKqFiFXKsLss265T5qblUZOF59w8PD1GTccm/zIB+iWnTa1WD2O5n
         Jw4+lQoTPhfsjLTteEp77hdX8zD0dLugkTMLRRi9oi6zAvAULSTA4G5ePxG1y0lsH31R
         v3Rxl3PGMVDgYciguo2Xnc8sZZ/CFqqCTtmR1TSlktbEisTjAfIpPXhuA5K1A9TqW2AL
         zom7Cm29i9l8639DcK+4f36M6PjKWHkJ4gXWerAnQa93rDLmTT0VkwBVPzU++IUR2iBV
         9RbA==
X-Gm-Message-State: AOJu0YzEFGnKvHm7/xIoBcY2+SP8uRFGsS1KHBiJVvF43Gr6zrnk4gbC
	8/nkrvlj+Ilfz+UxqrhUsw74xflYnYY=
X-Google-Smtp-Source: AGHT+IE7TmqHMKHKgZX1NTAreBGHNdqmsN91K3ft/OadYBs8869eUaoyHQxBBrQWWA4Y9Z8CFr6cMg==
X-Received: by 2002:a17:906:de:b0:a23:6708:cdd0 with SMTP id 30-20020a17090600de00b00a236708cdd0mr597284eji.88.1702929390578;
        Mon, 18 Dec 2023 11:56:30 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id vt5-20020a170907a60500b00a1d38589c67sm14604413ejc.98.2023.12.18.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:56:30 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-crypto@vger.kernel.org, ovidiu.panait@windriver.com
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 7/7] crypto: sun8i-ss - Use helper to set reqsize
Date: Mon, 18 Dec 2023 20:56:29 +0100
Message-ID: <4854975.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20231218164649.2492465-7-ovidiu.panait@windriver.com>
References:
 <20231218164649.2492465-1-ovidiu.panait@windriver.com>
 <20231218164649.2492465-7-ovidiu.panait@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 17:46:49 CET je ovidiu.panait@windriver.com napisal(a):
> From: Ovidiu Panait <ovidiu.panait@windriver.com>
> 
> The value of reqsize must only be changed through the helper.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



