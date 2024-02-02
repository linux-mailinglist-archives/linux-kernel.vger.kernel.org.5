Return-Path: <linux-kernel+bounces-50317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3CA847752
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B438D1C2342E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FF152DFB;
	Fri,  2 Feb 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG7D5afL"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64216150990;
	Fri,  2 Feb 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898166; cv=none; b=VSlUMqFv0qf3drKQKA5rmCtFKxVAop09yBHGl8ubxVcXdcR9ZNrcs6dis5hOSnVEIUnlZIcbMW9kFqS6JmUyBPr9PETj1McvW1L4vt+ckEWOeq5erS7uWO+C4e4cILHpR/z8EWVPDjbp+nNdkylBAipsjXQh70+I+rUXYeYF7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898166; c=relaxed/simple;
	bh=2VoEdRvrRqBHfptG31aYebj1E1qTdeZ8YWp0J6B5gdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Syc0T8rzonN4rh3v8OPY6ZRABH8ENuXfmplYMjij21w4wTBBqGNNbchLKu8XNPRDHwTt83rFeSdlnSfPSwb9DZbylw0MeWGm66A1fAJJCNMPK8AIG4UMmDBS7Hu2Qkw9BD6N1OaU/A6XLTel2xPX4foqk9F7FjcgVNsEN1UpuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG7D5afL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso1787170a91.3;
        Fri, 02 Feb 2024 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898164; x=1707502964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YT/0Srb3byEwhZGAN9MvjmeizM6BiaKwUj1DsG3vCZE=;
        b=VG7D5afLoG6oay4ugal35RSMw6734XJSxkyc+cXzMhFs4G0Cwz0ErzCQfqIK1Y0gNS
         ee1iZsu/WFOe4vt6UnMb2pOlEqpNUxNt2S9zzD3MRc0Z/OuM8f1cDtDssp7pniEgMNvE
         7QZm41vkI4RaOHtHn5ESWny9hYaQc8d/4A9ly6Ahm+fCjs9lOOSyVp0HmWGH5na1ZzA6
         cOB3GYd3AJ33fcLj2YsImqUt/3KCDLHSa1mVDP7Rb48G0oruF1A3kaO+hTa77uvILIqV
         K/uQhuvPUJaNv28n72yc94moArVgKTsNausthTQxgr2fou+ahBkNwpN2s2kkZ5OJOdV2
         c5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898164; x=1707502964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT/0Srb3byEwhZGAN9MvjmeizM6BiaKwUj1DsG3vCZE=;
        b=usecHkz8m7P+ZG0mZVpFdNQA9ktO1RfqcZl5JQzI3XpC+MQhknuiR66jtsjpcZ81Ml
         aaPkKtF94+klmJmhTfy9l6Lhd0laK24wpde62obqeSRyMLUdIbhapXzTrer7e/AV6Y0Q
         PlVN359+5F+QdcSvbvfqOmR2w+VyYNhSxEuQ7rg6gOWA+IOtQWGIfJkUXCieJWf2i/Ri
         Fw2/8kUd+nf/xXl5LqOJI2uNU1O0eCrAPduSZ9xwAxHgxZaopgWKaGAiNXhMSHTLDTr1
         KMX9565sw+6gYGpuq+H4hZrC3gHDFkrmZ0ijzM/NBav7tjXg5gNxoljCiXPIZSDUAfvh
         rmpw==
X-Gm-Message-State: AOJu0YxukAAqDhELoQlbxP2jm+jwRDwMGQrbji/8IHcPyYpnsQXo2/md
	uG4+O0VfoA1b+dnK415w1W801NdgR9lvjm/ia3OPeGk4EgxXAqMwa6vvWINp
X-Google-Smtp-Source: AGHT+IGrUXxBw9jg+aIzlF/xYC+0+LaqvOK84khmAMHLUTLNSJQDwY6j38qwSHgxrWVfIv1UR3NiZg==
X-Received: by 2002:a17:90b:205:b0:295:f9a5:f8f0 with SMTP id fy5-20020a17090b020500b00295f9a5f8f0mr2883428pjb.10.1706898164395;
        Fri, 02 Feb 2024 10:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUeBJY7v8lYdeGa0d/C1VBduqn96gP+fdlNA+X/J9qXmj4Z7PxTFe8Y6ugyx2+vcY+meTvYtVcYnq+HNLCDwxbTLECJcq2IiSbCYXYXbM1MBTCJmOpzl4PLgmp+Dykf7J1yWbGHAkAr
Received: from google.com ([2620:15c:9d:2:c30c:2f35:dc97:44fc])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090ac89000b00290f9e8b4f9sm311350pjt.46.2024.02.02.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:22:44 -0800 (PST)
Date: Fri, 2 Feb 2024 10:22:41 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix strange behavior of touchpad on Clevo NS70PU
Message-ID: <Zb0y8cc0T6rr_NDr@google.com>
References: <20231205163602.16106-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205163602.16106-1-wse@tuxedocomputers.com>

On Tue, Dec 05, 2023 at 05:36:01PM +0100, Werner Sembach wrote:
> When closing the laptop lid with an external screen connected, the mouse
> pointer has a constant movement to the lower right corner. Opening the
> lid again stops this movement, but after that the touchpad does no longer
> register clicks.
> 
> The touchpad is connected both via i2c-hid and PS/2, the predecessor of
> this device (NS70MU) has the same layout in this regard and also strange
> behaviour caused by the psmouse and the i2c-hid driver fighting over
> touchpad control. This fix is reusing the same workaround by just
> disabling the PS/2 aux port, that is only used by the touchpad, to give the
> i2c-hid driver the lone control over the touchpad.
> 
> v2: Rebased on current master
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry

