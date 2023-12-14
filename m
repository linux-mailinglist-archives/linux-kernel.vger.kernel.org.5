Return-Path: <linux-kernel+bounces-52-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEC2813B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F99B1F2248E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0C6A02E;
	Thu, 14 Dec 2023 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGkY0jRE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D243399F;
	Thu, 14 Dec 2023 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55276a725a1so1243687a12.0;
        Thu, 14 Dec 2023 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702584643; x=1703189443; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oXRGDVWxX94OsNcmHPdKQjnC3+bMi5ycVcH7pTv09CQ=;
        b=ZGkY0jREStQgv+AbB43rWlLywLyWnvYrRVxP0VSUojx2StfNJnBQxzrnVG26YuGim3
         llSxc1RxSveXgKRAwytugwpD5zBtMCLVhRWOXdTVdh46CzxLH0SCwNlkIAiX/0aAHhYD
         7N4KUfaon1J8hwvwSSuBBnLlYrFoB47SM5gQQKxQBLtWaE0kX/NTmtbEqrNy7d0oCPym
         0kJ3Qa9MEZsfuFFbengZ3Iv78g6rK0PUe1Qa6fbgHwxLILeth5RDUvMQ1i6G1hYqZ0SM
         rscDQg0KcC3vB+Zg/3byfA3vDfRERitqOlsOHw6Kyb1NLvGPd5Sat83HUwrN98W2R9h7
         oOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584643; x=1703189443;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXRGDVWxX94OsNcmHPdKQjnC3+bMi5ycVcH7pTv09CQ=;
        b=HUdQcMNdv4cMB9cXTe5dmNWJKse5294D0QX5q1YzQtKWh6qhUm83AdUvlQg3Dnss+r
         LxoGK7L3U5BWJRFC/sq6/qbLZq5ZGYMsDWDvDbBQaE449X7gXJ3RJSGIehxrebbFXo4N
         zC6U52zdzLIvHvgprcT/BGBuAuvlfqeprJ8dhUAhHEZdslr8bsUnc79adBo4a6nA4egE
         4AE+BCNbfBNPEmHcpS+OxiwaXft+Vb8MGpgsye5PcM/swGjIZ4xobbNlpw8LLb5xJGbS
         yftnwudE3OWM81Q4yvhipZfH61e1W5yw4hcHhDQkkJLhlbjl2woqNNYRJTiVSZg66nkm
         SMNg==
X-Gm-Message-State: AOJu0YxnCNsD6rPZBuQ/fZps9ZYM/BASiFaJL0xhuZnoqndbCwL4gW1h
	xIQej7XXC394KfxGCewi95VrMl3fMYtEKQ==
X-Google-Smtp-Source: AGHT+IEE+Y27j8Yq29Aaq7kM2wmUQ92wVbZ801T2cr9y6J280DhLnL3ei/WWC+u7waVnxt73X8YOcg==
X-Received: by 2002:a17:906:13:b0:a23:100a:b3a2 with SMTP id 19-20020a170906001300b00a23100ab3a2mr782402eja.123.1702584643163;
        Thu, 14 Dec 2023 12:10:43 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ub26-20020a170907c81a00b00a1c96e987c4sm9928723ejc.101.2023.12.14.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:10:42 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4B388BE2DE0; Thu, 14 Dec 2023 21:10:41 +0100 (CET)
Date: Thu, 14 Dec 2023 21:10:41 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: make deb-pkg: Does not strip debug symbols when compressing modules
Message-ID: <ZXthQYablvopq0su@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

When using (only tested with XZ compression, but the others should
behave similarly) CONFIG_MODULE_COMPRESS_XZ=y to compress the modules,
it looks that the debug symbols are not striped.

Building with the attached test configuration results in packages:

-rw-r--r-- 1 build build  8.9M Dec 14 20:47 linux-headers-6.7.0-rc5+_6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb
-rw-r--r-- 1 build build   75M Dec 14 20:48 linux-image-6.7.0-rc5+-dbg_6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb
-rw-r--r-- 1 build build 1014M Dec 14 20:47 linux-image-6.7.0-rc5+_6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb
-rw-r--r-- 1 build build  1.3M Dec 14 20:47 linux-libc-dev_6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb

This is odd, the linux-image-6.7.0-rc5+ package has a size of almost
1G and the modules are not stripped.

Switching the values instread to 

CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_XZ is not set

the packages are again produced correctly:

-rw-r--r-- 1 build build 8.9M Dec 14 20:59 linux-headers-6.7.0-rc5+_6.7.0-rc5-00042-g88035e5694a8-2_amd64.deb
-rw-r--r-- 1 build build 819M Dec 14 21:00 linux-image-6.7.0-rc5+-dbg_6.7.0-rc5-00042-g88035e5694a8-2_amd64.deb
-rw-r--r-- 1 build build  73M Dec 14 20:59 linux-image-6.7.0-rc5+_6.7.0-rc5-00042-g88035e5694a8-2_amd64.deb
-rw-r--r-- 1 build build 1.3M Dec 14 20:59 linux-libc-dev_6.7.0-rc5-00042-g88035e5694a8-2_amd64.deb

Regards,
Salvatore

