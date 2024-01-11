Return-Path: <linux-kernel+bounces-23477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADB82AD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AE1F23CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD8714F9B;
	Thu, 11 Jan 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6S3euTN"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637414F88
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so4392913276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704972273; x=1705577073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aojgwYUr2QZguAnX8qCVqtq4dlhf98Fk0ICKv6JZtAA=;
        b=I6S3euTNp/+LZ7D4a64R/spzkuCFJrbmvJm4nvY2yTPulHPUla4wTXPx7xdbp+zxi1
         E438AzFdcfByFcNPGc2O8+clYPFFZXqUMIBevBD/KbpnmkovZpP/BBqBHmGShlO/055K
         jWazNttenZzfW3b7eYiu5rHdPIrwZpnczddbSNZWSF9HQ8C1nuoQZLxU3XdKd/YK/+yz
         oYdbMIu/zGuAEUHH0gQaubZY4bkj8yS2Sy6iIvFoIB13QL1rplhG3hhrE9HxilT/YmoI
         IcGqb+Y6m9kQsOwTvLvS1JQZLfvNZQ+fRDoU8mW125qMIHewM7Ls+pYHXun8XJ5ODa4r
         ifpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972273; x=1705577073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aojgwYUr2QZguAnX8qCVqtq4dlhf98Fk0ICKv6JZtAA=;
        b=gfT0858AsxlqE8wCp4STjCAmPS3AnuycSxOVd/BRZaD9y4tu6SwBDcA3Bn3uzpPfOl
         gqk4fax6NjgRYR9HrOB6HQmj9ghF3rKkOlFFr0hcXuDrykzaj/EratL7FBktq0NFfgrk
         nuhvaPzRvt+OskEcD8f2OdQG7FEFUOWFSTycNulwNOq6BOQRgRp791W4A2LhEgtXk8Lm
         l4IRYmC6gin1zdRFKogx+/Z+UGNTqRPxh0f2t9kfX0NGlZwmInGX5DyPv+OithL8aBp6
         TrWLjhTfnCIPBUm0xTnPiRVJPbIujLqWOmCdmxD0dtgylV6Q+3vN6pbA6qlsEyz9m+XW
         yTWQ==
X-Gm-Message-State: AOJu0Yxx/gR/6CEiBt+lbB1sEEZpVJiZlgvwN+8Pie1f7oNyDJD7oyLH
	n+pXhGuPmL1mJ6VKwQihMgBAe+ogAkmNDMlfRko=
X-Google-Smtp-Source: AGHT+IFx/bMfT4kDTm4bgkWCoYa3rLRG+k7Kmh2mgpdeVBjV2rOa+hvE8gKeoOVOnexdTpKD/cM7RjMgcYULBo13E8A=
X-Received: by 2002:a25:fc1c:0:b0:dbd:b46c:c1e2 with SMTP id
 v28-20020a25fc1c000000b00dbdb46cc1e2mr837247ybd.110.1704972273260; Thu, 11
 Jan 2024 03:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111070652.71717-1-pranavsubbu@gmail.com> <2024011144-silica-viral-9e79@gregkh>
 <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
 <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com>
 <2024011144-sinister-baking-952d@gregkh> <CAP1Lp89zshQW_s0eLJjekr5tyc3XLaPnh2VGFrNDHTA7GT51ZQ@mail.gmail.com>
 <8988f86a-f850-49a4-b7ac-ae363a7898d4@moroto.mountain>
In-Reply-To: <8988f86a-f850-49a4-b7ac-ae363a7898d4@moroto.mountain>
From: Pranav Athreya <pranavsubbu@gmail.com>
Date: Thu, 11 Jan 2024 16:54:22 +0530
Message-ID: <CAP1Lp8_6MRu8DJOqfvOEWVzA9wPhFB16iw=i2jOQX4RWELj=kA@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code blocks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Forest Bond <forest@alittletooquiet.net>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:38=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
> I have a blog about how to send a v2 patch.  (v3 patch now I guess).
>
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
Thanks Dan, I will take a look at this! Also, why do you say it is a
v3 patch now?

Yours Sincerely,

Pranav.

