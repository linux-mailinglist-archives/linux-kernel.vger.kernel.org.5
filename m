Return-Path: <linux-kernel+bounces-151986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DF8AB708
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222C81F218CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33613D277;
	Fri, 19 Apr 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YDtDqbq5"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8612DD97
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564277; cv=none; b=c9yveV+p7/2Zwfkqqtx1kkOZcO2OBQXWy8UCZJFHJ+H/9pxCH88IIdHXgAIwJOydfuPe59YWAzpu9MqugrtqPtfw1uYZDD2JZlyQvxdBuFCHq3Lo/nIOTZgrlQSDh1BeE7xhLoot3eE/V4dR6stGEs+ISAz8VxJc9RFg4Wm0HNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564277; c=relaxed/simple;
	bh=EyxFb8C2nMPXsJxRVXr8QOZVkvCYbC8xVHt8zrs9UZA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV0i5gws0tByFUleYoS3xrurq+zyV5a0TNmLTFD37agnf8s5ZQyH4uZQWBTj9/CwJF8yiGF3pdw8YUE02mZlREntRIQzWroUN47TQHvxP8QKkW14vNYdP8Z7lmtnkPH86eXsv9ooK5ff3T5TBQNQcNK82kKIgtUJILuUeLGVT04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YDtDqbq5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D3EC3F4BE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713564268;
	bh=EyxFb8C2nMPXsJxRVXr8QOZVkvCYbC8xVHt8zrs9UZA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YDtDqbq5zmnhnCpQJhBWbnHViy76uk2yQsYrIbh/U7+l84l5ss6tDuNVXp1UfQhP0
	 mCvh7R77EQmN0J6I1HtPx9wgV2nyE4MH9lVn5w514FESnAdIsugwr9jOeEDY5MJ+I/
	 UHjSOMi5CmW1veeRnTiDOuTysRTn6Camn/vNgokOKlHe/Po7apNW9DXM+0i0mjtJxl
	 wgZlnQBwglvG1343pnB52x7PgB/gm9RtOo17vMJZcd0qwLq5co8B8HUz9wOWjpOLrS
	 vz+qzk/+HTWbE6+FVfX0JNC71fE1XumEKYcDIaymiZ4HBYL+jQ18G/a/iRc7itRa28
	 fqMmtpfYEc4nQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-434e823ba24so29948791cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564267; x=1714169067;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyxFb8C2nMPXsJxRVXr8QOZVkvCYbC8xVHt8zrs9UZA=;
        b=xMpD7wQ9aRMSA0o2Xm+vKm9UvTcpLdGvb1XVEPMSAVhWpcCSFT3yRWfc5Im/OwYtKK
         EDCPc2fViVKHaGCsMFCVc+9+HDTR76O4+8kPBXSMO03E38uNvlYtH1vn5jVOIkf3S2L1
         UGzdP/WKGYAWJ3wMTMOTO0c9nRo8u+5BTxElbutcMhFPciBiEKzaab4l0qaci/LVB6GV
         qW2Vsj24hqHsqa9zJmVRHAgnND/6HDK/XjQCdrel84872wvtTXIthvys1e/ufjQrpZbN
         FQUl3fGdnglNE06vFTJ4Lh4GbgiqfaZkcM3tgLdKKAytmCPqTvAjzIq4HKer4vC3Gcth
         kE/w==
X-Forwarded-Encrypted: i=1; AJvYcCWBZLrAzZ2rSH8qGLzv0PAuVImzMelQaIh5bkf7zofAUXNDw7i3iLRsAne5/BJH+CdvOczswWPcK4/ikm/0m0Yk5EiVj94qAppz4N3t
X-Gm-Message-State: AOJu0YwjUMpa/DY063aQtdVRbtQx50cne3UsKSC29+NnezjoblK9rnZy
	TY7poxgHFuosKrwrB1MKmZow3u55vu6HSk1dr7m1jzJ5INdE2Xwu+G71UOX5vxZvBl0ME7HD8Wh
	Ao7IYT53lB8rOaRJfMzdJKRO1c2qGBMvIYBsJ17/iH32XQnushOH2r8Poc1picVlqircRkVY96x
	EerYAtSN0WkfftiKpAYRbG+Sq0jwFr9iCwXQTmwB1gwx3Wq5Fy4ED5
X-Received: by 2002:ac8:5fd2:0:b0:436:5107:d358 with SMTP id k18-20020ac85fd2000000b004365107d358mr3587632qta.63.1713564267036;
        Fri, 19 Apr 2024 15:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXMVT8kEhNNrR5sTjDPD3IBV2C1MpWA60uIyzYlOJKirdgWffaPQMKlaHbw73PAg5rN0enmvsbfQurBKGXuI=
X-Received: by 2002:ac8:5fd2:0:b0:436:5107:d358 with SMTP id
 k18-20020ac85fd2000000b004365107d358mr3587616qta.63.1713564266754; Fri, 19
 Apr 2024 15:04:26 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 15:04:26 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240131132600.4067-2-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 15:04:26 -0700
Message-ID: <CAJM55Z-i=JUavZ=GtY+c3ZfDQWChckCWXa8i_6zgmW9S9Ey7xQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] riscv: dts: starfive: add 'cpus' label to jh7110
 and jh7100 soc dtsi
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> Add the 'cpus' label so that we can reference it in board dts files.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

