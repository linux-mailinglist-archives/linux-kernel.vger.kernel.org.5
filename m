Return-Path: <linux-kernel+bounces-29840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4283143C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D8D28787E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D851428A;
	Thu, 18 Jan 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8cfFVUo"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439414AAD;
	Thu, 18 Jan 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565182; cv=none; b=bAXIlswR8kvnS0G5FNEOVrs7t6MO046XOmzUNvgY9j/9zoWiA6STHrHnmCWoAcXU6g8PFf3dyoAVutHp+gMTyigD1kGhUllg1xfhIBWN7to3YiRJEH4QR0shGuLcisTlxlkWQ82X4wy2+vAto9wZZQD56P66DTQ/4ZsF3nR55N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565182; c=relaxed/simple;
	bh=j7yA4SHYk6Zrg0OShldfrxk82ZO+cWYmPlbEQ+Gl41g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=mJZscDAxH7OLrSH9eIpbem4svqiFPTj1P2aeqbNS/StfsHXdyUVBGE0PC0gHsumlXCctYr10z/nIGjnHWR3hI95k8EsnZBEDHQak5XXIVEPKKyNhb8SdWJxH3qrNjm3jCIhHCBbbXmnKpSYeoeHWeOa/8ucl1WO7LcR4j0uZzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8cfFVUo; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5957ede4deaso6811867eaf.1;
        Thu, 18 Jan 2024 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705565180; x=1706169980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7yA4SHYk6Zrg0OShldfrxk82ZO+cWYmPlbEQ+Gl41g=;
        b=j8cfFVUoX4xIWO3qpiBtfYiuTRTkfACnMgHytbJAm77oXj94nmSgxhHGNk35XCKr2H
         yQDlQNfv+Fp8qUWOFAsZTmEa3Cc/JcHx/1eLfuqfK4PRIrIT74G9K0pClSIc/6iY0r3J
         GpzEovCm8rykMZ3eIzTggotdmq/VaJCyHmfGP+EgxEjMpglFz82K+ekpvo9xLbYhzrak
         VtmwDGL09sFQKkOyfUyaqu0avwzrs6QHGGvrlIUNPwO9xz3kkhkv4EGFPweQZVtECuy8
         vOekwX7lg1lWzWTOSIG2qxO2Sk+5zTxcqBPVMMkfVlqhOB7VBNieHTN3szH1S52jC3ro
         7Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705565180; x=1706169980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7yA4SHYk6Zrg0OShldfrxk82ZO+cWYmPlbEQ+Gl41g=;
        b=hTQY3dWYzIe/1Mj6O/OHrkB8DRN9Mo7OhGMhSBGrAoIkbG4342LRQr91ip/HbGeSjJ
         xATIbVmouEzxntA8YGEScl5bpB2dnyu+ftR4Q0/7bH+9ka53ZIhi2R+h+9rRJ531/b8x
         218pqqF9UbeP4DpFhJUhtznUEfDv7ZR/bZnDF5GbwHsXc9EAD2uAltZ5El8qdtCP4LpX
         6XuUIpFofrusqTukoCnSuO1JcNNIwAz1eNSLaAf/clQGH/Jhkd7DscnrsF/CLXgL3qL8
         TolY23HKrQYpUJBet7EpqPK4EImk1SXKfswEc6+0ostdTeYgqwEGAdWhp6GdWnKSUvXo
         kw4Q==
X-Gm-Message-State: AOJu0Yzxj0aGIOeAsAeRNEjXj33MCie0xlkvrNOAFFzUEY5K6ztCc/Px
	pO5NVSttXHXcRFHEVOe/m0jucr+9Bgy7Hps2JWXqvcnNalE/JVP2
X-Google-Smtp-Source: AGHT+IGas9zSD5Fhi91j/1cDN/WJ1zUM3zem4b3W1hS4RQbRmpmP68OBWo1Z3V/8mlVUgAVLZMrWcA==
X-Received: by 2002:a05:6359:600b:b0:175:f9b8:89bf with SMTP id rw11-20020a056359600b00b00175f9b889bfmr405217rwb.22.1705565180329;
        Thu, 18 Jan 2024 00:06:20 -0800 (PST)
Received: from localhost.localdomain ([221.220.134.213])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78d41000000b006ce95e37a40sm2682844pfe.111.2024.01.18.00.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 00:06:19 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: nicolas@ndufresne.ca
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	knaerzche@gmail.com,
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
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Thu, 18 Jan 2024 16:06:02 +0800
Message-Id: <20240118080602.9028-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e01c9ab69f3e120cdb9b70fbacebbab32d5abba4.camel@ndufresne.ca>
References: <e01c9ab69f3e120cdb9b70fbacebbab32d5abba4.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nicolas,

Wed, 17 Jan 2024 14:13:19 -0500, Nicolas Dufresne wrote:
>In general, we ask submitters to share a fluster [0] score (this is just to
>demonstrate that the integration has been well validated). LibreELEC community
>have patch to enable this ffmpeg fork. I don't expect any surprise here, and you
>can just reply to my email here.

Here are fluster test result with ffmpeg v6.0 patched with v4l2 request patches
from LibreELEC and gstreamer 1.22:
https://gist.github.com/amazingfate/1675389df382ff266d6f1318fd4675fd

I am using Kwiboo's fluster fork[1] to run ffmpeg v4l2 request tests

Jianfeng

[1] https://github.com/Kwiboo/fluster/tree/v4l2-request

