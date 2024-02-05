Return-Path: <linux-kernel+bounces-53152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EC84A14C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65675280C65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47F45946;
	Mon,  5 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyqaOF5E"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B04503C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155336; cv=none; b=gm0ZkNdo/CtnPPnV9qjZ9TKU3kldPGTlWatZP+rfLXP6txIk4m3DfzDEyTszqoEQiWhjY2kfmtJ4LQb6XFRvANG3z1UNuLtfa43bPrOlc/uRZklv1ccIeSHEvKsFT/Fsu0/Gm9JGVEpoRIkkaxQzhKscS5XWAzlAC+ki70V5YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155336; c=relaxed/simple;
	bh=Yr53Qvxk9Z8/X/CCTuZKOqru7TtKBTkjgwQvH7qmTRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p36/naRAUyXYvvheGRLq7J+1JVhn3+k4arxJvr+ItRTn8Gw8BtOXEykYffQJwQMBZBp6RZXdCCBLk5f4r1g9H4X6PA7z1k5ze82lmkk4IDeL3bNSAgNuLp1JVpVXzW6EAMpv2mHEz3jaf70krfdqqc0gqXaOlNrYgJo0mqQLCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyqaOF5E; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so3669276a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155335; x=1707760135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaPraCRIHPJubeWFX6MVMaiMZlyy5vM9DZL94NRqDo0=;
        b=eyqaOF5EW1V9T1ppUA2r8yQTkk9Ja0QKxdIpxOzq7qBCoMvRNRGUbgSnK2NYkoZG8b
         SextO9EL9M0/KDk4t2BPug2XRRflB2AtSnyLp1PKlKdr1gtdsgns/sSlczkxQamROL91
         jK0ZlwN1mNYAbJAAAM2n/DylXz+7jI9amYIrbNQiMHqeA+NsFt52cdTBuSD0umO2/0fL
         +oS/UUSNOX+3KEhKF05HaAqGI/tWBY0aLoX8LajbeMTdfi9UXqYjnAA/nnuPpGHPoz09
         Vq/iu9zs9iwM22LDIZH7l2rsoFcerVKo7+R12sRgwshsb0QyROpq4JlyNs0QqjeCn835
         9mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155335; x=1707760135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaPraCRIHPJubeWFX6MVMaiMZlyy5vM9DZL94NRqDo0=;
        b=nvr1SfM5CriKh4XNXK0DdDKW0kJQNxicIcj133kV7Ce4DKpnW/BSgwTGbbZKPylIR0
         Qgx0tsax9asF2LU4eO1gRsCoIwbodEctWrmmVw8i1bynLUkmtzadwlWaSSz6Bt0Xfol7
         1W5KIza1FGpxsESZPmEKCdeI3XFI9v6FEunYNn6RGKYJ4fZ1SpnB1Tybu0+yDlHIjiix
         cnmXGUG0VArhsCV/kvnLNkAlaAwyFw3oe8aCK99DTia+iFmiI5NT00L+VqG7AYzkiruF
         grSCSUMbWGhLN/MW7g/B+JcVVrVMFZsh22Uj8BxqLqAqug6hKLpm26LEMtP0IFJMHMY2
         grzg==
X-Gm-Message-State: AOJu0YwnR2Uf2/9FFRivPpO+PLpXl1orEhQiC1sdvpgzgM5wiiLqE+js
	8y0hY2YwvSXmte7LeSAa4e5nNbsjdFLt6DOLb9nvf0DirbIaTg5IkKa7mmMu6Lw=
X-Google-Smtp-Source: AGHT+IEUpLJCfF67U1zQwYpuikCA7rRZO3qRDCzhkst7IAYgWsh2q2QPnqOL2En1JdftBazt1agUDw==
X-Received: by 2002:a05:6a20:3c8a:b0:19e:488f:6933 with SMTP id b10-20020a056a203c8a00b0019e488f6933mr295744pzj.21.1707155334837;
        Mon, 05 Feb 2024 09:48:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXWS5t5kW55kU8GqGGD+Skya7M/LMkz+anJMwf79WGWfww4Wt56Rtz30AhIOKWUngHNDctoyIgcyIaKlPZymd5aYi+EKL0Wliz4NrcQvJFanb7QiQlmSQO0E3VsWQk+AQN/gvWh73key9WXblyRLgZIUTSVISbMTg==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id h17-20020a656391000000b005cfbdf71baasm250195pgv.47.2024.02.05.09.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:48:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 07:48:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com
Subject: Re: [PATCH] workqueue: fix a typo in comment
Message-ID: <ZcEfhRsBHTbYh5D2@slm.duckdns.org>
References: <202402050831+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402050831+0800-wangjinchao@xfusion.com>

On Mon, Feb 05, 2024 at 08:31:52AM +0800, Wang Jinchao wrote:
> There should be three, fix it.
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

Applied to wq/for-6.9.

Thanks.a

-- 
tejun

