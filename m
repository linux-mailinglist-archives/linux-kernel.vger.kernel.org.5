Return-Path: <linux-kernel+bounces-8100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C48181B22F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF80C1F251C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA94D11E;
	Thu, 21 Dec 2023 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNQeE0UO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17E4C627;
	Thu, 21 Dec 2023 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso553426b3a.2;
        Thu, 21 Dec 2023 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150068; x=1703754868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CGjWDSkysFv97HHQzfjDPfqf3VPoMwSFXyDdvLi7BM=;
        b=PNQeE0UO6RH6pxi72Ll70GvxrrKAN4swtZANRXQmzlLObUht/7TCpyuOt0B9Qqswyx
         CctTkh9xVt2y6GWdBRKxjz/+wffEf9EbRaTgsimePIxE4N74MNmZGwteeAulHv6NjoHy
         aSRD7BXyzDI+G5krtcwGPBWJJZuBt3WdwfUgDLqV2/CpNkWMVh8tPRNEYODzn0KiDwv0
         1PF6XiQ/hWBo+YqTJUOQXo/ew44OoIzIRa/GTWJwItj/Eb30Ud/H0tA6FWHKcdRNk8Gi
         ASu03ckNIJ7PZeangNub7O8Y91LvYJHSNQErkRf8QCy3wnG+kjqWKNOvB2gzsq1Yh3X8
         VAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150068; x=1703754868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CGjWDSkysFv97HHQzfjDPfqf3VPoMwSFXyDdvLi7BM=;
        b=btU/gWM5hrySGUx7fdht0k6UaF4kDc6yh8R71PAT72n5GDooiBU6eUfWREqrCVJDwS
         hyfo94ldGlNjeX+WVMlGqGdCFE/L2kfggIannPPIU6oil84/GlFdqF0l/xm/7OEJ03VP
         +s0Mm2a/nhlY4l2nvEiRcCfPDmIu0wvnmRe0BBDwuaVv61tEhxOR7O9o5gMspzDC1xXJ
         ohiwN1fcFMpr/UoNC6pAtFDnSxXfkeqoGnvnDEYMSMJ6GO3uHSYIox8MUQ/eE4osiDMq
         ZmiGg30BBmE88f0mAkuluz82FwrD1eBqLpfjyTMm7AB95s3Q/DEKytTeI/4EgwVvELTy
         3S/Q==
X-Gm-Message-State: AOJu0Yyr/Uu0zp8pJLUVMrmAVPa1IHUN87UiIA9U0TUTmSBL09wojObw
	BZZNPzeDA3/+seOc1POpYwg=
X-Google-Smtp-Source: AGHT+IEYm5R46naacXA4TfxnnRRE9q6jqcrx4TiBJlx9bfCOMBJ+E5n4Op970e6/ONFnRL3UBNnRbQ==
X-Received: by 2002:a05:6a20:748c:b0:194:c7f0:6068 with SMTP id p12-20020a056a20748c00b00194c7f06068mr1062179pzd.17.1703150067739;
        Thu, 21 Dec 2023 01:14:27 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ch10-20020a17090af40a00b0028bbd30172csm1279452pjb.56.2023.12.21.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:14:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 085CD1024D744; Thu, 21 Dec 2023 16:14:22 +0700 (WIB)
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
Subject: [PATCH net 2/2] MAINTAINERS: Remove isdn4linux@listserv.isdn4linux.de mailing list
Date: Thu, 21 Dec 2023 16:14:19 +0700
Message-ID: <20231221091419.11764-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221091419.11764-1-bagasdotme@gmail.com>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to the subscribers-only ML bounce with "550 Address not found"
error, yet the subsystem web page (http://www.isdn4linux.de) is still
active (last updated in 2008).

Remove the ML address to keep people's inbox from delivery status
notification messages (and to keep Cc: lists a bit shorter).
(Note that get_maintainer.pl already excludes subscribers-only MLs by
default, so this is no harm.)

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fab95e0258e799..dfe4540984e103 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11238,7 +11238,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git mast
 F:	drivers/infiniband/ulp/isert
 
 ISDN/CMTP OVER BLUETOOTH
-L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Orphan
 W:	http://www.isdn4linux.de
@@ -11249,7 +11248,6 @@ F:	include/uapi/linux/isdn/
 F:	net/bluetooth/cmtp/
 
 ISDN/mISDN SUBSYSTEM
-L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Orphan
 W:	http://www.isdn4linux.de
-- 
An old man doll... just what I always wanted! - Clara


