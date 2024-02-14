Return-Path: <linux-kernel+bounces-64625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A4C8540FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89191F29E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A2443D;
	Wed, 14 Feb 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F5N+xPF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3EA20
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872589; cv=none; b=dyYdpYlqMZ2TTolksQrqAv25s3NuCehDUt5OH2A/ouKJv7sJV05S855quZxamqBmV6hUPab+5Jh+wOZnq5R7USxu2uEIuoiit6KXYSwzL8nAogtLlE7V+aXpJzeRTQx909Szk/BmX0gfxBvUFMPMW60eyvxHltMK0VmP7ArjXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872589; c=relaxed/simple;
	bh=fp2tcaGg3mBRInYwHk0XUlmweSyISAqCzH6oa55u6qc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gRPo9djn0iFnjZfsO/GuGCj7b1AFreJj9dh/s6xK/gatwLggjX0kKZ+m6NGFDlTcI4BpPDvF7h86WkPwRWDrv8xVwhh8O/4srxjlsGdMC13SOhBD4wzjBDfr8F+uHUOP1LaZ0iCMwi32uk2ukAFmiEKUjv95KoofFq78QJ06AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F5N+xPF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60753c3fab9so4578307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707872587; x=1708477387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp2tcaGg3mBRInYwHk0XUlmweSyISAqCzH6oa55u6qc=;
        b=2F5N+xPFWMP1deEQGo1LQJ1AN1w+KATuqR4I/KCnCkDI2tPsqlXhO4V1W26oDsucL8
         R9JOFHrRGkxTnMUkHwO6/Nq5XTIPPPIXXSsriwzDegQXZAUi0wy72prMrlfGA0UHMCnA
         42KjiO85QMANkV8DsZlJhAifyelJbNx/X4EE6HgskIaJx1BXr3pOc110nI6EcSeq++c7
         rWKx2/upPIoHqdjtYTTVGh0gDk87ZuLfmbWKm4QxSe0Y5bsdUJIQhvtjkFL7jGfaiKVn
         kTPiY2Ho+usmyFbDIH/CdggVNGp1lgx0jRpfk1pKufR29UOyFepesyPDQTkF5jvNV+YO
         1xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872587; x=1708477387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp2tcaGg3mBRInYwHk0XUlmweSyISAqCzH6oa55u6qc=;
        b=oR6r4dqjIFGJfiD4ntgFFYVLYgOc0psMx+cfcahnOmYbiWTgN03KhsF8Hs1eeLg2kl
         rhFE113K3a/k6m7KE4GaFeGASfKAFX1GwqeNV29T2JVPloyh+ZDm6WLDb0Bf1r12IDIR
         dsbkYd6bkvB+FkR0cq/oGzeglUanZyPElMDP3VzHq9j4x2dKKPE+ludqbNShueMHbySS
         4tay6dMpNwrKFAu+X1LQp/0hLsSwjsSjdaHUTd2yltALQ9mpBIRMtP5/8NS4rCBeGYQk
         c+68S+yBGpCck4nbeEsR7SVLyh83I1bdsjxYmfis+on8GMP4DlGC/jLdCZEC5wzArTuC
         1ybg==
X-Gm-Message-State: AOJu0YwRq/YDLT99HDg8c7udHf2XrqXpTkQrwJoQbkIriMu19hhrNSdg
	2HAGOC4Lo7SspcTcSrMhRpaxxafkcViRbYpZLleGC9fW+EGfePWY/2ErzDgLewoydNRHfT6RHGe
	YFvKknOJFvw==
X-Google-Smtp-Source: AGHT+IEkbqpIWwbskkoFRkODu2Z1VH2IJTEFzNd2Yhk3d5CPZP4xGCXZePBKy1W9Gy22GHIOZ1YCRk8mHg8dxA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a0d:ca96:0:b0:607:83fb:53ac with SMTP id
 m144-20020a0dca96000000b0060783fb53acmr92606ywd.2.1707872587312; Tue, 13 Feb
 2024 17:03:07 -0800 (PST)
Date: Wed, 14 Feb 2024 01:03:05 +0000
In-Reply-To: <87zfw4f0r8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87zfw4f0r8.ffs@tglx>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214010305.1712548-1-pranavpp@google.com>
Subject: Re: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback to
 check for imminent alarm using PM notifier
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com
Content-Type: text/plain; charset="UTF-8"

Thanks Thomas for the detailed review.
I understand that I got a false positive, and I shall make the suggested
changes for v3.

Regards,
Pranav



