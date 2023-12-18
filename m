Return-Path: <linux-kernel+bounces-2956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB981652D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514861F21B23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF85399;
	Mon, 18 Dec 2023 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQdOJpx7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76B538D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d04c097e34so18937285ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702868590; x=1703473390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRiBBcZGcrpP0v/TFRrZqGYwkaK/3jatn87Bdd5lS5A=;
        b=iQdOJpx7QBp7npycXAI02Dr2/mM++oeJwOLDV7htFbCb5EDYiOgfJu572h3C4L74+z
         re66sTwENPUZ0VRJH/Pn7W1eAYYuAw27V8jp58q7TDssFjU5Nkii1Ycj1sKTd/b8WCf7
         U/lUyX+h+N63fbTwkuJXyCC1hG/izc9GdWAaE4amx7nB9Um87mqawAoRspIoCwi1LvaG
         X1tD5S7EasJcnW0WGaVVOxwyrZIw4vvdlcAVtYdTjWVZBfuqzq8nWCfDSfJJqsWuwkOb
         ZyPk9A54+dr8WDyqu9vR++RBisQdtiDYckYremo0pVoTKcDOppP2YRjWyMkjKv3WAXg7
         N24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702868590; x=1703473390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRiBBcZGcrpP0v/TFRrZqGYwkaK/3jatn87Bdd5lS5A=;
        b=KW7ZmCNhNCCjQDpsoSjQ41f7W8Xt0rNQ6GVGsC7UNC0XQS5P/y3qUc+eXKIlimtjDs
         fKqGBkYy4Nw+bnNdzcFmOWaX4dTP9GJyaYHQAwCowRZgLgfxzj4GUNdNBhSgGX2k4yHf
         2PopEI8xokbrtLVkc52s2bT499Qj9hj9y1oglganzEtsgik9mxnDeyWHsoDU1AKDn72c
         kURxEfCwJBWrWtCuC9BG1Uca33WgeSAB3fzvr8SoiLNn96G101VHtZR+T7CE1syyumyA
         QzdIInh8zwkIxfRwe/7OD4ZSPcF5OeLEOOezUZnXqQHC5VwDeue1dl6ebS+I2QDAZ+Ak
         2QDQ==
X-Gm-Message-State: AOJu0YzPCwCOGwfzxKa21nEnbwzl5EYlnM6K8Pa8FjF3qxipJ+aU+lng
	Ny4DUkHrJyK1XZp+uKXe4P8oBtMZb3c=
X-Google-Smtp-Source: AGHT+IFKKF360nqQq89H8+YRJ/5p436D7TyDqT5K/xLbvCj/TEgVertdIXIcQg7YWtGK9UqvV6WWRg==
X-Received: by 2002:a17:902:d505:b0:1d3:4cbb:3017 with SMTP id b5-20020a170902d50500b001d34cbb3017mr11895395plg.42.1702868590216;
        Sun, 17 Dec 2023 19:03:10 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d3564cf109sm2429482plb.11.2023.12.17.19.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:03:09 -0800 (PST)
Date: Mon, 18 Dec 2023 11:03:04 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Subject: Re: [PATCH] erofs: fix ztailpacking for subpage compressed blocks
Message-ID: <20231218110304.00005be9.zbestahu@gmail.com>
In-Reply-To: <20231214161337.753049-1-hsiangkao@linux.alibaba.com>
References: <20231214161337.753049-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 00:13:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> `pageofs_in` should be the compressed data offset of the page rather
> than of the block.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

