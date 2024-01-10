Return-Path: <linux-kernel+bounces-22599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FD82A03E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3751C2236C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC84D582;
	Wed, 10 Jan 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFoV4c1K"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A3495C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so3019740b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911298; x=1705516098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y95rNNfwjLQzN9p1W2Wed8HGytubXo93i27+UvIZ5c=;
        b=jFoV4c1KLI65br0NuLRFqK2vF9+YvZ1//3oug/uTThFYzTkoSPjMqQ6zoAY943DXeR
         fXlzEezWDu4fH5TwXrBNfRpzWw6fFVugxXUMvfu+2YP84gq4gk/i+DtDq2wUjx3SZjlP
         ddZAJog1yne7RAThc7S4KSPy43Ll0ChBTlEZsDuC5M+D499IiuybgIRQz7ts1ppbGJw3
         JtsFb/zt5EAosL5nne9gVt7k+mNy5KDLKo8GMgZKxKTWgs8ss65G9qh/0MJLNmnIO1b+
         hsFsLkelLTDRDRGExGB0l75lB9cYu5NIF5Gb1+w77EZOFXh/UfRDmtnEavrtcVyBYOQA
         yDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911298; x=1705516098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y95rNNfwjLQzN9p1W2Wed8HGytubXo93i27+UvIZ5c=;
        b=EdgL/VmOnam54UV7m8DEGeccNMU1z05g5vliCDX/GUykm9NFaapGOYXOZyhvR7xrKP
         OJDbfh+PqichqI90SwZbEclpiiPw6gpYYLzCnAMo2Zb6P4FBdDzWrupvLuI3xh/Vb9hz
         eYlfwzC2/nsA6zIdaQKQsz9qPCWJAUCWcnt85cjR3KG9RY310ZcZuXi9SEvaI7vZzvW4
         SKd1/evYLSr94YgtAVVOs9gF4uzlTP2TSMhJKp9WwTmYdLHulAiK9IXpoIpjn4AzOrxs
         uejr2FSAbnPH0WTXojyqd+3dyUHpT8uP6Qt3musmjhOfvrLXABpH6Vn0e69X/qwnrfwA
         MSMA==
X-Gm-Message-State: AOJu0YzIVmFLorOB3SXr80cxfIA3/lNFHsGyqpwr9TKs5BcNGu5v8XJs
	hftXbaMOK9gJPnHyOWM/92g=
X-Google-Smtp-Source: AGHT+IHMc7MWyNv1HudtNmoeI2ni2yWHYMUdCoYze8fxfk3HOpEgzZXbWPW84IpclSa6leK8REFCkQ==
X-Received: by 2002:a05:6a00:8d86:b0:6d9:b7ef:466c with SMTP id im6-20020a056a008d8600b006d9b7ef466cmr26252pfb.67.1704911297630;
        Wed, 10 Jan 2024 10:28:17 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fh12-20020a056a00390c00b006d0d90edd2csm3828088pfb.42.2024.01.10.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:28:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jan 2024 08:28:16 -1000
From: Tejun Heo <tj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: andrea.righi@canonical.com, ast@kernel.org,
	linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: [PATCH v2 2/3] kernfs: Rearrange kernfs_node fields to reduce its
 size on 64bit
Message-ID: <ZZ7hwA18nfmFjYpj@slm.duckdns.org>
References: <20240109214828.252092-1-tj@kernel.org>
 <20240109214828.252092-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214828.252092-3-tj@kernel.org>

From: Tejun Heo <tj@kernel.org>
Subject: kernfs: Rearrange kernfs_node fields to reduce its size on 64bit

Moving .flags and .mode right below .hash makes kernfs_node smaller by 8
bytes on 64bit. To avoid creating a hole from 8 bytes alignment on 32bit
archs, .priv is moved below so that there are two 32bit pointers after the
64bit .id field.

v2: Updated to avoid size increase on 32bit noticed by Geert.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
The third patch applies fine without update.

 include/linux/kernfs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -206,22 +206,22 @@ struct kernfs_node {
 
 	const void		*ns;	/* namespace tag */
 	unsigned int		hash;	/* ns + name hash */
+	unsigned short		flags;
+	umode_t			mode;
+
 	union {
 		struct kernfs_elem_dir		dir;
 		struct kernfs_elem_symlink	symlink;
 		struct kernfs_elem_attr		attr;
 	};
 
-	void			*priv;
-
 	/*
 	 * 64bit unique ID.  On 64bit ino setups, id is the ino.  On 32bit,
 	 * the low 32bits are ino and upper generation.
 	 */
 	u64			id;
 
-	unsigned short		flags;
-	umode_t			mode;
+	void			*priv;
 	struct kernfs_iattrs	*iattr;
 };
 

