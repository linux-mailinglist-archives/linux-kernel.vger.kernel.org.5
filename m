Return-Path: <linux-kernel+bounces-47383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870FD844D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267351F2315C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49B3C088;
	Wed, 31 Jan 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqk1aFQF"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B83A8D5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744051; cv=none; b=f10eFsykFh+RzqCtXl+DG3X549YGeugQZQNLbw5qDVF9VRfEKEHRsemEAYyqXI2YDTTNakJGX+U9+NRQLrs/Op/K+R0JsbkXYEOS67Cx9U1595bFOQL8JniW3WJ1gJiLGHZqYev3l56nb7cKQVARRrXTwktXMOhmp4XmLulm2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744051; c=relaxed/simple;
	bh=lmyZU3S6tMC5hxYgmUt0gdZ/4qn0AMR/VJac2xrYxKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8pikmAa/2ZkSjR5WstMe/BFw128aPF/8enr7nqpOxHaB7pN2ogasDVmQcUFx4aOiBRuZng+s5Kx0m/tM/2xdq6ppqDyJpS8/WTH2MW2JorI/THYccElBhnzqVJOX8kvBao2vyS4nCzuRaN57pn/TSK3ntaFGzSofAR3jA6vIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqk1aFQF; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso13845839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706744049; x=1707348849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmyZU3S6tMC5hxYgmUt0gdZ/4qn0AMR/VJac2xrYxKA=;
        b=jqk1aFQFfKWJ3BA+tMDcAhF6bk7GFKZ8jtpdiuh0wgSJlJXQtGq0BeuIYXe9sXbE/s
         tezLRMbiaUoSvdXHwEJQ11Ht40SJrwjZykw1j4/UmTL20S+yAArncyvAdqJufIzL8VBx
         OPdmfLDnOnuQehaoZ/yr8lIT6O0SWSlNSmJN+MdjThMVTz6GTPHBqQ+TXQJx9eZ2ty3j
         ionqLPxwG2IwWuThm1j6sOtexGVLBNemUAOeID76eutDaPFv9ekrIonHsTRHOieO0bBF
         +lyRO9rKsCrZJBGG+5l4aTkCfqwigG/goUVa0qnU/GbH26x9/5e8qdM/f0NnrnqXlvxY
         mElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744049; x=1707348849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmyZU3S6tMC5hxYgmUt0gdZ/4qn0AMR/VJac2xrYxKA=;
        b=if5+0WGru8ItEJKRoRD83rmcrpKq5RO5tpVAPKrS7D/w8eusCWTunByz+27CqOI2XD
         Ry92pdq5tx1Kg5xgGKO9neAXF43Kw44v/ngCpKeqi7sSHO/bgutkKfnbfsscECy/VlFK
         SMK0RY5Av/vlXx5+7kp4bXPuHG8GERFogxK+Y1OTPYl+8Rot6JBuEnlSgkP7rmP0DMF6
         SQNLYz0y4J8IFXrLQVBL9uQ2zQlxsfYXMUo/JvOHVZJ3mEojTYtMZ6/H+jSvs36okcR2
         yG/B1czwLucH4dh3wDuXeW1OAd6m9/SIWsXNdT2qAnRX1G/oPLXpWuZsTm5wVvi0Q1iP
         x09A==
X-Gm-Message-State: AOJu0YwHN+SABRBKz+mJnTrKL8Q2OE4YEYvkeUFExL6NxzFqwtQhh2Kp
	Uv3pv2DHVkAlQO+xHya3BoRtwVvhfHxDPWNJQYgP0JeUb6IktBiEnbHYU173gjRet/wGHV62gtp
	NsqQEfpaL1oXpCjWO5yyhQOujepA=
X-Google-Smtp-Source: AGHT+IFZu/hiUQegGgWy9wxoJkhDiSUldn4PD7yrsv2jucKPgStY67D+emB8bvpHETCdchmR0Dll5Gj5nl6pjUofg3A=
X-Received: by 2002:a6b:6911:0:b0:7c0:2b65:ae30 with SMTP id
 e17-20020a6b6911000000b007c02b65ae30mr1143742ioc.20.1706744048869; Wed, 31
 Jan 2024 15:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-19-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-19-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:33:57 -0800
Message-ID: <CAKEwX=M+EUuHBV9w8yR850g63+QcCxjg1yBe7oC8DsYCMV3dxg@mail.gmail.com>
Subject: Re: [PATCH 18/20] mm: zswap: function ordering: per-cpu compression infra
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The per-cpu compression init/exit callbacks are awkwardly in the
> middle of the shrinker code. Move them up to the compression section.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

