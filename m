Return-Path: <linux-kernel+bounces-106442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9C87EEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0550280EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88555784;
	Mon, 18 Mar 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiQ4SKMs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B654BC5;
	Mon, 18 Mar 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782703; cv=none; b=Z5U/WHXLazZzM5j8DANdIUSfQpahQit75+JxpmobbQhENX5ln6yvEhniLFVMii9HKlGpp0qAwC3UeWKgxiaq3tmC9hZN14OLm4lFeHmVLyLpdh1DqHQbI4Fh1Kgk735TxxptHSpcQMK8DVrVcj4/YG3NrXu+YZHNNV4mscn5qDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782703; c=relaxed/simple;
	bh=By9zNHOAPEUzQgCAwnmGWAN0P+JcSIiVYrCNA/N3Lqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUgkDjiIRka0+wuhUe//4hJ6IqCyxFdw4JP4W3uF+qirNHTsdJMYsZvWTWuM22qqT0doZ0Q55nQ3pAs+4itV7P93KUUBhDdfHL/khWovpLpTiu+8TtFfjVSj4qkR+9uW+cdAS26OhM0QJnshSKKrygqMLJNTTv1wkqHoy4DJ+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiQ4SKMs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41413d116f6so5773785e9.1;
        Mon, 18 Mar 2024 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782699; x=1711387499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVbU6njYiiJoqweMNi/CTr2/6zPXakEgjaYTRXv3XZw=;
        b=IiQ4SKMsIPDeyQedlRcpjN1VTVJHB7payOGD2sIkp1V50D92YnkHyGI7AybHUoFpcH
         HOwieCwTkXB1mSJMqHchmuUT0iMvLsegLVsbLQWxl/PtTYcRIwiSqcfhmMBrjqVAxS2x
         WMxRI/G4RnH5z2oaDraI430ulqG684ub3DUc8yvcHKMfRXwD1VvJ9eOQ73Np1R8jgQaK
         2MTAi7yDc2IwE+gNpXNu4gGMw1MpEKjDNtW4eOUmUBoBHUWttFJDrfHoTMfT7KEkaXNB
         n+Gf/KrW0kzPbTqWfpr9M/rmiJYUCmAvBy9H0UiKu41+gHS3HgFLXG5zXexLTL0bbeI5
         XNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782699; x=1711387499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVbU6njYiiJoqweMNi/CTr2/6zPXakEgjaYTRXv3XZw=;
        b=LGBydraUyY8pWnz7BVhHMvN1qo/RyRvn6kHKVEek5A7cmdke+t7eXyneSOLkR7gRzJ
         b6WgAjCKJlC1sJ71atTBulKzlmFNRFcPNDJsx6mxXMn9O2RGx7Na6MmtPj7Fmesom7om
         /Vt3t5dor5kftugw+0wzdBUIyeTN5gJ/JP9HZ1jCTM48EQvbfpK0rOgHZsZ/IYvVxIfU
         0Fv8lT0KWaA7/iAY5fBsaLcbk19j69auUYGZ0D+2iuv6xzJZ4zrqr/PLophJI1Erduim
         2YWLx94vVCsS8S365WkbXs3OetTqp1A7qAtwt58d1XZTdaT/5cAd8rKvUt7ByA/Hy3Yl
         FPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa0c1G8CY5Q1Bzdm9x3o8iY8HxP8ZtkjAc8icX569AD0dkGuOlPXK/nLpP6zJ6TYQg74f++dFn+J+Aij3RPBvDLv8tx2D1ajX0y/eRrTdL9sksTcVtooERXx7gj3GxAW0ZhaZ10D/T
X-Gm-Message-State: AOJu0YwrWBGOr2vyjIhn7zH1JjIxHJs8VqgWSn5+WL71CX6RKw4VLuwi
	pDkIak4K2DpWpHM/2kwiOu4b9/MlZ2J6JzIfkrhU9Mhmj00zTMAr
X-Google-Smtp-Source: AGHT+IFAGo5r7gdXXbUUCazX2pOBmsHfh9bfQQ/NaXwkVwNK2FUdr9fDbb5bjohyXESf8K3Q6ff2Gw==
X-Received: by 2002:a05:600c:4e93:b0:414:245:f6df with SMTP id f19-20020a05600c4e9300b004140245f6dfmr121085wmq.21.1710782699021;
        Mon, 18 Mar 2024 10:24:59 -0700 (PDT)
Received: from localhost.localdomain (munkyhouse.force9.co.uk. [84.92.42.80])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041312c4865asm18674313wmq.2.2024.03.18.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:24:58 -0700 (PDT)
Sender: Adam Butcher <adam.jessaminenet@gmail.com>
From: Adam Butcher <adam@jessamine.co.uk>
To: broonie@kernel.org
Cc: adam@jessamine.co.uk,
	benjamin@bigler.one,
	carlos.song@nxp.com,
	kernel@pengutronix.de,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	stefanmoring@gmail.com
Subject: Re: [PATCH v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Mon, 18 Mar 2024 17:21:48 +0000
Message-ID: <20240318172415.1588-1-adam@jessamine.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <98914a36-e5dc-4f44-bf3e-c237d803a7e8@sirena.org.uk>
References: <98914a36-e5dc-4f44-bf3e-c237d803a7e8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, March 18, 2024 3:55 pm, Mark Brown wrote:=0D
> On Wed, Mar 13, 2024 at 08:58:19PM +0000, Adam Butcher wrote:=0D
>> From: Adam Butcher <adam@jessamine.co.uk>=0D
>>=0D
>> 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU=0D
>> mode") corrects three cases of setting the ECSPI burst length but=0D
>> erroneously leaves the in-range CPU case one bit to big (in that=0D
>> field a value of 0 means 1 bit).  The effect was that transmissions=0D
>> that should have been 8-bit bytes appeared as 9-bit causing failed=0D
>> communication with SPI devices.=0D
>=0D
> This doesn't apply against current code, please check and resend.=0D
>=0D
=0D
That refers to the commit my patch fixes.  On looking it up I found it=0D
was no longer reachable=0D
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=
=3D992e1211dc91).=0D
The corresponding upstream commit that is reachable from both=0D
torvalds/linux.git/master and broonie/spi.git/spi-next is c712c05e46c8.=0D
=0D
Though it was made against 6.8.y, I was able to apply my patch with=0D
git-am to both the latest broonie/spi.git/for-next (593c0afc18d) and=0D
torvalds/linux.git/master (0a7b0acecea2) without conflicts.=0D
=0D
Shall I send a v3 correcting the hash mentioned in the commit message?=0D
=0D

