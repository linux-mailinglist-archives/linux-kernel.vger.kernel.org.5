Return-Path: <linux-kernel+bounces-116574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563E88A581
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A41B2F8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684C468E;
	Mon, 25 Mar 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNJgRBPa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A6157E92
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348468; cv=none; b=EJmqGAqo9nUr40zaJnvsMFfLeeRiOX7z/z9ZY3JUi7DY7e/yF5sICD3Sx3LqDHqhOFNJIBXYsLAyHm2s+YkOz75qZfMBJtW31mr36Axp2gDq1g5j//8eB59LbdIzeyKnhZTEHFo6qc3DqyUu6AFoavGHp8V7arf1US4qWPO+2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348468; c=relaxed/simple;
	bh=QN19fvWw72zqe4L6uOTMd3PKADyywUC1rmNweFwDF80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAtRdo2Re10SWo5vsImv+8OCpwWjUSzjvwSn3k2GYX1tRdV3Lr1V40cc+S8XBvuuL3t8u+6Yx6kLmn9bRnEtk5rjnr6c89UZbCW+LNS0Tc11UGyT2gqIMXQ+uhcw4N+wIO9zySxCoeOOGPUDk1kmZ2mNi7P1KkBJhXtoUr7VNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aNJgRBPa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c0bd07e7bso591794a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711348465; x=1711953265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouuMvqhBWtKZeyRlQhg9ts7M2UrMAOzI4owdP6M8Xh8=;
        b=aNJgRBPaXXhJT2KY1QCmiVfJj1Mh9FVOgTTFGKUaMPw4cEtvMgwxAbp1M57gGZFKXl
         ad53Ud09vrVUqUZHbpMS3F23t2W+gHZ3eOXyeaim5/T0G4VpFQ+qISZPjZd1tRk1VCP7
         5SyU436UR2uOK6olIHg6IXo73ExO5oFTyjNO2G5qxqIo9BbbFmsQPfVqqlWTxzudPtMN
         s/J9mraaeUOKvsgh2Da5dk3e43unQXRSipoSSfeaVw2222tn7nIfGLVv5URr41FLa1n7
         6FffghjNLusHXAm8In50exajG5qlRld/E8aqqXo+1xSt9zN7j4Azdly8YiGouQRs5QLu
         EaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348465; x=1711953265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouuMvqhBWtKZeyRlQhg9ts7M2UrMAOzI4owdP6M8Xh8=;
        b=sOe8L0ZbjZ6Arncmyx+xfpUnpOHCYUazcoONbJMJ53x+1lkFWybuXmJvJWccB7m7X9
         IYq3Y99BQws1B8doPZoTINjuiXU1V+4cPzevAKungHKM44agwlXTa3r+bCbyc0tcIkph
         AlNfzclxw0R9tuhDA+luuy6SP84PN1auqaXTISs+LyvbdpWPIxpgLrilxcyKrEh1adwm
         UcPniD8Oc071+tDMiPzD9s5HOF2ay7mCBEFIJ6bjESCptVSxN84L16KFpBnu2U9g//DZ
         pnKmD/tqb3R1T/kxrKqOwXkYHKsBQJNpEjhgdsvCjR1JRSoqhTXAyTdFwO50ah6vEAA8
         7JoA==
X-Forwarded-Encrypted: i=1; AJvYcCVHzlkaSUDst/uze8hBBloOObswPEp3OzUO6t41B9Lfrkzn6C/ky10umvjUFSXq4VUBNuVGzCWThEdgnwGqBsm/kifiCDt2zJqOd9r6
X-Gm-Message-State: AOJu0YxP4gXvcc8g++Ob57p/qkoy5FxF1HAaPLrIfnBUajd2ddWJ2xlP
	KCX3kxUCQTj+T1GHMrhKDuHdvcUP43AR0z1dNFG4dCAHISYPCWRgrBukj8tRdhg=
X-Google-Smtp-Source: AGHT+IGAlH0YlD1ZMINxKLnBqO/4BL4KJ+8SGOGWb9j5yhc1ycqyskEiz3zuIxQM1wrctSzmWSUnaA==
X-Received: by 2002:a50:954c:0:b0:56b:94e3:856c with SMTP id v12-20020a50954c000000b0056b94e3856cmr3706894eda.36.1711348464694;
        Sun, 24 Mar 2024 23:34:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id en21-20020a056402529500b0056be25367absm2638555edb.40.2024.03.24.23.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:34:24 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:34:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc: richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
	ada@thorsis.com, error27@gmail.com, Artem.Bityutskiy@nokia.com,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ubifs: fix incorrect UBIFS_DFS_DIR_LEN macro definition
Message-ID: <bade7524-2b8f-449a-a29e-cafd11359504@moroto.mountain>
References: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324120333.3837837-1-wangzhaolong1@huawei.com>

On Sun, Mar 24, 2024 at 08:03:33PM +0800, ZhaoLong Wang wrote:
> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
> debugfs directory name, is incorrectly calculated. The current formula is
> (3 + 1 + 2*2 + 1), which assumes that both UBI device number and volume ID
> are limited to 2 characters. However, UBI device number ranges from 0 to
> 37 (2 characters), and volume ID ranges from 0 to 127 (up to 3 characters).
> 
> This incorrect definition leads to a buffer overflow issue when the device
> number is 31 and volume ID is 127, causing the dbg_debugfs_init_fs() function
> to return prematurely without creating debugfs directory in the stable branch
> linux-5.10.y.

This commit message is very confusing because you are talking about
5.10 and the current kernel.  Only talk about the issues in the current
kernel.  Later when we're backporting patches then we can discuss
issues in the old kernels.  (You will need to re-write the commit
message and resend).

> 
> A previous attempt to fix this issue in commit be076fdf8369 ("ubifs: fix
> snprintf() checking") by modifying the snprintf return value check range is
> insufficient. It avoids the premature function return but does not address
> the root cause of the problem. If the buffer length is inadequate, snprintf
> will truncate the output string, resulting in incorrect directory names
> during filesystem debugging.

Heh, my commit message said that my patch did not affect runtime but I
don't know what I was thinking when I wrote that. :P  I guess I saw
UBI_DFS_DIR_NAME but didn't notice it had some %d format strings in it.

I think the calculations were wrong, yes, and the comments that explain
them were wrong, yes.  However, I think that the original code worked.

-	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
                                      ^^^^^^^^^^^^^^^^^^^
The + 1 was added by mistake, however, 9 + 1 = 10, so in the end the
math errors cancel each other out.

+	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN, UBI_DFS_DIR_NAME,
                                      ^^^^^^^^^^^^^^^
This is also 10.

 		     ubi->ubi_num);
-	if (n > UBI_DFS_DIR_LEN) {
+	if (n >= UBI_DFS_DIR_LEN) {

n > 9 and n >= 10 are the same.

So I think this is a nice clean up, but I don't think it changes
runtime.  We should backport my patch to 5.10.

regards,
dan carpenter


