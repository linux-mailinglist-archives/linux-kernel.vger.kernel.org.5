Return-Path: <linux-kernel+bounces-30885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458B83257E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830701C22F26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1AE125C1;
	Fri, 19 Jan 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkR099OZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D6DDA2;
	Fri, 19 Jan 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652116; cv=none; b=EAZpbNI5pxIdGnIKuiThOr+ggIouPc8P2COIou/L3pm7DKJk0Fx/WX5D/Xnt8di4t+IKeBCaCClQXTEmDLdnn0TBTzY5kl8dP15DMIQXDzfAi8UzTklxBxkwnOoSqZ6FCTKR8CqQVZwmaAQK5KQo5xmhW/LPC9jXjZLZmBkY0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652116; c=relaxed/simple;
	bh=Brs4I8LeGv/nD7PSa7xlIQSgiZc+XxvPNqzYhGnyoNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P81na710lda6CRWBa4Kd4Ok967Mxg6mZbxXVWNfO8Zg8UENKXTV5967NO3s+KxP8nd61n2qpq5y6wUsgi/e6EGKmV2dpkLnT/vn+pb0k2YSIvWZJzNKQpqS/0TAsAufdJL1xIu4yCaQUZT4pDrwXy2NNylngwcFftHKCJXi1PqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkR099OZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5f388407bso3287785ad.0;
        Fri, 19 Jan 2024 00:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705652114; x=1706256914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFiyPVIeN48MBC4wX1Z72krh/+iVgMlLmTO4HYqgbs8=;
        b=fkR099OZODpGi2PMpg+K8hgbhIF9VfGemMlLWjKYqtn/Ldvfif5mdgcd5bGsBy3E/a
         VnW9LiLN/3WIJ7ZJy4B/KlwLRb3ca27J4kXDYVMNQBX5MphnQ4YLtYhzyoRz2/58grvz
         mAk0QPcXSaCTKNr7a+Zzn++R0UcN6PqnhnWYhnAzxofLSb5ObDDJWOITjg0tGaEihVrR
         GxEvR92CWA7a5+xabkdHl3FPitglnyV+1UymugmeE3NR2JaY234lW8NqXFaBQ0E7zrK8
         swy9cHlJRIPSDndLw75Qa4Sdbbk08RTt6q9gD4x34V4zPcs2kiAW27k4OPkRGHliPAsN
         M8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652114; x=1706256914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFiyPVIeN48MBC4wX1Z72krh/+iVgMlLmTO4HYqgbs8=;
        b=pYWSpwsuqyFhvQ5lrc22pcvB04X4JKsZBkCCA4Iz8/RkgW87xRK3/8A8PjGzduWPqa
         nJbVfryKFP2LPLjCjBpeworKVXPvT2NCA+0GKzxZkVI5CyU+4Z2xqo3foAh/ZNehD+ps
         YlJ4A68IrJVwDqliGYv5XHX5F6I41h3nAXMB0IBpb8HdDxW1sauGOJxhXh2+d5IUWyet
         CK+VtX1MbntDv1gZYTYFVSUc5ZqjcPnD5NoKQLxh8FPNTwe/fiEzaiWvRinjQbaWX2/t
         VxYFHnMfg8tfbvEAavIcmldPXJ6XlFmd70YVv/IB8nmbrQL8/30HTxQwVp/BbBE5H7mX
         Fjgg==
X-Gm-Message-State: AOJu0YyegXNp3aW3X7lHlhUVMwGWquJ4y925XZw3e7cCq1XowPFIRQs5
	9PjbpR61SyZDgJJC7fEInjvaX6f36oYc0gUgA7h+yJx+1+GoIEFyD/3cQZA9
X-Google-Smtp-Source: AGHT+IF3CUyn6OpGy2SQVSG2RlMUA3LqbIze/2BkMRUySl0E6xO3DVCRPA6t/t02ovMMqlaVUobUJg==
X-Received: by 2002:a17:902:ce90:b0:1d4:e308:d6ff with SMTP id f16-20020a170902ce9000b001d4e308d6ffmr2172134plg.113.1705652114201;
        Fri, 19 Jan 2024 00:15:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902e90600b001d720956b8esm610126pld.77.2024.01.19.00.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:15:13 -0800 (PST)
Date: Fri, 19 Jan 2024 00:15:11 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ting Shen <phoenixshen@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, fshao@chromium.org,
	Ting Shen <phoenixshen@google.com>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	joewu =?utf-8?B?KOWQs+S7suaMryk=?= <joewu@msi.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: cros_ec_keyb: add support for base attached
 event
Message-ID: <Zaovj86pZIZdDQiJ@google.com>
References: <20240119074831.2979671-1-phoenixshen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119074831.2979671-1-phoenixshen@google.com>

On Fri, Jan 19, 2024 at 03:48:17PM +0800, Ting Shen wrote:
> There is a new type of ChromeOS detachable keyboard that talks to
> the host via CrOS EC host command interface, rather than the USB
> interface.
> 
> To trigger the firmware update daemon (hammerd) on this keyboard, a
> signal is required to replace the typical USB hotplug event. This patch
> addresses this by mapping the EC's BASE_ATTACHED event to SW_DOCK.

I think emitting an uevent on attachment might make more sense here,
SW_DOCK is to signal attachment of a legacy docking station.

Thanks.

-- 
Dmitry

