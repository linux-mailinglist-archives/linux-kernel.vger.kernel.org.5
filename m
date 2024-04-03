Return-Path: <linux-kernel+bounces-130467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9206897888
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894601F213C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D333154423;
	Wed,  3 Apr 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epfmfXag"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68853A7;
	Wed,  3 Apr 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170032; cv=none; b=mpyALkqm7YB1/0GUx/E6FyoLTqpAfeKstqfNZpE9O/Bz6F/xYibGAqu41z6X5BHYqk47TxDC9Oio/PSBr8RjMT+haemCP5ytb72nqhpvsIOnMrHVC8PmF60ZQfBfVXCTahVa7uOvmhDCu31sslyIsEo890sYG9L0tvxhN08OvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170032; c=relaxed/simple;
	bh=/hLqYdF5gKHHXRiWGmtGcaz5aLMxaT3b6M7ooBUSkCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udcwe/YdvGvy74EatNfg30DaAk0paVOhDeu3VkWWxcgeevzZpW+W+xtohsUatW4pMx+lp0hB49WvbsnMiU5ZWbND5/YHWF5UFdgonNIHaODXPtYIffgPtd0/FTpwOfcA0G2WG7Tp/udJgp9Yk4dgiNkfa5zL7Dd+cXf1P0jf+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epfmfXag; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d0845e992aso9655539f.1;
        Wed, 03 Apr 2024 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712170030; x=1712774830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC5h3ZTRasG818N8HOgac3acVCmQ49CiIq6Ru5aVP7g=;
        b=epfmfXag7OxSXACBpppBPtTonLfRAWTMd2YLFsFktJIt/6poEYPSIEqcqDt3bLEebK
         23MqLQohBc3zUkuCo0QrpuAo6iNXVPDI+KAfNPopxTB/R0HpkzeYdTO96UDPFyT5PWGE
         zyX2z+gQsutj3qHvuIixN/1u4JXwYxXabqmfo5M07txblD/JqZ8SEA46nM96hzBi0BMg
         PML33fWL+nk8KZ27OysJl9Bu7CtIWrQ+wOzQXJBWUf+GmpJzVNGZnWSB+nHa5CcMWx6p
         jZXBAd35nvkXuANhhQETqD6gTJFqUlp6UPgRcfKCC4nc7WOjhF/8bGdy29iNrIP3mW0p
         4RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170030; x=1712774830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC5h3ZTRasG818N8HOgac3acVCmQ49CiIq6Ru5aVP7g=;
        b=XHdqwENS8m4v1chxetGJ6jb5BOg1JEToRjBDBzLIA93DZuW0xWY7S4rJgiVa3i+9Qh
         7EQNugZAnlqhPqBWMQeXdvSYWUXvL1bEFNDnrJeY+cv+aVm3vFk6QJPTKEnE9VFr1E07
         VfYxzdKVD392xdCU1CYqKo3VTsUP3z1ayJkCOF2F2q2NbgwMCtE0gxeFOaqCmuD+KFX5
         yq8TiSwCMrDD3ntFYc6AvpN6DNuB3d7FyCF1g7UL+ziinzLpg38yJmvk0D5utWb4vJYI
         afkAFrAZRvc9EV83lfVqSSn1M1Tfr6AZq1CfjvTy+FeTcpdnfuHhrJEfIB2OaldChjO4
         xRbg==
X-Forwarded-Encrypted: i=1; AJvYcCXo0UxpeDziQqBzTZe+nx3cZ0ytJWwnjH5JP+K4/BGHuJkZJdE/Hv5jnTapKGDZxpLtFEf/Kt86HANcuktjtWVE5i7yQI+PUk+8X6MVJ15i4m37OQTh0fkxbvYT8qvmsSSGFmtzPTpj
X-Gm-Message-State: AOJu0YwnQoqEfyXohPV4r6U4DYxL0YalX/wCp5oiA3cn1G/WCmtXH+38
	TFunsq4A6U20u6ItCuQMM0Iw/btQMTSirygIZxd1xU4sDjBaLQ+4
X-Google-Smtp-Source: AGHT+IG++c0hL3KBqwugr/8BxzCaTq+uwJm+9RN9dRLE23dvG6PefjFq24iJBJkWs8HLOJxSO8g+Gw==
X-Received: by 2002:a05:6e02:1547:b0:368:4a3d:e8c5 with SMTP id j7-20020a056e02154700b003684a3de8c5mr545217ilu.15.1712170030135;
        Wed, 03 Apr 2024 11:47:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id d6-20020a63ed06000000b005f3c84e12c9sm4532297pgi.48.2024.04.03.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:47:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 08:47:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Xingyou Chen <rockrush@rockwork.org>
Cc: siyanteng@loongson.cn, alexs@kernel.org, corbet@lwn.net,
	zhoubinbin@loongson.cn, wangjinchao@xfusion.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: core-api: Update translation of
 workqueue.rst to 6.9-rc1
Message-ID: <Zg2kLON8LBZkijEE@slm.duckdns.org>
References: <20240402230813.25472-1-rockrush@rockwork.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402230813.25472-1-rockrush@rockwork.org>

On Wed, Apr 03, 2024 at 07:08:10AM +0800, Xingyou Chen wrote:
> Significant changes have been made to workqueue, and there are staging
> works transferring from tasklet, while the current translation doesn't
> include description around WQ_BH, an update seems to be helpful.
> 
> Synchronize translation from upstream commit 3bc1e711c26b
> ("workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered")
> 
> Signed-off-by: Xingyou Chen <rockrush@rockwork.org>

Applied to wq/for-6.9-fixes.

Thanks.

-- 
tejun

