Return-Path: <linux-kernel+bounces-4124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F659817823
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6711C21738
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FA5A845;
	Mon, 18 Dec 2023 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ji60oT4V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787E4FF66
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-425c1d7d72eso592891cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702919169; x=1703523969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x29irrX3xXEqtqEYM+OJ0BBAXCsgyxR+RF6i+7rkCJM=;
        b=ji60oT4Vcsqo7jzTWIo6QJ6uerOj4XZVpVEHrcAoMWqX9g+CkG+gY3CRs2mUgvwbhq
         nCBmW/7KBihr0qqrB35aTAkJbbUO/+SZ+XFoqtqAH7sn2iC0eJzvhTxyzx0RzDVWxuw5
         qgOneRa/P3a3YwgEoH5nX+wT1Uc75IumOLZxXtHqWB96DmTTZ2khsouYndU0L8QGE+r1
         3flJGYKCOfQi/nkDTrraFZyG3Ux+dFi7Rw4FmfRDm7R0B2i473VoYnVqug4QnJJamkUM
         1Dxj3lvP+3aiTIICZYTjBc/LKMcYuyN68Llj3E8SSWBysrgeCR7i4HdIVWtnXSpkQKkn
         +U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919169; x=1703523969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x29irrX3xXEqtqEYM+OJ0BBAXCsgyxR+RF6i+7rkCJM=;
        b=jaCARvBmt0tpQGLCHBHP1oXdP5OCSTzWWRATZQOzLJyMcwbSoCgDF6TJ6l/LJmN6Ah
         wNSZotAQPbT9sgGZqPa3jWMZ6kM7SnzyHqhJm9nbSRhUJjQxhj87ZHG6JNnkjbaYBK13
         aus5s+QQtwu7ahOfmzAcaK2gJlwMOTxKo1nDx9DBUVIiQmjWyOrtpxtckkF7ZPDXQqQg
         /Tfe0CeUYDDBoY4ngDnwrFxnpz1vwnQBEtLYkdRsMG1LgMpBNl5N10Uw4FUCARiMzI8U
         ZwIlP9cieWlquJsZCBtMITyXviWHt0iD9IWKaQhDlRg5sqRdi5xMaTRGOJZ7U5rZUp5r
         nNCA==
X-Gm-Message-State: AOJu0YwMMnZTPtaquFiftIWElQttaWd3ZGlhs+e1tpx3K1P2CB1xq688
	uZRJ25x2unGQye/DrK4LRnNaqTZVwlHX1tbuF4VCKhS3ipds
X-Google-Smtp-Source: AGHT+IHDcKVJi48DWxUiRF0cSlxxE9luXr2JxmQw2R42ge6ILA0VXUS7myKPno4BTplV6A8qHqw1BOYXjCT3w8L6d/E=
X-Received: by 2002:ac8:570e:0:b0:423:8dd5:338 with SMTP id
 14-20020ac8570e000000b004238dd50338mr451777qtw.14.1702919168821; Mon, 18 Dec
 2023 09:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com> <ZXx5DyidpHFhRevy@smile.fi.intel.com>
 <CAE-cH4p5VJ_A91BAkURBN67ACA0_u7T8UhApUYLQDWeeRY6FWA@mail.gmail.com>
 <CAHp75Vdo=g7ZBAuk79PtLOYs-YHo5sCTp1WVFESHA0xN0zGEmQ@mail.gmail.com> <CAKwvOdmMqJacYRfwohY-DXBbmNmz_M4EKUL1KuTv=tT2dO_p1g@mail.gmail.com>
In-Reply-To: <CAKwvOdmMqJacYRfwohY-DXBbmNmz_M4EKUL1KuTv=tT2dO_p1g@mail.gmail.com>
From: Tanzir Hasan <tanzirh@google.com>
Date: Mon, 18 Dec 2023 09:05:56 -0800
Message-ID: <CAE-cH4oQ+nM6G897PaUwd8zaaAvqq3QL77=4739sZovVgkG9XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

> While REPEAT_BYTE has a manageable number of users, upper_* and
> lower_* have significantly more; I worry about moving those causing
> regressions.  We can move them, but such changes would need
> significantly more soak time than this series IMO.  Tanzir is also
> working on statistical analysis; I suspect if he analyzes
> include/linux/kernel.h, he can comment on whether the usage of
> REPEAT_BYTE is correlated with the usage of upper_* and lower_* in
> order to inform whether they should be grouped together or not.

Removing REPEAT_BYTE is manageable and I have already moved it. I will
be pushing a patch that moves just that into another file called wordpart.h.
There are too many instances of the other functions for it to make sense to
remove them all in this patch.

Best,
Tanzir

