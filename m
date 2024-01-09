Return-Path: <linux-kernel+bounces-21439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B4828F24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C01B23DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98123DB9C;
	Tue,  9 Jan 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0v0lAOr"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53253C6BF;
	Tue,  9 Jan 2024 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595b208a050so2178394eaf.0;
        Tue, 09 Jan 2024 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836908; x=1705441708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvdJeq2ZBGjXZzlPb1uDy/+QxH7QbSi8cCkivdpW86k=;
        b=W0v0lAOrjixCW3VBfB/7DyErQuGWnd/D5mF7Na1L2XUozE+qcFdIYhxfQvzxgBoWpH
         BOCnFQGLP88N0ZbO7aSZ+4TuJ7Bs6x1txsS8F/7xXpbaPY9SBPYtopQ0jCBNjMbvGz2o
         bgUPw9glYgVPXjdV2kAs3NrtFe2Fp1FX0kS6YB9Ex4H5awKzLUs/pbd/4cRHrl4W3jnR
         NBROdZQGFyIRxfNbwlenftDjeVtKbMgQBSQVHFtheCwuLroghnCz7VLGnsAMjoRJg9co
         esniL4esdNLuNjXfCq/l0mJATDKOJ1yz3oL09McveM2DebrHIXJpRwZZsplMD6f6Q7/9
         lDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836908; x=1705441708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvdJeq2ZBGjXZzlPb1uDy/+QxH7QbSi8cCkivdpW86k=;
        b=ITxYDhoH8PgMV698z5QTddAOw6fayDwssSXTFD18hz5Q7nL6JBGFwx1ghCffxJXHll
         bebeG4tcnSjxKeGdDDR5u4vOdTRj7dkWENGD27yihp+zJ7hj6Fn8zQE62vjlSt3v02gq
         sfL7m2Tncg62tXBEINxJLZinyiIKFi1oZkKKrx59xpM3AUlFSbS2nFMfMDWKMou2SH84
         1alHU0+lLoYm/8d4xKSN2GEcgEbO4v3Kkbk0px6utKQEjJIhSM3DQl/D6SLK57cv7Lhs
         KVEoQSxDeknaI3Q2pih6s0+oFkZNX7PzArHZF0AIjwRp9WK1h6HZfjL0mJnL8E3EzAJx
         iXfA==
X-Gm-Message-State: AOJu0YyIoVHgTDawDnLWFP0BO+u/9OHpYQg4umrWQvUM4IjokLiiZSFh
	QP+yTuqaMU8IhS0CpKDDRTo=
X-Google-Smtp-Source: AGHT+IHUwiTUiTbOOMgRI+gBgs9efvZk8PJoJM0uHPgr/GwHLKas07lU6aQ4pBFuYyzhVoGr8P65fw==
X-Received: by 2002:a05:6358:5e1d:b0:175:a47b:6616 with SMTP id q29-20020a0563585e1d00b00175a47b6616mr21234rwn.24.1704836907570;
        Tue, 09 Jan 2024 13:48:27 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1135:ca4a:123c:5e53])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b006d97cc5cc13sm2137072pfn.8.2024.01.09.13.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:48:27 -0800 (PST)
Date: Tue, 9 Jan 2024 13:48:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: hdegoede@redhat.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] i8042: Add forcenorestore quirk to leave
 controller untouched even on s3
Message-ID: <ZZ2_KMGdokHNWcNL@google.com>
References: <20240104183118.779778-1-wse@tuxedocomputers.com>
 <20240104183118.779778-2-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104183118.779778-2-wse@tuxedocomputers.com>

Hi Werner,

On Thu, Jan 04, 2024 at 07:31:17PM +0100, Werner Sembach wrote:
> On s3 resume the i8042 driver tries to restore the controller to a known
> state by reinitializing things, however this can confuse the controller
> with different effects. Mostly occasionally unresponsive keyboards after
> resume.
> 
> These issues do not rise on s0ix resume as here the controller is assumed
> to preserved its state from before suspend.
> 
> This patch adds a quirk for devices where the reinitialization on s3 resume
> is not needed and might be harmful as described above. It does this by
> using the s0ix resume code path at selected locations.
> 
> This new quirk goes beyond what the preexisting reset=never quirk does,
> which only skips some reinitialization steps.

I think the original change mentioned not only issues on resume, but
also after boot, which this one does not address, at least directly, so
I am not sure if this patch is the proper replacement.

I would also like to understand better what exact step is troublesome,
as I would be surprised if any interaction with the keyboard
controller while suspending causes the issue to manifest. Is it enough,
by chance, to skip restoring MUX mode and reset?

Also, shoudl this system use s2idle by chance?

Thanks.

-- 
Dmitry

