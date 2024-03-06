Return-Path: <linux-kernel+bounces-93632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AAD873297
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C311B1C212A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED75DF2C;
	Wed,  6 Mar 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5O4DWdn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1F5DF15;
	Wed,  6 Mar 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717649; cv=none; b=fcONJBgNDs2zo0aML7k+VQ7Hyq5PQb61WzgGL6Xgkh9x3jvfd+0ovOJuhJEeIY/idLq1dyWdOQHHFGrFJajwwZ/rmUycvIEoyQxyjMpuAmLMi3rXjhzXl9PWqQpPS/aeNQpNPTQeiJbqYgaaNoMGkTjDJgB/kEBN4pxbL4rKe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717649; c=relaxed/simple;
	bh=3VPWgy4kmEtl0ozNE0+NCCUSOx6mZ4Bx2IGbG/ljvUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bOXCzHnWZBmZ4KuAaU0pF08mnJxAM6jZrZs6bnLEQijZTN6AS98Tqvt9evcZD0rgMJFATgO1AkiOpfZOr3NETKDs5op0mwCEpimBKONU8gK33u5CaLkU64RW1XWK79hZFfb17CwsLjzK4IlpyywXObDcAbA03Mug+JQo5r9vrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5O4DWdn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44e3176120so476783366b.1;
        Wed, 06 Mar 2024 01:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709717646; x=1710322446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VPWgy4kmEtl0ozNE0+NCCUSOx6mZ4Bx2IGbG/ljvUU=;
        b=S5O4DWdnbBCL9Yf4SzdocuTBKsQH1oMApnCkbHjnVNgeEhki7ILfb6eGpVjTT3vWVi
         Ryx1M5+vLAFqrxwYnkh4i5HWKRu3y+4kPZ2gPBQuVr0mP8jmvNcYKu1EqrFFF7p3Bog+
         jPXXwd9qnTDvv6hambwc6VIAAEfV8fniH07izeMHKT8jFseyIBJxkSZS0wko5rqrsmM8
         X+JCkCvlWy35WLGqX4IG7DVxuh/3QkbF4zbgG9jQWFNC+olktieJtDOSuKsUlzEi2KrZ
         GtaEpXwYsIey7humaH4vW695WG2rBIN1hDYEZcn/IxbgO+yNLwP7U1/D9YFtnPqN8kKh
         NFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717646; x=1710322446;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VPWgy4kmEtl0ozNE0+NCCUSOx6mZ4Bx2IGbG/ljvUU=;
        b=Nok1QVetVGfO6HAyHuzhaFehqq0u8rr1XAIkWq74X/W4iHU8oQ/XKZ+OOW0pDjS0P3
         vhWwOBuc6tgdeIZkn0BZt7kBbi8m96dP0KFm/m4y+W4GrAmxWuDM/9LiEKu9oBOsfF8P
         JKnW2673kocTfjMMobmMtAcbIrYN/x8D3kf99cnmxTYhSFis8yDXLSDH6BiywWFfs/tz
         hMhbK+DfYlu5vMYAt8rhDeFr6gLaeJr9ZLi+ov09PQBf4m49Bq5JOdZofe5941p9kPyH
         jagK4EjyPn8jIknCwZC3dUs/GkXYyO8I1gaSxYfT0jbwfmPFvSSuZaw+V2kBsD2gq8lk
         yiAw==
X-Forwarded-Encrypted: i=1; AJvYcCUpNiVCflvqAfZMPoIDYVFvm8oDQeiP+3lvkcaIidvXwzcXv0x/D8XJ/D3QP4g5t2LH2jZtiXihILERcpsTTuqSCqkPSVI5lnwkQsf8
X-Gm-Message-State: AOJu0Yx4UiZQoGhHekp4P6qVUuaKpvj7gcqmVVTZ1wFhbJ2bMFsbhylm
	Sar+QsWmcgsPgWUCwzUq0ezeMSQWaPbqBSqIh3LJhLJ6gzE3EeaW53umc3WyhooH3zg+gUdMtAM
	rhEY1LnPk/WfT2lO8aZ0eNrI2TDg=
X-Google-Smtp-Source: AGHT+IFgOs6xty8sZqa6V7tvJBSNR2MMGtXeCL6ZOourVsoNgle1afwMyf7cL0mpz7lp8cQoEOQIcrqCGttHsqPA3qA=
X-Received: by 2002:a17:906:4f87:b0:a45:bea5:b9a1 with SMTP id
 o7-20020a1709064f8700b00a45bea5b9a1mr589958eju.57.1709717646095; Wed, 06 Mar
 2024 01:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 6 Mar 2024 10:33:55 +0100
Message-ID: <CAKXUXMwCdV466mRd4K0ePV73qDO9GRAph4KuC5nQ0JAp-ouemQ@mail.gmail.com>
Subject: checkpatch.pl getting stuck on a macro in mm/kmsan/kmsan_test.c
To: Joe Perches <joe@perches.com>
Cc: kernel-janitors <kernel-janitors@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Joe,

while running checkpatch.pl -f on all files in the kernel repository
(v6.8-rc1) for some experiment, I noticed that checkpatch.pl got stuck
on mm/kmsan/kmsan_test.c, i.e., ./scripts/checkpatch.pl -f
mm/kmsan/kmsan_test.c never terminates.

I could already boil it down to checkpatch getting stuck on the macro
#define DEFINE_TEST_MEMSETXX(size), see lines 541 to 554 in
mm/kmsan/kmsan_test.c on v6.8-rc1.

I do not know if it is worth fixing, but certainly I was surprised
that reasonable code can put checkpatch into some stuck state.

Best regards,

Lukas

