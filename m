Return-Path: <linux-kernel+bounces-147732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9A8A7851
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DDE1C22DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453E13A890;
	Tue, 16 Apr 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIfA/bfa"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14D13A3EF;
	Tue, 16 Apr 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308646; cv=none; b=CTOVOuRq0gqtnB/9fVGbKFQEk+AQ8qGqQW190ZTOtC+i83Daiovyddtk8cSTV8H9qxigTkqR3L2+HKoR/annVDqzm556S6zImnenD9Jr0ppgV7oM94TesJ/WL623XECTE1wCBkoBGMldSM1His2scUXzPJvAppeV7MJ7doctiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308646; c=relaxed/simple;
	bh=krN7TDVY8gsasYGH21Hk8s3B3pWnfrUYQtqBSfSjSD0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SAFD0SSQhQ1RRd6zb1kUSPF2bRfBCfSdyK6/wBIm4zxtUrxh4I+83tVTjREXmNmly4mwZtfh6E3KD33tZvEeXllBoZmjASI6mFtInQjiwbHNGJvnXUdssJQ1k3lpNxeHvDysQGGa4t4okVWInR2O02in+n5Be1wq6LMXA0pWkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIfA/bfa; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78d555254b7so22221785a.1;
        Tue, 16 Apr 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308644; x=1713913444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73xcy9UhpOQbwGv1P/rFuD3j5Fn9C/d34aHsmJnVy1o=;
        b=dIfA/bfaGk3+xspAaZCaK50Y+w2pTwe3a+GjFwgAW1c3S1xZV66ZD/luXzz4E+Z44N
         5LJeyvmbG2DJtyC0hbxl7REjC9DWHnyJ2Cm5mG/AApJ8LAYA+FHS4CEOYdBhqa689TN2
         cu78b1wx7mttEp8btoZquL4ljLHg37dzNVoTgxIJz14bXK0IVTyNUEiHItxnPddwM0cZ
         +V5P0m4GFy+TLhpaoBdSxhTOEapf5O1ahuJAwq0ziyel5NO25F4/Vmky8UPVS8eQSTqT
         NY//G3lFThA+MMJ8QgoiQDnvYMyQMTpqyneZK956JsI8NMhTtWQGjy7xzR5mpE4/z9pO
         TMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308644; x=1713913444;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73xcy9UhpOQbwGv1P/rFuD3j5Fn9C/d34aHsmJnVy1o=;
        b=iYicWeE8xZMI8/hEkN25MRFgAINaJuCLZsRPvxIZt+Fat56mLl+j84LV2GPldjbHBr
         ccuyas+WlB/7Lt0JNECBR5G9eSzxrcK5SHPTXK2nBx6m4FTXhOfZsCzA7qsNUhURme7f
         IWDFDi6HkSowSTqOta8HejlCw9QzNG1lXb6SLoPQX76gIwVipPSM5HEIE30edZiunF5o
         itcwE0nX6dKS3DZew6bIlYSRFVB+veb+2jMBu58r6F+20pxRIQZS4AtkSjK8AAB4dymq
         WLDoEAWm+lGKicFoxAj7CxFhgyFK7k2CrdGOavAi3jXzWCJjaR9fWvw2UIw9Y09d6QGc
         WF3g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ag0MoG4uM1U/pxV0WxkHzHI6KPdHFTCbqIHHne9OuPeEFCttQwCdheSyup36ykbuS50FPSkgbxXnut7onzZo0vGuobFzcDntOTLcdN4Js7zlcGms6bIVfGSIcKOQB/BRoPR5
X-Gm-Message-State: AOJu0YyUzoTbfQrjRxFHdzE3lo7G0d0ylaXSUuj9/ns4pqnrG0oFchgR
	75F5jvwk0efcxZGQApO6M5Zk0sYE/F29EzooayWwVztOjQfT1Roi
X-Google-Smtp-Source: AGHT+IGcA13vL6c4ugk9PYxrjjpvIYxyA48/0OOUcyt6i/21n3ZP7grwU8ardiss45AZicduxRu41w==
X-Received: by 2002:a05:620a:851:b0:78e:c032:ec3d with SMTP id u17-20020a05620a085100b0078ec032ec3dmr5733432qku.17.1713308644166;
        Tue, 16 Apr 2024 16:04:04 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a439300b0078d6ef5fd07sm7844991qkp.50.2024.04.16.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:04:03 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:04:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yick Xie <yick.xie@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <661f03e3ad386_7a39f2942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240416190330.492972-1-yick.xie@gmail.com>
References: <20240416190330.492972-1-yick.xie@gmail.com>
Subject: Re: [PATCH net v2] udp: don't be set unconnected if only UDP cmsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yick Xie wrote:
> If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> "connected" should not be set to 0. Otherwise it stops
> the connected socket from using the cached route.
> 
> Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> Signed-off-by: Yick Xie <yick.xie@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

