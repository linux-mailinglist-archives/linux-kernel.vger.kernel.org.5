Return-Path: <linux-kernel+bounces-25469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965882D0C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8EEB216CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5923D2;
	Sun, 14 Jan 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UflK5n/g"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F12100;
	Sun, 14 Jan 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-40e78238db9so964145e9.3;
        Sun, 14 Jan 2024 05:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705238497; x=1705843297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GomAbZrLbBtM8vyboZCJURUxBp78Y509pQ6wuZF3DIE=;
        b=UflK5n/geVxiNVCb4d5p0PzInLi2g50XB384VxOFQOI9etPvWECOoS6iYtIVpuF45m
         3vYGl1JJnb+jDF53MYicDBqDM/WRmStS7fZk494qa2JxXPdodKkYm44K3cneDt9ik1pa
         mrbnwU+nhtir8+DBtxYZEzPnHsOtBvktZ3M/dfHZM5xi7i4E0/5yyQFi0Bdv0i3yNWB/
         mnup9l3RNCd3OlYs4GHyodFsYRo7vq8UYTBZh40o5m6WFyyAG6a8K53YNMhNDZI7h9xk
         YvIKn8FiB+Gc+yH7PkcDy+/pPhHAa1XN9wzjYSirN04ynMGhY7NzyhLd/h0WOnBjhPTt
         MHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705238497; x=1705843297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GomAbZrLbBtM8vyboZCJURUxBp78Y509pQ6wuZF3DIE=;
        b=S/IT+NtHHK1hHsjfRG6mNGJL9H+jnE6Fn81mGB/9WJoYAHgXklrWBno+zXAyceLK1K
         t/yD3Pc5NxgY1VjdDnU2mWVOEY16iOrSUTjMB9FJ8aKpAoyh6DsHP4S4IzTYs0u1CvEp
         tHVqNctFzJScPDIhnSLCCJtXbS4XgmhLeVp97g0N77IjtrKGs/dpIK+0nImYHAm8nrsV
         hItFR+//c3uQF4ivI1Qw5raqS7tC3BGymKuqm0VIrKTDSgR4w/6qXahNZ/kI3bWCgNAN
         ZxNZgswpiML2E6k9kC/E23tKZUQ/9b+/QM3ACg7LMlnW5zXanqe5xD2wSjoqWDc3QQGu
         C6MA==
X-Gm-Message-State: AOJu0Yw2iVnFagsDbb57/Urs2AyQM4bTmc4FSdTJQKDpPmMwKBoTVAfy
	Ej5XnAXPr26kpQrRjHOIrus=
X-Google-Smtp-Source: AGHT+IHBKURrr+5ry2mYvwjRbWYEy0Fmj759JdqVweE4ix+TWDYp2mcDhJYO17mxIWWPnnvbZ+9b/A==
X-Received: by 2002:a7b:cbc7:0:b0:40e:6707:b758 with SMTP id n7-20020a7bcbc7000000b0040e6707b758mr1596211wmi.178.1705238496862;
        Sun, 14 Jan 2024 05:21:36 -0800 (PST)
Received: from ?IPV6:2a04:ee41:81:c881:98da:8231:7230:735c? ([2a04:ee41:81:c881:98da:8231:7230:735c])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709060d9b00b00a2c7d34157asm3770152eji.180.2024.01.14.05.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 05:21:36 -0800 (PST)
Message-ID: <a02e8fbb-8579-4cce-9868-73c8bbac4720@gmail.com>
Date: Sun, 14 Jan 2024 14:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: add recvmsg flags for own, local and remote
 traffic
To: Oliver Hartkopp <socketcan@hartkopp.net>, mkl@pengutronix.de,
 linux-can@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1cf96afe-6a27-4fd5-975e-96122f72df2e@gmail.com>
 <14e86ea6-e038-4702-957a-39af27bfc280@hartkopp.net>
Content-Language: en-US
From: Nicolas Maier <nicolas.maier.dev@gmail.com>
In-Reply-To: <14e86ea6-e038-4702-957a-39af27bfc280@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thanks a lot for the feedback!

On 08/01/2024 19:57, Oliver Hartkopp wrote:

> But in the first place I'm interested to know what the use-case for this 
> extension is.

My goal with this extension is to be able to implement a reliable
'CAN send' function in userspace which would check that the message has
been correctly transmitted, or retry if no confirmation was received
after a timeout (I am using a device which empties some TX buffer when
recovering from the Bus-Off state, therefore some messages will be lost,
which is why the reliability needs to be handled elsewhere). For this
purpose, knowing the origin of a received message is needed.

This was already possible with RAW sockets, and the goal here is to
provide the same information when using BCM sockets.

Best regards,
Nicolas


