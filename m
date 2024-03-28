Return-Path: <linux-kernel+bounces-123774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF51890D94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78603290736
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3C13AA3A;
	Thu, 28 Mar 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4afgPKn"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411E80639
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664812; cv=none; b=droxsOL7tXQjQ8LgWS8iuuC5IbS+Lmu3kIbs6rLw54nKH7ShfmKskSX5EVHoDpqn2G/2vuHYBtCoZHhTj11wTPhobEsWkvkq427bOCdv5cmjc2t33HALXStn7bi+rpE9gEj1I7Cz8tA2tvobWzpNaM1PxD8AYxlSF57llVOUDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664812; c=relaxed/simple;
	bh=f2KZPL3xcVNpG7J9pfI78XLVn960iQlBYAAkqRBmdFs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RqSe21D0h6WUf2m8ODoFbGxE2PD+q1JG/Fk73oovlSzpeFARGL1scr4HPWJw0cxYn1DoRFA8ScKM70zl+I7JDn5TSY+rW2saD39HJOb7x+dzzbMQtQVKtnOl5BzbeTLAMmi0G0e1kvcYdhgMxpp/6eMOnzVg39KHuSDkhKzsj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4afgPKn; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-368c13003eeso4251995ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664810; x=1712269610; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCGlANBlhtFgOS9gNA9KtfZG7bA9JbQQdS+5iDoE6gA=;
        b=a4afgPKnEQK8cxWIeqQuXa0+P6CiVQHCCV3jAMktWKXFJa5eZJGr6xnDLXyqO2M+dy
         y2WXvFqHDrMmieMg9ggFpyLhBC98vHliAomTAmCTfF4C4E9gu6+u+MJCPx0nL64pZn8q
         TusWdLIGjr1Ff5EtHAQR7hC0AJzl7LR6IRXdmcsmNNy/lm+/8RZq7AiCbgV39l5Sh6HC
         iVpqdFaLb2Gtnf/HgxuiTef3ioQwjZ/FQRqVuwgu9eRYT6O1S7ubcc71XaIrGH0tTVrL
         4CvEN7gK9A3jFbgfuwm96Yi/UxdqNyK4jtSIlEa5p+r4tPO+rvaTf3JesERv8qn7Pbla
         4DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664810; x=1712269610;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCGlANBlhtFgOS9gNA9KtfZG7bA9JbQQdS+5iDoE6gA=;
        b=iKrtwtHUFblF3Ead/anDzm1RSsObmAyAaBwG8Zboe6IMPT7pYhXN9qOws7lgy/JI4C
         KjIsadOB7OKVvN2wxM0hGofzi003cmCI2EhmDJG9NHLjEhse6eEpo360KlZVJtf1JF+g
         MBi5TIg2I1BLx2BQSAmIZ/c+lb/VxeqeJpvO28Zjkedt90YSEDSStmZCYFv1GxVQyQXd
         nTeOn+uawLDNjWeNGcDxsbDvV60Jf+gdMN4yFVQlwVYEXRQjev4HYX50UYGmuJE7s/43
         U8v3xRswegXx24fVzUk3A62A4/yOA9zj5Lkh/pnQUtLr+HBUEGBUTI5qpOm2OTRUhElR
         DUhg==
X-Forwarded-Encrypted: i=1; AJvYcCXS3GzD+MmU4zXIlQadsrnr3vddMOrSjN9r8HzXQtIm6csIYL3uF34ZRCAyC2Hw95c+yEgaNVWjGmlWqZKX7YgzK17HyGeFnpSuSzKX
X-Gm-Message-State: AOJu0YxYztu/ta0mU/iY3jq2ZgoeszSDVUqL1uFV+n+FmGrPgiP7l5zP
	ymgQ5wb7gKf7mMOkxF9kw5FsFS+uy4VkhnIyKd4Pmq496QxD4N2w
X-Google-Smtp-Source: AGHT+IH2qqVQmRhKzSoKucyp6jbEq9qiSNnOHg2T2rWIs14uYn6qdOtF+yKO6Y7q4oywqwXTHdjpEQ==
X-Received: by 2002:a05:6e02:20ec:b0:366:468b:3e26 with SMTP id q12-20020a056e0220ec00b00366468b3e26mr466153ilv.28.1711664810046;
        Thu, 28 Mar 2024 15:26:50 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.124])
        by smtp.gmail.com with ESMTPSA id t62-20020a632d41000000b005dc85821c80sm1767676pgt.12.2024.03.28.15.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:26:49 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:26:47 -0600
From: TaheraFahimi <fahimitahera@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH] staging: gdm724x: Align descendant argument to the open
 parenthesis
Message-ID: <ZgXupx0nXwIOjy7F@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mute the following checkpatch error:
	CHECK: Alignment should match open parenthesis

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 15c246d3b1a3..bd80cd48fb44 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -272,8 +272,8 @@ int register_lte_tty_driver(void)
 	int ret;
 
 	for (i = 0; i < TTY_MAX_COUNT; i++) {
-		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
-				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
+						TTY_DRIVER_DYNAMIC_DEV);
 		if (IS_ERR(tty_driver))
 			return PTR_ERR(tty_driver);
 
-- 
2.34.1


