Return-Path: <linux-kernel+bounces-92790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4612872604
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128481C266E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B817BCD;
	Tue,  5 Mar 2024 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2Tgu49Y"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50714A99;
	Tue,  5 Mar 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661102; cv=none; b=lLaXVzVn+MpTRTNW3IkqZLhQKnnGuuDTEaWeUvDUifKX0rUdTrI1III+KMkG/XzYHO2Mv9Y6QI++wVitkLzWdcigyOfAtu/Ai/mxPmXb0I8dsiHWLfuCpQ2S6llSN9tKPVbmMH1wq2s/98czLoJ/QlD+upchxgDIkrhiBvC7c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661102; c=relaxed/simple;
	bh=2M9LS8/TFzVtINnbm0xitDXNpDBa5QKyfi1NFWuZEJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkghJ3jxZJbbDWs7xR25RtojeHoR6Z4MI8T0trcFiBH8h7isTYX7TRxbMj3LyuA/zeR/URNv/xV1P2+FoVYMUDej7SgV1z3CXUe/FpV/8VTXdVIX09D+1LTFKJprHq88MXGjUHtmumSRveZ3yyHDaX0qqZGLbUKjua0LpnN8w80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2Tgu49Y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so2283533a12.1;
        Tue, 05 Mar 2024 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709661101; x=1710265901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpTAtw3UQ93UxOybj4sot8nZNmiyYpy30JpPxTWnT6o=;
        b=j2Tgu49YGrfXjpbyl/YVmgcX0A8mqWabJ4Tp4mbzJqtrig/kfLJTBmOT+GtiOvEQKv
         kL+p5PEZVNvxr9g0sCExmZMgT89I4QwFsLJ+TNYkUNLdCkSYU+Uo3aoyr2wzqP87AVn0
         vHQp90Gu8COY2du9IMITaUFvCcMu1xnJHyu8KsSKVPpkE7MHyJpQdLwa5Lb92u92I9Hj
         OFVLhkXU66LYrTDr6C/GqG1nPZzMXm1EVgXHKsTAQq4E774XkfoicaxwDr1DNrjxMam0
         qveDFu7gh7MV4WMcnPZFD/CjfjoFAdHEIkYkRMvixkWbgydRbV0jmDl1Wi0+b5uE9LN5
         Hm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661101; x=1710265901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpTAtw3UQ93UxOybj4sot8nZNmiyYpy30JpPxTWnT6o=;
        b=H1o809+9DMR//TJojGlpM03DsFevgKLcz59ADoQmGwlMbnIYmnFIIwofUQzI2hboVn
         T4krRV9nzYNg39iyUcSLMExA6jQiwyA/PJhixW0RmnxL0WEo1NzNoZPBEwGnCgLSBIZd
         sHE0VSBr002wFn+fnamFeA1/cP8aHb1XFGyhHVVrVlO89lpFzmkmOGZzLS6m6V3091fO
         Uu+ankVXstTrGKlBKclzFE/jSLT+77sx3qaHDwr8YEY5P87Gf3g751QZo4wdZJVaU01H
         WOf5n6UTG+CJHrW2AMtHPfzWN3apaB5oFlmwKQ0rxfqIsG23gujjSTrF7MGCEJlw9OBZ
         tNUg==
X-Forwarded-Encrypted: i=1; AJvYcCWp9ZnIyhZiDxDQriF0UPkvfnh2qxzNs1y7Cr4G8Ub5tevWuv6bxNvfMqU98jMkJpHkuVbB4BiA2eq1WXfQch7XZLkxyG5NxXZ/bxuDvi4WAXrqvy66XLVzGWEXWUUXPyGxEdvW3jkQM2cUF84Hz1TdkKN94O7FBW0kyyBqBmzWBagkSKCd
X-Gm-Message-State: AOJu0Yzz3Wt8ADKLRs/8YyLTOwu+SSPH5Rb8Fmx6VLZt9nnBFg0GYTXo
	Eitb7s/NhaQFOGk6qq6W3zSxQlV1tjYKjmdshz0Waez6dQT6AT5NQ6x60jNp
X-Google-Smtp-Source: AGHT+IEXCEPMzLnaVufcdsnqvv3Px87pp8CIOt+QaL3umwskWU4qB01+4dyG4lax3qmGLdnMAoYDHQ==
X-Received: by 2002:a05:6a20:8428:b0:1a1:215a:335e with SMTP id c40-20020a056a20842800b001a1215a335emr3251417pzd.27.1709661100543;
        Tue, 05 Mar 2024 09:51:40 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id h37-20020a631225000000b005cfc1015befsm8377078pgl.89.2024.03.05.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:51:40 -0800 (PST)
Date: Tue, 5 Mar 2024 09:51:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop
 redundant type from label
Message-ID: <ZedbqeNY23o8JzJb@google.com>
References: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>

On Mon, Feb 26, 2024 at 01:29:34PM +0100, Krzysztof Kozlowski wrote:
> dtschema defines label as string, so $ref in other bindings is
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry

