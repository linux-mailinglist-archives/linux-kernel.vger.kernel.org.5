Return-Path: <linux-kernel+bounces-120218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F888D48F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E351C243DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDE18B1A;
	Wed, 27 Mar 2024 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVgKszvn"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EE107B3;
	Wed, 27 Mar 2024 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506758; cv=none; b=PNmQis6r+Ath9bEMa/H37xzdFfAf/TbVn7Bib2nE4TxA1pxRq4IqyoE4/VIKizYbnqzQsnUDIGLtrls65uVMlT9xW2TFgKVQiyfDx7pc0pea1Ilv7YyzqpAUZRjWJ7Y5MIRU8gBAwMzfyQrhOeFG5ibvkSfG+s0QtfGFoGsdUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506758; c=relaxed/simple;
	bh=K2zdk+IPiJCuMUqRfK86wOdEpvaU9O1xQxihU+RkeVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsxu/DlEjTBkTvDqTFljjMiTP6y2DKLZEakSR+CWjDdIuxhSlFPUO+PCoGOSjWd1bBnkkvjsnJFbowX6F7WI4U5p9ph7ei6qQ6hbdcp11Jlbu8OplrJq02vI/aV5xGH8xgpMLILQkjwwghez9GF39mdpLLDLPIGUBvcEz0ukPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVgKszvn; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6962a97752eso44692906d6.2;
        Tue, 26 Mar 2024 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506756; x=1712111556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2zdk+IPiJCuMUqRfK86wOdEpvaU9O1xQxihU+RkeVY=;
        b=TVgKszvnEwkK4xaNJ2z6wy+dxpxjh1y033vpxf9VzN01tRhFUpao2yHRluJFlibmv+
         iGFZITi9iYeeu1Yre6F913cTe6Bps7bMwkPLls0jDQ9G0XZzMvscJfmVFgN9gSPmhDi9
         QxE75xqubCNKI2BYysyX2ztDBYUjs0/7v4z8IK4luv11CVqbYZSZHpDrXqH6yCgyPpQE
         fKW+XuoOLEOPvsEalgisT1CiSr8hdeYyNlBmVHEayYhbpIv8NQEViC79B/kYi2mXNHUb
         C7RpcUhZJPNH55GDln2czATwMv0gnV8gvddZsKLn1Gn/a1lJMbdUmfXtMaaLYV1g8GX2
         JHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506756; x=1712111556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2zdk+IPiJCuMUqRfK86wOdEpvaU9O1xQxihU+RkeVY=;
        b=kqs7NwJf3BbkEd19Yvxk5a2brlN3htpfrnycYFciRpGqQVFPB+68fvOjnnDrrdAK5X
         ovRPX0SZUwokZUOYCl3cZidTopCRe+hvSr9BU0Rg1mmmsoWPtLn7YciUMSR51usJ8hr2
         e20Umi3DLF1YKcOuPkz9m1wLaQ36DVwuUP78lRoXUZNWV0qPdYno2RkAopi4odG38yXn
         VlrI6QpwvPjLhn1ADk9CbrBGKrMuvzTdPkONJtdJk3RZ8voTrNIL1tLR4tJbLmyUNzoo
         Lqr9/r022/OQPDAMQHZUkBxPoaceGLdCTISxgNLcD8trPzC7tlYDoC/oZ7FOHNCKESva
         y7aw==
X-Forwarded-Encrypted: i=1; AJvYcCXO4grYjvavAKYzBoZbPojHjIbAca2NcsLT2xaHJ7fhUCCr8e+ZaYSCKTcps4XcXkffNkcrnFSMJLyVlSX2Ra0jAWU/yKidF3pRG+nSUIrMlcTJwG0m/S7ZmmhwX5ztPqbogECcSlitq9K1U6E=
X-Gm-Message-State: AOJu0YwFfgCZ2Ts26bTudmpfWcgAX2AmuwJvzR6H4nwDsRlY0Zigdgrm
	n8yimCbUyVip+1Fffg2PMCQcunBAi9nq/dHyzWJYAmHXtvjk9TbEGyzliIwTYgQ9n0zDhk6a0Ok
	uRVL+RSnK0zDTgvVzMoo41c/sibQ=
X-Google-Smtp-Source: AGHT+IG9bdk0altQ73disy5xzFgfBLXIJT1ZVEYAT5esSV5eomchNp8U3pOZcSz1TRckyBVygNVmvFthcdBh7JcwP20=
X-Received: by 2002:a05:6214:2b0c:b0:696:4855:cf18 with SMTP id
 jx12-20020a0562142b0c00b006964855cf18mr11842065qvb.43.1711506756022; Tue, 26
 Mar 2024 19:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326120345.68786-1-zhuxiaohui.400@bytedance.com> <wor6mzq6nxhochp2bi42ece3hh6pywnt5lz2jacto4ns6lysj7@bc6crgl44rdu>
In-Reply-To: <wor6mzq6nxhochp2bi42ece3hh6pywnt5lz2jacto4ns6lysj7@bc6crgl44rdu>
From: xiaohui zhu <zhuxiaohui400@gmail.com>
Date: Wed, 27 Mar 2024 10:32:24 +0800
Message-ID: <CALqu+RjkS0=uO9WERLfBe2Ur-49Zz-ROsemYxTMFmsuB=nwy1Q@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: add REQ_SYNC and REQ_IDLE in write dio
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhuxiaohui <zhuxiaohui.400@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for your patience and explanation, that seems a interesting issue

