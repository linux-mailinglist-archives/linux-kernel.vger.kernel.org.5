Return-Path: <linux-kernel+bounces-102354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C887B191
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F49B300B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030370CBD;
	Wed, 13 Mar 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYZ5gURy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B570CBB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354088; cv=none; b=TKKitCPqh7Gg44TD27UINmRd8qD0DqBBEijvNjPA9lGeqyiFp0Vn2gDI4fH0zZ0DBypyO48mIgR4SY+BdV9KnfPu3aHer6klqm9A4OOmZp/iiRHgqsF49RmJSR7Ic3nDp0hKx2Speg9gY/5WkMAMMqCApIm/7xoX6lYTkBCz8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354088; c=relaxed/simple;
	bh=6rFg6CcKMLD14drzCA3SHo3Z7zKCaSKlbg5GJFtZOhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EkZbKRKtVvkAxcyGZfLtbv8yEE9eGulHSUw8AFc2nJee42dMgFEEQDemltw5uRdqU0ngSVHxcDfa6vSJjUJzSdXNPwkpB3qO+We6avwIjBlncQA4TrEbyZNzJ+x8T7J3xalS+Cr637iopzxCc9ZQ5ULB0HA6gY2MoQi0nQAj4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYZ5gURy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ddcec424a6so1060825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710354086; x=1710958886; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sV8OWgEsKS+n96/9q+dNrgF4gsdo3YO5aFuikQZDqA=;
        b=jYZ5gURy3BqNdLeYet6zfXDh/nM8+9AulhlsfW3mxskshwkT+VOmpdkuCheBBncayN
         4I0FhPL92DW6Q62gLOHkhVw81NZgWO0Mif9N+T9oIjnsoBzCWF+tZ3l6cdbi7VGEn/xs
         0AypwdWF0Q2SSHkvHiFVUCiOa68pAYUUKodRWME0I7lD60h7DABLSm9vcwdraaFUeVRG
         sTzLrgWNKsJ2sXw45YU+VUSPnZVxTsBOfy16IhfF2/Gt03DGStxdG/pEtJK5S9038qVu
         4EdSBew6MCQ1joKNM/qVPqqMm/OHKWKbrEqD/lJhhgLZvuo20GA6cgmGzECdGxX80f3M
         rDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354086; x=1710958886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sV8OWgEsKS+n96/9q+dNrgF4gsdo3YO5aFuikQZDqA=;
        b=dThAmXQkVWdR5aLpkHYM2/JvWl1zeZIUjHnoVe4N4Q7gYocTE+LuwRSMqMfGsZ6iQc
         ufCnWgvVAO3+gxY1fAS2dine5rbto0TRqN4bQ2OasFifcxywlxIJgTcf++CnumuOwVhA
         AETyTAp5MaWtQ/PKJZ95HA5QR//KzcXiRw7yj8AS6DqyjSTFg2kzQCVUkSB4x23L8Q7I
         nBWJV1Zmbu9YSiCgLixL630b8dwGChd6mtEhnKRE/R+JxfPwKwa1ho9D8QTxWnfphA5G
         EBZL5h35wf0Fv6UZvML1vW+VoUMho0qxhYhNFY3X4NnBuay0frbD6eTqsSBFD8dP//aS
         +4/w==
X-Forwarded-Encrypted: i=1; AJvYcCUnAQUO9TKLqr1DLH0Neq3lMt0rjpWbC0d++aS7ap1TQuV99c/yH4oIWftCu+T401Vvw3BlPUwsIoN/tpJTCqaFFt+5dflXEnqKv7aD
X-Gm-Message-State: AOJu0YyCVNh64eshpJB56sFmDYF8YLNV+uX0Oiv4JwAGueMq+7gtC9KI
	ae2q0Io6SR5N7thOKIOtfcbW/YKBoZwRdtFE1DEiDsJPyIsNvn97HemDPz3htRM=
X-Google-Smtp-Source: AGHT+IHFppbnb4bOvcDyX6Y/Vwi359p3T5moeHDqQ8hYM6Eb3swg94IWpkuT7d1ejOpLNdRHa5CHag==
X-Received: by 2002:a17:902:b784:b0:1dc:4199:a31d with SMTP id e4-20020a170902b78400b001dc4199a31dmr12133902pls.53.1710354085965;
        Wed, 13 Mar 2024 11:21:25 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b001dcc14847e8sm7282436ple.138.2024.03.13.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:21:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 23:51:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: greybus: add comment for mutex
Message-ID: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds descriptive comment to mutex within the struct
gbaudio_codec_info to clarify its intended use and to address
checkpatch checks.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/greybus/audio_codec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index f3f7a7ec6be4..1f97d4fb16cd 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -71,6 +71,7 @@ struct gbaudio_codec_info {
 	/* to maintain runtime stream params for each DAI */
 	struct list_head dai_list;
 	struct mutex lock;
+	/* Lock to protect register access */
 	struct mutex register_mutex;
 };
 
-- 
2.40.1


