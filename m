Return-Path: <linux-kernel+bounces-44451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8026842246
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00FFB2FE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717765BD4;
	Tue, 30 Jan 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="Va4iGz6X"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7B381C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612600; cv=none; b=V9rvspl40riB2qa0Q9tEMbnXuVZpjQ8SfemXZRK/CNHofmq9uz1L88c4HDYRc0mg9gzAyccYFBP7F3dpnZ02Ofaee+05y76CzI9BKf8Ia++IsP5TfGPAoo5/eGPX5YYj02Ti+jELrsFoeifmWQUZ8Jn9Z1IR1OE0eIb8GV7IISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612600; c=relaxed/simple;
	bh=cYhntMSvc2MQ9UlZnJhG8eD51SepVoA/G5xtLrHgJgY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icHnEUl8+adYiax+Wu67JO+l/m6K91q8J/8RARq6WyqEf8sev9efZN/orUflybwn5Lrrt0qrESI5M0c2yelGIyEFpvVCp7Jbx/sq5aRTziVTp3UxaLmE5pApp3sAhtMNibjp/6VKX1lUkq+LF2xhf+AbYEX9Jh2lxnGfLQMbAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=Va4iGz6X; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1706612589; x=1706871789;
	bh=cYhntMSvc2MQ9UlZnJhG8eD51SepVoA/G5xtLrHgJgY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Va4iGz6XebcW70npMHgNmN/9mIutcs1itAXpO5jphdw1h9KXqlKwWppoZlcJEo0PF
	 cujXSLc0uZo3e5VGNWXk56QhAC/l9mLssoxotvoj0Uvm0Ffg3KmxE0moUXUmS1h6Vw
	 3yAScwDcQhk+/roxlzkWWsrR83V3ENrV1dSvUD26i9QY+nuUhmelXP+t3cEFrjfTzL
	 9ur0/SbL0WkuJWafnXhYMMmrdQ1foUUAN1nSU9DWqUSx17AOGztEPJIYn3VWTC4le5
	 9NT83Y8XSw0Afzmt17cZOvNiDNVY+/REp1+Ao/PvAl+HoPxCyzKDZqZqyDVTfDEGnX
	 95lZb9ARmrJbQ==
Date: Tue, 30 Jan 2024 11:02:13 +0000
To: Daniel Vetter <daniel@ffwll.ch>
From: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>, Daniel Stone <daniel@fooishbar.org>, =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Implement check_async_props for planes
Message-ID: <T6R8csfFYwdxGqaYt8syjZ6qa143x9HHPS2vS57_sk-NKMY9hJhP5xsHyIFlmhjzkZ9S7gR92E15Zz6DfEBN7qhdF2-fS5x88VeCExqReNE=@emersion.fr>
In-Reply-To: <ZbjVyI_AnTBHACT8@phenom.ffwll.local>
References: <20240128212515.630345-1-andrealmeid@igalia.com> <20240128212515.630345-4-andrealmeid@igalia.com> <ZbjVyI_AnTBHACT8@phenom.ffwll.local>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Do we really need this much flexibility, especially for the first driver
> adding the first few additional properties?

AFAIU we'd like to allow more props as well, e.g. cursor position=E2=80=
=A6

