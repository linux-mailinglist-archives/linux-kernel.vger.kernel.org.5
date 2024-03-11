Return-Path: <linux-kernel+bounces-99630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF8E878AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2112823C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDA58226;
	Mon, 11 Mar 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ2gRqkj"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EB58119
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197468; cv=none; b=M075rrCZLUqi1qJGXt82nFX9gDbefca6ras+RUTMplnPh1xBYXofNmMCu5BfccxkAbCNxBiYJNODHO21Gzy549eCvTRFvtC/gmHI0RjaWWps928Qnmyve6EAIyl6tmGWzsaOpF91gIdMMboAx8ZrzS2QFdy/SLPbXp1wgmtt8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197468; c=relaxed/simple;
	bh=LMoLZDTZ9w38XZbw+wvsD9KU7HwLnveuxNXtvXR3LVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwXAlUZzPwP407qPa/kDbxnfHUXwLLQaorV2XCrHssSP/z2VJZY9UFw4qPGqIuVftBe78RCyIF3cHTKRSmQkIoxZsQKIC4Wncl0bvtYTiovMw3s8I99xfRcIPEOrRYfX7Q4a+dj4m2wVRKWEAxocipplBWpTgr2tYwHrnydJXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ2gRqkj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d35ab44ba9so861621e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197466; x=1710802266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LMoLZDTZ9w38XZbw+wvsD9KU7HwLnveuxNXtvXR3LVs=;
        b=RZ2gRqkj+FbLzoowUMILf81x82p80DKM84+zrnmSF/rEstRFVAjAtR3q0zhqdaXTQ/
         NKaHJGRH0jKhJkcoj2ncNVXfX/qaqvN+T29RqHnj40+gNmd8FHfBng2W+ygHvXQ2Bujl
         knju1R5V2Db8IEf/RglR43+pwZ7HbS5ADHX+mf8sYufriDnRph+DPwQnCb9RB0nzb/fc
         /5MvCzMbZ9k5nATC8DaaAn/5mFCGzwtNG7vlvUOYJHrHO1360MRPY0KcC3PKsDNoJ24a
         O7z6j7nejZZFnA5Mr3mUeDedlQ1Kb02DBuWghRzaItCx4DeTsDm+i+OyBanVcxSk56BJ
         AZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197466; x=1710802266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMoLZDTZ9w38XZbw+wvsD9KU7HwLnveuxNXtvXR3LVs=;
        b=VwNWGa+M8vtVYpcc2XooEQ56sMlQ5iwGAL7kyITRqo2TWO6rSUOUPgy164KMHHrcDE
         acXw3/aKvGC0B9btnTp+z0Iw3zXtMCJxP5jfBpr90Kv8v7dyeLls3lZuRCqPm7GajHW7
         dG+XFI1OcReXqVDOOG+UsVRyHl7Y3+L+/10RpeSqrYebhT/GL982fTaijSSikpn6FcTk
         NWxgJyYbaEVFl8bONXs+KGrZbIXDKETaZkKnYShJH5ckPB9UMqaYuG9P/+672UMYDSiu
         CErAahSWvT8rxDo+2WyawB6bgPpprCA+xQGeKaXz/t9Zx2UwCyQlZDaJZL82i2ypLdxS
         Ys8w==
X-Forwarded-Encrypted: i=1; AJvYcCXEKQKqdjhfp3mEQhqEu7uApvP5sW7/P+zM9Uoc+W+3k1/hrMOCGor9aeezU8LHUywhGyJ+WCs4yv5zgw4dfKNCtH2/BrClD7s7MGFu
X-Gm-Message-State: AOJu0YzsYQsoT2TCiFZ6YBU5a/sYu2lufCTLLYrg4990eLW+WmvizKji
	MMsf80gw/F1+Y/ocFOTkmx0JkVDsW22crZu1DENyUfDEYe3k+znDVt2d2IgcLwvt/nLayA+0T2v
	xZPLTDNvS2VSc2rHX+P5eMsNY2iU=
X-Google-Smtp-Source: AGHT+IFD3sRtdaZsArjY3R1zMZN5hkmo/IIjuhWQjA3356ADaTSul4sqYvqwD3R3DYcOxRJ11DGTi1kvHQAvHLGDmx8=
X-Received: by 2002:ac5:cce8:0:b0:4d1:3f5a:75f3 with SMTP id
 k8-20020ac5cce8000000b004d13f5a75f3mr1397449vkn.15.1710197465671; Mon, 11 Mar
 2024 15:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228181850.5895-1-apais@linux.microsoft.com> <Zd96XzRHI_jMOCip@slm.duckdns.org>
In-Reply-To: <Zd96XzRHI_jMOCip@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 11 Mar 2024 15:50:54 -0700
Message-ID: <CAOMdWSK9_1LMA-ULLa-iZ26P75UCOrO4gScAqmYvqbrvJi7wSQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience function
To: Tejun Heo <tj@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tejun
> > The function accepts a target workqueue and a work item as parameters.
> > It first attempts to enable the work item using enable_work(). If the
> > enable operation is successful, the work item is then queued on the
> > specified workqueue using queue_work(). The function returns true if
> > the work item was successfully enabled and queued, and false otherwise.
> >
> > This addition aims to enhance code readability and maintainability by
> > providing a unified interface for the common use case of enabling and
> > queuing work items on a workqueue.
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>
> I'll apply this together with the rest of the series once v6.10-rc1 opens.
>

 Could you please let me know once this is applied or point me to the branch.
I have all the conversion based on this.

 I have a series ready for review(a set of 10 patches):
https://github.com/allenpais/for-6.9-bh-conversions/tree/for-6.9

 A series that still needs some work(testing and cleanup):
https:/github.com/allenpais/for-6.9-bh-conversions/tree/for-6.9-wip (This
series contains changes to all the files that use tasklets in drivers/*)
I am working on cleaning it up and also testing. They should be ready
for review soon.

Thanks.

