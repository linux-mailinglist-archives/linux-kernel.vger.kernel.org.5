Return-Path: <linux-kernel+bounces-143641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C838C8A3BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5971C20EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6D2C189;
	Sat, 13 Apr 2024 09:02:04 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3542110B;
	Sat, 13 Apr 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998924; cv=none; b=E4BJhk8qShkCYp53HfigaJf7gp4UXRCyYJazgABN/UgTXxrcnL4uGpqhUwBtYYso6hEMlvbVDG5Pa1msu0wtL/ZNA44uMdJon0NcpS8O8GCvXyNu6tBawSILkwCD1Wpmb3AtZibHJATjHL9RYJiW+SHAvmQp3cwP1zkq8R/sgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998924; c=relaxed/simple;
	bh=OUSUxcE0sHG/pVSLfVF04gHERkRgIOisdfrwCbkj0CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f73NlsXEMhJE/UUsqZUTVpVsq+ebwl0cY+DkxNP3aRTFe3U7GiX5ogCt4HVnknVQm79kSg8E0tkwOV0o7MjW+xrbkgFtjdOP58zWS74wecp0liJlAWhs2xyAPsB+uIVZGy6UEILYiXPZP/W03+1GC9eaL+InnhtXYjA05n/NDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1065432a91.1;
        Sat, 13 Apr 2024 02:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712998922; x=1713603722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUSUxcE0sHG/pVSLfVF04gHERkRgIOisdfrwCbkj0CQ=;
        b=O9Mfr1Ru3tlR+iivKoiqu70QVNub/h846IXvlwQqBF8Uo8Sd05SIBN/KHlnTwm1JjL
         HZxO6hf9zEjWgg7OZd4ggM/pj0cjtr0i/unPgZFaG1RHTJraLZO7bims6+ASujKvzqiy
         Q1xdQBO8hGQRWx0c0aPS85K1LMVl7ZqTKs2kiIN6Wbk6kvUBE5kloR2V0G3s9mLKpdo/
         gaCN12tFtE+ed70Aiy1EKaCiQCMv14OtP5KmGrS8i/boWIlg3cu80Qd/qREum25x9OSQ
         rhvbZ8/L0qA67cz5lv/z6XdP3kk2JyOaH/2aC3IqRAaDrFIREOtxS2ILrztIQV1QUOBb
         xmQA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Qa0d8G9f41/oEIZ3cLtE3QoQHqlVf7oty+uwmA8DIzyZhv0bDULsY1FroGV26sPW6ogzcjFz0gjG4QLsv+awMAq7sJZBT6tr1W/VKubywrV4AlpdHtDdCUT94K36V1/Y/Ngm
X-Gm-Message-State: AOJu0YzkWR8CvGP+4hofu5MrVEV63q3AycFsfRPNrQNmQDWaQa7rnycL
	HQVIWwc5IgbBej3sy7rHecvB0vOF3zJ3y8exWQYBCAD2AjLG0bUYV6mjPZ442gG3EJQ/NkLn5O3
	J1KM+HBl4fM00IpArAs2VZC8N8XU=
X-Google-Smtp-Source: AGHT+IH/J5olMb8DBJhgw9hOvDiGOdu3AljEKe+ONFbnD+K9ygwPzFOJPEuNgbQGcLOi0TXUwGCieIHVXgWzWEuPveQ=
X-Received: by 2002:a17:90a:d083:b0:2a6:19a5:1ae4 with SMTP id
 k3-20020a17090ad08300b002a619a51ae4mr10615943pju.3.1712998921635; Sat, 13 Apr
 2024 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412173332.186685-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240412173332.186685-1-andriy.shevchenko@linux.intel.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 13 Apr 2024 18:01:47 +0900
Message-ID: <CAMZ6RqLWmjwsFPsVZtpDiWCW71wTao-oz9dDrqKUfrYTvtDxZw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat. 13 Apr. 2024 at 02:33, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but the only thing it is using from that header is the wrong
> define for GPIOF_DIR_OUT.
>
> Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for the patch.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

