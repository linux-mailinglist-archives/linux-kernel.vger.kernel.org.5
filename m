Return-Path: <linux-kernel+bounces-106905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E931287F532
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211A8282745
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710B64CC9;
	Tue, 19 Mar 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpqIYS1U"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974468F72
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710813531; cv=none; b=u4d1Bmm+wV3q7Z7pPaP+WTRPq8iw0WYq95Ws8WGwS+Wq6FQhKBl3WigOHp5f640umEhE+5B1MoJcfVEpyo46Rhz5yOIf8E7s8pCKLocdnruFgsfVCme1C5zYAOBbhzPVk4qQk8/3+fxxqtMAR2F+MAguEcr4ffa7zN9GGOLhlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710813531; c=relaxed/simple;
	bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=P/Plc2acAiEuucPmj98RWNfCYnCPsBJDynuzYmQQI246DqoKf1dgW3w/OTVFQRDvJQ9U7w7VKclY/bq3XndygpDY8APGYOX6NRSiTMzCJH9qLdaS4hz9uZ7E0FhhBOdlWFi+mAj2JInqJ5uT1bA5jGz3PgVtPSNJ+K2foxBaMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpqIYS1U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so553762566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710813527; x=1711418327; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
        b=cpqIYS1Ucacr+3w1xPxYBx3VgRlOj8tyd49un40sc8gE0v//33vwjvEtl52te/nOAt
         dcCVwo+f1A6vltYEm+OAqRjhVtvyIqWOWau2DngWoA8CZoaU3IohVWtQWGH6lHOOCRo4
         8CUUfhCiR4WpoUkIhCU5KTiCNW2vISbMVaXdcATPZEyG3PkTDFx/o19ucpJp0Gd6onO+
         DQhpn+kXf2Rm6VotEHIGCbj53x7zWMJuKTjwGcrGPtlDAOfXoVperJJeWQ7q84Xh3YZv
         u8wfDGRDL4GnWt1FP6RI/eDzsCH4UTpuDbzwdf0fKlPZ7qyVcfE+q7hLGbGwUswUVNDI
         +Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710813527; x=1711418327;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKEChwLZgqf91BZqRO5tB463PmxN9ql3rOvYJ8YLsEI=;
        b=aNrMDuoQUeTm6fttiNg3pOPbVByfsWJSa7SAqgPufJ1Qu8dtFuvLh4ZAieFRFhIxYa
         eY4GRxmj4Pevlb4/20DpdaMT1fRoPkj2wgelzIFchoIoEHRSi9O0mX/LFVptdbkdqxiA
         H8PuhelZ3x093f6d5wS5Pt1ehx3QvGvxbvxevtTTfon9tLYqUN9IdxamaByP2mTyuoau
         +BRfuV+NU8vmVSBtgUazCq/ahgLhd9CzLKXNDBtv3lHMDUElPtwGiotV0bo5nEfDTgeo
         dLRwRkiiAlWnlPucUQdNZhCNQR/VLO6CZ/AMgBrQY2sPCLLxyV4MpmRFeSb0ntGc3xlE
         1tmg==
X-Gm-Message-State: AOJu0Yw7whQNKQEsyTvawuOnWUF5iL2KNoJW7om5qjAdYtBoJbE8oHgf
	RwNkFtNJy84MCsDivHrKBQkSvDAGFpVuCo4rxcRnEOa7f0wT1fRHqP5Bfwob
X-Google-Smtp-Source: AGHT+IHk/W8qo3PNyHf9wQuZRZc49MrhC4QavO0gp4yzhCslC2bSHvVD+U5onljxS2M4/dUt/bXFCQ==
X-Received: by 2002:a17:906:f24c:b0:a46:e12a:a2f2 with SMTP id gy12-20020a170906f24c00b00a46e12aa2f2mr66459ejb.70.1710813527422;
        Mon, 18 Mar 2024 18:58:47 -0700 (PDT)
Received: from [185.222.57.70] ([185.222.57.70])
        by smtp.gmail.com with ESMTPSA id li2-20020a170906f98200b00a468bf8586bsm4255834ejb.174.2024.03.18.18.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 18:58:47 -0700 (PDT)
From: Lori Cozzi <rathotodavid@gmail.com>
X-Google-Original-From: Lori Cozzi <castillom551@outlook.com>
Message-ID: <bdac0b94aaf95955a403ea4fa7b497d89a905be8c8a7a950b650c1f908b47b64@mx.google.com>
Reply-To: loricozzi@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Offering an Acoustic Instrument as a Gift
Date: Tue, 19 Mar 2024 00:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm giving out my late husband's Yamaha Baby Grand Piano to any passionate instrument lover. Let me know if you are interested or have someone who would like to have the instrument.

Thanks,
Lori Cozzi

