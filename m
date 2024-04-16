Return-Path: <linux-kernel+bounces-146896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFA8A6C99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097C61C21CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD812D218;
	Tue, 16 Apr 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="WNo0Op25"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FE12C53B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274487; cv=none; b=pRrNtflvNDVSO6Hh93lG7pWZ2mkgTY5kP/J+7kwcHuJ2xJ9R4poq33nwx6xjLiLC3KFupt4dyOkrE5cFs1qoNhxwf0AKS4n+NNV3n3bBnScthDb8bymGYlkH3mS1/plzH7+uqG1m0YPnqzD5X/ZEJWdp2cM4xj+NvNhGXxF9dZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274487; c=relaxed/simple;
	bh=x1iSeR8brmhtLjIDUSCjuInatEabzV1f+Dkph9dhVIc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GQJp17T8tDOjq+MTGc8HQkJP6JmYHwOMc2UgI+pn4s8ReVdXVfoL5JaNssTpT/MIIIhMwWowkhA7t8JoMDBhqFn5hxQtB0CoyhH++WSK0Uf2pegjNwe3OlOTH5CNXWt45hpsUugqMyTHikYUEwLjXskN50mt3mThthV4+iHVvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=WNo0Op25; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346b146199eso3160299f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713274484; x=1713879284; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSpasVcLTZB70Sav5wxRhPBNp7m2qZ1ZQk9+abC0XXI=;
        b=WNo0Op25yxBxLlFmxe/ZYFLMfUZMJd4qgc9ltyCQCWjqClBqtBcn0N1/60mP4QhvEl
         70CSJt1aNqzcPjpeszb7NB9TQp31WPPZumM8WkXdnuxskr/7I9ogZHR6lRBPBf0N/0sk
         Nhl4PY8eNXhB2Lk9mrKaz4So9fHl9nGLl6wc/KfGA9/e9iA92sjAhNRUyg8MosqqoMbE
         dmFJ4jPbfZB1Tim3+FxSEwQW6d6Roh86pHOLbe15Ik64lyYOsn04ncCuhxWNE1lkxmFl
         xuxFlRB7je3eGnkWJ12PwA6/OVy8zYVUJUBFW89dMNw1ac9Rqa9WfLtzfn141gqSA+A0
         uSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274484; x=1713879284;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSpasVcLTZB70Sav5wxRhPBNp7m2qZ1ZQk9+abC0XXI=;
        b=E5MWDA659fXtysgfAVZdOlyxTAhJzJJstbrS8i9jQYFPjiGaHV8u6cI4w/WoqgIvM2
         NnwWk3s3rhbbvcA3gR3ict+6n8ZUUSIczfNscylr793yjWsiVqdKCN2ykA6AWsDt32x/
         nxkHqYfbMcV5D4B7vG4Gi7Nfb5/N+SQHsV5o5t7ejplyQmrHzdwdV/6uZw+BNU/Zo0Ie
         sfmJpmMLX6pPCrDpd0XmFtoN5sxzOy20QCTb/uRbGZczjiq2kCSbrU3ymoR+laiF1uXZ
         58PIABpelz3QFBZ94vRlA8Cu60B/v+gl7CY6KpqssPbKf28ca4ZvF6lMjgz1uqX8myZX
         iQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWuDBR5ccD0N2FBXY2lW/hJS00dbU4qPvx20Hweby9+fcb1mxy4ATAia2UCfMBUMt4/alCfWCVdy+chHs47qQ9X/X+VBaupOGbKLJTB
X-Gm-Message-State: AOJu0Yyop0RwnsW49qEBZCestHclcyW0j6XPWQ+ruD3z1Ahn1Hg61Wop
	uPwaG/udkR/Z0sJAsmyRaRPBBnw7clOSILrntYPYt8T2MyPpatSV65ZZunGSsJI=
X-Google-Smtp-Source: AGHT+IG2BFHksEcDc+5L6w6uK4ftspfgtCi9JVkjGm6DVx45WYw2pXqKslICcbg8N7gyBUKyv+7rmQ==
X-Received: by 2002:adf:e750:0:b0:346:ab3c:1753 with SMTP id c16-20020adfe750000000b00346ab3c1753mr7580365wrn.40.1713274483759;
        Tue, 16 Apr 2024 06:34:43 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:2556:9555:6b40:d25d])
        by smtp.gmail.com with ESMTPSA id cs5-20020a056000088500b00343a0e2375esm14977447wrb.27.2024.04.16.06.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:34:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] m68k: bitops: Fix typo in comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zh5yQ6cIK3Rw7O-I@casper.infradead.org>
Date: Tue, 16 Apr 2024 15:34:32 +0200
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0F415CA-213F-4A0F-85EB-26BED1B128C1@toblux.com>
References: <20240416122155.313400-2-thorsten.blum@toblux.com>
 <Zh5yQ6cIK3Rw7O-I@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 16. Apr 2024, at 14:42, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Tue, Apr 16, 2024 at 02:21:56PM +0200, Thorsten Blum wrote:
>> s/Coldfire/ColdFire/
>=20
> do you have nothing better to do?
>=20
> Also, there are 37 lines with the word "Coldfire" in them, many =
visible
> to the user.  Why change just this one?

I only noticed the different spellings within the same comment while =
working on=20
something else. I neither checked the rest of the file nor any other =
files.

Feel free to ignore it.=

