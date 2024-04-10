Return-Path: <linux-kernel+bounces-137833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED62189E81D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6D91C23CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299B8BF0;
	Wed, 10 Apr 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="hpiJQFHg"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D1138C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715881; cv=none; b=sy8q8o7o+6/TTurnfcc3VR4PHb/kz22vPazY0Ne/IgjQAjAt1mxXtCIvCVnmUhgbnQFGG9AKY6HfG8Up5dJZang0ih7/qrjiPV3F9bvUlM1ALTnRLZffMfYOh7ke0q2kpW6fvMxvu9JkWI9/xFdF/0MBVrd+IMqYbVTRo8swOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715881; c=relaxed/simple;
	bh=Vk65zLEOHyz65cxDoyt3Cn3gBlwcWIXgVqjFJrJWXwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQG2dwzpmQuSfappne0JXSCuV4qbmndTL9DVfRyFoOa8tEfMU+eMu/q7hUMvPiuPURFi5h6W1L9CYT0FOR5raxIMIFLv9tbQpz8QU/7uBUlNIjKA025q7PknyE510xJfnmrgw46XaEdFRpu+gpHnUkqfny45mBLiDbZ5U4TRrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=hpiJQFHg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617d4797d9bso38647247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712715879; x=1713320679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWFwQDfL/X9Ah8K+tT4l6UKgiTB6JFFzOxSKcxIzX5U=;
        b=hpiJQFHgm4OB8xAcJNAdoYA9S8p7Ly+NnQXxymoSO58hlYapeePCNManQnKoXUrRLe
         l0Tgojus/032/Fhb0umJbRkSABkZiBzlHkw4XWlz2WwbYk2Bb+J8MpgXsaduJ4KDx5WZ
         wAL5EcaDXcIVFyXko1gICLvDZdWu7sSNoEIIboVNI5vFeJlx3eyTCT5y++UjtyTQLrnw
         b6aQ11j73g72wZElxCd/6p+IBd3rc19f9SFUkB8pIOqnKm8KnNeTZQcNslhUaXZkXTv2
         HHjFdC4yiVygigpLd07G7uQ8LHJDJqBl5h1SnApP10HYiLUo5pYruebuIHYpWIdck4Bv
         SpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712715879; x=1713320679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWFwQDfL/X9Ah8K+tT4l6UKgiTB6JFFzOxSKcxIzX5U=;
        b=ShGpJEkjapAw/FAcQUBJz55eGrab6h5zWTZnFiedZ7QkSsEmxM9Kk2Xcg94T9FrL6f
         WEflmLQ4XseJu/FNgYBTv0ntcRitNj8Nz0FKJQFQWRJMIpGOYDSbZVn2TE4I1NWkT1bo
         KZA08YG5hfHwzCj3fVjCXTa8guygHQu6pD6Ap1kaggG99lqITv8Q17qy4Yx+mYcrGF3K
         ekw73uyYorNdtoI/utgfQ0se9b2sepdQ0QEjBwFmxP/Ve6BAFnl/OlBSxbEUuljQx8Ta
         3x6PgCkMMy2Rn2H6WhrCtFqQPAKFIr+m/XqnS8i8pq5BBVVavbhXWajX/AMllJv9g6wP
         nyjw==
X-Forwarded-Encrypted: i=1; AJvYcCVL3OdFetpxVw5NZ5nYvcUEjE5NVsOKzvsfAcAUX6qigZ+1tpAT2A84GMwyKoYOQ9KPOjKxO7CrJFQZ915ry7Re+ehzPFAb/e35f26Z
X-Gm-Message-State: AOJu0YxxCI6OeSrroB7gcXCCH9af/ALTEVIdOkndHjEiEm8uLgiqb7vA
	RtTv7YRMdvVB8Wq8dRpckXpSTwiI8CusXPasj44nj8ePK1p7I8o8e8a93yVkxt/3/qpkcGVjqVn
	uMKNHdog/6Kk61UdM9ZFo08J3WLKsP1f5cgYw4+qdGtFHLUsCwQ2BlcxBsY8=
X-Google-Smtp-Source: AGHT+IF0fFXPIj5xQwzDknu6VhWQ6LucNMUUiMp5+MYiPRoNAeNvB36ROJa2HQ15muqnIQn6oBi5o/T3s1Y8xNIz1bo=
X-Received: by 2002:a05:690c:92:b0:618:4a3f:2752 with SMTP id
 be18-20020a05690c009200b006184a3f2752mr533296ywb.11.1712715878272; Tue, 09
 Apr 2024 19:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409062407.1952728-1-lei.chen@smartx.com> <20240409182535.166cda7c@kernel.org>
In-Reply-To: <20240409182535.166cda7c@kernel.org>
From: Lei Chen <lei.chen@smartx.com>
Date: Wed, 10 Apr 2024 10:24:26 +0800
Message-ID: <CAKcXpBwVuRS1Orrvi3J4Ru5N1J8hzeRuf6GhOfX8BMWi-82q3w@mail.gmail.com>
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet received
 by tun dev
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  9 Apr 2024 02:24:05 -0400 Lei Chen wrote:
> > --- <NMI exception stack> ---
>
> You need to indent this line with a space, otherwise
> git am will cut off the commit message here.

Thanks for your reply, and I'll remake the patch.
:)

