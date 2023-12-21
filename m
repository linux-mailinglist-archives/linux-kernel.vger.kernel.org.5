Return-Path: <linux-kernel+bounces-9077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436181BFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345ED1F25A58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DB76DB6;
	Thu, 21 Dec 2023 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA36MNvw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAF76915
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d77c6437f0so700580b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703193731; x=1703798531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6venq9bHfmBWWhwjxySgtc54+MAVBFnlcQFjdSlMIG8=;
        b=TA36MNvwDE12+mDCOeE06Ss5n/Dp6c2CkXZO2G0eOOp/+aHbgkbjsADJ6GWNzQwbjJ
         +xNjD8W61ohpmlrEM5Z3ZxkE/Fz1/A9WSOxD2tVI4fc3X6hhtcuqj3Cc8Nqt/10/43w7
         ZtAwkvHiMDu80DOU6niKqQuhDToVO/CASDbDfiBkJ1UrDMFNbRWAv829UFfErxdmI31k
         50gO9X0G5e2fsGYBx3vMc4IkH9hF7sJ2jRvXAZV179yCHoPtDk6pvNU1jLeMQVRUQKWo
         jIKlX3R5zry59/D6NtYsuxc17kO7jX37BiaSUXADL0yhpRRCsvqNINNauD402lBECfHA
         l6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193731; x=1703798531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6venq9bHfmBWWhwjxySgtc54+MAVBFnlcQFjdSlMIG8=;
        b=jvnZDwCLUXge93ePx/hfzp+MThrbGQ9X3h9UKG1XDTQRbddKtRoy/vTAzOwwJConBX
         0wxWVIt0pqzxF1O3EN8EQX0pE55YzsmUnbbiryI9MBgcTsIfTKdqvwZjSknVr0jWG5MJ
         ISehKD3Ccrkz9dg6m6yVvg1knXoIE+RxF8uAxMwXSkmbrRpwCxDD95bCXsva34Ke97re
         fJU2PK5B30JcIfI85roLY6iJq8ml4cX/6b+t97w/8zpffXhJ56/LMHwR+k+ZftTihBOz
         mBMupSUHfQVhAQe8tKKjhONlULyXZzwsY31a/+LAYL4YxviX3QAwKuNwKcF9h1nrdBzF
         OEIg==
X-Gm-Message-State: AOJu0YwrIcJ+cfzoykk+dvoPgLUmN6QN03cLaMqVv08EWoDc8GGKOlOX
	TrDrJoBCiegRrwyl3AWClh7jRIAjVpAJvg==
X-Google-Smtp-Source: AGHT+IFFnU2wfGl95PeULQ5usQzoz+5IRx+boN/heiVddzxhZUV9+YmQgYtlMemNKVztvHHsPjvDIQ==
X-Received: by 2002:a05:6a00:90a4:b0:6d8:2be2:775d with SMTP id jo36-20020a056a0090a400b006d82be2775dmr358019pfb.19.1703193731110;
        Thu, 21 Dec 2023 13:22:11 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id i10-20020a056a00004a00b006ce273562fasm2068251pfk.40.2023.12.21.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:22:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 06:22:06 +0900
From: Tejun Heo <tj@kernel.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix reference to renamed function
Message-ID: <ZYSsfq798hVa7qeU@mtj.duckdns.org>
References: <4f2wybrepigxjpuxj4bdkh3qmksetfioedit2bdrswf6b75ebb@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f2wybrepigxjpuxj4bdkh3qmksetfioedit2bdrswf6b75ebb@tarta.nabijaczleweli.xyz>

On Thu, Dec 21, 2023 at 03:15:42PM +0100, Ahelenia Ziemiańska wrote:
> commit c637b8acbe079edb477d887041755b489036f146 ("kernfs:
>  s/sysfs/kernfs/ in internal functions and whatever is left")
> renamed kernfs_file_open to kernfs_fop_open, but didn't update the
> comment referencing it.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

