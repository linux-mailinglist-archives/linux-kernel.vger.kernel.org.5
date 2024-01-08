Return-Path: <linux-kernel+bounces-19657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1014827073
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA5281706
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37024644A;
	Mon,  8 Jan 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8QE47wY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A945976
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbb7d80df8so1470990a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722309; x=1705327109; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Uald3hXpkL6rERFfHLnDIIjZwOssqnYWQuwEAP/E4=;
        b=I8QE47wY4luLEhZXrCHmrx4w5RFvHi2iKi6U3koZdKcCTY1KdIt0mUCIuto1orl1du
         Lnv9cvnFxJCBkDKYTLzcxNpyEZnhjYPs3629z8Id4umSVy0Ulom+ZN1xsanEqFW10Umr
         7E3mnI61lBxm/yotrjmR9b5VW2eM5vJV/ogt/4xN1qoX8Ud7Mf1tITL962m/WgK/l8b4
         85lT5S2amVtC3AX2n7TSrUyHFG/sHE48HCk8pRdDvGT0VwxCKRhs30AOBZBGjh7RVgkU
         nlwzLrMQuyPmYnYKT55xX0+zoula89W5P90XKNYR99pu79EwGU/Y+TkmW5FdZqEL+az9
         AcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722309; x=1705327109;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+Uald3hXpkL6rERFfHLnDIIjZwOssqnYWQuwEAP/E4=;
        b=R1p/dbv084ljYFLEdPRQ1CXgVDH6xJbGgwmBy1JP21G0NArRCLs0RG5j/8lzwsgKdg
         0nmD9+hIfRrqUoNcLfM3x9X9GoRiAWM0WYrDQXIznbDvXyamT+sn7N+7Q0q/ceYJhVPe
         pjDodpF+ErmZVpbv2WwYDnrPc05sRfE3sOEPJYFDfg9HlfM7EZm5lktLU3bO9TpppAi2
         KCCzAgm+0vrWQEY2IMuJyeK9oGxdGj2kluc6AoSh7to0QO2i15rnGMRy+oR8NlIz4eNJ
         WEXtToIyMzibXAnwg1T/6rM5JsmmK1HRUDpQtYZ3/sLsXd2K8FAYCDhvayu7PNhnEwhM
         x36g==
X-Gm-Message-State: AOJu0Yx5k6sepeiSFk6HW63OjPXlVQr71bi4m2X1ZF7HAjFRys+77wye
	QaSOuWDx4CNyRZgnXv8QDg==
X-Google-Smtp-Source: AGHT+IFWxLsq/+3FcSyAZ71H28oAZdrAlpYXB16Ykt3JZdH0QAxj5J8r97on44B0UEbsnFx0l+XDgg==
X-Received: by 2002:a9d:590a:0:b0:6db:fe20:fc1c with SMTP id t10-20020a9d590a000000b006dbfe20fc1cmr2782711oth.63.1704722308724;
        Mon, 08 Jan 2024 05:58:28 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.73])
        by smtp.gmail.com with ESMTPSA id b19-20020a9d5d13000000b006ddbfc37c87sm899909oti.49.2024.01.08.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:58:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:876e:4000:b2cc:9ba1])
	by serve.minyard.net (Postfix) with ESMTPSA id 60BE41800BF;
	Mon,  8 Jan 2024 13:58:27 +0000 (UTC)
Date: Mon, 8 Jan 2024 07:58:26 -0600
From: Corey Minyard <minyard@acm.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.8
Message-ID: <ZZv/gs97F3xQwOGQ@mail.minyard.net>
Reply-To: minyard@acm.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.8-1

for you to fetch changes up to 9bd9fbd9032a3b7e9ea916d6e58ba0116e0621be:

  ipmi: Remove usage of the deprecated ida_simple_xx() API (2023-12-19 06:33:45 -0600)

----------------------------------------------------------------
IPMI: Some small fixes

Nothing big, just aligning things with some changes.

----------------------------------------------------------------
Christophe JAILLET (1):
      ipmi: Remove usage of the deprecated ida_simple_xx() API

Emilio Perez (1):
      ipmi: Use regspacings passed as a module parameter

Rob Herring (1):
      ipmi: si: Use device_get_match_data()

 drivers/char/ipmi/ipmi_msghandler.c  |  4 ++--
 drivers/char/ipmi/ipmi_si_hardcode.c |  2 +-
 drivers/char/ipmi/ipmi_si_platform.c | 12 ++++--------
 3 files changed, 7 insertions(+), 11 deletions(-)


