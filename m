Return-Path: <linux-kernel+bounces-105552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FF87E006
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A6E1C20D62
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675C200CB;
	Sun, 17 Mar 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg+xoVGu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DF1BC4F;
	Sun, 17 Mar 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708368; cv=none; b=mzHdESXmO/bDOIyN3MYcwK2Xi00QcaPrco9JrHxf+U/muczJNNhBzh2O/NwqIKurWmFsDfXhfJNgoFJl8/+lSLYjA5PCmvXECHujJQDZEp6UEQNkUZhpiaWdr87nz+BNLlGQVmy1Ikee1vkJabBEHKE3pJaqxPPgzgz3FswKBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708368; c=relaxed/simple;
	bh=HyaIQM7Wm7PTFyReb5LU2BHlzLtBr0gdOlvDFFlKUk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=av8KJw5ISyaD4mHGTHmUhnJfc1hEqp66EOvYfaT130ifgVbNkhch1kjbm0h0FH7vFmmQk1bQ2QKQJy2QhFI1RWJ8pPzcpfwztU2i6BfZ5dQJJwGnVJw8sLbgD0jC7oSFbukHm7Z3ETWVmIu2tMFz7Mp8bQYXyV/SiM8E9zz1gD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg+xoVGu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341787c7dcdso22664f8f.3;
        Sun, 17 Mar 2024 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710708363; x=1711313163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyaIQM7Wm7PTFyReb5LU2BHlzLtBr0gdOlvDFFlKUk4=;
        b=cg+xoVGuVZd3aPj/B7fuGHatCbWVEFHwpATUH1kIVllSJ61HnASZcthqMh67OUok3i
         c6nWIGKjTlk0LX9vUjOIX9g3UbPtogfsARtLaQJV7M6NUDHkuEuLJXx/T7DthvnzsYZM
         vcONurVQpTveq/zNq1txwswvrOwaJD6p277xqYSut6UMgeEDrbR8m4xuQOb2rNun1/3/
         7fEHrcp7YU5wrL6KTm16jmkwj9F6URoZVR6ICtr9iTd/HKkGDqhOXP/rJE00zOxGGsGx
         jvG+J6rCZaojN64rahUuioktPSjz6F1PTFB1BqgPGnOAUpFSqREmg00vugCAYP2TGZbW
         lb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710708363; x=1711313163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyaIQM7Wm7PTFyReb5LU2BHlzLtBr0gdOlvDFFlKUk4=;
        b=uy6yWMO9JUj1QHG2DdWdYLen92Lzx00LstvDxYe5amIMwtb6o83cdVtjwElIE9FVJl
         1wjkmTo/XVCj2JuK3CQ+aNopo1p5gmoXgZNxCu3PRbz6fy32mfM3IgWydSC1gIbOQeyU
         Fw8+KddCdqjG0LWwnA4mJCBW3Nus4eBI8EEmLli8SzwR7s9YmBKtrgfaRK+7szOMpP3L
         0kJ4HWrNjVslANZOUzFpvSku0c1LtfVKh/Ui9frsJiUdUQtMPnItuXmy50xpDLK6UH7N
         B2WkHq0tfZadYeBs7jKapmNXoOcuYQGjULT5qamNil11vzw4ZCklCele82dA9HeECjjU
         PjQQ==
X-Gm-Message-State: AOJu0YwsOtyEBai+Ck9BLiZlf/fV1p0+YZu5bOoHmuMB2mpLtzUcQ63B
	ewy1GwQWJe8d70YcCdoA6q6r1d+O/y9Doa/ItTx4wEFDwC69L636VZvWPLRAQxhnv1luMm5mMga
	aF8snqNKwlRSMUaZPDHOU2H1OxEIPLAsx/Zo=
X-Google-Smtp-Source: AGHT+IEq13kbR+pu1JFHoINw/8e46wtxhCxpj5fnXQPZOF4hSUOrOKR1YgDxQbXpfRMuKYMaFpAMI7Ec3p2PCBxaAMw=
X-Received: by 2002:a5d:420e:0:b0:33f:6ec1:56dd with SMTP id
 n14-20020a5d420e000000b0033f6ec156ddmr3523874wrq.45.1710708363271; Sun, 17
 Mar 2024 13:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stuart <stuart.a.hayhurst@gmail.com>
Date: Sun, 17 Mar 2024 20:45:52 +0000
Message-ID: <CALTg27=oxjn6sz7a9H7Jc1z4-ZsoupaEYioWhQPeL1HEKrcRgw@mail.gmail.com>
Subject: New driver for Corsair Void headset family
To: linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi, I'm writing a driver for the Corsair Void family of headsets, but
I have a few questions before I submit a patch for v1.

1. I can see there's already a hid-corsair driver, but my driver is
around the same size as it so far, and shares almost nothing in common
with it, as they're completely different devices. Should I still
attempt to merge my corsair-void driver with hid-corsair, or submit it
as a separate driver, such as hid-corsair-void?

2. The headsets can be queried for their firmware versions (separate
versions for the headset and the receiver). However, the wired version
of the headset doesn't have a receiver to report the version for, and
the wireless version isn't always connected to the receiver, so the
version can't always be retrieved. Should I just register and
unregister the attributes as the versions are made available /
unavailable, or always show them and just return something like
-ENODEV if there's no device to return a version for?

3. How should I expose the limits for some of the sysfs attributes?
For example, the headset can play a few alert tones, and I wired that
up by playing the tone whose ID is passed to the send_alert attribute.
If it only supports IDs 0 and 1, should I document this in the docs
for the driver, in the source code, or as another attribute to return
the highest supported ID? I have the same issue for sidetone, where
the headset supports values 0-55, but I'm not sure how to communicate
this.

4. The wireless variant of the headset reports a value for its charge
that's ~54 higher than reality while plugged in. The Windows driver
just conveniently reports 'Charging' instead of a value, I'm not sure
how to communicate that the charge value can't be trusted while
plugged in. Who do I need to ask about this? I'm assuming someone
that's responsible for the power_supply class, but I'm not sure who
that is.

Thanks,
Stuart

