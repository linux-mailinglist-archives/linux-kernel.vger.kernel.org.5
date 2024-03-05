Return-Path: <linux-kernel+bounces-91990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EE5871974
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909E42825B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EF524D8;
	Tue,  5 Mar 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI7zDYJ5"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49250A69;
	Tue,  5 Mar 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630457; cv=none; b=WF3+KAZeELpnlvcnXVUT4gl+1ouz6VJHN3cEhj7D0elVXZzhrZgXa1KiiutpbznzmnFsVlpDMYow8TMGR5LnLwiSiUG+n3gfEJu4R4kO85khQHlAphEHFE9UCEfTTfCPQ9yM95MwenKSMzDRETx/Dai2CfSf8rUNCalmC9zAgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630457; c=relaxed/simple;
	bh=Sgyyt8kvTxLJxurki0hYZ0igZUYEyJwo/AUa81JBIM8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S0yuh77HzGfiLbgRiX1iOEF6ocpeE0x3Uv+fgAQwFVUsy/LEwSk5DSv+5veo/Awf5L7K5PTbjM8t8CMJuU/uLxnqJD9+iD2KMWCZr1Zn8KTPosL4MBYDzqUuxjdHD+zGMPDabhzcxYfqc5Qnvhr3XBnAWPy41WwaKnx2nWT2IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI7zDYJ5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7882e94d408so120987985a.0;
        Tue, 05 Mar 2024 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630455; x=1710235255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRRM/ARae3sSFkhIeSz5op1mbTEpfUsArfGcXBHTCfc=;
        b=mI7zDYJ5fZgq2niLF3hSsh1Ixt5T+WmzAlHCU4wyV2lr44iMu4QW3lOk3AMU+hsP0q
         cqUL4hpG8z7zrgCDLK4L2OS6lpl4340nsa/So0dNgRPjTM1sGqjs3ZqXmlTACZIR/0Ul
         TElZhKzxqfrp++eNQDZ/NYEiPhfOTgPcexEcfVCp6s6pU5097yuXifhOEUcFuZULLStF
         S6Zfo4CbwHnrShKx6niF7BsJMns0t3meHGtMNbP+DgY22eJG6aUDJi1C1I0W9ThXiL3P
         pCkj1Jaxs/ljzK21iC/b/eFIikz8lLWmLLCfsF1+2ZdcyOFi5/TsCc+tNoaKaXUp89CA
         msBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630455; x=1710235255;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRRM/ARae3sSFkhIeSz5op1mbTEpfUsArfGcXBHTCfc=;
        b=HXCIk6ZYLDzRuwAOs3CF/tTMbJFyPm59VCjlVr+rVlmCmLC+ScdGEW7OoaML43ttZb
         OzC4dnZDTeL6NnetiNwPfaRYuTZ4ALw0nuxrBoU+c8mMKqiAnfju2KpnSSa6DIGROrRX
         c2IwOSakfRMGq5HXiaPWG+bEJk7AnDI4YnyjBOa96RBf5B4RrRIcB1QCmOygYstW6XJP
         5g58miTQ0JSY/XxyT84IF06vuOtJQxgATgwHI7TlJzf6ikH/AcUlkbz+IiCOZUYg5BMC
         oLoK9uk7CtmFhvPSZsO+emzqNT8o40Q+SCNVfC8R9mwTm4akQezcwGrOge0C8LrZGbaN
         Ymjw==
X-Forwarded-Encrypted: i=1; AJvYcCVrw+XdubaGCg+PjMy7PgpUu01rJvaTOMKbudwp4VCyrnzMV9Q8dVQa/QGSkEb9Ce/2YwBvjvTgErD+HNQpaEQqWHKaaCuCyV8DnHi8
X-Gm-Message-State: AOJu0YxKRxUo834xz1yN3zR7WH/cxgPh2FbtyjWei7BV3kf6y29utLX1
	Hhc/+jZOJZvzUIdz2tFXbsB3cCj/EI2x1uJoH8SBdvkaWiAB1yYC
X-Google-Smtp-Source: AGHT+IHoFHlvP2YyD4zZfG0qQU+xEscrZXbwRFr/v8RhQVATagvUg9jqQOi7loyZcdnSOhqUEpiXfQ==
X-Received: by 2002:a05:620a:1a0f:b0:788:137b:b847 with SMTP id bk15-20020a05620a1a0f00b00788137bb847mr1555482qkb.7.1709630454804;
        Tue, 05 Mar 2024 01:20:54 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a0b4200b007881e5a90e9sm2926930qkg.125.2024.03.05.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:20:54 -0800 (PST)
Date: Tue, 05 Mar 2024 04:20:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 horms@kernel.org, 
 dsahern@kernel.org
Message-ID: <65e6e3f62c314_3cfad29462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240304183810.1474883-1-leitao@debian.org>
References: <20240304183810.1474883-1-leitao@debian.org>
Subject: Re: [PATCH net-next 1/2] net: tuntap: Leverage core stats allocator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the tun/tap driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

