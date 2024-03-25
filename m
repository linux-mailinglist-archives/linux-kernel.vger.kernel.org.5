Return-Path: <linux-kernel+bounces-117780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02C88AF82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE6E1FA2421
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE05134BD;
	Mon, 25 Mar 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSFh/gRj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133911CAF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393968; cv=none; b=bFMRyNE+RX8lxIDyxO0EfspbrWO144B1AiQDVO179JAFEqJyvNWqFHvHZbhcYhuj2YUElPjS7+2I9FNFz5Vu26F32Zi3LvoJzgAnFL1eiH4SfrcWDkMkEO2Lx3A4xgBf/wkuA1olnWofKYrJc3ERGk/FbHPm3KV++eKGnX69d7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393968; c=relaxed/simple;
	bh=6OwKHcyzDXLEpRuQPM2xn9zI37iwaTHxLz6SiXPrAfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHRZiD2S4FR0W4Jn/+dMKoYq1tBre0XZOD48XZSTONwPmJ0gm3OfzlKEl6TAW9mEqn49btbPyjidQiPmZ//nll6dlAq1dOZS81HIEzNA6n+laffR63ObkSqJjF/erqXEG66P1T8osfyGxjvnGfDwSHzH0t9mCPrP0VTpXXH8l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSFh/gRj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso3144819a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393966; x=1711998766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yVsEYou4yuQbn7i757+jI0ASwRnGr+YZ/l/89vUgU4=;
        b=SSFh/gRjfRWDexGr+0Hhn057GxbycSBDLbP8jCdvI/hEzUH5lXU9dsO4gHCIaxBpls
         DypPwVYn6QaUiz397tzJoxlN93Jgm7JQXJSsv7AaSHUWRCk8Tik93XuxhT2nsigZ3+mw
         4Sa8jknqZ6bg7urgeUg9fafuGTrFxb+P5y3dzQ4m/YvNAxqc7HGn4tzmrq5BQ6vjecT8
         w93XRn1Je2N6bt/YaAO3M+bms062LUuGhFALbuPyU/5so87mXjngK3+lto5nsdtTlAcJ
         KfJtoh15uSy2dgy9lmV/PxtWLOr2JYxRoPgCSmQ85cNRSpxaUf9Wv5qpk0JWZXPOk/ce
         w8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393966; x=1711998766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yVsEYou4yuQbn7i757+jI0ASwRnGr+YZ/l/89vUgU4=;
        b=HJEf27bS/JVAicx/OrqPxQoRaVCC8OsZObBZA6/aREPdogh4OkBijlezcMctC6rODP
         T8nazLNBmspzU+3kQZVze0XqLwOcIY4vN+fp5Rn/6rff/frV75ielLvLAq5uRkBl1YI6
         eLxGqX7iE77Wbioatn+HlAYjaZGwl+jSNycTeDFnTP8aDefFF1Wag8GL7fGpxYF00baZ
         J+FZEjgQUm6GLyn+7p0FXnYKDiPiR9jXUFSBHBlU5CPeCdPv6xMvcZep6uhpph/q6rsj
         Rw1+yRRt+rTTxq/Ok+Z49z0YfmT0jgrePB03nDBb19Q+//VZm20Lq0ZtUDHx1dI9Al8w
         hqIg==
X-Gm-Message-State: AOJu0Yw0QQiS92GeRSfl7QUDp62IoHFyWxrKMZqL6p4CCspYpwT8/R7P
	jkGtJR5NzgfT1dr1KhEI7/jTaPuhDjByp7Fnr7O5zTQpgUD44xN7wMV14YzP
X-Google-Smtp-Source: AGHT+IETahr73UVaFl5OPLGR3+nH+03OGRVQKPxFDYq1YfWET0tdKP+Wwh0cActhUhngbLh1bh2dWA==
X-Received: by 2002:a17:90a:bd0c:b0:29c:74a4:72b3 with SMTP id y12-20020a17090abd0c00b0029c74a472b3mr5814779pjr.8.1711393966311;
        Mon, 25 Mar 2024 12:12:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id pd4-20020a17090b1dc400b002a064133d87sm2960532pjb.12.2024.03.25.12.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:12:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 09:12:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 3/4] workqueue: Move attrs->cpumask out of worker_pool's
 properties when attrs->affn_strict
Message-ID: <ZgHMrDQ1IWivC2ax@slm.duckdns.org>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
 <20240308094253.2104-4-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094253.2104-4-jiangshanlai@gmail.com>

On Fri, Mar 08, 2024 at 05:42:52PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Allow more pools can be shared when attrs->affn_strict.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

