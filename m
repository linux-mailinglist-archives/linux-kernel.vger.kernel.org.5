Return-Path: <linux-kernel+bounces-150679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37888AA2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32A11C2272F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF0180A6D;
	Thu, 18 Apr 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoQFXyBT"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEB17736;
	Thu, 18 Apr 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469091; cv=none; b=qZyV7aYC+5toHKdpJ18jEX8hu+LiaeazgSGE2YP6fyV+CFsdu3COxZm6cqHeLnqZ9f0CQkDChG4GWoAGoWaDoODUn5Ks2/zPDIpV4B1JNuWdmtO+xGrXp6xqIUB+ppb7JM1fGXTuYgoZHu3q65lPK6iDjz+kFr8vfE/wBph5Ut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469091; c=relaxed/simple;
	bh=krN7TDVY8gsasYGH21Hk8s3B3pWnfrUYQtqBSfSjSD0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XsV4jgTuQXld0/mY+P5K8ZGmHeI3SgNISlIQRstQHknPhB9Ulko6cHGEXESe4iFWrLrOz2lK4LioVMQgtAM1jnBwzpBEuNDXaCxNCN9wupa9+1ocIn/+LnVFnFi+7SL+UYUVSptqOhBSMs8Sti5mVzaSU0Ny8irDoeMEdTwOeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoQFXyBT; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dcd4cb27beso362637e0c.3;
        Thu, 18 Apr 2024 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713469089; x=1714073889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73xcy9UhpOQbwGv1P/rFuD3j5Fn9C/d34aHsmJnVy1o=;
        b=ZoQFXyBT/6BM2razCldrO81fIK9VIBnATEXZDZ+zwwiPI9W7Rumy7mcbTRF86yY/D+
         IIqNqrWsJK00SZEekPm/89nAsoMPIuYQ6L9TxxAgesfMLfbKAw1RSkFgTULjiv3Lu5NB
         rKdd7DqkLRwecB5iub7ryQOls/om31MnlLOuACtdWhqx27VM6bXr/pPBqYjAmjdYN5H6
         LTVW3JREH6ZhxZ00ySOZtZavhcvIUdYpJXEMIdGrAvDhF1wTVobplRa4T+YQdSIOlBhd
         fuoESU48HBDm6rtFr6crRZG+/WHtw2oMGT2G/n9tq+5f9c4ZclQtmbyq3oTRZEokktNO
         /QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469089; x=1714073889;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73xcy9UhpOQbwGv1P/rFuD3j5Fn9C/d34aHsmJnVy1o=;
        b=tDEqv9hBbN7QVtylo1V8GwyBrx77VJ4jaKCW7dg/wlk6XJQNmh9aMAJ/9w+6t+unxk
         II43vXrjfXcCcoy0ot8IAQB6CeCba1Tqz2klDzLwoR+r6HnN5yY+M0DHOfUN+ui4iE0B
         hK/KUJb6jK6e3ngoHiDb25n/PmMMHux7a7pNCVirODuVQRaMaB7qOrvcIBJ1p48+VYKM
         sei05nPzR/mS08DL4dJ/AG8yliwMwpuySARI+Mj9w6QlvuQ8W8Ixl5fiEOiec3dr6djt
         Dzxv2NZS8057hXwDJ9/iJCu0THRyOhngm0fFjw2wFQ5HAhxSs2H2u01EKZSt0Pc10KxH
         A8fg==
X-Forwarded-Encrypted: i=1; AJvYcCXADeMxqO+0ZjmnA1iSkUGEPar2IP30CZ9xqPRAhPcAkbqVbWU1L+1VB0y0/ym4y2bjO893UWWlKl3AjdbFidbjE+StcNNhx4c6dH4nKSScKpcUi6Ca0wgSoszqADDbQsT5ohxV
X-Gm-Message-State: AOJu0YxwpQwFgnxaO1t9iqdwgEStcHgMrbTkanTkWFFuxLAX2nTQlO3I
	RxxNijnWAQ7bb+bCvw2K3OS14gfcTxsqQAb5SKIUMSLtfFPsii3b
X-Google-Smtp-Source: AGHT+IHBKc0wN3jAJfQwdq2HZ6fSIHBZYzooVvacnfYa+xx7vPre8ykaNL1aGlkdE0n5zkvgKs7M0Q==
X-Received: by 2002:a05:6122:8cf:b0:4d8:df31:6b34 with SMTP id 15-20020a05612208cf00b004d8df316b34mr3771436vkg.8.1713469089105;
        Thu, 18 Apr 2024 12:38:09 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id ow17-20020a0562143f9100b006a05aaf748bsm433587qvb.81.2024.04.18.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:38:08 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:38:08 -0400
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
Message-ID: <662176a05a2ff_f8180294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240418170610.867084-1-yick.xie@gmail.com>
References: <6621259d66d0f_ec9b929478@willemb.c.googlers.com.notmuch>
 <20240418170610.867084-1-yick.xie@gmail.com>
Subject: Re: [PATCH net v3] udp: preserve the connected status if only UDP
 cmsg
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

