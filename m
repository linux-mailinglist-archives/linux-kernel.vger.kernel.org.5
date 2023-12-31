Return-Path: <linux-kernel+bounces-13615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BF820968
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 01:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8098C283582
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2187F7;
	Sun, 31 Dec 2023 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRiCHFrP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA233CE;
	Sun, 31 Dec 2023 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbe00b163bso265473b6e.1;
        Sat, 30 Dec 2023 16:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703983645; x=1704588445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9UlgtUYTIvMQFMEP8d/dsSgErE5LVy70R1OWjxF4gM=;
        b=ZRiCHFrPbvrlJ3bbSjATrg4ppaPdx+POwijMcusJgqBLgo+TxaZOGso2UTxnKa1/3H
         Y4/0lxoz+har9wGvjyPavu76I76mFTkXpACZBfKkyOMVFwM1QfJjEgrCRAJA8itOavwI
         6isEuWcIIWq0z1ckCVVratRjkQT6GTMoLELXJNejHOCrCd5hGjiAOYozbnJN137W6HWJ
         e2t85MEUNeMf9H8vd69ueCLICLwv2UsjDOawgAZ65KAqc5G9camU6vsmDwQqew5Icl/X
         +iQ3BcFzILGOMyrWpeyO0gBlQzIVVI0Nf+k4eKmJyu23f8qOsZ9ev4Bp+k8bWnDRTpYp
         vkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703983645; x=1704588445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9UlgtUYTIvMQFMEP8d/dsSgErE5LVy70R1OWjxF4gM=;
        b=cVH/dcIhtPaq4HYD8DUjJwuO7YYN16W5BANjxNQYPv00IQ1rg1NeV5sSGwPfAlJHd/
         Iffj4OcL9qs7xdOMcABUMoJl/LfjOaUgll72bynOyLOEOwlV4iEqqpr3bFnZFf5A2SSq
         0a9fTomAaF3vC3e//f7VvUATpyED8D8Knhvh9nGYv2qQV/xGWhXZJDY89d8SLpS2S2Bb
         e2YDpccrDuGJZ6C8FHXFwJrnQysbPdmt2AAH0KbEHt/mEpQlJtCA1GhQy9NKYBxPvwjI
         o1MZcdOU7ph4VYXNdcTaLOVeO/p7O/rashsfkeqKzsJTEtHOL87fJxbBvp77R+wa1fJl
         OFRg==
X-Gm-Message-State: AOJu0Yx+xZYyWn1P2iOBZ+A+dIOzG+1wXaq2sgZUvh6aXaVoJvKALioS
	E8+HrroRefKpdFce9VZwl6QWKwDwkAB+RaJln6A=
X-Google-Smtp-Source: AGHT+IFX1UPGaZ8HmSmbP+cO0LcxcUIy1oLLVKkOpcI5ER6AIQRfPKHf+ykwSdij5XzL8GKsdWBJzX8hn5RMXOpDhDM=
X-Received: by 2002:a05:6808:2896:b0:3bb:d60f:df61 with SMTP id
 eu22-20020a056808289600b003bbd60fdf61mr6874945oib.5.1703983644545; Sat, 30
 Dec 2023 16:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net> <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com> <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com> <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
In-Reply-To: <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 31 Dec 2023 03:46:45 +0300
Message-ID: <CAPnZJGBdwSBeKUK-An8n-eDJdrrA-rnKPMX16cFDfwx8wxQiwA@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Rob Landley <rob@landley.net>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org, 
	initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 8:01=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> You want to add a new capability requiring a new build dependency in the

Rob, who are you telling this to? To Stefan? It seems he doesn't
propose any further changes. *I* did propose changes (i. e. adding
rdrootfstype=3D), and I already wrote that I will not pursue further

--=20
Askar Safin

