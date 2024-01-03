Return-Path: <linux-kernel+bounces-15041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A64822696
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9495D1C21B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C911399;
	Wed,  3 Jan 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLvOEsXZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F381108;
	Wed,  3 Jan 2024 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680b1a2c966so14930136d6.3;
        Tue, 02 Jan 2024 17:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704245936; x=1704850736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC3YNpZQ824RvnO6l/cHjeHZ3qIOYGfCscSR0Xu4SHY=;
        b=aLvOEsXZoBm6zsmKM6cYKA3UPQN6cc1g+G8aUxtPjaDaFs5Y+/WsUyzakZUUm+rPv5
         g8Vcsjzpx6SDoyaVWWj5i0J4zxD4BK68MyE9ypMqLijEi36iDDpAVgzPPi0CxFMHj+3a
         nNtJlVVfOTG9s6AlS8ULVc3I+zFfsEDIIdJg2n/cRcwQs42bJ+OaohM8l0UtBNw1CB6s
         kbMyWCPBwLruX2J1mOsHpIkPLmumte3fpVZiepVHZv+rYODqrLe8BG9beupB5HNCTdPI
         BpTsZyXWJ8EH4KbZd7utUtLhBb2KiJsu246BDgdO7Sq5AlbyPPQ+qHoNgj0/uxDuCFDt
         N2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704245936; x=1704850736;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FC3YNpZQ824RvnO6l/cHjeHZ3qIOYGfCscSR0Xu4SHY=;
        b=vxvlK6JrjzeFODkhqfsUcog+nTTe1aR4zIx9I9k5TswQoCXr9AUb5X6JhPwFPJHitm
         trvrmA9OvXq3VE9HNw0pzowYlSNcqAbIL7lx/18AIEnKhJLAbqohImMmPcXSgqA01MwB
         gWd7jHcFsVScYhSWXBRp4SePykG3gfJyA1dt4jkHAJfYnTCuOGbDwYnw8wyoynKwDy1e
         FZWSf3SDUVbvBEUuTu+GmcqTUPxasxUdploJEbMetCAVsQTza+mZhWazMVMT7WRXuqqF
         kgAsfcXOQ6+v7QgGSDkPAELRNPDLK/ftAIsSwHagkfxiUDQt0rvut3KmzD9OVDiIB7NV
         qGag==
X-Gm-Message-State: AOJu0Yxai061RoCoHNqZydyJ/DQhN1MIz4pJeHkULb4Qe+TARuUrSH4p
	hpDw74ouWEmP264owjAoG4jvZUKmG3U=
X-Google-Smtp-Source: AGHT+IFDvPq3TzqkSgnyyR4hQaDcBezziHkJCMDuLOt7XAqrnqdfbHY28UPqj3s4Ta942mEH66MB5g==
X-Received: by 2002:a05:6214:19e7:b0:67f:4f8b:e298 with SMTP id q7-20020a05621419e700b0067f4f8be298mr30598302qvc.0.1704245936508;
        Tue, 02 Jan 2024 17:38:56 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id w6-20020a0cef86000000b0067f77ca8d18sm10555731qvr.96.2024.01.02.17.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 17:38:56 -0800 (PST)
Date: Tue, 02 Jan 2024 20:38:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marc Dionne <marc.dionne@auristor.com>, 
 netdev@vger.kernel.org, 
 Jordan Rife <jrife@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <6594bab0a524_2c093829412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231221131230.2025000-1-marc.dionne@auristor.com>
References: <20231221131230.2025000-1-marc.dionne@auristor.com>
Subject: Re: [PATCH] net: Save and restore msg_namelen in sock_sendmsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marc Dionne wrote:
> Commit 86a7e0b69bd5 ("net: prevent rewrite of msg_name in
> sock_sendmsg()") made sock_sendmsg save the incoming msg_name pointer
> and restore it before returning, to insulate the caller against
> msg_name being changed by the called code.  If the address length
> was also changed however, we may return with an inconsistent structure
> where the length doesn't match the address, and attempts to reuse it may
> lead to lost packets.
> 
> For example, a kernel that doesn't have commit 1c5950fc6fe9 ("udp6: fix
> potential access to stale information") will replace a v4 mapped address
> with its ipv4 equivalent, and shorten namelen accordingly from 28 to 16.
> If the caller attempts to reuse the resulting msg structure, it will have
> the original ipv6 (v4 mapped) address but an incorrect v4 length.
> 
> Fixes: 86a7e0b69bd5 ("net: prevent rewrite of msg_name in sock_sendmsg()")
> Signed-off-by: Marc Dionne <marc.dionne@auristor.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

