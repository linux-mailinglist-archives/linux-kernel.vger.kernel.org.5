Return-Path: <linux-kernel+bounces-16892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152D824588
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A394B1F2289C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286324A05;
	Thu,  4 Jan 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llk27PDF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C148249F3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6e377ceso443379b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704383827; x=1704988627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFr/AUs9sMgt0FzIO0npkBkWStq2Hc0oZ+hoal1cfyw=;
        b=llk27PDFdjoQG/Nj4t1g01qZJEi8sWRkMqSt+ju6ddmPh0SvvpuDYT4ZzOfg6JtC+n
         T6UJ/Bac4anRltkVSXuv4RDSUB+2lmy0gJh0q4yjbbAnh+fslwDrMtXu4wyueC+e8AL1
         +xtJvSzXWqv3KJDzU/nRdgcvAb58g3PkglNhCXztL++WBImMneUyl2zjkLIf2V2erX+p
         YELgzV1Q8StjtAKaeXGhL4scwatghOHnQw3d60F/2KiDUT/gPtbA3qXvKdELnOqeY2c9
         MzWjqFqb5Ln1vJkBSmTIw2TTkEw9qsxCociMlUssQx5mf0PHuAdW2gzKwhqeEeMvFNYQ
         +RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383827; x=1704988627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFr/AUs9sMgt0FzIO0npkBkWStq2Hc0oZ+hoal1cfyw=;
        b=oHXHRLL1J7/eHFEBKi74PQ8/UdoFoS43a9oqZV3fSanyiUkQTYqk0S8kNrLydu9o7s
         5TmUp66zJ3Lo2H/Xj9xMKfqGZKB/P9V3l/QAqGdYYQUYhN9gVBt9l1ieiZOaIlbGah13
         nxqQkv15Gx39+B8lPJNpUS3NvI1fUShdzdgWs/TgwYR6rbJ1ulubyy/xHu8Ld8iImE1h
         erZOdrExlzofm90V+WAjzcwgOQ8BQ8nz3jy9JykaiLEy12J3mJNW+KOo6lJo2B14Ww4p
         8AUU+WB8MOLuU0HQKehqGrSjIDg0Y3Vk8rd+6br90EkzTrpPoQWpBI9llgH9azjfAVKQ
         o8tQ==
X-Gm-Message-State: AOJu0Yzi0cx6X0V7T49A7xALovyyTYod1w6KA7QzlmQPCZM2vov9tL/Q
	3S2+qFlTsV7hPHcZY4W3ALE3IpZ0gGycnLQgk7e5vn/pWerQCA==
X-Google-Smtp-Source: AGHT+IGRhDpFjiBKMa4aosjcsebCWIy3gsTL34wBY2Uuf2U7aCIMdsa0cOJL4F+VOCzuOfGVrM5UC3tRtb6uPfX3hXM=
X-Received: by 2002:a05:6808:1693:b0:3bb:d656:b95 with SMTP id
 bb19-20020a056808169300b003bbd6560b95mr826254oib.84.1704383827456; Thu, 04
 Jan 2024 07:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226110459.6816-1-phanirajkiran.a@gmail.com>
 <2024010401-deputize-occupant-cb6f@gregkh> <CAJEOW9YiuBSLUrP0BkRGQRmJWOKpB4Y=DhTGUnDDumhuzmcH1A@mail.gmail.com>
 <2024010418-navy-grandpa-dc0e@gregkh>
In-Reply-To: <2024010418-navy-grandpa-dc0e@gregkh>
From: Phanirajkiran <phanirajkiran.a@gmail.com>
Date: Thu, 4 Jan 2024 21:26:56 +0530
Message-ID: <CAJEOW9Zk-+ajEO12sDgyLawF+Z6fbDw-FdPoSCBaGFSx3WZjSA@mail.gmail.com>
Subject: Re: [PATCH] staging: axis-fifo: fixes alignment should match open parenthesis
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prathu Baronia <prathubaronia2011@gmail.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yangtao Li <frank.li@vivo.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sure.
Regards,
phanirajkiran

