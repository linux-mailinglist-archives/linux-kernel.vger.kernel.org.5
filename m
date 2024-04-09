Return-Path: <linux-kernel+bounces-137263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D489DF99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A672824A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C5137C21;
	Tue,  9 Apr 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjzMzTx8"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BD135A6C;
	Tue,  9 Apr 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677707; cv=none; b=qnB9QcQd9luUe2pDAAqcaappS61K2MugXiWueamM+7VQPtWVxrvIhNsoJZMaMjlW4BTFqJlgL6tWBUR556zKfAJIODmfGXVGbiNv2/D5rNR36stsQlxIXgyTmH1ZQXIA6NIKa1Qen7Ek7hh7ZzgjRL3irkQcJGbbSaC1MS2qaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677707; c=relaxed/simple;
	bh=eAvKh6eqc1wAK0+874dWwmF7seYGKqPybSL7QY7bLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbJw+2J5WgJc+iQRJaQ/oaWqQUbshILaL+xwOnTkkSXhYMlpN9ZDimnaEjd46X+f02/dFElSZStYgjnKikaLaE+UoiTHgOsGrIqmtKk8Opf0OUcg453scWS5C+yz+/hhlANObdglqLnVRrP4ra971u6imRcX1rcyIOFZ50z3560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjzMzTx8; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e3c4736d6dso1149045241.2;
        Tue, 09 Apr 2024 08:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712677705; x=1713282505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eAvKh6eqc1wAK0+874dWwmF7seYGKqPybSL7QY7bLNg=;
        b=BjzMzTx87/3YpS288k9v2S7RDYo/4j47YPreIAqjQ5F4wVbf0o3w/bgcDBLiEI6/8U
         4sKNNZl0WrbzVm/cnFXiaqSwnt+OhmwrOPeiZQE7jBD+XkNkqR63cpAMJZI6hm/f8P5m
         jO4MAn97DKWlgjns8vyWAPNn4HFS4UMFM65Bcnx7YD2/rsUMWm69ExLW084c+uBhsraG
         wPuQcDatVTaIZZ4uY2hRWfpwlkICpxwqz/1fgEmLH6hJEcydsai3etwFCtg7q6Oo6Z1G
         YC2CoxQTIss2qry5k4yIRigiBZU3dlnv1KRLYgBktO0GS9FTKfjpmzKXrjwBSaqZZEQt
         Uobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677705; x=1713282505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAvKh6eqc1wAK0+874dWwmF7seYGKqPybSL7QY7bLNg=;
        b=Pou9lvB8NWLuNOE8Ym6X5o9KMku3BC9g1U2JCP9tfrGchfI543+2dtOmrnduVnhkrs
         AF6zNVfPca0bZlQ9t2HWWSvz6f0RuUnnJ8TxnMUC/e2n2HE6X2lX8lQCcw1yCn1ryTZO
         v5Y0kY77gQuA0t7bKbatzHN+a9+SVqzNWU9Kc2TLfpOWfS9stDYjaw1ZQGUQHT0jFJK/
         LNgLgPSNYxcS0db7ah6k0Kk0/mplSNVkAuIup6ohkKxnxqh8EHpzXoBxOqLDhqj/a3A9
         FaemgOItbnpwal4Z0N1rZhA6+vheQMmVz8/fxiAg4u7Rzq1AsWPT/Q4qNca/Jp0Yw7Er
         Yy4g==
X-Forwarded-Encrypted: i=1; AJvYcCULguOf1+HQgSAXO0CQN/Rv+lTq0qbmW2omjT07hxExGE6IGLJD97tzQ1C/5kBwOWXpufd8wR8YE/uVcIYcbvgUN6Kdn6Vrbdax8a0kNx2FnLwn0mvsz7j4p+rw3Z8H0+4wcwbZiiA6I2OS
X-Gm-Message-State: AOJu0YwjEGJDRIab+n3vcwMGrGY+rVmCSW2ktsd3vqJgnIYv3fPSmozS
	BDeHI3ftbR/zySeZExXtGFOC0Ea01UEbgIa+bkylSsvJiDVh23yRvFi4wVSEYjUV8Ne3M48hrIJ
	QTPPiF7rET4/af51H3YDyPpAPOiM=
X-Google-Smtp-Source: AGHT+IFS2mvcddKNspVYdssJARe9I7BdEwwxCNlX1LVamupkex1tiGvtbAsY8MM0xLcMmRQFzdfoDyuUwwm6kV4/T+A=
X-Received: by 2002:a05:6122:2016:b0:4da:a82e:95f5 with SMTP id
 l22-20020a056122201600b004daa82e95f5mr284978vkd.5.1712677704783; Tue, 09 Apr
 2024 08:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403161559.19970-1-apais@linux.microsoft.com> <3358869b-db3a-40f3-b02b-4f1b46d5d724@kernel.org>
In-Reply-To: <3358869b-db3a-40f3-b02b-4f1b46d5d724@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 9 Apr 2024 08:48:12 -0700
Message-ID: <CAOMdWS+fq=hW0MpcCKYrJ5tYHBqVDPRu85cfpH215RwJWQz_HQ@mail.gmail.com>
Subject: Re: [PATCH] tty: Convert from tasklet to BH workqueue
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org, tj@kernel.org, 
	keescook@chromium.org, gregkh@linuxfoundation.org, richard.genoud@gmail.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The only generic interface to execute asynchronously in the BH context is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > behaves similarly to regular workqueues except that the queued work items
> > are executed in the BH context.
> >
> > This patch converts drivers/tty/* from tasklet to BH workqueue.
>
> Quickly looking into the changes, could you also elaborate why not to
> convert most (all?) of them to (non-BH) wq? Or threaded IRQs. Much of
> the code comes from the pre-WQ era.
>

 You are right. The idea I had was to convert every instance of tasklet to
bh workqueues in the kernel. I will send out a v2, which will use
threaded IRQ's.

Thanks.

