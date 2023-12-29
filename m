Return-Path: <linux-kernel+bounces-12915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063D81FC98
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A131F2417A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748217FA;
	Fri, 29 Dec 2023 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIsxMAL7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18E15A3;
	Fri, 29 Dec 2023 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68009cb4669so27062106d6.1;
        Thu, 28 Dec 2023 18:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703818358; x=1704423158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CAFQDRm25+ktJQAT4BWlL9gykmQATeQR1LgJYUYlBo=;
        b=DIsxMAL7GxcW8j1DkTpxCnwGbBq/EMMxMBORQjE6gup8Ig9rJBt/g4pYXVEJEDrAaU
         TkhULzyH5DSofIe2TBVRbLBoQZ4idyjTZ3dX4y0tEpDGhMB9cWWdYbTrsm48rFUtJRbT
         yr+luV+9E/azqXJRaN1XgdCqlnJ76gQwA0imrmF/37FbSD5sRmwWAG+8VqMGpepb/3ni
         D6DUq2DOGaTWO3BDx0x4jejhoHRST/qiEeEOf29jWo3f8zW6A29Vz+m8Y0Rp2EeeySLz
         foyZUkRUvlAeWlseEUiXaeF7xI9p7EJ93+iClmKwPIeq9a2qzxghOt3NDvnSlh8AxKy6
         lqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703818358; x=1704423158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CAFQDRm25+ktJQAT4BWlL9gykmQATeQR1LgJYUYlBo=;
        b=RfjwyALY72jQJoSYrUVi/wl50a0yLzkypM4CTQUui7Jtv6lecrCoiQXHDxFhchZMfz
         CLhHpvJdl9EQJVHXj0XFQPKEzRySeP7c3dInbPbiX5dKzpbRO8RY0HyUIMj9LIiNkikm
         bX5W1Zy7jsL3+qtoS2Tgq9B5Ku8m3cOW9iYyPGEnUQ/7oSevUreRfO1HIRSvcWLcCL0l
         VUnwBL3iddUkaXL+KXkPwa5hlmrfmnB/MQ4fS7CMgsLtq/XyjC64klQFA6AlxAg8mNcl
         xxddWGMWQwibq2KBHtdQm1gIIR1YzwQ97wWWrGPlyLUsN8zCMplTvJiNUyHhouJVYYH7
         JeAQ==
X-Gm-Message-State: AOJu0YzirjOBePh+Bf7WLt+NeFa8haaRui3OIAFn2y+/pFzxGojcFgyw
	n9ZPkusVOGjYoPGcHJx8m0Mk95mokfwjM1xvQJ8=
X-Google-Smtp-Source: AGHT+IHe8aPzkUWWTlMPdMh7CaO3RR9EPqyOXS5nlMXyegLtZJv4xAeXZDlmnMa1fYMVgX6CY2CiB1rPS5jeUmzE4yY=
X-Received: by 2002:a0c:f70a:0:b0:67f:998b:bfa6 with SMTP id
 w10-20020a0cf70a000000b0067f998bbfa6mr12007546qvn.64.1703818358069; Thu, 28
 Dec 2023 18:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOWitWMs30qnEBcJ1EzeVkU7fSjevG+jm2Z21WEZGWwjBpuZgA@mail.gmail.com>
In-Reply-To: <CAOWitWMs30qnEBcJ1EzeVkU7fSjevG+jm2Z21WEZGWwjBpuZgA@mail.gmail.com>
From: Hayden James <hayden.james@gmail.com>
Date: Thu, 28 Dec 2023 21:52:27 -0500
Message-ID: <CAOWitWODkAECrS-VL1Ck-tYfSzHLrtSevJLQnmywyX1Ji_JF_g@mail.gmail.com>
Subject: Re: Bluetooth with Linux network namespace
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, 
	fupan.li@windriver.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending because I had HTML turned on)

On Thu, Dec 28, 2023 at 8:44=E2=80=AFPM Hayden James <hayden.james@gmail.co=
m> wrote:
>
> Any reason why this patch can't be merged so that Bluetooth sockets can b=
e created in network namespaces?
>
> https://lore.kernel.org/lkml/20170814071640.289327-1-fupan.li@windriver.c=
om/
>
> As of the latest dev kernel on 12/28/2023 (6.7-rc7), this still doesn't w=
ork.
>
> Socket with AF_BLUETOOTH:
> int main() {
>     auto fd =3D socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);
>     if (fd =3D=3D -1) {
>         std::cerr << strerror(errno) << std::endl;
>         return EXIT_FAILURE;
>     }
>     else {
>         std::cout << "Successfully opened bluetooth socket" << std::endl;
>         close(fd);
>         return EXIT_SUCCESS;
>     }
> }
>
> Failure with network namespace:
> hjames@ubuntu:~$ docker run --rm -it --net=3Dbridge hjames/bluetest bluet=
est
> Address family not supported by protocol
>
> Success with network without network namespace:
> hjames@ubuntu:~$ docker run --rm -it --net=3Dhost hjames/bluetest bluetes=
t
> Successfully opened Bluetooth socket

