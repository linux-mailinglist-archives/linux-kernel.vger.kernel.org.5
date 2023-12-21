Return-Path: <linux-kernel+bounces-8098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD781B22A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40A61F242DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754184CB49;
	Thu, 21 Dec 2023 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXMS0BDo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FF4C633;
	Thu, 21 Dec 2023 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9344f30caso403053b3a.1;
        Thu, 21 Dec 2023 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150067; x=1703754867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpM0Z2D2mYaMGglDthssKKX4CJJJdWWJEe+BrNFWG04=;
        b=cXMS0BDo7xwcDno6R8XiPO9zHyITxGIt6RdLIanncqf0JMLOMVitOemI3jsFaMLvpK
         qpVv45hWykCAru9R4Ky7/gB0Cwpbs0FP9cf0jrYSgxiqWczpjHbGkn1HqfMQqizrbaAy
         IbrsgOlbRp6G9WibNZe15tfadXFt1fZYBjUdjABK7M/kHC/iP1Ah4KLRBJlzki/CYAEM
         Q55IWHYovPvrdoTVUVzQbz44Z/4WAZ/sqom5WlPIXZMlKMeVJezH8EXAa73xcIbvYEzc
         7AFnazU394Iwsr0wxNuhPNB0QDKRUCcfRcAnOBTN450DM9cQeZbdp8uK8gZ6Um7ZDeKB
         L8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150067; x=1703754867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpM0Z2D2mYaMGglDthssKKX4CJJJdWWJEe+BrNFWG04=;
        b=d6m+fJuTi/f7AnPchWJSzZkyobYFhT2jku5Fdq5FhcPg0qcMGrH1gOOEq+YH0mSXRn
         Hvp65So78X5zxri0gJS09cD1K3qKsgFdJp6b8kW6vF3YMgh+W76+loOYq9+173zuFKoF
         80Aj4mUiQj2N+CdOmG9euFpVmzTf1G0OfR0oj91lXERiE8GkD8QY0JjsmvcHE1PQsFlN
         WpTpyFadUSCTXIJE21Hj7yX9aeYsYe7N+rkghTZBWWYbeMinNhoQ18O6k/YyxVxZA+cn
         HNEZJKtpFkHnux81afNsNH3ZY9sD54v3vTzCD/WXoTnuyx+dZOcC9H6F5R6YZRpBkqwX
         zSqg==
X-Gm-Message-State: AOJu0YxJN65KlI+tjlZ1cZ4Xjmhhca9c8PAxc+TiFiaXgL9oLnMpv38I
	zDW/m2GTjYwSbr2vu2LBulWJmHoTidF/Fw==
X-Google-Smtp-Source: AGHT+IFQXdl0RjGZTlB5jmDPkfX0BWQWHQ+sBnyJyt3Ua+QbdBjJ8SabKIuWddwZBYLfgVt6IxZY3g==
X-Received: by 2002:a05:6a00:1d09:b0:6ce:63d8:3b61 with SMTP id a9-20020a056a001d0900b006ce63d83b61mr524344pfx.26.1703150066789;
        Thu, 21 Dec 2023 01:14:26 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006cde2090154sm1105566pfj.218.2023.12.21.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:14:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C2D2D102429E4; Thu, 21 Dec 2023 16:14:22 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Karsten Keil <keil@b1-systems.de>,
	YouHong Li <liyouhong@kylinos.cn>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net 0/2] ISDN/mISDN maintenanceship cleanup
Date: Thu, 21 Dec 2023 16:14:17 +0700
Message-ID: <20231221091419.11764-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I'm looking at simple typofix against ISDN subsystem [1], I find
out more about subsystem activity. It turns out that the subsystem
maintainer has been inactive since 3 years ago. And also, when I test
sending "Lorem ipsum" message to the subsystem mailing list, it gets
bounced.

Update MAINTAINERS to reflect above.

Bagas Sanjaya (2):
  MAINTAINERS: Remove Karsten Keil
  MAINTAINERS: Remove isdn4linux@listserv.isdn4linux.de mailing list

 CREDITS     | 4 ++++
 MAINTAINERS | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)


base-commit: b414020fed42b274946aae28becf45ff156bbd2e
-- 
An old man doll... just what I always wanted! - Clara


