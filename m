Return-Path: <linux-kernel+bounces-143799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C18A3D96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317BA1C20D08
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16C4C629;
	Sat, 13 Apr 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns6GVcTY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E445BE1;
	Sat, 13 Apr 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023860; cv=none; b=JbtSH5FRN7C5GZt/yj2cL5+iVVfwQdhtgE6EKxcruFXuiMWvo6NaI1EhAllZnzdkBo4VS6vns5uGbHpRV3bb+Jubp1VrBAJROjeZaMKa6Jw7Iau+AQo8GUKyRGa1Di9da9uV18zqLt8s+lxDRiMkh68aYI4PKTb54tsKE6+MYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023860; c=relaxed/simple;
	bh=Hh8gI3Xc9orusEEhaZP7ATpypY8/sW6RTqMlovJMv9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7o5Nx3x1pjjp5EpXD2GsmwfkVYcuU29CK5tvBIrQ3utaMJ8XjWA0BZfziwQVzRHxP7BYzEX7NiWjTK4ynmfgXtucd/zpxuYBx7R4SROWenAgtBLIny8AOvhMuy6K6ROrC/jDGTOtqmEXOP60jQnu4BNJwW9nofYeWkZOv/d56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns6GVcTY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee12766586so1217849b3a.0;
        Sat, 13 Apr 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713023859; x=1713628659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh8gI3Xc9orusEEhaZP7ATpypY8/sW6RTqMlovJMv9c=;
        b=ns6GVcTY4jwRSShsSklovlhwMbrKg764cliYeZcYNsqXV20aBOpriUPTXNIG1f+BHV
         GWUL45S5kkUcJ1L0LUQRtutsfqINvLZfC5tpA+Shudbh87rSYN6uKgCkg94q2+Vex2Uk
         bO0Xz+C6mW3lix0E7a1Bai4ZwuTFwpOjVfBxtEW4G/8jCIAxF2j4K9UZnlAgUf6B210r
         F1wVf3yrqe9V1GwrVIrtIGAbEwtzkGejfwa80OTsfWAGEnf6syKdn7S5PIhS4uL8CfO5
         Ixc4iPZftfLTvA3nO7Wpw+tJ8a9DWobPsZCQZtCmA+gdLyYYgPEnRml2jAUoisJadmln
         EA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713023859; x=1713628659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh8gI3Xc9orusEEhaZP7ATpypY8/sW6RTqMlovJMv9c=;
        b=Gv8TjZtGKav91SKWCLkxLiHMDhUSkO7O6rtgZSSVodm41z7dzyacIXWEY91XZt9Uop
         /DfK/n12gtLf2IDBDIboAkRa5jtwwr2pQpRQ0YnG76uOaTrZY3m7BGBQUWZorseZIPnb
         EFYsI1Pr9O2ceY9KV1/U/0/u52ULk2ZtWcd5cx3HgkaJa6Rh5pBse9bOxwv8fotQ9Jbs
         gxGhirz0MyHEwNQJomiNxgc9XZ6Yq7xADwVWcZdg60WwTQDNRRiQDO7j4SdcN48HNO9b
         DaAgnucZ4mywE0ETh0ctK7D1x4FJHo4PKSDCYeMa72mJGSliChKTRBMPv8A8lOP2wfMm
         s9hA==
X-Forwarded-Encrypted: i=1; AJvYcCWtOg9jA7Xts0OcdFEICcJ8ForjcZJI9dcAMy0uU+w6ZCRteHVM6QhEKLK87QqX0LxQ6nG1c5sHB/QYzLdY9hLPhxbqxcRRtFEO5rVt0qK0x7tepAqb7+tnstaKaZGzsFiFV7Lk2NrJFhF4OjPOaif4sKtSUp2RPOI4nTTNiIlKHyDxfPlJ
X-Gm-Message-State: AOJu0Yw62FDfWFJwP8s2v7LD3KCBQs8ZT0glsi6O5iu5oGVFBB/qFc8o
	It6kPL2tJYerN8AsUdLEpFQ6b3ypfIJxkahe+Z/eA8uTQhQi/5qlJP2hXMgytEA=
X-Google-Smtp-Source: AGHT+IHmNyIuiQTOgddGulL6Vm47X53qcvJxkNfBjq5gt5nrpoeVWcF8ECY4cT4aN5LYDnQpWA1a9Q==
X-Received: by 2002:a05:6a20:9483:b0:1a7:9e84:dc51 with SMTP id hs3-20020a056a20948300b001a79e84dc51mr6467684pzb.7.1713023858942;
        Sat, 13 Apr 2024 08:57:38 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id w9-20020a63f509000000b005b458aa0541sm4334034pgh.15.2024.04.13.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:57:38 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	sfr@canb.auug.org.au,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: Re: [PATCH v5 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string
Date: Sat, 13 Apr 2024 23:57:09 +0800
Message-Id: <20240413155709.802362-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2a516484-ea87-444e-a89d-9fe33d08148f@kernel.org>
References: <2a516484-ea87-444e-a89d-9fe33d08148f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

I'm sorry for my unkonwing about the kernel patching process. And I'm
sorry to let maintainers do extra work. Thank you for teaching me this.
I will do this right in future patches.

I did received a Acked-by tag from Conor in v4:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

I note it here in case someone forgets this tag.

