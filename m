Return-Path: <linux-kernel+bounces-53899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F684A7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929C81C27B22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCE12FB2F;
	Mon,  5 Feb 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="KMJXLZam"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362312F5B5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163922; cv=none; b=QBPoXVKROUcVRKvBDds/mqYImHp8qjYIjwR28sqB7ZZYDCcaDkbe/ZyPcoMcejaP/YAaPsvtVa2OK249PNjjG/JsNQEjJSheCNP4sLjmM2Tgn6+vkNMFiWwuAyVGFi9pyf6LBlRAHVB9c+ZahDS6MjvFaHtNzzthgSs5OxFa0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163922; c=relaxed/simple;
	bh=0Z5+6iG3qfDtRDuftl4qlEqF5t1i4M61nAy0NvQK7ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8nm1XVLx0PtY90ic6p91Ydk6hYHGWJlce0ccN2597XLy4s9h0Gf3TmWC48fzvXVYix/Nza1VnuAlT5sj/GJ/Iu3a0rDhLxOD2V+UI8BWc0unTtlO1TRqrZeUxQyeI/OXhsWQvs9/arZsWkVKrEP52vgu8SDbHaDp8d/Pi363Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=KMJXLZam; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7354ba334so42465365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163920; x=1707768720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VrXjwtbtApfoPO9WipzGxJuUYZe1c/gxVMsPgLQPCn0=;
        b=UrwSa+HA/M7Jh8aedR0OczM5Pfu6TjTq8LDAnYx0OcgKqZ0mpKWolE3NeT6XUhp280
         rFJQpaU2eMfTjyTZgYBXz2nXfboR10Xej/Dt6kcp11UTVQJ+1VTqkVtib8SML7UTGzaD
         OxpQnq59Yh4At1s458FfbRIyND8FmW+pRF78DmifocCMsqZS5WHPqjlqtmamAoyyBmE3
         9XhDzm7O1Q6y2m7AYaB0XItOYQUJZGopJ87QPskbOfCKzBrJ1Zwc66cx597Eyjvuxo35
         gsI/sk1Ot06dI2KFo5eiIqCHrQwzvNVWBW4hs8VxcMSRtGup1e/W/gH5YQ9+Z0oy3FEx
         37pw==
X-Gm-Message-State: AOJu0YxBBOSkh4qWdZKGR58ysBlEs7/o5gISnTMScE4rPkz9MhhM2zdr
	0nH1l8U4Dv+OzwPTnDQQBldi9BbuvB/GeQb3DHhGVJWkdA4bcjwVgW9yZOBQveIHkg==
X-Google-Smtp-Source: AGHT+IE5BPU04d1thygWvYOo5NmtGvNSIgJCitGyCNP3+5xGEi5pBD35Pi3sZqr42IpbJEzxJ2UA7g==
X-Received: by 2002:a17:902:d389:b0:1d9:a2d5:a113 with SMTP id e9-20020a170902d38900b001d9a2d5a113mr188350pld.67.1707163920051;
        Mon, 05 Feb 2024 12:12:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX5bUoYI9CKd2L/s5FbsVePJPxAlWZLckxwyBerkG+0iGPej3iD0Ep1ChRRJYQZXlRpSZyEHwCv3KQnmOVdc/ncJPV9bVB8+CYrE9AD
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kp13-20020a170903280d00b001d9b749d281sm276104plb.53.2024.02.05.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:11:59 -0800 (PST)
Date: Mon, 5 Feb 2024 17:12:28 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707163917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrXjwtbtApfoPO9WipzGxJuUYZe1c/gxVMsPgLQPCn0=;
	b=KMJXLZamTi8dosPezu7VN5rTIgV9vKLocj1dpB63S/gSVtMuZuazsgqbF8yAM6kQV1JiLV
	xWvZ6hLVo1s/NDcX8E6sWqF0IHbQL73+xI1igJ5/JdqZcXb98OrEzgPBhQB0N0Ltm7UXon
	MuYlMyEboTX0JoXYMgjIYfrrhLc4ijAHA6sZbbccTS+8/cXxbUuPQuigvQ75D96ZDuyE08
	pOLBbq0n1uyx31Ut/dn52Bo70SxbyjLeWWA2bXNs8W4pIRWgd/seb1DEsnBvZIvznrEjHs
	7vPwLGEJu9fBFO0O7SmjdhphSQ6krOslXoCUIvIQOHkEGg/YdSQOVyUo2x7WcQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: make w1_bus_type const
Message-ID: <l4x2mnhwa4l2r2leswc3w6n5oqgkr34vzf3mjzpkcrdb6l6xzi@5lfmfsjsak53>
References: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
 <80d80422-139a-4bfe-9d8b-4ef193e72d8b@linaro.org>
 <hk2w5pow3kqhw3vk5hlgeoy3dntbujb2s2xup2vkivtabwwb2k@do5ud3tj33jj>
 <2024020523-vastness-preformed-0cb0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020523-vastness-preformed-0cb0@gregkh>

On  5 Feb 19:08, Greg Kroah-Hartman wrote:
> On Mon, Feb 05, 2024 at 09:08:20AM -0300, Ricardo B. Marliere wrote:
> > On  5 Feb 08:34, Krzysztof Kozlowski wrote:
> > > On 04/02/2024 21:55, Ricardo B. Marliere wrote:
> > > > Now that the driver core can properly handle constant struct bus_type,
> > > 
> > > Does "Now" means some dependency on other patches?
> > 
> > Hi Krzysztof!
> > 
> > Please check:
> > https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/
> 
> Sorry, no, that is for device_type, not bus_type.  bus_type didn't
> become able to be const until 6.4 or so.

Ah yes, sorry. The correct link should be:
https://lore.kernel.org/all/20230313182918.1312597-35-gregkh@linuxfoundation.org/

> 
> thanks,
> 
> greg k-h

