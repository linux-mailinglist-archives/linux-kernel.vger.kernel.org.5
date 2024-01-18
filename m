Return-Path: <linux-kernel+bounces-30056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF683187D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A3C1C2254C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DF24207;
	Thu, 18 Jan 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7lRovnW"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4D241E6;
	Thu, 18 Jan 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577477; cv=none; b=YcB9jCsdv/axBt8FBQIsnTJFvO8VuE/krHrRcRCK0CgOLV3fdcN116Ncu15/lqXzhgOmC/Nlmbo9iHZgrgm6DDnK7aphILJHiBLqSMQWxsvhc+MV2C4YMRTzATcCHeF9YN9+xC4Vg3MoXw6PXrBhKkaNd7WVIMwbVmAVKsRab8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577477; c=relaxed/simple;
	bh=/2dkV31yHAb+Qfdj4xcle6MF5whChIwDA5UIkWma74Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=MNldedp/zqG3ocQ14XbkvSA70wldmShuNqE4XRvycDHZKWQe9/6n5UZku535rCOjE5T/pt94M2PJzVWxQTkRIAH/HT76Sm8HKMK+1GcvDO6a+9ukIBn+vwq4qMbpJC0G7ViG18VG4MNErUERZjBUhgjNHeo6RX1ettNgyErLxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7lRovnW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dde528dbe8so5745804a34.0;
        Thu, 18 Jan 2024 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705577475; x=1706182275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2dkV31yHAb+Qfdj4xcle6MF5whChIwDA5UIkWma74Q=;
        b=R7lRovnWvQGeiG9FmMLsbXMp2xqKSHnQxw5u5oJNJe+yFrTn9KtLAPXLFHXAxpbP55
         Q2UuPMbMFUp8uKFr3PV4WCSJYuz3MWpPsH7NfejpjgzpD+NynFrB9mVhIWHfZY3xmjA1
         us6Xs3yif20x23sZkuPGAoAqgnpCK92vGo7Hb/Mf/3Ha05ICa+vkcFxZkS70GUewqJvq
         jOBeC0N79l8TUcbH2CspZ+Fmz/rbBaZdpyxs895zpgwFg7XuVDeXnSzWwZXjy0/1DEiS
         d+4lzU6MALmOc7qT7uAJB/VNETSPZVkvmJh4v9FI4kzhPAEAhEIbXsYt54tJLSzeHQtT
         s6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577475; x=1706182275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2dkV31yHAb+Qfdj4xcle6MF5whChIwDA5UIkWma74Q=;
        b=sifHrSW1qdmBnxdoeX9qWuvD8Ykd4V4Ryzazq3K6H+/ldB+Ydi9pbpDpvjDjXs2Rnv
         nshDut+Mxq7DZ4zo3Ay2wRsj5nBB+T+9r9FcEJfd4e+TcmplioY9PT3rLVHGoUBT7S3S
         XI4oD81p59czXK7SKlWMe4ORjySE/hQS/Hk8fMp5gmbxfroCm7OouqMSPpCJIfHRuESy
         n5K1tqvI7tF+TZS1iqY00aNIoqNufeg24cOstNb//scrT4am/oWQch5cpJ5LXDWZv8pg
         21wbgXWmTN/MxgDqC+QJOoOVR1emwPOUQCidLlua8AMSnhZsdGPpe+jX7XrbkI3Xt9Hm
         U3Zw==
X-Gm-Message-State: AOJu0YwOgy0/JXKvHNbHoDR/wsJa2L3Ux5iygG7d4ZXudR7I5GMA91Jt
	C2DGyu1aAdfKAZb9Fy9kfMyGCK/0BDkdobNj1L0EopaOEinwloY1
X-Google-Smtp-Source: AGHT+IG7KytPhcCCGt0DJgflFsul/IGg9dbIsuDpZgqGurOYArTCDBoYnurv27JfOgVVV7C9JzB4IA==
X-Received: by 2002:a05:6359:689:b0:175:abbe:58b9 with SMTP id ei9-20020a056359068900b00175abbe58b9mr592825rwb.64.1705577474866;
        Thu, 18 Jan 2024 03:31:14 -0800 (PST)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78496000000b006d974d47a8csm3096710pfn.115.2024.01.18.03.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:31:14 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: nicolas@ndufresne.ca
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	elezegarcia@gmail.com,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	knaerzche@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/2] [v3]Add hantro g1 video decoder support for RK3588
Date: Thu, 18 Jan 2024 19:30:51 +0800
Message-Id: <20240118113051.10773-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
References: <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nicolas,

Wed, 17 Jan 2024 14:16:24 -0500, Nicolas Dufresne wrote:
>The only concern I have is that we rejected enabling this VPU on RK3399, since
>having two H.264 decoders was confusing userspace softwares at the time, causing
>the slow one to be picked sometimes. I know the selection is not fully
>implemented in GStreamer either, not sure for LibreELEC ffmpeg fork, Chromium or
>Cros-codec.

Only H264 decoder is disabled for RK3399 in driver code, and RK3399 does
have this VPU node in devicetree to support other codecs like MPEG or VP8.

>Of course, its not a problem now, but only when someone provides an rkvdec2
>driver that enables the much more capable HW decoder. Shall we hold on H.264
>mainline for now ?

RK356x also has the same situation. That is why this patch shares the same
compatible string with RK356X. Before rkvdec2 launching mainline, this
hantro g1 vpu is the only H264 decoder to use on these socs. We can keep
H.264 enabled, and disable it for RK356x and RK3588 just like what we did
to RK3399 when rkvdec2 launches.

Jianfeng

