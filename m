Return-Path: <linux-kernel+bounces-13604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA38208B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D381C20F84
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7992D518;
	Sat, 30 Dec 2023 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="WzJblL9s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329CE57E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680a13af19bso7744376d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703976393; x=1704581193; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fZIH0cllwWP10xEZ7qclYaGxBZpXoISgRGheC+EsW2c=;
        b=WzJblL9s5WcFHtPruCmD8VKuI5L4zDuOBb3kc/ERqm55ISpz8zQTa3u1SWB+5TcE8P
         hM/6Fwey6xz7cOzWUax2Z+Bggizf+mmoUH+Qv/zQyFJEQ8boZDfRUMAAkPSy4k5zG+Bz
         9QPnpgIVcq9X2B2hPyhRMYtMTSrYiIq2eUBfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703976393; x=1704581193;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZIH0cllwWP10xEZ7qclYaGxBZpXoISgRGheC+EsW2c=;
        b=DN7d9r3arr3xH7vdpYk4i6XaogMdtXHQiT29kLI3IN7F23vMY4aWOF7GFojqX4IJc2
         uwaNKTQ1QlNyEhiVZcpJxht5LnjCuiNh7ynYsa6Jxh+P+4GDwvDgic9JBXO8BecqyUn+
         ONfV6e9eqyW5yh997BN3S+cwAfhbaDrxam5s5yXH5z8Z2qHwh5F4krdFu3aLXjcnrvX7
         WYIDVpM5o3GJEp6U06EcCxZbnPk/vnug3AHcTsYZdeq+WS+RFRZ+7lEfsehxVoMJrIX4
         4KdFWnFuPjBUQI0GOeJm3o9kqV8suCtZiXDOyrhYKMlGnjJN63y3MgDsnaOG+BxhnHYX
         wddQ==
X-Gm-Message-State: AOJu0YwZbngiUgVesFXsByBsBcM5rMhPDyZEqG11jh2BNfzX+e2wP+T2
	WKxH6XKWX1vMi5BrIRhsbby+BGbbB0s3EorAgzndZ87zR+uTvw==
X-Google-Smtp-Source: AGHT+IHJ9upV4SW2nHDVn+pdfd0Dmw6j+xR3o3cnnfx5doXDlyLXLFSm+v3OsxVzMPdKpASOiFCHCg==
X-Received: by 2002:a05:6214:1110:b0:680:1099:851f with SMTP id e16-20020a056214111000b006801099851fmr11210203qvs.83.1703976393569;
        Sat, 30 Dec 2023 14:46:33 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm8136440qvb.100.2023.12.30.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 14:46:33 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: luzmaximilian@gmail.com
Cc: corbet@lwn.net,
	hdegoede@redhat.com,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	markgross@kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: add fan speed monitoring driver for Surface devices
Date: Sat, 30 Dec 2023 17:46:30 -0500
Message-Id: <20231230224630.12618-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f564b1b4-d8d1-4809-9cc0-b01aa53570a0@gmail.com>
References: <f564b1b4-d8d1-4809-9cc0-b01aa53570a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> As far as I can see, linux/platform_device.h is not needed.

Correct, it's no longer necessary, I've removed it, thanks!

~Ivor

