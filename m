Return-Path: <linux-kernel+bounces-64804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC5854303
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790F9B27EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1244125AD;
	Wed, 14 Feb 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuFX9pnR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77200111B7;
	Wed, 14 Feb 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892780; cv=none; b=JUcrbAg90pjZWEE3gvr9jsqSdC8KoEU02xv3fEYQvjINFnX9MzuwCaGaTXVEXd1E8+v4G1oRlYRsHnamxhkJmhqFSliAJguLLudnq3s8uxsh1us5NIGLGR87ZW+NfUFnRqAU+j8N4ZuDIR3a0ELdTHZVYOlVqk5ZeNzkkvtYxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892780; c=relaxed/simple;
	bh=Z2UvlYmy8jStGF8rtmlur5G5fjSEbZQAQVjtf/FVXLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B66T/hUHQ3oOanz91jq7T7wdD3FimB08ZoEOjRe0EZfhu8Cj674XPJW4zeows5m9M5npEUc7giQXrL4xJRJeeHQ7km1IDBq01LhX7ZEtoQAQd2GHvzC02IEzovNU4tcy5PJBIWyjULLXfhG8Yyma85KtEhFXaXGPJsu8cTmn5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuFX9pnR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6933620a12.0;
        Tue, 13 Feb 2024 22:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892777; x=1708497577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFKJcec316rzwihbFHNeOIUKYHGn+m3YQYlGgXHiGrg=;
        b=QuFX9pnRKNviSlT+iySKDwT7F6UuVJBCy3ClzEQH3UFY0qDxdVeKt2r2it+IDHCzCw
         KE1xGLYa8PEsNk3w/eucsfLY6AwR9NfC0HNVGfufPYbqDWFGXzBa4tC9vbrfhVCZI13Q
         zfXX+HdgVnUwc4ffBrh/0ySgSM1Mw88IGuxNBA8F16wq6bm4tciagaeqkbO6pqWyw46/
         wOqZ6iRGyN+plaHKNJNNI734wPxttGE6FVhkNAZ1lNP4YLDn9X04hgsHZ2OQWix/imar
         uOA3Cvnz52GNag79SZI/2uZhGD6bUBzbpsc3Hwq3fMx82YN3vWrr7sG3xJ0ovds2Hm7N
         p6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892777; x=1708497577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFKJcec316rzwihbFHNeOIUKYHGn+m3YQYlGgXHiGrg=;
        b=HFf4/V5EYYggLhxwfFId2B7exv3c+2TE8NmBlHPfRHdmlrITox1+LTW+eRmwgfamaz
         wxxHqrtd3uk2VcW2AId4L0ab0YfwT+2WmoLL2qHHme2YAxNiqBmPx+A5XwPbNg0Rc9xF
         kFKr3x2kVkYCBOJBt0DGUEaMus5rHerKxe1OAekZAli5rJabSu6EChyQXp321CytU+P2
         XDaIvk/v24zR+ArcyBdNqfAtA8ylHZwTk6mGw99aa7zULoBedPKiPSH7ub6EEBKIO0BN
         d9WUiMTAYsquez/ENXzHNmZpHtkHg81JA9vip3PhnxDBRAowaG1CulmtcpDQNwmvdUSO
         PDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk3zy/2rECWyMnSaKT3kXx2kGI1+Af7ZXm416RRM2tkDid9LtxnwzW0RK67gTBO60qw+JQ5a/zzDAR3st5bJ+V/WYMxBnq55l8GZYGF+7oddjhmsYHx8mZqPP4PMFVmRneTRMm
X-Gm-Message-State: AOJu0Ywr57IYAXf3njTCYiPxtZbzUyjAbwPCrJNYYhEH2KpBi14w+8cn
	Xf4rtu1Jywoo+0U2B9aXGzo0orrwEwthMp7n/POQwr0cT0NIDGui
X-Google-Smtp-Source: AGHT+IFwIs1XjPv1nNLy0ki1+hUV0xeIi7FYViGiShhVo2GD7O3Ym/xNkkxjLge+cJTJVcDuVbbzzw==
X-Received: by 2002:a50:f618:0:b0:562:7705:57c8 with SMTP id c24-20020a50f618000000b00562770557c8mr755318edn.34.1707892776495;
        Tue, 13 Feb 2024 22:39:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMg9Zsug03GXLaa6kHL66vuelk/iBcTkj5G47AWFAzX9Q4GJMkVUGo+o6oXWzOPAgzmkwPqGqq4EVGlMEuMghK/TgY7OoMES8/w7xidZisFdb0rLJPKaDs93kOsMEChOiy9RqE2An6T35IE3iLdS+7LY9wREMOvQrtDbr1HZlCpUqTR+yc4m8srgJRGd9UDX5Cbwh8JQHo02ShgrQGC8VhyMtWJzAPNCGZz1LBMGT9SK74V9CtyZ3NgabK+oFBjuyF4BP86lzO2JjeC1i3Up5Libh/9GbJKJEbLfvnKqA+
Received: from eichest-laptop ([178.197.206.161])
        by smtp.gmail.com with ESMTPSA id fg10-20020a056402548a00b00562ee409ea0sm291175edb.62.2024.02.13.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:39:36 -0800 (PST)
Date: Wed, 14 Feb 2024 07:39:34 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 12/14] net: phy: marvell-88q2xxx: cleanup
 mv88q2xxx_config_init
Message-ID: <ZcxgJmGNDIbeE56a@eichest-laptop>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-13-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-13-dima.fedrau@gmail.com>

On Tue, Feb 13, 2024 at 10:39:51PM +0100, Dimitri Fedrau wrote:
> mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
> mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
> also called by the PHY state machine. Let the PHY state machine handle
> the phydriver ops in their intendend way.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

I tested the whole series on the MV88Q2110 and it works as expected.
Because this is the only change that really affects the MV88Q2110, I add
my tested by only here.

Tested-by: Stefan Eichenberger <eichest@gmail.com>

Regards,
Stefan

