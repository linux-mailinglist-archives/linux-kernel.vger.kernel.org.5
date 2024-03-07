Return-Path: <linux-kernel+bounces-95856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F3875428
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A79E282122
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9F12F5AF;
	Thu,  7 Mar 2024 16:25:31 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1412F399
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828730; cv=none; b=pBGT2M4R6sneYEOF9Mqzc0ZDhAmTeVfp5agDNL1LdV4XUqZmTwRu8K7y6rdREHuoytvCCzqURGMXONCaz+U4CuJg5cloueVm9w1jHl6wMhvQ1j9Q9/iTlQnCOFKwW85BZc+YEGSE9+3lOgvZD7RgW5TQwrIVrONBj0nNjaGVZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828730; c=relaxed/simple;
	bh=6J5z6Bi4JphLzSbdemzDaybVl/GSN9qiuQmgl4F3BiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdsZslnSawaxc6/AjQQ4IpJGgR/x80teRAVRglesNOUp09a2sDJLHCCkvFKDOXj1n+aEp5Lz93NHnZztVhHYMqypKe1GNbtyq589xrli9qm7bN/NH3dv1tadCy3uuOSjYjGTGVTr4yCDNXv51RppN+HaWUnAb+8/riZ7oEem9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e28bd74883so1091161a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828728; x=1710433528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J5z6Bi4JphLzSbdemzDaybVl/GSN9qiuQmgl4F3BiY=;
        b=REa+iKHHh22B41uyNOnI0e7TI/jMoD5vjpD3od0h++4itAAoe+PGoUA8AqhV0VCfPX
         ZvU9jUlYzQQ4r5MTr2r2r+1vgvREJ3Ua0MATsHi91LRH1deUvLppRfW4wIrlPp27Io7m
         T3hzWGaMh49C+zPFfdE7zFTQkAF9XF5H38BxTCLsir17ogQgkxDNtmdZR9smYo4H3685
         hM7aQMeKcNLT2TA+MlTEerkM6SpwHtY5WgD78E/d7XOvF53LbOSIxZtsRg4PAy3hIy4W
         FNbCZV+LRmUF9DdwIqTcLhyJGy4jtX8olD8qhIm5wJTU5q6AfQa4YlHInh4eXkfe1emL
         Ae8g==
X-Forwarded-Encrypted: i=1; AJvYcCUSWAH23o9GECYJundTbkaoBXnHoR0rORN5K3Zzzgs5UrmArwyNzNw41iK+03fDFFD7gBUL8AC/dR/A9HY7UV7F2GyJpNg8DvuCFbLq
X-Gm-Message-State: AOJu0YykbwQMqBslmnrSFyQPjIj83EYxd6P5I0VDxzreR4OKdX3qyT56
	GR+PD0IOJB6qSI6MDckzoGyY+WMUGOpeG4ichv6U/pw0eh0KHggDkEv7+VTwXcxisVpee47H9fp
	cCz6xEdSpoecSgCpyZvX0d1lvd6s=
X-Google-Smtp-Source: AGHT+IHmbpjqAPEGZMLhC3b4HmwWmZgBqBBMqSrzvHXkl1Cb9fn74CbUHnpsgkXEWLig/BKFXz5vK9StNmjPA6BNSHs=
X-Received: by 2002:a05:6871:408c:b0:21f:f24f:ff96 with SMTP id
 kz12-20020a056871408c00b0021ff24fff96mr147422oab.25.1709828728359; Thu, 07
 Mar 2024 08:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com> <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
 <ZenacXkUAh4I1gkK@kbusch-mbp> <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
In-Reply-To: <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
From: Len Brown <lenb@kernel.org>
Date: Thu, 7 Mar 2024 11:25:17 -0500
Message-ID: <CAJvTdKn1xMP-WJhd64XkEk3cznhp4vkVjTynwp+10TLO8_FrgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org, maxg@mellanox.com, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:23=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:

> Or maybe we can make the print less scary: how about changing "shutdown
> timeout" to "D3 entry latency"?

Works for me!

(The problem with the word "timeout" is that is is usually something a
human should know about, along with "error" "fail" "abort" etc)

you sending a patch, or shall I?

thanks,
Len Brown, Intel

