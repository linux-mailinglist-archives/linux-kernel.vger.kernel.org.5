Return-Path: <linux-kernel+bounces-149037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71D8A8AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD711F2297B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55317333A;
	Wed, 17 Apr 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoCRHWTG"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92B172BD5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377448; cv=none; b=sCJ034tX47y+LybFnpSKJjlqQO6NrcJLglRhvcAy21RpeZUFeW43THoRhCEcN7OU1rFpGDfjI/Q8N2xS2yNkDqo1AsmZiuZ1EM9i3bpM548rZcnxPRTQ2PYmuVGoWFLy9XSAdtgvPshJovjiBh3zyBs1ndnfv2JkFulxEv68YPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377448; c=relaxed/simple;
	bh=xT2ERLXiq2DKe/pTxO73Li/ifSNoQuLAqDfZEO5enOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n1vhA7V3SYAMvoiMQSMtazp8w6iiRJZErkFdSMcjj/N0OZde39fxBz2G4l/Mhvzzi33sY6zgXNkTUYmEs+mTC2A2tNFyXGowzEnzU/VBirOsNYOKcs/e/2QuIWmOUd5H3ydEUUH8fWV1QtL3r0dYzUAWvrfiTY6HAQllj0gM9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WoCRHWTG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51a7dc45easo664855766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713377445; x=1713982245; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GmA4aba1jpIYiloRxV+ylWHh6VXG3/mxuzWiUhtbGk=;
        b=WoCRHWTGIobjowMNqo0OsXqr/hazzxGWoy8nm5NBAZOTg5ZgplwjS3Tp32cn7QwOKw
         qZQKUaUNG+yVtwicYeAmKsC5UrAp1898ps9NLGdP8PMmrPOAvZc55ZqnMi+WykHALXG/
         /laZSla62Gc8CKbTFN57GxnkEplYVjp/7OE/fhQIbMGivfHZWQmqHqxx6DWWI+s8BeQb
         UJTEiRYewTpMfKMvp08Vpz4SZl8rzefCxf0T7ptO66FzHyXHqzPJg7vTyIEm1cTJucnq
         K8pcnyeStL9TVGwiRB6dUac+h/8D51wYVav/7HnBZZsi+J8At0M6exqKZLk5ZYUUhr43
         BgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377445; x=1713982245;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GmA4aba1jpIYiloRxV+ylWHh6VXG3/mxuzWiUhtbGk=;
        b=wuVihS+jgVHmV84C0HPPqafAMpB2/isBq1OoLNFbwt75uJ/2gfs4ZlQXMIvud6iT0D
         2wb/5TtLamoarv/aoppbFvQiMSP7aM0zrg13OPYqnA5JYkBPxcZWsVkIRvx5dduDfefk
         ADNJ228JRuL50vQqd1lLIKY49WXYrIzxgMxodgmaxBfBrWFm6++0h6rQajQPZ7hwONjg
         9tDFZ0EScHdolMAIP+st4JHmAh096Y90j82LDfFGydMVb++ZU5H4M5a51e2LCAjyrA13
         q2wF9t1tTxj9v9RQpdqVDz7tkBWqOR40jlMfsCtgBJ48tGl33IqwgF8+IZtOLou8/Eqp
         g0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWhmRJ3LgE9x/ey/O5OxCk5IrXo/4vaSHOpg9hCBOcH/46LaPCDZaHjcdcXWGTYfq07k4i+gI6zwYyP8NDoLAN5fBSAuWPc3OBhkCy/
X-Gm-Message-State: AOJu0YwgMRbubZNwZD79I1Dw5C5dftrnpWkgHnz7tE+jEkRU2t8ceXmS
	778HWCS30XzoFDR6METJboqeCnHrWFXhDf6ncyqW4hx1CO9U5OOMEgb/HyriZmM=
X-Google-Smtp-Source: AGHT+IHOfctM5ARKZ57bhI9WDUzfMCwg0qnXp/32GMJKfD2iVfzFP+9ShBiH0UrnBKpfdiTlPOvgpQ==
X-Received: by 2002:a17:906:19d3:b0:a46:cef3:4aba with SMTP id h19-20020a17090619d300b00a46cef34abamr206887ejd.75.1713377445507;
        Wed, 17 Apr 2024 11:10:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709060dcb00b00a553de860c6sm2587149eji.133.2024.04.17.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:10:44 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:10:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: fix potential unnitialized variable
Message-ID: <363a4673-0fb8-4adf-b4fb-90a499077276@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains "err" can be uninitialized in the caller.

    fs/ext4/indirect.c:349 ext4_alloc_branch()
    error: uninitialized symbol 'err'.

Set the error to zero on the success path.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is a static checker fix and I don't know this code very well...
Please review it extra carefully.

 fs/ext4/mballoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 12b3f196010b..714f83632e3f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6113,6 +6113,7 @@ ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
 	ext4_mb_mark_bb(sb, block, 1, true);
 	ar->len = 1;
 
+	*errp = 0;
 	return block;
 }
 
-- 
2.43.0


