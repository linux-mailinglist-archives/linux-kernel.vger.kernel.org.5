Return-Path: <linux-kernel+bounces-1204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A88814BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F631C219A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13F364A7;
	Fri, 15 Dec 2023 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDNrPDwl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464E364CD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f1ef1ef8eso2291116d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702653609; x=1703258409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ec/IkJvxWOTEpNokLms/85Ff6vAF31dE3zXHdBgye0g=;
        b=WDNrPDwl2Cuh10AceB46Qo867KT1bVO7xMcwEZDr8gtaxym1fWTX4vf79qXYbQZJPI
         p6FPxOc4OFXbw7Arduem/0Jh0+CB0JWHsSrcZEEtJzEztaNPjfFIPXqzXaaxswC/MQ4F
         RvK55rmo9pnZw6qP6iLJwF8QszJJKEhA3ssbtAtkHwcGmdAjP5zMuEkeo22eJBK7njS3
         iP2S5Y4rwaojbn1w1UBS19iu/9C+Xe82Tow9k+Boj0KwMFurjAmv4ypyECECkDLe/5yz
         apgwQA1IWh7TSL/qFl0KCPli4ipiBnWkEVLcBlBNi1Tew/nHR0O5hqiQ0b978ZFXtpTW
         5SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653609; x=1703258409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec/IkJvxWOTEpNokLms/85Ff6vAF31dE3zXHdBgye0g=;
        b=tJhEq75h2WpGjd1NDnpnNWT4A1YuyzP6bl5PwoPzdW+6hob0wYhxXFpu7oUVgzQklV
         MBPJ9OxA1pQ5q6Wsj4dTn1T/IYSSSDUXsJmiQ/hemD2SUcPxyF1YXCK3Pl1JPhwkDqCW
         d/jauWjELTgSn7Pe11RDKk3pVMZnGYQQMPubgpyx+CwK24Vp8WF8SQbdvBZ3V+AxDe/I
         XrShb9CPCnnhuj8OWmxZrg5MENDlhActqEg8P4AWyIcw2wAnI3sjhpHx3ifOdtemHbTy
         vvW+/33nWLjTV6tOY7fGrjUSugbbRTPW01kkzss4vCNmgSMS6FbgPL2610XoZP4Sbx0t
         vIIQ==
X-Gm-Message-State: AOJu0YwD1G+PgPkGWoK+8T/cvtcUo6vn7sUbU+gtETkFAb+P18kTtIAX
	hgLVeN/rMtom/OUpk1eeaxo00UsnII99pLcD1gU9JA==
X-Google-Smtp-Source: AGHT+IHDMCLAtnTkA4Lr18w0p1aGS/OoZZYewpgkL8h3vDpLLQUelxc7l/pRhtCSBfnrltjd1JTUF5nkjYWKUN1i7cY=
X-Received: by 2002:a05:6214:8f1:b0:67a:4da4:e23c with SMTP id
 dr17-20020a05621408f100b0067a4da4e23cmr11597856qvb.56.1702653609560; Fri, 15
 Dec 2023 07:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com> <20231214110639.2294687-5-glider@google.com>
 <ZXtircr4TllpqyeS@yury-ThinkPad>
In-Reply-To: <ZXtircr4TllpqyeS@yury-ThinkPad>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 15 Dec 2023 16:19:27 +0100
Message-ID: <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>
Subject: Re: [PATCH v10-mte 4/7] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To: Yury Norov <yury.norov@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com, 
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, 
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, eugenis@google.com, 
	syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

>
> That looks weird... You're casting address of a 'data' to a bitmap
> instead of 'data'. At the 1st glance it makes little sense because
> 'data' is passed as parameter. Moreover, in mte_is_compressed()
> you pass 'data', not '&data'. Can you please comment on your
> intention?

Although `data` is a void*, it actually contains 64 bits of compressed
data, so we pass &data to mte_bitmap_read() to read its contents.
Perhaps I'd better make `data` an unsigned long to avoid confusion.

>
> > +     max_ranges = MTE_MAX_RANGES;
> > +     /* Skip the leading bit indicating the inline case. */
> > +     mte_bitmap_read(bitmap, &bit_pos, 1);
> > +     largest_idx =
> > +             mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_LARGEST_IDX);
>
> Nit: really no need to split the line - we're OK with 100-chars per
> line now.

That's true, but I am relying on clang-format here (maybe we should
extend the limit in .clang-format?)

