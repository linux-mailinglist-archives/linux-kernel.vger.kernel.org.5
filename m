Return-Path: <linux-kernel+bounces-55541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA984BDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B8D1F230A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1014019;
	Tue,  6 Feb 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LVYTNWwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D913FF0;
	Tue,  6 Feb 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246497; cv=none; b=kU41aK9yhVmsn6+4gxuhlfhkgWhsQqxUulsDvdqKCnHb3V9qI2h3UvhrsvuncZRVujNj8lxZHNNLrwtXP3kCxZsjmSVbzrxBeYObRMssWJl8y0fueNpJ3h6d1ZIdf786L/vQIHFtCHkEEjhdy1mEVUBase+Fp3e/XP4sCQxNJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246497; c=relaxed/simple;
	bh=5Z2BovTB2FP3edEraPK/nJ0WYXm/OBj4X4o2+dRHDHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCrHIVMxgNCPRwE4c7YaRvm3EbqJl3L0Msi9l9LV8SUhz+n4nLpoqzFYm6qSd66u1+hBO5Wj/9TAjpLuRcs2PwHfI152c7quN8muZEkSlIstb7sEBfoS6PLU2BMNts6qnt/Z0Hk+iLiaFDtm4t/d0MNpVHk6H1xCpvq9ZD7o8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LVYTNWwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CDC433F1;
	Tue,  6 Feb 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LVYTNWwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707246492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Z2BovTB2FP3edEraPK/nJ0WYXm/OBj4X4o2+dRHDHE=;
	b=LVYTNWwYm9Wnifm+IPQytFsIAWPe8JRZPoAImZ+xzPkRASSk8ARmb0BFkv1v7b3KZjEBEd
	p/QCXwDCviVUlOQQfN09tIpxSlcGQbxkxlcWz6KmGWBlb4FZw0M8l7ZdpkgmvgnrIPbLlt
	Scnb/Mp3SgEFPF0wRmM213GES4sPrmI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fed1e447 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 19:08:12 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6047cfd1f5cso8553327b3.2;
        Tue, 06 Feb 2024 11:08:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxYCR3sCYh6QLMY55HCP2zPGN7wQ3kVTPAa6j6LbJM/oRr7lnW6
	W8PyCBqrcI6MaxfZ7lC/2OGVIS9kBwbO8N8KvbSSx4x8oew7/9h4Tr3Grk3VPlKSt3HDGjaCtXX
	NS2/lY7NNttEaY71F5bA2cNJoQ7k=
X-Google-Smtp-Source: AGHT+IFOV3Wdo2fUCv+WtJ2o5y/XqcPp1tWUbVJd5wtVPEHmafutx5P5ZJmnK/9+OaT6VsaQgi9vpUwdxEhxJFQC1YU=
X-Received: by 2002:a81:99ca:0:b0:5ff:85f4:27ee with SMTP id
 q193-20020a8199ca000000b005ff85f427eemr2455343ywg.10.1707246491366; Tue, 06
 Feb 2024 11:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205181111.43414-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240205181111.43414-1-n.zhandarovich@fintech.ru>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 6 Feb 2024 20:08:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9qkOEzzUJmJroZp3X2j=2Q6tE+EMYCr0bW3vYyK=M5FuQ@mail.gmail.com>
Message-ID: <CAHmME9qkOEzzUJmJroZp3X2j=2Q6tE+EMYCr0bW3vYyK=M5FuQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net v2] wireguard: receive: annotate data-race
 around receiving_counter.counter
To: n.zhandarovich@fintech.ru
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>, 
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Queued up, thanks.

