Return-Path: <linux-kernel+bounces-104408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DE87CD65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002602827E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B622524B31;
	Fri, 15 Mar 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHL2qR8x"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E51288CF;
	Fri, 15 Mar 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506768; cv=none; b=FYTbOXoNTVL2dF0yT4AQ0iVcAUxgZXRPP158PSakU2dBuB1YYehzFsJ70+cp2Z+EWOHU56YCBPx09ay+bwBYGfKcolaZ4MEPr2FGVQT1fMQc1WhTEf/EkjHlFPuvDatEyCCY4gtEHAAy7M5lzJMlQHoPQFrSiPHvwY6AfnYlVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506768; c=relaxed/simple;
	bh=20IG33nOEwuRR1pUFhualjUElca3LxWrnrxj30/jnfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUoyrPgTmYNajtEzMeWFVzqls1KeuGURygQR7TKSHzALeoOC2UdI+2vu/G079vP76Ur97ybh2K/qkTzkJ2YV5Ad82SdGcrcK6D8mAv8QcSbwVqFX0SLn76jNbJ6xeh8fTJmz7ew0u1AQbUo7/ofnZzVGgMZGmnX2eqB9pJcB2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHL2qR8x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def2a1aafaso3278495ad.3;
        Fri, 15 Mar 2024 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710506766; x=1711111566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20IG33nOEwuRR1pUFhualjUElca3LxWrnrxj30/jnfE=;
        b=JHL2qR8xWKEjO988T+43MaJPkTy/+74tGGmTnzF18H/L85uCf34/KNdhLcq+VpAtPp
         NHBlnVzUSb/CgZ6Fr0yqEWzILSLtqfCpETgXGRF2vuLshR3A9F18HjlfCxEDayFPe8JA
         TJhlcKROEitLvowHNwAMcbJ+zH38u/okKlbDFWG4n7lgqJRMcyjMkenC3QYrxdEbm75x
         goujloF98DZ5l8qs1kkDIY8S07xyIkz+RjWjFKHdndOx2pHy9ZD8ERbFTS5cT4ykO3G+
         ZAYh2XS/I0AKMopuCLfkywzxvsrv4M99LBaJAdsT/zqc4HVK55adFy4QMB05WC7PNZR1
         cG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710506766; x=1711111566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20IG33nOEwuRR1pUFhualjUElca3LxWrnrxj30/jnfE=;
        b=XAatw/mvkZBZCIB28UeDR4lYfclzNfY1GJn189nt2DiODDqgr1XfEz8vO4yMhqG9/M
         fg2+Rq1b3oBkn5rM7rF9jQ3+D0vPm3sFj9fxWx27BHVFklccsLFdr6mGuovCjG8/xEYv
         i9qA9CwrJP+Q2y0/JtkEPcwjgnoTPJ+3DAVLhDrdzAQuOH/ifKxR8URTp9rE9C6IoUpU
         HrXrwnEXVBB4adxmZy3dMYsdNXR4Dg5Vo/FYlPLNPDOnl14JklTVuZyhsR/lV747SV1n
         mP2p4j1VSF4G49ia82BD/Bf3zvhAT8Fx/JVlbAdhbOvxng0KmkVfJxahyV/dwMuKu7tk
         a1uA==
X-Forwarded-Encrypted: i=1; AJvYcCX4XNEBnzBo/a5H6aM734EXezVwbk7EbdNL+FCS6KCdYykvF++Q1oGQpGdnlal91/zxQ3aICHhnoHgeHARVxiVscPQQ52m67DMYIY1m61hjv8tPl5YgUvV3naPwXtxbguX5U+KamMX77LRZxSTULY/++yzPwhvY0ZQ0NMRj/Oo65QGCdo5f
X-Gm-Message-State: AOJu0YzpkSN1A9KKHYxMMv+kZMGIJk3Qws5qZ86y3GYHu8zP5rFKhJ5e
	kMWK0Y3tHny8SsD7eIUhCMs93f5WjSuMBYfU4DSsqxcOBkp86/LY
X-Google-Smtp-Source: AGHT+IG02f1X4y/QUdftzJYm61fhlTwyzXwLwDPtt/QNDq4srYRtBpaVtW1waLd2bomU7sgQ/vdLlA==
X-Received: by 2002:a17:902:ed0b:b0:1dd:6f4c:c67 with SMTP id b11-20020a170902ed0b00b001dd6f4c0c67mr2864513pld.24.1710506765775;
        Fri, 15 Mar 2024 05:46:05 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001db616fa11dsm3695125plx.238.2024.03.15.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:46:05 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
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
Subject: Re: [PATCH v3 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible string
Date: Fri, 15 Mar 2024 20:45:56 +0800
Message-Id: <20240315124556.2405143-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9414316.4vTCxPXJkl@diego>
References: <9414316.4vTCxPXJkl@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

Fri, 15 Mar 2024 13:22:18 +0100, Heiko Stübner wrote:
>at least the rk3588 has multiple v{d/e{.}pu blocks, so this compatible
>is very misleading. As you mention in the commit description already,
>this describes the vdpu121, so can we please use that in the compatible
>as well to distinguish this one from the others that hopefully will come
>later?

Since vpdu121 is in both rk3568 and rk3588, maybe it's better to change
rk3568 as well. But rk3568-vpu has been in kernel for a long time so this
would be a big change. I will submit v4 with rockchip,rk3588-vdpu121.

Regards,
Jianfeng

