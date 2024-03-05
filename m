Return-Path: <linux-kernel+bounces-92826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2887268D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572341C26C50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903E18E28;
	Tue,  5 Mar 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QlQY8mm1"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38927182BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663402; cv=none; b=GtJoW2z+5fa9w29E4yEGdflJRRdPBarh8/CYkzly/PRRs+3i3BCYmEF4AiUs3CKEMlF1JrcLryNYcelYGUONpq1vr/HItIOsYLQZODe7YHrWEvGs9jRX1PjhvxwtWrFIuMRxV/f4w8+U7fJpskkuqGTZ8n/L4qIzS7xOjKWNVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663402; c=relaxed/simple;
	bh=5Ppa+R+0XzxFeakOVLHikQCXNl+/YtMGyczK5rMovXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI2CTjGHc/0PoFjHxJYp81vZmiDSbnG9veQXatPmd9qXDwomN9fCDi5AOgCKktAOlOcgyFfiVCnhqya4tIOzUE+YsRAhKog5IlzceYCdp/RQXt6xPiJsOSA3rvEKEweg7xAVKsuYyLQ113u2DOmdylRlbVFaysieCHwxiIoExwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QlQY8mm1; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47288b46f2fso1276935137.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709663398; x=1710268198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ppa+R+0XzxFeakOVLHikQCXNl+/YtMGyczK5rMovXM=;
        b=QlQY8mm12Ra0N8GgCJ0/dqXPfgYe0EgnnyNAGP5zOP5cpUMI1okzhb2j76RZpUzEr6
         GoBg5ouYFV+FCVzcpq+ANlyh3NpiV897GwzeJUCkqRLfj/2aqf+VptWklidMbSfN0kMt
         ZSTzmeQd4OLhjVd8uNFNn8WvDB/hY/m4Y4JM2cQsHem5iYE33gL1oTMcQMX0486+fL54
         p6DxQlRFJ9WH4DDthKQVN4/fjiZNUlSvowERAAt6teOf18Srf73Jqd/RqsqJz2PMS2rk
         ruk3+jbWJKq6Eo96TGrPyKsRunrUkb3zty4nCPqH5pdfMQbnwJkqn+nkucWZqhsTLu/Z
         6USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663398; x=1710268198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ppa+R+0XzxFeakOVLHikQCXNl+/YtMGyczK5rMovXM=;
        b=EfKUX92Nr/HhnUqy9GS/pMVoPBUQ53uFORc+kNxDqsVz2zsAkjuUqQHwOcMJYbysJA
         BDvY2X5VvnqCbVcIFQ45Jh6FjtH1tbj23o0zr9bPkdYsZZkGwJcV9f49yJMwMVrVdCzL
         uuFsC4GdQ2kUvylO77bAEEKlkR1LlzI+U4m/cSdT+IysL6aaat+BRJ6oRST+Ph290dS3
         QMMuvgo0+BbGUD0yXBMPSMO7k735c5uQL0kq1p/ee18SrieqTM0oXr5CmZUd+xe2k7Ro
         u9v5UjaRGyv5WrUq+S50hpngfOsf4f8O+RpVnaI2oPEL89krZJqb1rKZEotHa7Omi9bx
         +PMg==
X-Forwarded-Encrypted: i=1; AJvYcCUvOOf4PQE8yiNWJ6tUCsJB7GK8YU9AqcNn1atgJyk3l1SO+GQweV5cH7W25gKUMtGQLxXFlpfKEkHL88HZ8huDSXIAVJtGIOVBf0R7
X-Gm-Message-State: AOJu0YwmgaOAxh7+Lc13aeO4zg+oTrzz5cMaaCRRnzwxBVXi469H9msI
	g9I/n04Zk9S+pV4PQAFgz0B84QR094RjPkuyO/sdfIu4+UXncHHyszJ7lQJ0dS+b8rjKkLADmgh
	7HQnVjsovdaDVoHBszeO3zALZqYti6chaWgWWMcCln1UecV4Cf0w=
X-Google-Smtp-Source: AGHT+IG9jVqhTMcMdyK8btYn8OnO/2Uff52no+WLiN7VylpwvZptkwmXQCkdKdkRK2NjpbUZHViXA9xgngSAEjpC4XE=
X-Received: by 2002:a67:c912:0:b0:472:e6e1:9b33 with SMTP id
 w18-20020a67c912000000b00472e6e19b33mr636651vsk.2.1709663398038; Tue, 05 Mar
 2024 10:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304173630.1150382-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304173630.1150382-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Mar 2024 19:29:47 +0100
Message-ID: <CAMRc=McU-jjNthSL4-Weo+Tchn6H9m2Y2xLuV593d5=a5yMGmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 6:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no need to repeat for-loop twice in the error path in
> gpiochip_add_data_with_key(). Deduplicate it. While at it,
> rename loop variable to be more specific and avoid ambguity.
>
> It also properly unwinds the SRCU, i.e. in reversed order of allocating.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart

