Return-Path: <linux-kernel+bounces-146348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673CB8A63C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41DAB22511
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EAA6CDD5;
	Tue, 16 Apr 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwJ/DjB3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556F35280;
	Tue, 16 Apr 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249147; cv=none; b=SUzWmEEGs7XCP/XwhPdyd/bF11JKB1OxvmxOXHmMHHlm27vSzRLzdGVZGm2mZ66p4TqEFvVZRtctBoUGhBYGNJidf7FjBA+0wSPx4+t4d3lkNGTKMu8VpDnhhGbWTFatpDsKn08bGq9jEH2HfldCNYo2X8AsBIhDZZF8vvlEyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249147; c=relaxed/simple;
	bh=L0uSowqXWaOKHmbvtmcvv3CH+kLSNUKlVoz9ET8Wz6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa8VYHEudPY31JJdD+UU8OZdqvQpGv63AKNF0svQfSVw5Xh14AvyPonaoC+epHbVT2kirsG2Ztp7qkHmFUqbHzVwuS7gRculL+TF8BHMVN6jdz+4OggZZPfEI9NylsARd5l/6DvLjtKOVYneZntETr1M9c68zDe7CLNDZgLkYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwJ/DjB3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a523dad53e0so509272466b.1;
        Mon, 15 Apr 2024 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713249145; x=1713853945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvT0ik8y9YSN8TDWnzi97O0pi4EAtF0id/yb9bB2ojE=;
        b=kwJ/DjB33koeKyzv4BjVTnC43isP4efqTrl03W4nc5rUUQKqNEAmQ9x5EZAf9u6AVC
         KE24d9n0Udu80DA0pEbn8R+8jWHZ8W84xWZ8LkWRIJA81E/+AYb2g3BXEfTgnSFJzBX0
         bxHmI/m85ggSaj9PU+vWGinTmr+P71/Q7glHUZTLDBLfONWZn2QTdEoAzU1qpv5axMVR
         U+3V/cGUKpWsa8q6wW1JyGVs/bNqPBvwJws8IiedWIB/9LiFivl1zIt4CyipA1Sjr5ZE
         BSAB5nfPEZopLWobjCxjjbHoO0m0bzkoEBKRV4iqqDGuX+xG29OKTAVV3e5jNDERaM2+
         RoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713249145; x=1713853945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvT0ik8y9YSN8TDWnzi97O0pi4EAtF0id/yb9bB2ojE=;
        b=lMmTOumPSzZqpDy43jVEHZel1Ut1WBNa1VWOm7T4K4usSzeX/eGCkXeI1kLL82qKSp
         KVezE9g81HlQ3nT3BE6FGvVoT7VFF/9PByUb4TsS8R9w0IqxMPGL29VqZfJRt4ekFqyL
         VBx3oIxi2QI56R2BPLxs5r2+ZZNBw6jHz9iEsaly6jkgICByFb/95j6QYf07mEMTiZ/9
         yZ3NEa6FHTCtS+vxIbKH2uGdQO23HTviTQFS78ppKMXbZESvl60fHiFxL85CQ/16yyPK
         GmlsWISLpS1Zqo9EW3Z5irpeqcNBttMNN4RtH3hckxZY3NHMKq4IJxFElVPfL7dEzc8a
         W8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXktxvWw7p2h+X3yalTSQse6ta0rZS52r5fHPC20S8GGGAATTfkhyY4SVg3Yo/ZU74Am4YQaeZB1X65M0Y7nq32l5HwJHhu4FliMw==
X-Gm-Message-State: AOJu0YydB0INslDQP7H6Hhh8xIpDq6t6QJjEGQjoy8zuC14jNwv6tMlE
	rzuUiSqZa9+7VoK8LaR1DIoLv1MQJbZRoKX4hJ4g2mI1s3zuQaS++UQNSNu/etKRkRNMcl8ykL6
	7D3mCK8pPURgCD+9VjdYcOm3JZdM=
X-Google-Smtp-Source: AGHT+IFxCqi2XVU3mI19z9HnKc+NcVHkZkkUQWCwzy9Il40jnhoF1q2Jp8UC32a+LmEsQ3Lc2W0VGzTG/8DDEWMGnLg=
X-Received: by 2002:a17:906:8d1:b0:a52:1bba:7458 with SMTP id
 o17-20020a17090608d100b00a521bba7458mr1427775eje.0.1713249144472; Mon, 15 Apr
 2024 23:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYNguDt47=KnEUX7tLwx_46ggBx3Oh3-3dAcZxqndL_OWQ@mail.gmail.com>
 <48043100-a817-4ca2-a141-60e3ab9cbfef@acm.org>
In-Reply-To: <48043100-a817-4ca2-a141-60e3ab9cbfef@acm.org>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 14:32:12 +0800
Message-ID: <CAEkJfYP1eieCj72nnbWQFOq3PmDi_amtRfrG89kViiQy+bePaA@mail.gmail.com>
Subject: Re: [PATCH] drivers: scsi: fix shift-out-of-bounds in sg_build_indirect
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, xrivendell7@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:26=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 4/14/24 20:14, Sam Sun wrote:
> > -    num =3D scatter_elem_sz;
> > +    num =3D max(scatter_elem_sz, PAGE_SIZE);
>
> Shouldn't the following statements be modified instead of the above
> statement? I think these are the only statements that can cause
> scatter_elem_sz to become smaller than PAGE_SIZE:
>
>         scatter_elem_sz =3D ret_sz;
>         scatter_elem_sz_prev =3D ret_sz;
>

Yes, these statements are the only statements that modify
scatter_elem_sz. However, ret_sz will never be less than PAGE_SIZE,
since it is calculated by 1 << (PAGE_SIZE + order), and order will not
be less than zero. So I think these statements do not need to be
modified.

scatter_elem_sz is also exported to userspace by sysfs interface
(macro module_param_named()), and privileged users could modify it to
any int they want. So I also set the exported type to uint in this
patch. Should I also change the type of scatter_elem_sz and
scatter_elem_sz_prev also to uint?

Best Regards,
Yue

