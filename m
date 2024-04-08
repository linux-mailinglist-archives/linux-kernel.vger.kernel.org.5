Return-Path: <linux-kernel+bounces-135796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D089CB75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2E5B24298
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D91442F8;
	Mon,  8 Apr 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxzr7YyE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B4433A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599454; cv=none; b=EjkhL4tH/QgpxfSokPbcRTRiihQAbUvXF6N3XCLoThMAfb//sjYBhM5CD7RXGeBKX5OX6e6bxBVJEQqWe78lPoxHwfsgv9aw2DITKfMd1Zeq+92z8ASdmB9+VlqVHjFO0PsnSyohFI5OYVG09q52YTsfDNi3swRGNBNOvgwkg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599454; c=relaxed/simple;
	bh=vrW5RWosvEn79vqsR7CuY8qzmt7Z7EzFpIrWYilzKko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQkQKX2hyNP95YQom6nxLUrv4SQniLnL7JozCBhGa3InYWQ8UzM03BwHP01ebNEloAFk6VSU/Tx22DyZsjI/rM6QLUvPsBYA767Ogh4Jce4HMyf2V5dOgC5FAKrDgcQbPMhKkq7fmLhqzBJjEMyUKzkrMwtMuDx2S5fdMa4Za84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxzr7YyE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso3389160a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712599452; x=1713204252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyVNMyBP7ciOXINbiRnmQAXOHQGJAcEvQsgk5x+Gi9U=;
        b=Gxzr7YyETQDVmCgGPsm7LQPvX6kdof6S5ujIFTdCT2i8IrCUKTjWy9TqfSSDZqumXj
         3W2nLhW0umuoo1H9RJ9cxbIjO4e59JMzji5JUXdplZ48o/dl05NwDTZmAqBe+7r4/G6q
         MM02iPlXIkKsZET6JoHKdXB7vrtjchaKShEUAPUvDut5lujJrqad5fJXtZJ1WCiOFGYI
         of3DlKJbLJqB2x0QJzH8eQAP5cCSCXGwSCwisclVdDVvCAqNaHbfxCmEkcFoIG2d/kFz
         uWrhLCvlz51/Goesp7ebwrSSFjB/HYqmnKkC2fnP6M/14YAlZmV4KNPilUk8OZvrTz1O
         F9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712599452; x=1713204252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyVNMyBP7ciOXINbiRnmQAXOHQGJAcEvQsgk5x+Gi9U=;
        b=syaHjN2rqLxZFL6IlioAy32siO79SoGjfjnok5bfE3/dEwgK1mZseziuXCqF3/634+
         xdEMks0p1cvLfXwIcOw5SGQWYvdyoi2DMYUkPXcrvTkzpMxtM64N+dO1ZuuZBWS1kIlp
         UiwdUSK/uStewrogx4nChdAmF9lzxbZbW3F4PFpS5AFnwuOtPx9Y7eJsAqd9unHJ+asP
         nLSzRAsO8c6sHJ3lizz2K5U5SGjwRUC6iltKzY0nBs9AKupmh3CRRVYTR6KukNVDXkEv
         bY2wuZ9l6zB/7UwPCVEv00aYPMEguM3MiHncFZhV1SaX4bhrec4RdelngRUVg0gj5G1t
         vzZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8r/vB2h7V+m7lzzll5tFCpFRdckMAUFYnY1z+hYRbynoe9F3zgcCzzXAwuugCKxao3l2YpuwvQXM6/OwmRPgfleVyoaEPbkdinCb1
X-Gm-Message-State: AOJu0YxLfK7STtjNyrgl1lTsKh5yyHAsLTQRypi9TzAPLPWy3nefwW1u
	76Y2U6QImjE8Jd6prlCJYrSitU7eOi2w0c76ik93sPXYVs2LmPHh
X-Google-Smtp-Source: AGHT+IELR7cckUwirtAPJ42Xu45YuRTZTetzuQnSiEymc3N/kGwYolpLsxhVXEQzVIGN4Eqwg9sT7w==
X-Received: by 2002:a17:90b:400b:b0:2a2:d8d6:fc3a with SMTP id ie11-20020a17090b400b00b002a2d8d6fc3amr7430555pjb.37.1712599452355;
        Mon, 08 Apr 2024 11:04:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id gk21-20020a17090b119500b002a54222e694sm1443700pjb.51.2024.04.08.11.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 11:04:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Apr 2024 08:04:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Add destroy_work_on_stack() in
 workqueue_softirq_dead()
Message-ID: <ZhQxmruOkIMNrqWB@slm.duckdns.org>
References: <20240408084404.31991-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408084404.31991-1-qiang.zhang1211@gmail.com>

On Mon, Apr 08, 2024 at 04:44:04PM +0800, Zqiang wrote:
> This commit add missed destroy_work_on_stack() operations for
> dead_work.work.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

