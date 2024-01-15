Return-Path: <linux-kernel+bounces-25574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A1D82D2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15361F210D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33E3D8E;
	Mon, 15 Jan 2024 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQgjgKcb"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A436AA4;
	Mon, 15 Jan 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd7c15a745so303924b6e.2;
        Sun, 14 Jan 2024 16:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279848; x=1705884648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eW8RN7A3SvV8/GoRhnzwM9t4e+MIpt3wvyYqQPSvIo=;
        b=kQgjgKcbZOW517br8OlFUZ+UCr0vTJQD0pE9j+HNfEoPovv/XzImM0rHMvJoq65Mxl
         w28V8k2/hFg6AwRmHZRqdrft/ardtma8FdnFexfYivkkwCLjjrmkSGI/xfpliX7nBNV5
         JrzWiqpTwd8NdInJOkM5wb45UvykAuGRVsJFLQPB68/YztzSH017QKkzBwQJpIKQPndY
         579FMjryprGr/v3mUWJy0qFv1QH0TfT4QsA7B/fhgRk/XuVvHDtry/KC0QCTxsFSwYjQ
         /YzjZ7ZKx9VdMlw+41ufMpNZ5bD1mbjsMp6EitTV/CLWkQxC0EDu9fDqli+o64SiGwDr
         fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279848; x=1705884648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eW8RN7A3SvV8/GoRhnzwM9t4e+MIpt3wvyYqQPSvIo=;
        b=do/pG018a1lnM3XSRAnfUjjyDyBCE9yAWlgnsM3PcpSoGqUgPa/NDQQPSFmeb5EnbH
         8xjWnwH867Al26bihwgmrNNfe0RUmkhT0Mm3Q6BXs2a9No7EWmbFqf/g9WIpU/Sqrh92
         y7JIgHxXpk1xzEUXfLiCrvxdfWspqVFuP81fH+eklWX5JW7jZ3UoaNp5Y2+o9efIGbnG
         wRNIH7wBjR0Uh5huf9p/smTC5y3bZ60KX29Wu2cQ4Vq8IqtXt7YbXttGyfAkIHdPp5iI
         xjcrr0+mV97S/nHrPJ+obv4epqxQVe9IhR+Uamwvvj/Ty42I0MPN0LgZbZnW/voZiy8C
         z+tA==
X-Gm-Message-State: AOJu0Yx0VJS/kA1ZEvYrmK0/oJyS/vTPiSOYmkqMyS+7vIZuHly6UTQX
	L6WFHFchjm+qWAWYKPGufur4TQLvU6g3Ig==
X-Google-Smtp-Source: AGHT+IH64aw0gyf05YyzW2NTTWATWT0U5XUetej+yejvQN2zs/duC1Ed49DUXWUK6dql2zMKfayPqA==
X-Received: by 2002:a05:6808:150c:b0:3bd:46b6:45b with SMTP id u12-20020a056808150c00b003bd46b6045bmr6285952oiw.0.1705279848550;
        Sun, 14 Jan 2024 16:50:48 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:50:48 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 9/9] Documentation: gpio: move gpio-mockup into obsolete section
Date: Mon, 15 Jan 2024 08:48:47 +0800
Message-Id: <20240115004847.22369-10-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio-mockup has been obsoleted by the gpio-sim, so relocate its
documentation into the obsolete section of the admin-guide book.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/index.rst    | 1 -
 Documentation/admin-guide/gpio/obsolete.rst | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index 3f6d5a76702b..460afd29617e 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -9,7 +9,6 @@ GPIO
 
     Character Device Userspace API <../../userspace-api/gpio/chardev>
     gpio-aggregator
-    gpio-mockup
     gpio-sim
     Obsolete APIs <obsolete>
 
diff --git a/Documentation/admin-guide/gpio/obsolete.rst b/Documentation/admin-guide/gpio/obsolete.rst
index 5926e5440207..5adbff02d61f 100644
--- a/Documentation/admin-guide/gpio/obsolete.rst
+++ b/Documentation/admin-guide/gpio/obsolete.rst
@@ -9,4 +9,5 @@ Obsolete GPIO APIs
 
     Character Device Userspace API (v1) <../../userspace-api/gpio/chardev_v1>
     Sysfs Interface <../../userspace-api/gpio/sysfs>
+    Mockup Testing Module <gpio-mockup>
 
-- 
2.39.2


