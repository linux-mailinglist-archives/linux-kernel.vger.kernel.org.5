Return-Path: <linux-kernel+bounces-35796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E98396AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAAF1F244E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5D8003C;
	Tue, 23 Jan 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3tVwSos"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5880039;
	Tue, 23 Jan 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031802; cv=none; b=J6P+wqe58D3oXEyFRsWGFw14WBFENIU3I6MuBlTzlNVfvynBKOVi+xBtuqmcK28Lv2a/OYNCbXo3cybHtG2tTrcWr66fkStGNYw95UV67lkXATZRuP3l3rAGAWv1o9v5tMxEr9d9bOl/7DQvblGsJmITM4gHXl99cN1/YzKPrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031802; c=relaxed/simple;
	bh=kTxBbsO7xNZINKwTMim0Kh90fmp9yZ6WuJ5NL2lrpH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6YExxNlfvUYD9B8dpFRf31pI3rHA9EE7XlZYB3hrOLF3YfuivrTb4sI/5zLt0nAX/zg7ojWHOykTLwruA/cK7Lw7L7Dp8ehLqG/LjzrGhoiPyqXnKa0cnkIWUfUP+mmsMEsmZBLDsy5y8se4BGo2i4GdVZ4M3xXAecj8eSK3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3tVwSos; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33929364bdaso2908665f8f.2;
        Tue, 23 Jan 2024 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031799; x=1706636599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTxBbsO7xNZINKwTMim0Kh90fmp9yZ6WuJ5NL2lrpH8=;
        b=j3tVwSosK94AznslSO4C3TOR88Ib1hAZmYTSDjkrBPop8xnaocZdmd3CUxqRTxe4S0
         IJz4E6uDPKZi+tqy7y2QLpLClUSlNusUSa8jt5U6teno87b/o1kji42yuyRfBVOjQ4WS
         SzFTYHOwNi+LevOV3z0lcz7owCtmazmWvpuxgko0PHjVTUoreoD8XOghgoxeC+94bYfd
         6eCP+KykyZRk7uJA5OuuPGWgTfwbVKpk94n9OBAoy8zjE/eIQQRcmffvBDXlQel64Whg
         FF/auU3tZ0AR+lLNdus9YuJxPIYqD4vPxwwif0p+B4CTt+Xo5xW9kJ7MIAAYGZzlYTks
         JiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031799; x=1706636599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTxBbsO7xNZINKwTMim0Kh90fmp9yZ6WuJ5NL2lrpH8=;
        b=cw14qRMlhKl8qOkFWveo8S2wi6/XcSuGsdDbQzO7bcYAPFMNjvUKvZT72oyPGXRAz6
         xQ2lAIFi4rY8ww3Khv+3k6m+uOBYJYfamMHHXvsY+QsV3Coo/pR7xaBjXo/xszm9iSqF
         /qYrosQ0AoZ1gcUwxrIHZeWMorOjbxfZ4hdqq0qE9BnUGIYMEpX+WckZzAMwUnA2qEZb
         w2WlckHlsEO2nCRs61gGhchLUHv+8B7+Hob9TUPtUM1w1EfhSOgNw9RtwJBjISIT7d2d
         xnmPZxbGDElxNGNgdLKIGYNHfNNp2LGltiF+Nq6NO6zRjagjGmVBhITQYxYuoTRa41K8
         WNog==
X-Gm-Message-State: AOJu0YxIjayJA8oydTJQlOg2aPEZ5VbPGdqJcbuXlKqDKoY3ZiZmSpT6
	+CYPyJFQTCEsfqPO5ECs8dYUwpozqabJw6zP4ktDKA5EuZz6PLY5u0qfE1cF
X-Google-Smtp-Source: AGHT+IEgZPKPFdnWg5569ss0DlAqGEitJtHlNF1gG2/gBSvhOkjYp8Mr7g+2XGWViwxLPVQ1X8/9wA==
X-Received: by 2002:a5d:4f8e:0:b0:337:bb0f:3702 with SMTP id d14-20020a5d4f8e000000b00337bb0f3702mr4120418wru.35.1706031799047;
        Tue, 23 Jan 2024 09:43:19 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6146000000b003392f625adcsm7148732wrt.36.2024.01.23.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:43:18 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: usb: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 18:43:17 +0100
Message-ID: <2312051.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20240121051858.17647-1-rdunlap@infradead.org>
References: <20240121051858.17647-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:57 CET je Randy Dunlap napisal(a):
> Move the function description comment to immediately above the
> function implementation, the add function parameter descriptions to
> prevent kernel-doc warnings:
>=20
> clk-usb.c:80: warning: expecting prototype for sunxi_usb_clk_setup(). Pro=
totype was for SUNXI_USB_MAX_SIZE() instead
> clk-usb.c:91: warning: Function parameter or struct member 'node' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'data' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'lock' not des=
cribed in 'sunxi_usb_clk_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



