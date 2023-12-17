Return-Path: <linux-kernel+bounces-2660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3D816015
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF8BB21D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35844C8C;
	Sun, 17 Dec 2023 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCN4/ALx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDB36AFA;
	Sun, 17 Dec 2023 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-425959f36b0so26480061cf.3;
        Sun, 17 Dec 2023 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702825859; x=1703430659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsWDMqUeycdFferxtBGhRHD/oVHnewRJx7Wjqx7EV1M=;
        b=KCN4/ALxg/Yo/SYAE+yVszAOq8Pr0w8vbC6zEibhQ/kDeRF9Dngib7atFSJCqpGNWW
         me/GgfGMk8lCEPLXOUy8V9u/VBRHaqsi8RovGLioQd0ouCc47WMGHK4LwNl/H3JLoDco
         wRXrROp1Z4P1UrVWtHcqRbCHWniag2uw+TBD7QQS5MyJxkeZY9neBnUpfcrAGMgRlhpW
         Y6CiNCOqletZKevlNmeG72rlaoAa9MY++sS3Zwh9jCyBTBYsA9JRYqNSKAPUtgexbvv+
         dS5SdIBCeuefL9/TFA2nkbKQre2vXtD9S908a3ESAxoGnhqeRvZ1JTjjKWM+f9/eUH2a
         jDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702825859; x=1703430659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsWDMqUeycdFferxtBGhRHD/oVHnewRJx7Wjqx7EV1M=;
        b=Y+aSONm9KN2N75G0JxQozFkZEOz94R8S9j13NWF9mRTra1PcH/oTUgclUXV3W618/E
         4JW0zUD5Z0eRQkIVS2iXqDZ7QNBKMcPoHNeqInnY7vPbK68894f4vApGnhMlROq/bvft
         9n+n0I5sziyuL10L7jUtPxbuz2CU4fZOGNhZfUzhgc0fXSjvvsk+pbpDfcfh/njRykpw
         i+Da9yAhNuvAdTSKynIEF6xRTzegit+IgUjHaKr8wSbu8RzIE8RYayEEtfgUe/meFCQj
         sRdG+1l93UqbHh8gx5dYiG+sTVjN953n2qhLTChdjx/FuUTZHHb6VPoiai5XZHNicubU
         GZww==
X-Gm-Message-State: AOJu0YxVKF3p5fh4wb9GqdAxQp2TH3Hkn8B/Kd8S9msZSxokpJCuz2VX
	1Z6Zk6BBBqI1hgmKMpGEaHMC8/JrGzk=
X-Google-Smtp-Source: AGHT+IF2IFx60RANfnz1Nagow/lXvtBhPocWFmcLVid2GFgv2EKxBM2Ia5QBxGTtj8LfsWkZy3m7UQ==
X-Received: by 2002:a05:620a:e14:b0:77f:9568:72ee with SMTP id y20-20020a05620a0e1400b0077f956872eemr8004592qkm.31.1702825859561;
        Sun, 17 Dec 2023 07:10:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a056102244400b004663caa0d70sm898645vss.4.2023.12.17.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 07:10:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 17 Dec 2023 07:10:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Remove unneeded
 CONFIG_DEBUG_FS #ifdef
Message-ID: <e62ed773-81dc-43ff-86f2-773c4ae6db96@roeck-us.net>
References: <20231216140754.336775-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216140754.336775-1-savicaleksa83@gmail.com>

On Sat, Dec 16, 2023 at 03:07:54PM +0100, Aleksa Savic wrote:
> Remove the #ifdef check for CONFIG_DEBUG_FS and the empty variant
> of aqc_debugfs_init(), because the debugfs functions already do nothing
> if debugfs isn't enabled.
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

