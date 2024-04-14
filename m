Return-Path: <linux-kernel+bounces-144085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E408A419C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DF1F21688
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2223777;
	Sun, 14 Apr 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9z42lRY"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0A2C190;
	Sun, 14 Apr 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088456; cv=none; b=ZiBemFwOU9iLqX8wD/lu1obW7t4D8bjhheF4YwwQuU+TmSxTEiJ+J9N8JjCvgFxIitgsjAiARIwkLJTfHptYXeUnS4zwTUIJDy7HbjTMcMa2aq0awMxq50L+/w2nRFbaFoKy7kxkvhaSAtrgv3ofycHJskXAQ7NBEQHDdf40dDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088456; c=relaxed/simple;
	bh=wgynEANorF351RVzuOsloaArd9XmEDXEW45pR6cxVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nen1TMa1rq3CDmQD33Pcq0egG/b/8aGSAhrd0vNg8IJh2+vzcbfwEGnnDdpd62XGG2CeX/4KiwLufAoDpv2gAAKf6UIwT3Xq2PPs05Ut4kSCrbmjsJflmYbrg0ArrQIJwW2glKIuhbNVRftQNZ0wCCUMDLv8Tru4i48IQ223nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9z42lRY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343f62d8124so1895251f8f.2;
        Sun, 14 Apr 2024 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713088453; x=1713693253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=966TSiAvoCvjdkEs42Fq1pDpYys8o1+8WOVsY0jF/Mk=;
        b=b9z42lRYJI11z68kfu63kuClOVnyEzAceTdy2NhWZ794mqaqZ39dE6ouXtWFaOUXET
         r/6VSVq+Su3qxxmWIAQEnDP3cCHeuRfpxVtw0JXK9ROfMrx5Tb0cyV5aDwTHw0xUF+0t
         MsWFtmRaEGOBCZlYy7/de8d9wD47ynRqcV6H02X65i+oc0nx1k17WIPmZuGe+Gtcfv8N
         TdiziiRMDqfo5VJtZ0RsjXNxuBmAnJYoRgR6Qn1XsDkj+HafQQZ0oXjee4MhakNlBOC+
         DLij+9OD3Mdt7LyZuYAaFj1zyCqzzGCWz6P7+IU36McUSN8yzc9qOYTL3vKzqnc3o3jm
         i5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088453; x=1713693253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=966TSiAvoCvjdkEs42Fq1pDpYys8o1+8WOVsY0jF/Mk=;
        b=AUy9N3a1bP7Zjq/SMWE3NtzRSKmIvKOgbMNs8jaj21f1lFjTpmyZTEpxh5bBa/aFsC
         xNEJ3mJkhBN8OlM9+jotLguY6MFKy+bfijwm0rgsjBV15uWXO1PLcacwY5BPCroJkvp+
         eSwODUC0E4Cyf4gfybbrqSavRGUS9ZxjVmGoaAVKG4JOXAHVyJQhNz94pbThQ/xvHc4r
         FstSUSJuXcp55aSN4naOynutr4uPqSCRZk0m0jtqsGqE0JcJyNzwZfomTR/QU0fcg1uO
         FQIbzBTuZO1hr0/oBuw0Z4bCsUOuIzAqE1XHGt8cO6EMFBP+kYf9nOmrNext5FauxkZ2
         rgKw==
X-Forwarded-Encrypted: i=1; AJvYcCWr52bOD28AX4DkrMCm1MUFEiygPnUYfeKzkN7pr3byrcG4XSnAJg1en6OD3mNMYb2ZLMD+Gg0kDBdCpdpXEx3gVMEWeAUgHZiGv9AI6PoQs26Ap/r8mcAygNNpAA6iUgxqGcGbrgaS
X-Gm-Message-State: AOJu0Yy9UxgT+1HJkf3S4+YrjAGGMMKn1xpc5NotzGzPfajcSlvnJa6K
	H5htaSz3w9sOiTmS7PP1WGJQftEpz9AVgdTFtvX0GyEKOHvMBJX2
X-Google-Smtp-Source: AGHT+IF2QILXTcSU2QsKiUfeu3z+cURRk+Q2HhcPstTor91J1lND/K2er1pKaB2wW3r4LHfskQ1xxg==
X-Received: by 2002:a05:6000:109:b0:341:e10a:4858 with SMTP id o9-20020a056000010900b00341e10a4858mr3723437wrx.56.1713088453477;
        Sun, 14 Apr 2024 02:54:13 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-252-50-gprs.simobil.net. [46.123.252.50])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b0033e91509224sm8690824wrq.22.2024.04.14.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:54:13 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: fix module autoloading
Date: Sun, 14 Apr 2024 11:54:11 +0200
Message-ID: <2929619.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20240410155420.224157-1-krzk@kernel.org>
References: <20240410155420.224157-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 10. april 2024 ob 17:54:20 CEST je Krzysztof Kozlowski napisal(a):
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



