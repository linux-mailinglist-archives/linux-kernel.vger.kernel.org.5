Return-Path: <linux-kernel+bounces-145937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6408A5CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61B5B23698
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242AC157474;
	Mon, 15 Apr 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNn3qSHo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD3156675;
	Mon, 15 Apr 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216894; cv=none; b=Nyp6Ynt0e6gBv3Fam8gcUOezLL1SqTlz3thxI6WrpJEpDkrTFd+PV0Y1bCtzm4k0D+crOKgJrzZRhaeKwrqTP5FBzZC+WN0m9pWLGzfxhMzkyCJcVG7XZjLCpaVIjj86JctJqVvnAhCJRZxfAO6j8WK5zk4qZsoCJnihZiyl/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216894; c=relaxed/simple;
	bh=YcBaD99GoN6AuooIAKX/irl2Glt24VolMzRvwDnXKSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUueJiOtYdxYQptTW5KA8YuPDyxh6x6cHZSGAbbrbJ4FKRq8a14hzyDsZA+yRgIZZTGZmvItt460mEFubrLMQRa/DdhSWSluEQRNidNknkspL/BXByTMkQQ9MJ94E3D6r5asALasLi0B5XA2CaNG1UEx7kGVoYRmTcDREqc4ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNn3qSHo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41890fd335fso388305e9.3;
        Mon, 15 Apr 2024 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216891; x=1713821691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MngAaDFVN1bHp4jdNB2FOwRByqVy5DrODddXtj7GEQ=;
        b=DNn3qSHoFozHf0mV860AV0K2JIIVVfsQ1MtdQV7/lGTD6qW786f2eZC+2Nyag4BJ0h
         +aoQSuwGRJLSA7STsrIXbsJcnOxrjcJD9cbNzAdDR9WszDXBlh6uTWgENyem7mYLKhlS
         3YRS+GIEd+5RWvl2MMwiV4VlApn4Fgi2jt+ojq97ni+Q1hjDOKjS1hqLFrJ131id89e6
         Fb+PeT1Pw1svGndqgMhu+YasvNk69yC0/jzJOiiyzXWhbVMyAalo2wcr3HGATdyPDg2+
         00LTlw53V7+TEv1/kaalB6o95USUvQQWc1diGx+viHwJG5eclgFC3GdMYH+tW5hC+ndo
         EIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216891; x=1713821691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MngAaDFVN1bHp4jdNB2FOwRByqVy5DrODddXtj7GEQ=;
        b=Yasw7UDrDJlQ69HdfPRaHsFUytePcwN30cKWuZCPwbLhytgvYS6+9IptSJWblkZYxY
         JbA8+yOxGPSUM5tnD/Xs82998SnhDHeK26bsG0pRdwBmHcygnaGfdwiPyDcidtX1rm7t
         h+Jx4+CHQANaxQJhiz1Y38HIDgmHTr+NuHaxypVoiQ4m+opBY4TSbNVgW/eOt6cwZmpw
         yBSNOfAJmMMhSfJImZgPlydJwMLrwTJX7vwm298L9GXlCu5gGL4o9JPvLRc7neudASk/
         qWnF3E94nEFShTtXyky/jSxYNVdRkqV4fgcNC69wXnL2PZkKoYCrERbE9Wy1PuEaHF8O
         qKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNz88i4OcWmzBS+TNqh9kEl69mMbqohIkHTFfq/MH4cUGVj5xAsdC+8wjQPka0NvNa7j1HVl/UITPfivCmB0OOQ4XppfwqzKDjpIYIAYOn7QdX4u+rDowtGak1BbUfScsZtqa2RKbhrQ==
X-Gm-Message-State: AOJu0Yw38CP+a/RlTfnPK6ulv6pDK6QL2znoMip49o7VyGX82fOnN15W
	JGTuVN42stDsUejmGsrAfJZmj5G8L5W2VWmPtRPVzUGFoNRZZny6
X-Google-Smtp-Source: AGHT+IHO0UydirU0frcJgoHgsd2d9A+XDIfIqbidYVQXXd9jmDbZT1co8v6u3rH+r5lyoWlHcu5gbw==
X-Received: by 2002:a05:600c:4749:b0:414:12f6:a105 with SMTP id w9-20020a05600c474900b0041412f6a105mr7619233wmo.5.1713216891306;
        Mon, 15 Apr 2024 14:34:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b00417e01ce03bsm16613050wmo.17.2024.04.15.14.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:34:51 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Denis Burkov <hitechshell@mail.ru>
Cc: Denis Burkov <hitechshell@mail.ru>, Rob Herring <robh@kernel.org>
Subject: Re: [RESEND v3 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Date: Mon, 15 Apr 2024 23:34:49 +0200
Message-ID: <3476347.QJadu78ljV@jernej-laptop>
In-Reply-To: <20240415173416.13838-1-hitechshell@mail.ru>
References: <20240415173416.13838-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 15. april 2024 ob 19:34:15 GMT +2 je Denis Burkov napisal(a):
> Add a new board name.
> 
> Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> Acked-by: Rob Herring <robh@kernel.org>

Applied both, thanks!

Best regards,
Jernej



