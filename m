Return-Path: <linux-kernel+bounces-97781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B89876F55
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0EF281CF2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D3339BC;
	Sat,  9 Mar 2024 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUMWo66j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8312D045;
	Sat,  9 Mar 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709962404; cv=none; b=UYaIHcuNdlToD1krb7/GBUpshlSaUQ/RszasaJq4+BKf79G9YDoaYuKP7GwWbwb9NG0ynRpzuTTwJW/b1I1b80KGVmL+3wDiXLbhAvaAUfWhTl8lbD8mGv12H3/dIw6A5cvV7rxZ0bc+FBQ3kYEdOlAjvP+jB9iLss+t9h5hqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709962404; c=relaxed/simple;
	bh=3qWDkvAze7bG7e6B92BCcsYTMHT+8KthtLLJL2Dh8cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJYNuxFEVqI+JwQswaafVWfHh9pomTC8ICWWDsRCynYou1szg81sQWYZNx+R0rp0pirT7U5JVkyt1WR8AaG8LD9x3GB38odcW0IJVUF/FXqlRo57wC2sy/EczAx4FGmBQhA0FTPgGePRgdAFOy/12IJV48uCNHkofPoTxZP3FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUMWo66j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4131804e695so7492035e9.0;
        Fri, 08 Mar 2024 21:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709962401; x=1710567201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qWDkvAze7bG7e6B92BCcsYTMHT+8KthtLLJL2Dh8cA=;
        b=IUMWo66jWA8Ve99neg8N7e/yyj/5U+Lud6vuzkWIf0sANOoBN0Izi8Fk8hWEkU/cv2
         R4DRCvOalwwLub/hIBePh8//fZPTTOM0hEwu2bPC4EPUBqwz1Iu0wpLfGmDMPI9uE8H9
         Xh7s88bYMJx+uQwbt/y4Bj/NOh8jZswsjd+pg1z/PBRoviOcLQuxKnvR5R6LnR12f7ii
         6XKbYiFKSKQ9EzLzKRzXY/Scf6AatDWTNjZsHBs/6KvZtn/uKg8S4zxJBxA0PLDiSGxw
         ke9Gyz8fnb2h+Wd6YDo+PnJfZQiMr9I9YlMCYg1TsCLoUOnnMbNqDTkAWZh8qUZOdYcg
         JL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709962401; x=1710567201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qWDkvAze7bG7e6B92BCcsYTMHT+8KthtLLJL2Dh8cA=;
        b=oZy8rFPXc5/j2DqidqHaWPszs44Usr+ckIRuLJy7LFPJD461lKWjqkkZAm/xDYCn4X
         1jmQOnQQVbBrWh05fGAuTGpLJ1u8RHyaCMrLWjpdPseu9PbBDDylequQjUYdnpAvOqRm
         vZwQqvdyuqgpq9WWG6wTm+j9fVhwFYhN8eZl5CQdAEFf0u3pAVNGC26FXl0dUkXz6vuC
         Wdi1wCKmneOlsNIPWtGhjTmDhxNxOKC/IEafYDp5vpqpuKy7q4YGzcfi/2364/831Rbf
         CYWvxW6mkGi8mk/zLPpVmsgRRXZ4sNVmyyjkTT3WiUsmVm1QfjrOy878Y2eLmzngs6ep
         dzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/xhu00Y1+fOHsAby5QFvWZvaXnghYRwwiHj32rAY3MjueYHBLj8V4kNAiD+6CC7wd72IyjkiBXdCWj7IZREfGpaZMFQXP+p1ffXDupyfmpYQcqb6jxOWBXsef9ZF85KfhAYrzo70drao=
X-Gm-Message-State: AOJu0YyiCf2vCyVovHK3ApJug0HkgmRCb0mbAwpF6klZhkjHSzup0VQ6
	W8S6lfyiPqfU97AqLkHWXBtclrDE4BVElGQs620NuvK4IvXBn3kp
X-Google-Smtp-Source: AGHT+IGMctqPu64zqUioIt40kShbUnUGhAdt9tNjK8FORm3qlMUhsoXBZByUV8hSom23/4/51+tLag==
X-Received: by 2002:a05:600c:4e0f:b0:412:b02d:71f9 with SMTP id b15-20020a05600c4e0f00b00412b02d71f9mr923926wmq.2.1709962400884;
        Fri, 08 Mar 2024 21:33:20 -0800 (PST)
Received: from localhost.localdomain ([109.175.193.91])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00412e5f32591sm1395069wmo.28.2024.03.08.21.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 21:33:20 -0800 (PST)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: shenghao-ding@ti.com
Cc: 13916275206@139.com,
	baojun.xu@ti.com,
	kevin-lu@ti.com,
	linux-firmware@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	navada@ti.com,
	peeyush@ti.com,
	soyer@irl.hu
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for different laptops
Date: Sat,  9 Mar 2024 05:33:20 +0000
Message-ID: <20240309053320.37708-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <23e85f35969447ab9161068f2c159845@ti.com>
References: <23e85f35969447ab9161068f2c159845@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---

Just following up on this as the licence seems to be causing difficulties for Debian, since it's GPLv2+, but no source is provided, and so it can't be packaged.
Is it possible that it can be licenced under a binary redistribution licence, or have the source provided?

Here's the issue for reference: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1033#note_471478

Thanks,
Stuart

---

