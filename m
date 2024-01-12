Return-Path: <linux-kernel+bounces-24970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D465282C569
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43111C226E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD825616;
	Fri, 12 Jan 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4pV8DYn"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213E25612;
	Fri, 12 Jan 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-680d2ec3459so51888416d6.0;
        Fri, 12 Jan 2024 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705084091; x=1705688891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opmBl8/CkWjdnrlaJu/bqZwfbUeX4H3SPCLc01ZfHrs=;
        b=h4pV8DYnedW7yvJ120/AYDUcPXpTDICsjKrolAshBkGz1Wunb28o21Id2aXOq3Q+Fk
         xXYNUvZ5ibYdt2cXFOk1xiequV4lgylOLBotwvnEeZG5cuPOHll9KX+5hGVRFc1IMS7n
         rtxbxrIkFltIaIsblo5EqHiz7aW0xEiA6XQaRlxFo5roz1i64AIF4nnzLxEL+zw5cnfR
         FJBZOvPPabo1nYcLBpXZmouYrDAuf32ilC/5u+t/ZVXUTCJj5NzHil9LE792W9k4hI0Q
         Lkf3bVkD0TAkICmqL3tSUdmR1ZZS9By9Z8QLH0eZh5UL/pBwO3ZeLwy9xXDAsbZnSWR7
         4IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084091; x=1705688891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opmBl8/CkWjdnrlaJu/bqZwfbUeX4H3SPCLc01ZfHrs=;
        b=v6UbwhlG74TjWct7tNsDqBu5LI83A31oWB8vmPHU4mLzJ53AiKM2Ouk2fSMdMuAAdo
         JebqN//yCss0mf+JeDjrEuOy8Q+835RwurzPjFkPhcHokgU8qdm+RwgtZar3heZ1TjJf
         vwX0vGU5qcv/yXbF2LYk/d6gHwaFdQn/sHecDNmG+Oy2iBuZE92kINATb/cCpvmRhyHZ
         au4YRt7Vdm0XUnbare6LhWMTD+GpfCLvNTTt+dQEx3hUvkbaYPcmgx6XfWQLUedDJmrw
         CE0tqOykAHJCncNX22UoC1+PXuY7CN+1TXTItQNSuBJLcqFoBpcaNYzKL4dnkNuLwYj3
         Ci9Q==
X-Gm-Message-State: AOJu0Yx2DL9rA1VnsVJ8jENIhTvvljA7IpCUXfwu+bsmN3jqCGKlaSLc
	azTQKo4aYJ8Xpr0am4vLsiaV3ye4BR5Gj4VZw8g=
X-Google-Smtp-Source: AGHT+IFF35QiYm7jA5bgAgr6n96xbYn8XdXq3EadB6kJJiGWSiysApSLocEODR8eqTUFZob8HUv+BGIsUkThmktlVRM=
X-Received: by 2002:a05:6214:29e5:b0:67f:62e5:bf17 with SMTP id
 jv5-20020a05621429e500b0067f62e5bf17mr1791809qvb.34.1705084091376; Fri, 12
 Jan 2024 10:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112083421.3728017-1-alexious@zju.edu.cn> <5dd12651-232d-41f2-afa4-2a3e5c127969@redhat.com>
In-Reply-To: <5dd12651-232d-41f2-afa4-2a3e5c127969@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Jan 2024 20:27:33 +0200
Message-ID: <CAHp75VfKj7sQ3HkNaqNe0CjVrRb0J=X3gPJf-rSLeU8RQ2hjFg@mail.gmail.com>
Subject: Re: [PATCH] media: atomisp: ssh_css: Fix a null-pointer dereference
 in load_video_binaries
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhipeng Lu <alexious@zju.edu.cn>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Hsuan <hpa@redhat.com>, 
	Dan Carpenter <error27@gmail.com>, Brent Pappas <bpappas@pappasbrent.com>, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:49=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
> On 1/12/24 09:34, Zhipeng Lu wrote:


> > Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")

> Can you please submit a new version using this approach ?

Besides that, are you sure the Fixes refers to the correct commit?

--=20
With Best Regards,
Andy Shevchenko

