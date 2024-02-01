Return-Path: <linux-kernel+bounces-48914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC5846324
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56431B23429
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449F405FB;
	Thu,  1 Feb 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei+PtNxO"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E1405DB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825319; cv=none; b=esK6l7ddgY0vVVdzUh8tb+BY+jmc3OxHT3jdixQNjSDMY4Q2uRuIVIC+iRTJlmfcu8qaimdjzi0A2TfJIifUgB5b1uv0bJUyqgQbS282BvyoH5oGS+N0s/Vr0Ct+LUucFEpcyVhmJQPhBOHTpwQedqiVMnCZ4DG6FTXSuq/2Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825319; c=relaxed/simple;
	bh=57YEKljpvIdaEyztgPvcMzGTUopVvcjnp5jXaXIZjT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zne/p2XcY44YXwQS2fVuB41Xvow4xVKmlVbsRxQMSwwZ8R8aqUPWHfbDMuXuBnCVde4TrBQcMyZO5CKpArdOTI4PJ9GmkrtZKZR5qgfuNSSoCdvfIR5O84dFksfovtLj0uK+M24Fr7V4+dufaBjS2zk9ELfHBCl9EeBJimULYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei+PtNxO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59a1e21b0ebso325667eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706825317; x=1707430117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57YEKljpvIdaEyztgPvcMzGTUopVvcjnp5jXaXIZjT0=;
        b=Ei+PtNxOhv+OcFMejcBT6zkhpmUdqGiw1uAdpR4I/fWdC61wsS+YVMvaVob/mVCUe5
         uauuCS4ZhP/I0TCWkdzuWkxdbYm8Lc5W04/jbwiyR4RQ5EV4lc4EWImPr0z2MR+HgPMv
         tRHwnbjilTdLCsEUuCNIr3yYbASRQCgZRz3+8Q9Kxo1f1Cz/X9rtOfMQvs+0oPHDaKEJ
         nNLWxQufb4xT5MboGvxNaLtrCnEia/N7WqQw4PiFr7NItckGm/857CvZVJ5XLgmT3Ag6
         3cCZ9utRoWPwQYg4H3BNOMq+o1ozAtmBH/L5hjR+DJQDCq9ZSOrZNHhuHkpe4HLq3ny7
         7B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825317; x=1707430117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57YEKljpvIdaEyztgPvcMzGTUopVvcjnp5jXaXIZjT0=;
        b=M+gZdC0rN7hYpryFTo2skZn4cqp6sKNtOwy+jA6BzkiyAOprFslAAI9vorfHT608CD
         2jeCHJf6ROLgAHx/s9+7OCjdk/Rb0KB8xXv59IFTt4knVJnhlUU+NzB8hS/jOKBdq0wc
         +mgDtLG4rrN+OpnJbeBk356XvJI3JG0BhEzoY5l2klDh0QnEyxeOjNA0N3G01NbqLEya
         Ftk1Ad48+Dkb0ongWwpHncBiCTAB/N0pJQTJdlA6pu0MSDrk2PGLtWjutxceSw9AFiem
         9mlDL68q43pZnNSECWnq76Wv+p/hja1wVAm/TqlS9Bu9TLhidCo77kdzp6w4uYhg7wrh
         T7nQ==
X-Gm-Message-State: AOJu0Yxh2kKl6wB4V/wRt4OrUvaFQtxe+VG8nNPxWUKWAif/llln2icE
	K6kjcHIcpOfPNxq++vIVjVAu4vYi4sSEw0iTbpCZq+sok/wfpEcj6sFzDxT7VO8n3kE+R9tYcYE
	9G46T0bmSqXEFw8U9us+V9ucK+6I=
X-Google-Smtp-Source: AGHT+IEOIBfQ2UplIvzsTdOJTI/sbMj24ykj5Vc7LdTbiXyLr+a0IQ33PIxDi2arww27gLLm92dW1FnmKPmL05KG2tM=
X-Received: by 2002:a05:6820:2c8a:b0:59a:bfb:f556 with SMTP id
 dx10-20020a0568202c8a00b0059a0bfbf556mr4076610oob.0.1706825317161; Thu, 01
 Feb 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com> <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
In-Reply-To: <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 2 Feb 2024 03:08:26 +0500
Message-ID: <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:14=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> Hi Mikhail,
>
> Please try to apply these two patches on top:
> https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.com/
>
> They effectively revert the change you mentioned.
>

I tried applying these patches on top of 6.8-rc2 and
6.8-git6764c317b6bb but performance unfortunately has not changed and
is still on regression level.
Maybe we can try something else?

--=20
Best Regards,
Mike Gavrilov.

