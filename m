Return-Path: <linux-kernel+bounces-47519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE8844EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31711F24222
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3341EACC;
	Thu,  1 Feb 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWJmy8wI"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC8EAEF;
	Thu,  1 Feb 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752140; cv=none; b=dtQQduC8yQGTjmL9plvLN+LTDqo2S17jo6DEymZ2hKg+SZRlfU8OGjPRxVqIVtb/OpZBbBBp0idj+Pp8LZrC/hEZdgAYB8qNi23aOSTrrK79vxvMStKr7hVajROGau93QBNdNP9nFd/ysnEB57izW8HhYcxR60by710M65OKLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752140; c=relaxed/simple;
	bh=N6QKfiFvZzxxTVFRsxwYsWWNcRXAOchRha0k2f+iqCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0jXwMApCs2sm8txI+NNwSle8E1kcvJ1MFljmIQGv22gWsugvTokMCIPPOGFRls/GtvnoyJ7gu4dXShllrUz+RS2S962y6nnK9H4jFvgHNe/XXiuCzjVtcMyogfoaGUjztWIxWDEcZVU+7H3NVSDJV2MwB3Oh0UcVicCxu+FkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWJmy8wI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dfc321c677so282571b3a.3;
        Wed, 31 Jan 2024 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706752138; x=1707356938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yoyeQ03SLQ2/KhLtmuYs2D9JtsD1upyRCzOcNiDbmA=;
        b=CWJmy8wIgaTohXSffw3wwa1nkAMbvBkI4Xw+Ok3rpV3EfbKDgxCT1O3SfaycZY25Jt
         uGQFUF1QrwEnbLNW2V+Ug1wli+a+gmPPOeFm0aqa1ICoiQYXfVECHGpMN89k2vDkgR3/
         uVbAYgvsJmNgxqKPAyQl+9oEETmTnMAG4Km+M0rqU5/CyEKt2xKa4vSwntboYUx9WEZk
         RApG9TCyKfexdnWw36nnED+Gb1dFVrbZY33VX+2la/3Zvt0f1v0t7ZoFcDzEcn4gi1BR
         290exQVQMN8p7W5a8KG0XBM37d3z3p1HucU8CV1C3PPfZFxKvY7Ysa9Z099/5PlASguF
         /xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706752138; x=1707356938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yoyeQ03SLQ2/KhLtmuYs2D9JtsD1upyRCzOcNiDbmA=;
        b=P8SD1TKZMfwTHzYEjGLv1CSffTmkaI2hbc9tHpZb40xDjTs05mTmplW79e7n98bcl/
         6gnlLnpDpHeq4G9wF2BxmHK54NFXo6WwgX7Cca7Wrv9EGVPlF0MeqNGcZjV2FbNVpiP3
         2gusRg9/YEvSiUhgk0B3KOAGMvRvOtFIcGHrJpYa3+sJUxcy5SoX6L11DvePnVFh5fkv
         4Lm9GNGzu3hlCTR9lq08IS72B22uJ7s1BnJGH+mQslF1knMGP/tosafQp2V7WS1GL8fM
         n1ysasae7SXQhiCS/Pv0maaDHGK1I8LaIUxGeN63k63DY5BWp8ZeajJeFCI5chNcZtHD
         ESpw==
X-Gm-Message-State: AOJu0Yyyt08t5GJo9Jv8nrRWL/ALCmyNQFzTwICPryN0EvE77HKsoKZg
	P0gV5Rxr+uzumFuuvMvyeQEay4Z4fYJxLLxnJHlvlob5e9FaGG0Nm6qFkFBPnhIC6Q==
X-Google-Smtp-Source: AGHT+IFxYwb1zXm5LsSCQsfI8y7IMZ5+/9g8tqNylKmrp/LkcNjBnoFR24f3iCwh74oislzN6KhgYw==
X-Received: by 2002:a62:e705:0:b0:6de:352c:c2c2 with SMTP id s5-20020a62e705000000b006de352cc2c2mr3217324pfh.30.1706752138075;
        Wed, 31 Jan 2024 17:48:58 -0800 (PST)
Received: from dragon (173.242.119.193.16clouds.com. [173.242.119.193])
        by smtp.gmail.com with ESMTPSA id t5-20020a62d145000000b006dde36aaae7sm11033921pfl.64.2024.01.31.17.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:48:57 -0800 (PST)
Date: Thu, 1 Feb 2024 17:47:48 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marek Vasut <marex@denx.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] TQMa8Xx (i.MX8QXP/i.MX8DXP) support
Message-ID: <20240201094748.GC463595@dragon>
References: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>

On Thu, Dec 14, 2023 at 03:23:23PM +0100, Alexander Stein wrote:
> Alexander Stein (4):
>   arm64: dts: imx: add imx8dxp support
>   dt-bindings: arm: add TQMa8Xx boards
>   arm64: dts: freescale: add initial device tree for TQMa8Xx
>   arm64: defconfig: Enable i.MX8QXP device drivers

Applied all, thanks!

