Return-Path: <linux-kernel+bounces-84829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20A86AC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FE71F249DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968756774;
	Wed, 28 Feb 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VHLB0nZS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370856765
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115905; cv=none; b=AJf4lm5Imw9JN5cQEdsrZvau2C2FU4k2N4108HuO0dO9lf1auCV0POnuAvnFSuF1Snkz6NmiQVhlA8MCEwEUQXkoUqGgFlmR6LL00JKOb0QTjjji4DK7j8IzFfLDP2UFwqKA9iLwoj5cwtCmmQmZOre2JWpkGk+fUQUfKp/aJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115905; c=relaxed/simple;
	bh=RJWvUgHr8awlOHf5f+a2KBnaO6oNMg4fY/qdVUnzznE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMLXmeoQ2fFnIl2vL6+x6EYq9trYs2U1Zjx3ZszTl268matIYnLp6DrQCVZX/L6l7Sv0JuoYWcj2q9pOQ7yv5nDBQmiZDmXao0UlgmLsOk72nLSdOzA7ijQcB9IBsG2PgB5GZoKvMJQUfk+4fQzJ7hKcgNBQ4nHrTx5w5MgVWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VHLB0nZS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23d301452so72617171fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709115900; x=1709720700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJWvUgHr8awlOHf5f+a2KBnaO6oNMg4fY/qdVUnzznE=;
        b=VHLB0nZSyQaFKtZcmkt3np1G94/kCMT4QEtZ1pFMUERk0xrpuIB/cFHO3fGjlRzOP2
         oPzD+8DH9HrM6ThX/bOOsq6ol5+/fZ4EzAiMfjD7TN2bC2b4a0f9oSIYEidetc7dvYXm
         LHmy3iZ85hsllimJ56Q4XeIdZRw+4XtGJCOlFSddkUfu8pJ7hsEkC8YrBoB8ClXV9FyZ
         rnVg9lleA486hOl6cyZb52Sw1VtTF9Cn+lIANYJUmkeF22AC7rs3muACZfI5sj6NmLL4
         Bc6THhkHYFJce4Qv++qsTkeDdqTkLuYtS6pVv2T1Fq+0D9kckt0TssylpV33o8mP3aM+
         5xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115900; x=1709720700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWvUgHr8awlOHf5f+a2KBnaO6oNMg4fY/qdVUnzznE=;
        b=S6FPK/pbt+GfYZeQhXFfDubVYd7wS/sMaRlINBcH2rXpbyGNOeqfita4qqtW7AOPtN
         9w0LHJxmhwIDskzh0EmeSFHZOen6AOuJAlW43ptI2h3YJ4A91i/dnvPGh/oS5ofXPvm4
         wPA9qorm2cF1zISaa3ONNj6uDOLrMwuEOFOVZcK8ZqMPba79cCcHkra1h85F0BG9CT3d
         MBcgbcMvwtq8Tv0mxMAE4cslXx4iizIct5EiMuE8j5yvWl6fCSDnMZjx77qSqZ+hA9hq
         4CmKUDb6Iu1TYvGwRh4p7COB2Oz29EogPImU4NY9YFj7TwV0EewoIOVLtQTk97ug6qYv
         c4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX6xwll1pjqVUt2Re8N5eddEyn3zvE1rYSIKOVeqPOQbotksLhPqkijB70MFmfD/HEKDg7kpdJfC87FGbLs03oSKhXe87Xqxx41OZOZ
X-Gm-Message-State: AOJu0YwW+9A7+9EwWBS798Afq7BxL4EYZelKFZ71RvkccWcOG0oO6Rpp
	Y62wg/b0j2g7Swp3YQCFVaP8Ur/UBBz++ctEZtAv2n+5vuR69z1E8vMpH63OU2s=
X-Google-Smtp-Source: AGHT+IE1v8GX4KnuPAkO6ZzFb7IevBYvi4p+fVrf0lN07SaeF+mCEndEdGtR/o1KHfLMa4I/j6BhoA==
X-Received: by 2002:a05:651c:b0b:b0:2d2:d449:6425 with SMTP id b11-20020a05651c0b0b00b002d2d4496425mr633734ljr.35.1709115900049;
        Wed, 28 Feb 2024 02:25:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jj2-20020a05600c6a0200b004120537210esm1621345wmb.46.2024.02.28.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:24:59 -0800 (PST)
Date: Wed, 28 Feb 2024 11:24:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: tehuti: Fix leaks in the error handling
 path of bdx_probe()
Message-ID: <Zd8J-F1SEyZwF5Mv@nanopsycho>
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
 <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>

Tue, Feb 27, 2024 at 09:50:56PM CET, christophe.jaillet@wanadoo.fr wrote:
>If an error occurs when allocating the net_device, all the one already
>allocated and registered should be released, as already done in the remove
>function.
>
>Add a new label, remove the now useless 'err_out_disable_msi' label and
>adjust the error handling path accordingly.
>
>Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>Compile tested only.


Looks okay.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

