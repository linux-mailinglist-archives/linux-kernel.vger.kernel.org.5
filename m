Return-Path: <linux-kernel+bounces-89194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1292F86EBCB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA28289FCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348D5A10E;
	Fri,  1 Mar 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv3Aatpn"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE859B52;
	Fri,  1 Mar 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331697; cv=none; b=ZLiDAz6uFc7CBgxcDB601PTpq5knGc+UBYqrlec/aQPIiVxadTy7nDnhJf7RNOQoRr67Akzu+zBvf+m2cddccYA5x6wtix0v2X4vDUEuHTDrU+ehbFKTVcWKUp79ydNwryJ5qOU25CdnRxFT/CmtZCYz6Lw32Xqy4twkICVnR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331697; c=relaxed/simple;
	bh=QHD6wdc2FcjJAuPr9twXZPAxgmO6Qo4sSe6LZC/0f8Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qLoFKDrH1D1V+RXwWRkh1119p5XpEGdv9ZhNeSuRoRxBH5JeIqL3lGsDINC7zgI5GN5/0Cgoqmoa4F2WtVAB16bH80TNNDiOf6eqPsE8Ytnnx60ctFRrPWR3ODeZ+YTPYy8tFNKen2Qyt5lkq7znY3vQZK09O7iwb2LvsU/X81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv3Aatpn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ea808d0f8so18426241cf.0;
        Fri, 01 Mar 2024 14:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331694; x=1709936494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7JfMhQCQePfKKf1uRWjRuFfK5uAA07CGHpzBysCxmM=;
        b=gv3Aatpnyzjx9YuW+U6KWZBdYkauwPCd/ZVVsksPKK4xAXnXH2rLcRUeN3ZhHOILVY
         idaLPQWTMdxhvh1q9LZA2SUAd9TmbiaNpNRFAeJqHWRX1LVRT6CV8JOA8UZqcA23YbF5
         ivhgslC0Ihl2yaCDsqcbN+u+vQ2s9ffUHLAjOpW3p2IOPGcRkGEO7u7RxXW5LD0ms4Nh
         ji3AjGeon8tCrj7wx6eWbNsh18drmvZZ+w4W1cuHQOYV4a3PhiaLYM2dvHJIlQxxEaqU
         1OyPEk4cQZE9RXbFgGvEgj4hDXHnAdt1qixtH0wkSZR5dhMniNp5XsrAe7LuD37zQYjk
         CL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331694; x=1709936494;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7JfMhQCQePfKKf1uRWjRuFfK5uAA07CGHpzBysCxmM=;
        b=VmJSaoxmiheRLmZPOD0BkMo7+0kQboTvrBtOmOHXQbbABDhM9xOaGbWd4svdtdQSyH
         jj854btLguT69MMrVh3XqWAwBi4Pm5FYak+p2vtMNinGgezDDwhrJqrkaySvytNqMZ9P
         BMWQ0vt/XsncoGOjpFUrHPUaki5aFkYJ6YXsSRFbP8lWvbpVCG8dih/DGDyJejUNhzOE
         ZpMg3BaJgOXgKVBvApFMd18ImVTUJYnUj07+4mRIQK4yBQ7QNNjjonmi0COunHRiQrfy
         wUCfHyRO0k+eAwH4xtyfKiEwN6dzwzo1JAKGhuPNNAUl2Bgn3/j5NVNKXATx0y0II2vZ
         LfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa9RlWnBGs+MK8S3YuniImmfx54t/Ij52QsX7qKWNSbURsiIApFJIG2tdI1DlCeTLatRmqSnVc5v2gyK713bPA9h0+CdOmjOuz+lmYwO/aIKt4ETJVds1kHG6XmL6VA5nk8Vkv
X-Gm-Message-State: AOJu0Yw3t9NXWkkDHpXjdd1Qbc4FLT3D5pSU7o5RZwGg7XVRZdFgr7Cm
	XFcyuvwg/h4PuY33hkCAs+YgyLcDnyuIcYEuNFn9xLB8mTD83n3O
X-Google-Smtp-Source: AGHT+IEMamr5yhLIGtxKwdhU5Qrbui94T6NRT6UrZ40ZHM5rj/1zsN5YOMk/Iqb49nY4xzg3m29UlA==
X-Received: by 2002:ac8:5715:0:b0:42e:dad2:fc58 with SMTP id 21-20020ac85715000000b0042edad2fc58mr89942qtw.5.1709331694494;
        Fri, 01 Mar 2024 14:21:34 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id m15-20020ac8688f000000b0042eae33debfsm2081296qtq.89.2024.03.01.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:21:34 -0800 (PST)
Date: Fri, 01 Mar 2024 17:21:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Message-ID: <65e254edea4d2_15e0d629462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Setting the same bit (mono_delivery_time) to avoid dropping of
> userspace tstamp packets in the forwarding path.
> 
> Existing functionality of mono_delivery_time remains unaltered here,
> instead just extended with userspace tstamp support for bridge
> forwarding path.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

