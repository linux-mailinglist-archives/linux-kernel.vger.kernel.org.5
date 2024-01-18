Return-Path: <linux-kernel+bounces-30062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B845831898
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD301F25A30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83D24202;
	Thu, 18 Jan 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0cot2KT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340B241F3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578243; cv=none; b=VqhEPWagtge4w66Xo3uhIvbHRIKdVbYxOQAf/r5FbMsIO901gnnLw0GSgxEgfehM2w7uWzF1FYWOZvYg3HvLdzVc23zGz+ZMxrjJ78JvieHLuTY9NV2hnMgXhNCpJK2UIZg+3wiviRjMoZdidqhJgUNOHi5mtwjOKhGeDDpMv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578243; c=relaxed/simple;
	bh=fGxN8H5cKdZFoYgwZBOkxu+K9a5y0CIqWCEk76K2YtU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BzJ9P0Wc/WVjw5ETAYLN0pDI+3xw9dNwEHJnTHKuPZgL5zKfVyXhfXVQLhdU3Io7FpkKuC0K1/dZb5V8PD4g6thXfSgSwiXLzQvshsh9UHOZcTxPb8lI5wduUGXGoefD7P+n5cC0q+slJFwSkezB8FdMmWfp3WvLco9KTPJUN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0cot2KT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so15444398e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705578240; x=1706183040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGxN8H5cKdZFoYgwZBOkxu+K9a5y0CIqWCEk76K2YtU=;
        b=F0cot2KTOWA1EPpVlzQaG6NLs9Zw/QVDlUQxluAHKY3qi8lVt0VJduyXI/41+Ohax2
         KEYmDh1PKtkDDsH4fl/HWjsZovl9utrqUPW5aqZ1/LRV8rstT27kVWnEVzRDuyiGxLgM
         pOGoUG43pcr8YQRqBhVY6ZfHAwgJildEyczasGwvJNB02dgaM/iEIiUTeKT8df1brDce
         7Ftn8jLujGPpkfWi4Je/50DwVbiQCbImjZig0dd9996stMfZNZDKeS9YWUT7bAcC3E0m
         rLLh2ABU1LHzExVLeI3h/yarWsxqsTSb51bSwOhNugpgp73eCG758wqv47UG/T7sW28y
         lKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578240; x=1706183040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGxN8H5cKdZFoYgwZBOkxu+K9a5y0CIqWCEk76K2YtU=;
        b=g5DhWYrI7IowOsOykWHq2qNg2L7yU9KBJ86101j6sO2IvJiBiW+OxgpQk1JPa9Z081
         t/tGK+ORVfYSk4ZKtVO0vktt0ao6qnINAh8bcgSKllTiYAvqMxe8z+T17tgw3jfon7jL
         nuK+i4+eG1L+Bt3QmsbN2hJ8kHUThxOuI3Hc35Hh6lB5pkmEyYyZHwaor24524WZ/Ra6
         vo4BxjUIHckT1dnNTpMl6HSr2kftyNjM/CUNYME7rpv7HfkaCZoEi6QHalBB0D7Tqcxr
         P7cGXY1HQov9p72oqo2FarqV2nojpNlLb7bLlY68f+WQWnHyKbRAUj318WFpckEoQHLj
         2AuA==
X-Gm-Message-State: AOJu0YwpxOLM9w3nwpy4mVwOv4YWcbGPBLQCA131D4UD0lww1IrsPTad
	P2hTOnR75tViq7UgLdvSxnRGQWQUXvobaueR+6WPMwTiId9GholE0UiDPoASXV6i9apwT+4vIKI
	6m8DLdblHMKYRg6eDwW30jprbJCw=
X-Google-Smtp-Source: AGHT+IH+ku94Iew2GTbP3stiXOc4w7Pc+iHFIUmBJ2FGRnxG5gnWdGIYhd8LU0pn1ChNo6tCtTMDSIOET/zL8wuPIlM=
X-Received: by 2002:ac2:5939:0:b0:50e:7fd9:7 with SMTP id v25-20020ac25939000000b0050e7fd90007mr395694lfi.59.1705578240018;
 Thu, 18 Jan 2024 03:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-4-nunes.erico@gmail.com> <CAKGbVbt_1SUmTftqA5H27keCeH+u2ibrevy=cW8KsJSHu8YRdw@mail.gmail.com>
In-Reply-To: <CAKGbVbt_1SUmTftqA5H27keCeH+u2ibrevy=cW8KsJSHu8YRdw@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Thu, 18 Jan 2024 12:43:48 +0100
Message-ID: <CAK4VdL3umA8KZizPAqO2GGZu5RTtvgkFq9Y0rSYSwZZNsVkjDQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] drm/lima: set bus_stop bit before hard reset
To: Qiang Yu <yuq825@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:01=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> Do we need same for GP?

I don't have an issue reproducer for gp so far, but the hardware does
have the same bit and the mali driver does it for both gp and pp, so I
think we can also add it to gp.

