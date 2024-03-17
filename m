Return-Path: <linux-kernel+bounces-105590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E119287E11B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D411F2160D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5C219FD;
	Sun, 17 Mar 2024 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mpe3pufP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74A2135A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710718466; cv=none; b=XPw0kQUN5TL0jcgOrZiOOIwClGKTou2Y6LcuQgV7k3F1Qsi54DTNzQXl1pJewuYxK+5E5aJAWe/yY4EiUBaFseChyjfEBdy8q+Lm11o3GUdICDf/XGbFgVLYi3+er+OpKO3Y+vYaZLx4dGthgIwhreuKdm4kCCTmaKwrWyK1tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710718466; c=relaxed/simple;
	bh=xnnsHJ+UJosxvj8HIRz+QCq1xk/bqLSFE7DBbkenkEU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IXQqChq66MFIqvaWAIYcC/p7Rq954XwGkebSGzawTqxm1QpLbbj7IYDWmIE3ICi0DZNehWsFEhOPtB0fAgT5VoYbHliWcOqf9QMKizdBmIBiN0Iv94Z+DpEMEfOKJHTtU10hJ5emBqhw33m6ELExBUkYyynpkSd5RZ+yPqyWdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mpe3pufP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso2088441f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710718463; x=1711323263; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWlVuXyMfQi+jO3DG5Ohs15H1NdmDMdDIw4bfy7FimY=;
        b=mpe3pufPQxM9vfgxG2lGPWuhNKUiqWc3PYy+AixkJKKpAqELw76SEOgjrYY2fKO/Ra
         WNcEhZL+YsxWa9xNOfOKwjbmzuwR5FNISRYyKE9Si2l6T1y4rlw2hIMZXavf8Smy94fi
         xldzqcEQIOl7BPDYfNmhTi5A4icPXt7kRgfX8DcKTUIcKomZsGJe+NeQV1Xiy/igdqwN
         gJKSC3j+neARjzlAe6/L0htFI9FOnXxUbq0d7PaTDTo8m9t80wc1j+LFxUGuG6IDz38U
         ppl3137o1Eo3Db/QUcXzE1DIVCvJ86j1hlfMoSoFTHJ/arpmQ1F3+oY97zfIpT2im0x9
         1zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710718463; x=1711323263;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWlVuXyMfQi+jO3DG5Ohs15H1NdmDMdDIw4bfy7FimY=;
        b=r748v1lRxL2YsFd6orE4asTL5oiISb2qxZrknkcf+2Od2AQzijhLL0uXpOSHwhDRu+
         CRzkL1NnQeqg2qAYGMWx0MzlZ2YSHM4j7759QJp3lM6x/wvdLOldLB4NpNmOaQfCGCHy
         nd1LTelZG5UyLxWhxvd8r9Hzfkj0lERKAuXtSJ/g+BV0/kPwXfO4JlwH/Jd5cteNj4dw
         PhtviboIaMEKC4MR6cIpe9KZm9LJ/ANJeypDZVbhBXMqyHzzOoNaWLPEnUtjY7Yte5md
         g4R9aFqwJKkgUpc2rN+9scmroQSVud7KPfyM/rDDIqt+cQHqiIEbw3/mwM99RceJE3Q8
         aAqw==
X-Forwarded-Encrypted: i=1; AJvYcCUuEN/crDIkxJRpk+7VeThDj8pf073moWtuS7HS2tBtN2fKfmZPeOAIVJYGn3uL/ZHsBmS3qcGPF+nvR7YP/p1mwzxnJKOilihQw6Vs
X-Gm-Message-State: AOJu0YyV3TARQPYgKR+Xx1dMt6Rkd6Yh7ba90yn8jI5G99eSdH7Qca65
	12bUz/YPcGzVwnR3yfsPvNdoW5nS0xYmkdkNkd9Rpo7k+kkbqH5PUUlPU7ifwSo=
X-Google-Smtp-Source: AGHT+IHUeC6A+y0FeYAILR0H9Qtlqx9YtDmJnOk1SY05HIVJjRaOIomHxcTiDQ2Qtjq8eF3ipTO8tQ==
X-Received: by 2002:adf:e049:0:b0:33e:764b:ab17 with SMTP id w9-20020adfe049000000b0033e764bab17mr12674015wrh.14.1710718462970;
        Sun, 17 Mar 2024 16:34:22 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:6585:db2e:8365:4236])
        by smtp.gmail.com with ESMTPSA id ay25-20020a5d6f19000000b0033e3cb02cefsm8524921wrb.86.2024.03.17.16.34.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2024 16:34:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] xfs: Fix typo in comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <40effb4e-9ea5-4102-a31f-43892e258b09@infradead.org>
Date: Mon, 18 Mar 2024 00:34:11 +0100
Cc: Christoph Hellwig <hch@infradead.org>,
 Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F2971741-5EBB-481B-BA46-0536AC77F1F5@toblux.com>
References: <20240317154731.2801-2-thorsten.blum@toblux.com>
 <Zfdcrtk3b6UfgQRF@infradead.org>
 <40effb4e-9ea5-4102-a31f-43892e258b09@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 17. Mar 2024, at 22:53, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Also s/straight away/straightaway/

Apparently, both are grammatically correct.

Thorsten

