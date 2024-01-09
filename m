Return-Path: <linux-kernel+bounces-21367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC3828E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20421F2156D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495F3D57C;
	Tue,  9 Jan 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZHdePyJv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC13D55C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A9DC3F62F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704830032;
	bh=Bq1omNw6f7jtSyxoxwHbRycz0j+0ZIPBs4sYsz2YZwo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=ZHdePyJvQeiMK6HZsQCD3nCeSDZ+GBv7eHlMqdiRSHsZV3wKIyV7CUiYV3dZ59XtV
	 pXor2OT0MQw5ARBNyp6SxHp03QG4FqIEjEm4BnSq6a57jYGTJv/wQH083FU1uCgSZQ
	 +L3jgbYWmIc1qW18F5ZlFfHLxgeYAqOr26tLkkqwFLomwDC3k4QCAhXZLibR5cUyU9
	 nv4cl+YiX6sj3NigcWvhuLSn8BXqfdvMEHTCYnFeTmwQfNUHtYDog7uTS/FPZ8NvM8
	 AqgGZulff+DSZZ4xviicZPUn0dinVU5zoRZO6FllVlm9j1x8jIeS1fMP70+lpIFfOu
	 1aOQg1BH32Mqw==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28cc1128ebfso3743089a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830030; x=1705434830;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq1omNw6f7jtSyxoxwHbRycz0j+0ZIPBs4sYsz2YZwo=;
        b=GSDKiiw5pc0rFJbvTvSnc1wjH0iBqgiNRXOMBnWFyrvm38AW9K5zchicnt9SDhbf6u
         7rGtvvOzAj6iwOOKaj3SXpHUhibE4eQLMB51iM/LiEBBC8O6Guhmttmj4ubqntohystr
         5fFsUJ+DCVJB/+PfTx9RZ7WwQWF0bl5l8t+6fyQmRoXW2i5Pp6cB34HUfQqq5v4dR+dO
         QvF+uLT7vfZjKuMI9cAZONFQCRpstsLilD5zKQRzmH77kZY7lg8V4qszaQY2Bo/+b9bL
         svoz4cBoGHGPxjLdBUtBLYFxhGHNgc5sXwGHrfUJ8679bgKsg/xoNpdpHpqRn6e5MPKl
         BTYA==
X-Gm-Message-State: AOJu0YyXY+owI+NrT8WjK8X2TM+2mVKCxPsw+2K7yR9C8QFieAycEWIn
	IuaTEZ9a5ZLhh61MxW6aTjurM7l7A44lSwakOWPs7Y+nB4F80QMyo+tclIu5PHZDMSCQ33QAxjB
	hq5gQbKLHQANEDgcw19WtVU3xbi5srudZiGGLMQ/UMmgUrcvQ
X-Received: by 2002:a17:90b:1086:b0:28d:2a42:3e72 with SMTP id gj6-20020a17090b108600b0028d2a423e72mr3339617pjb.0.1704830029997;
        Tue, 09 Jan 2024 11:53:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZMj4ykUd7cBvMtY3MpB0wxyu+uea0D0JtDy29mm4vM71UeiCez0ZTx6u/nIFLAC2pLVdQxQ==
X-Received: by 2002:a17:90b:1086:b0:28d:2a42:3e72 with SMTP id gj6-20020a17090b108600b0028d2a423e72mr3339605pjb.0.1704830029678;
        Tue, 09 Jan 2024 11:53:49 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090a520700b0028d22041d38sm2430307pjh.13.2024.01.09.11.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2024 11:53:49 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id D29365FF14; Tue,  9 Jan 2024 11:53:48 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CB9849F85F;
	Tue,  9 Jan 2024 11:53:48 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Aahil Awatramani <aahila@google.com>,
    David Dillow <dave@thedillows.org>,
    Mahesh Bandewar <maheshb@google.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State Machine to include a Collecting State.
In-reply-to: <ZZtwKFu4GQLQ5AXM@Laptop-X1>
References: <20240105000632.2484182-1-aahila@google.com> <11317.1704418732@famine> <ZZtwKFu4GQLQ5AXM@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 08 Jan 2024 11:46:48 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26172.1704830028.1@famine>
Date: Tue, 09 Jan 2024 11:53:48 -0800
Message-ID: <26173.1704830028@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Jan 04, 2024 at 05:38:52PM -0800, Jay Vosburgh wrote:
>> >+coupled_control
>> >+
>> >+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
>> >+    should have separate Collecting and Distributing states.
>> >+
>> >+    The default value is 1. This setting does not separate the Collecting
>> >+    and Distributing states, maintaining the bond in coupled control.
>> >+
>> 
>> 	Please reference the standard in the description; this is
>> implementing the independent control state machine per IEEE 802.1AX-2008
>> 5.4.15 in addition to the existing coupled control state machine.
>
>The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we should
>use IEEE 802.1AX-2020[2].
>
>[1] https://standards.ieee.org/ieee/802.1AX/4176/
>[2] https://standards.ieee.org/ieee/802.1AX/6768/

	I'm fine to still reference the 2008 (or 2014) standard even
though it's superseded; the 2020 standard is much more complicated, and
I find it harder to follow (particularly for the coupled / independent
control sections, the older standard explains them more clearly in my
reading).  Bonding does not implement any of the new things added for
the 2020 version, so we're not really missing anything.

	That said, as long as the citations are for the correct section
(the numbering is not consistent between versions) any version is
acceptable.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

