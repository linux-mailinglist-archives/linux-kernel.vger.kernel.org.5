Return-Path: <linux-kernel+bounces-10014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB981CEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA99CB2244E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DF2E403;
	Fri, 22 Dec 2023 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UxFSPYlW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD22C846
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso2417402a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703273661; x=1703878461; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eH7nfuydwx18BZVdknEjF/d+vyT018L8qna/6wtmdA8=;
        b=UxFSPYlWgkfXCa5WFIHexXoaugqCUs2oqPdje5UbxfpUMEg+P/uDQL8Sl5z2eddtzZ
         z1a66HDWcnYej6V2MzY85s1Y6nbc+M6jXfLD/MtH78o/i/NGP4bgWktNwb4O0R/7AIdQ
         CJc8vKzHnNr+zAl7AzzgKJUWRJl8+9T7Wgdfk+FsDIZfEq1SCkRnkFQ/SYG/iLRCVD1G
         KmRG4hzxV6t71vnP4Ggvl/3aHQlbrgXAH9NXUqUPzPve7M99b1XR+dYphcH/I5RJNRvQ
         BhOj4yMoDf6KNeMbdzsYdgadYqjwCQc5BXuFJiI6+rwaNQA2loLy3uwwHjUdyhGpJtlU
         y6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703273661; x=1703878461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eH7nfuydwx18BZVdknEjF/d+vyT018L8qna/6wtmdA8=;
        b=mIiqtt99acnvEUfJflLsR5pU4lWRqovXKdyge16Oeg4dgVIYr76iTeZjoiJ/Z85bqp
         A2uUmJQieCeTWPcywVT87c1qmyuqZgK/MhhAeI9Aq9gxQm+9zdX5iJN8DeEpnQ1bfJjn
         u34eEtORMSRS/QVD0/lndW8uaiddUPpyUxjGzexVeTDK0Nx/1fMTSkgPJ1o+DswCXnw/
         E3QOXQYOYQwRWQD+7Of+ezsqiPhHvQRUa7FR1A18H9+hu5XwPxWN+QydVywXHt81uJ4/
         FwAx0Th9DybV+in7HoMiAz1lODOhvISy1cWJi7AyGya/uMW00860xveFIeC/1Wr3eJw9
         7ZXg==
X-Gm-Message-State: AOJu0Yyv7Tj9tsYsnMmOasrA6bXN5qYcLM5TuoNlOVgJoqjj9eljGmx9
	soS+k4J0ZdWvU8JakOD5VxQp8mmtc2uJvA==
X-Google-Smtp-Source: AGHT+IHhF42mbtyj0pDN3BlmyVl9fPZZYr7ImiOtMRb58RUopOqEW6EcyeES6iB+J0Taz4Juw5YK0Q==
X-Received: by 2002:a17:906:74d0:b0:a23:619b:d320 with SMTP id z16-20020a17090674d000b00a23619bd320mr497055ejl.150.1703273660997;
        Fri, 22 Dec 2023 11:34:20 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906d20a00b00a1d9c81418esm2380572ejz.170.2023.12.22.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:34:20 -0800 (PST)
Date: Fri, 22 Dec 2023 20:34:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.8
Message-ID: <ZYXku6xHecwqwIse@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.8

====================================

- Prevent refcount warning from a code releasing a fwnode.

----------------------------------------------------------------
Herve Codina (1):
      lib/vsprintf: Fix %pfwf when current node refcount == 0

 lib/vsprintf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

