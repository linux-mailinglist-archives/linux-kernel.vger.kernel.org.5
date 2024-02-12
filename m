Return-Path: <linux-kernel+bounces-61110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F591850D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FDE282D49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3C6FD8;
	Mon, 12 Feb 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkbD3OZl"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293279C3;
	Mon, 12 Feb 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707716945; cv=none; b=IrUzrnzTMqfp9nH5DxO9U4IOUX7bTxiQfvopfydH+TsT9EVIY/5iodQXTdZtYhM0fP2uCFhTNKsW6zpyAu8bojIYnZgNvBAFK4nADMKmERWBgEq3YuRYHKrhQJKKRZls9Mj7lHTxZBBTKlId2AV6ERASj800lzwTj5ZsAAUpxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707716945; c=relaxed/simple;
	bh=Lc/w/cxoeZuQtJ8zSB57Yo7ACdM/KC7dv5cLvDWenbM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=qEqwnzOGQNXq8gH/UsJ0cm4QOsLGwY3Zp4Zy2cPuq8jB7JlUjeEp4aqA+nKp9CSQNK4Npu9Qder+CxcBztW4PxM28vaHAyW+wh3sQYkI1NxtMDxmhH4Sa52nt1/6fSx0koGGSt3bWltB53DVSPooKOWnJVXax36lStgaq6jZSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkbD3OZl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2b5f48763so1775580a34.0;
        Sun, 11 Feb 2024 21:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707716943; x=1708321743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc/w/cxoeZuQtJ8zSB57Yo7ACdM/KC7dv5cLvDWenbM=;
        b=NkbD3OZl0Q2lOjZvzrgPrBI5xvIRxNgg6fvfExye0YyP6NTkkyv1lVpYFwbBFdjZFZ
         RdGaTNRsmrjrBNKRTA9RYYeGLpy+MaZX8X3epXXBNUJNi/S385b/haS5TfgueYKrk7N/
         wmk0DHMQm7JQnvAhls1GUj9RFO53W8q6c5NRZpg3R83+vbINgctIUEbeRbV+KRgMFdnt
         h54WS7++ZbX/i2dF3ea/lDNDz8FEZ6tJ2xBfFbgaH6e+F+ha9butxwAoOSkw6NWT+4bq
         7xVGV+J506e42aDqjYcDt2vlR5ihAMN7nCLeyfiSHUkBcwG9O/VpdrgYE5VtpQMMzaIY
         ShbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707716943; x=1708321743;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lc/w/cxoeZuQtJ8zSB57Yo7ACdM/KC7dv5cLvDWenbM=;
        b=r1NSIxiO0s028IzrNKKfBLdXfkm46wMSnvXzJ/K/BtugHKjRkwLlgwGdO+CSJRGyF6
         1PcUcQ18A5TMPc8eTedexECwKbEsxszqGZhvp3bX3FsWX8CFss4XccDZBrnqmOppQhad
         7LkqXHo8P+EXyH1NLlJhIjskRp8bz9EfXihH86aRgqtCOswr2D61W3BvAQrPIz4fPrpC
         bQbjlZkCu2kyLpwRf78oLLt8gB+iT+47BN6BkGzFSVlKnJrXUkiXTBXx9uC+qtBqI9bD
         fFpKWC/Y4cCgQc8PaUeHsf3TOAFazvBuD2soKl0Y8/Wm91mlsmJnl9Z1eQNd+9bTbctu
         RVXA==
X-Gm-Message-State: AOJu0Yx++u2xEopYffFAM+8Dt1qoV/O+cjE2072g9/u+NiZA2QqvOmyR
	gIG7w1XbZGCOJwu0SQuH3ut3utoptT5UNlcUSIAtlNvARTSp3mPl
X-Google-Smtp-Source: AGHT+IF93Q96PWuIbJC8nHjbJf1rXR5ozPu0Z4Vq8EzpC9lxn23x4aky2fSJBghovWEbSgIGEPfsag==
X-Received: by 2002:a05:6808:14c3:b0:3bf:5e23:5082 with SMTP id f3-20020a05680814c300b003bf5e235082mr8086961oiw.10.1707716943476;
        Sun, 11 Feb 2024 21:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd9/jES2EFRMOpHbZK48EbPBYXh750lyuOW0p5wYHvHkuqHGvYltI31J3eEDTjlRX4ALfTrR7oBSQjXKfxcyzIVOWLjd4fcQKvLY8o6dzB6AOPr8e/qmGWoLWbJ4K4nn7cozmpC8NpqJTmVIp7bLAa5o2CzX9JQ7W9Y+yq5hbhnHJMJCPtnGO+S/qglFqz+RGz99iIyTidEueW20ysX2I/4PZ4yg7umvUo4YoRGmXcALvWSADxLyJ5N/x9owhN9IXLbnXBP98XKyMKObGeofxS8HtEXTtpxAmH4GLKnewa2Zt7N6uYlVY=
Received: from [127.0.0.1] ([106.221.234.142])
        by smtp.gmail.com with ESMTPSA id q19-20020a637513000000b005dc191a1599sm6083749pgc.1.2024.02.11.21.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 21:49:03 -0800 (PST)
Date: Mon, 12 Feb 2024 11:18:57 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	shresthprasad7@gmail.com, skhan@linuxfoundation.org
Message-ID: <39f63f54-89f9-4c9a-81e5-e6ccbd2c08e3@gmail.com>
In-Reply-To: <2024021158-rewire-duplicity-c31c@gregkh>
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <39f63f54-89f9-4c9a-81e5-e6ccbd2c08e3@gmail.com>

> What error, sorry I see no context here (remember, > some of us get 1000+
> emails a day to do something with, context is key... )
I see, I'll keep that in mind. There was a warning being thrown out about a malformed table in gadget-testing.rst, which I foolishly thought I could fix by replacing all the tabs with spaces.

The thread mentioned previously attributed this warning to the table begin/end line segments being too short for the word "max_segment_size". I hadn't noticed that it had already been merged as I was only looking at the mainline kernel tree.

Regards,
Shresth

