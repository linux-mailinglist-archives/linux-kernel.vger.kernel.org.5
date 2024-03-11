Return-Path: <linux-kernel+bounces-98840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C7878021
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F16F1C2134D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F033FB35;
	Mon, 11 Mar 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFGxQY1E"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E43FB2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161034; cv=none; b=bKrk1Mki4llTnbEjyB26bup/gziiB0uDlxmUdCPisbZY2B42ka95DPpk3pywNSbPqQreleLVlHDJg4Ryy0mmFqwRS21rKkDaQCT108wIrnxaRVAmAWXrO1O871HZKNTPdqcMTUXTippRfn4R5VReeZrper21+pQMyNaU2BfwCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161034; c=relaxed/simple;
	bh=c6teFgXaY0Jm3WrdtjWiBdN7gpyKJTytiFlncrXD050=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kd5TkDcMj4eq1dzjbNZxGpd9nYSaKji+G7BP0iY5g1jw/n8qd5CMrk9hxE0u3wPGCFpjA83wjoF4bAmo2dm+kOr3GqBxA9bsLCkw+bI1H0ZIg+jorTbtJ1Ksdb3nOrnf0ZcjbkyHOGGQCGRuS7Go85FSX6lblp0QZAcYWJ4XL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFGxQY1E; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1ec2d05feso2026825b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710161032; x=1710765832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c6teFgXaY0Jm3WrdtjWiBdN7gpyKJTytiFlncrXD050=;
        b=IFGxQY1E+xcE4Cp4woB9KPLiQJA5p6RwOss2jh+k4rcxQANsbiB7hh4nlYk4amMEgD
         GzVrFLkZ/F+0ZypAwpgpNNvHgtYEtVFaMMmRQ4lvUS0fy/F6MccQOQZeVLi3996QWjqu
         ppIwC4g94jCveArascJWWC/Sht2fED2V3vikIbYlpa8Y5OJk4uP/XcKnuwWA3XLr8RFA
         I79mEUq2uG2HeGqoqc7bUd1cn0YxzEiBj5GfQDqzrhDDeh7dvlIcougjB9A1aSg9MGXG
         bJSIFKAv4Pcjz47rxDe5xDKizgMD5QXTBoYiS/nUJaaZrNR+i+ym9sWhkvRZgRv491ac
         pf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710161032; x=1710765832;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6teFgXaY0Jm3WrdtjWiBdN7gpyKJTytiFlncrXD050=;
        b=B0RfQv3QCOWDmlNjwpUAvIGhThfbxKuESPQs9Axeip7OevrgJUYf8pbzPXKO/QxbAY
         7K6QVL62Iu5mf0+2cgJoTejnPhVhyGfL7zmQnBUOuDjro3hdp5oOJlfvIw2Knnew/8nz
         fMrr7LX259D0NCH6TaYyrN1rOggUkZ+3AWOp6ZwtatHbwKpUhDffkf6GsIhKFiySGUUN
         e6TYvXc6QGspQhh67t5Y3fstqVvWVAVjnDK8U8DBJxPmKh9DchBq1In52gEdQaEo+/QH
         Zd0KG+bBrB5WpGLoGTOab+ztd0/mRtvCKGPa4Jt1DXOg4MF9uO8HUFbH06GDa6CjlCQo
         rKQA==
X-Gm-Message-State: AOJu0YzXu2a/rsdsyNVVsxgaBIsamcnsHNKhPhtwqgry4jhMFBFe+PuS
	1lb8i9Cb8rXXy5mEkcqh5Ro4uKCdor50N31HOdQQFbuvZv8W69VkaWUZ2n+4sc6VZYyC25F6q9U
	yfuvKU8fAadMwIKltLkueAdGbVJGNhtm/kHZCKQ==
X-Google-Smtp-Source: AGHT+IHT2gVYpwVlswu74w7UKaYIb8JujwzscCCMLUZdX+3cn6BOgroXi7H/6GZSCDeKPsPni0/dKFynpwZ05ufwdC0=
X-Received: by 2002:a05:6808:6541:b0:3c2:503c:60fa with SMTP id
 fn1-20020a056808654100b003c2503c60famr462697oib.12.1710161031853; Mon, 11 Mar
 2024 05:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roman Lozko <lozko.roma@gmail.com>
Date: Mon, 11 Mar 2024 13:43:40 +0100
Message-ID: <CAEhC_Bm+CRyVuBmZC+2uJjkcopaLsWyJhfoQNPshs5nuE5FGrQ@mail.gmail.com>
Subject: What is the current status of Intel Thread Director support?
To: ricardo.neri-calderon@linux.intel.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

May I ask you what happened with the "sched: Introduce IPC classes for
load balance" patch series?
As I understand, it is still not merged, which means that mainline
Linux still does not support Thread Director? If so, are there plans
to support it?

Regards,
Roman Lozko

