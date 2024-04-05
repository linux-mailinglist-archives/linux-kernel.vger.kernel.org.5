Return-Path: <linux-kernel+bounces-132545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFD89967E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D5D287546
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C53C47F7E;
	Fri,  5 Apr 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+w9Ub+j"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DE364BF;
	Fri,  5 Apr 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301822; cv=none; b=mV5A1bZQEj2dG72opzyb6JVooU2mEW1a3f4YH5WmUIKhzxHcTcb2RwftaLWTmGEQ1908rdNrqWCxAh7LNzUcA3LO0oeRc3TGKaWujVT5Y4IXg+Fis1bvIhofkxAs72HG6VasEFIs2RaDU635Z92K8GeSptynKnNBuOBkMdgS8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301822; c=relaxed/simple;
	bh=dVtxKxdg1OU5ld/QuyllX0mtu7ceOemS+BBlFZUycWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKGC5JVg5VWlmQ5CLh/ARNNtq92FhXGI1ouovBSpkME6QdGWLW45oPVgKAZkGu/86MuGi1JG6XMyx7+vXWFfGVwgdsGXvrPTt1/97MhVvi/I8Nt3oeZQVM7oGBksHpA4fD1sQRKL/zbLzJGeO9ZEs4gxwwG+Mmom59QMtFFnRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+w9Ub+j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2235c630aso11016775ad.2;
        Fri, 05 Apr 2024 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712301820; x=1712906620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxNxklGn9SVUsQVsbibkyPFYcty9WP4EgX03Cm56A0I=;
        b=R+w9Ub+jh5QtXNCsBXuJe9TSRtkzUszoGheKYxg8g2sseERU/699vAcFjcuNT1CTtp
         Ba3voz7rhpcqtny+0uIKRtvvkOshHmCHqUGk1b4UxHrs3Qy7IPMTLgGmTJyRq2cUDgJd
         jIUyZDcUzaeuXD3WsMJ+l8yL4K5HywjMczbU1ZpDhP7UNqAZwxIrPp8H3PM0H9EeSV+R
         3l0QLDdmmuNnOHpbDBo5AC9z4+KW/owux6LQJbkCRIzpnUE1BL0eHGmcqgTtqAjYXwVY
         OlLmSZdcYlAHPBI6LnpyIaobz3HjYyfTQIVEdBRqww8NV0HTwlK0+XcVu3VUvg8Vj2NZ
         C5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301820; x=1712906620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxNxklGn9SVUsQVsbibkyPFYcty9WP4EgX03Cm56A0I=;
        b=m7tIXGieGGi6bGrUg4+kyEqOQzMt/L1b8yylfpVq6lkw0IZ2wu5eMeZXtU9gVc5S0I
         y/LKU2PlGxAlLvc5q/DX+LdIpMqDQTzUkt9gmw5sDMdJIP3uWqe6+i3TmQEivDwKQSRc
         7AGoeuR1ubXVDS/kQxYp0Lqpp1Xt/v7ejqzvJ1AQ/k7h16V3WGzUY1Gqq+DZ/mJe4Ffd
         fELM2G0wzT6SP39OU4P2KtEc27Ccp97Bt9eiub57MuSwNRsCaIvw/SRSZvf1FV/oAb4W
         HtBUW9IfZEGkPG0/1puh78QW6I6AXd0ezhj2iHhfBjUAf0bgqorzIM49y0WTqhnj6cVG
         levQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbPOgO/FBdd5fH2DAZTY1iKRo5+fsXK9z4+E/tsnqtOcOUKB9DTPvG6zUeWKbS6PXwJXxnGKaYOLRFNLODDDi0+c+zUXKQPRiMQzLlwfeZS77NafpF6O2Z7vzx7dvl7OHjwFjwJwexa2o=
X-Gm-Message-State: AOJu0YytYUaUL3k2TBWzkpo4HErspWde5q5o+rqJlpxXtX+Nd9WHrdri
	MQDkMsiwNDYriygbl+yWQazNfRiAE4DO1gxPrx/FO9JhnyLdHQ5E
X-Google-Smtp-Source: AGHT+IFfc/IdC5JjDt2WRmesL07W3LVTGgo/ePNVHicM2OyAeObGMTW6GRu5VgzsOxm1/IkxQoNOwQ==
X-Received: by 2002:a17:902:f542:b0:1e0:cc0:edf with SMTP id h2-20020a170902f54200b001e00cc00edfmr680751plf.13.1712301820418;
        Fri, 05 Apr 2024 00:23:40 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001ddb4df7f70sm844656pli.304.2024.04.05.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:23:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9C83F186046F8; Fri,  5 Apr 2024 14:23:38 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux bcachefs <linux-bcachefs@vger.kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] MAINTAINERS: Add entry for bcachefs documentation
Date: Fri,  5 Apr 2024 14:23:19 +0700
Message-ID: <20240405072320.23416-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405072320.23416-1-bagasdotme@gmail.com>
References: <20240405072320.23416-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=bagasdotme@gmail.com; h=from:subject; bh=dVtxKxdg1OU5ld/QuyllX0mtu7ceOemS+BBlFZUycWI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDGn8y3T/1XywyhFoPW+UaS1jEqgQVvdX453XVIdKyQ9v2 R4tuXilo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNJf8jwPy+10KKY5aQiX3Ve fX/Uea1jr5+eMvFY+L10ArPkapdX0xkZ5u1iLvs/rcSp6PmhVd837RQ9aXA004Pr8p/autl1Nxb JcQMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Now that bcachefs docs exist in Documentation/filesystems/bcachefs/,
cover it in MAINTAINERS entry for the filesystem.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d01..c0091a206fd206 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3573,6 +3573,7 @@ S:	Supported
 C:	irc://irc.oftc.net/bcache
 T:	git https://evilpiepirate.org/git/bcachefs.git
 F:	fs/bcachefs/
+F:	Documentation/filesystems/bcachefs/
 
 BDISP ST MEDIA DRIVER
 M:	Fabien Dessenne <fabien.dessenne@foss.st.com>
-- 
An old man doll... just what I always wanted! - Clara


