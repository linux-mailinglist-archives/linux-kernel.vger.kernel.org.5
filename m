Return-Path: <linux-kernel+bounces-28322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD282FCED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5281F26D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94393DBB1;
	Tue, 16 Jan 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI8PtIE3"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19791D6BD;
	Tue, 16 Jan 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442096; cv=none; b=TZf05ZHkYfo9NT00SSY3TL4b5bAeH/VuGUs3QoldTYtDojyTlgQlIR30LhO439yXaURFbtaqBor5Ike06Mkql+zbnFK5i03YJ6/PU95M27omrBvsMIdwVA7bZ89K3qDJBjXwhknPWLRVcmZf2cjoQP2DupopRPCv5jWhx4mj6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442096; c=relaxed/simple;
	bh=npI+Ih9mt2xbQi3BROxMXKfAn6rfg1s15HAmsZCxBbM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=gJlCx/uFSNJHzDkIcCaEHlhxyCw3bNOzpA2Xd/cRwjoKqpGrH0rkCG8QSTwRiQkZCNcLodMXXE3l2WahcjiPVjlFQkYkpGpOPneoF6+/rGJQ6cfHw5PLXQdSRnXkbkAbdJ1V1DTI+u/d1RD4uXA6vICU51hci/iy0dh0QwZfv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI8PtIE3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb53e20a43so7020101b6e.1;
        Tue, 16 Jan 2024 13:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705442093; x=1706046893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvvtxY1CbOhwKiiqsLbdlUrB9w8j8X3W8Q9P4s0eRV8=;
        b=BI8PtIE3xGbI/DXHA+mNvt8WE0kJmz+g7Dyrl1EQ/Bi04isT7lF6HoCe7DWkIRu0Ig
         aurhuJkoBt5BWKxD1/ZuCH7yDtoTKPfd77+ibMuCjjKITyCIaU2SupXwq8e35HQuqpWV
         m1OOh4V7QF91cl8ROd4Z4IXLgYSRGplUW1p3qQxMdtuevbJKrPXe9KzN8QXuxAkUkFyB
         VKaHLjig0U8PKeuvYZdAVTjxqDuRMb7QRbyZx7fjP3yx0FES7p2E8xQHnkmmjihBz4mg
         JNdgFyHh/DhUx3CeXOSISxbDKOy2pw5s33baxx4//u9tpqwWnzzMZe3E16i4dlnC5aI+
         V2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442093; x=1706046893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvvtxY1CbOhwKiiqsLbdlUrB9w8j8X3W8Q9P4s0eRV8=;
        b=EAycuzu377l4x2MpKRfQLc7Qg5+u2u7d9yL8QwtemOEqj3bbYMjKHWhhbAxUk+x/od
         +z7jEAFW+DWcZeRzqs9bwHbdaaL2h9K0OH8AGOgy8dTAz5ZtFHf7AuDmBBKrrpYrY3PF
         D1xayPY/ozK4QI3roydotFxAfa4nvU0oK89RL2DFBCZuEXobhWdxgAskJ4SJuaU4PaOK
         Ljpzgy+8uR6tOIph9M9LjzfBG46c3Zg2Z8HjEIdEy6DAFoIazEb4osqcT9AGsr9mkZwS
         Bp+/YScfGnn4+FAOkttoYTUtdr3mqtKKWa2Gz/pUmog+HBz6v3fvi7sogLlV4Om+qsOB
         3bqA==
X-Gm-Message-State: AOJu0Yzwf9zB0nkn2pbvLz8gnxed9deP4OJayC8rTeuuBsbm4rKhIYwj
	KWRTxoIAmUarHeBDbKTV++g=
X-Google-Smtp-Source: AGHT+IFdXgsLRz4CScn/7nc2HlTEx/jXFC16f4AGjokIAP1lG1KXO71YlSeSSYSHrOFXxuQSJqYbqw==
X-Received: by 2002:a05:6358:5490:b0:175:9bfc:1b32 with SMTP id v16-20020a056358549000b001759bfc1b32mr8713718rwe.29.1705442093495;
        Tue, 16 Jan 2024 13:54:53 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b006d998c11eddsm64665pfo.62.2024.01.16.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:54:53 -0800 (PST)
Date: Tue, 16 Jan 2024 13:54:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Russell King <linux@armlinux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] input/navpoint: remove driver
Message-ID: <Zab7KuDPKHlbahsn@google.com>
References: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
 <20240116-navpoint-removal-v2-2-e566806f1009@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116-navpoint-removal-v2-2-e566806f1009@skole.hr>

On Tue, Jan 16, 2024 at 08:48:07PM +0100, Duje Mihanović wrote:
> This driver does not use the SPI core as it should, instead tampering
> with the SSP registers manually. Refactoring the driver is almost
> certainly not worth it as the hardware seems to have been designed for
> and used only in the HP iPAQ hx4700 removed more than a year ago in
> d6df7df7ae5a ("ARM: pxa: remove unused board files"), so let's remove
> it.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Applied, thank you.

-- 
Dmitry

