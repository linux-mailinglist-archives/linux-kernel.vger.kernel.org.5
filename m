Return-Path: <linux-kernel+bounces-10124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E381D092
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C184B2371C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69FA35EFB;
	Fri, 22 Dec 2023 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW+PEk9f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55A35EE9;
	Fri, 22 Dec 2023 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb802341eeso1491727b6e.3;
        Fri, 22 Dec 2023 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703288641; x=1703893441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9uJAXYaWWEwDD2fcwcXO74cohGnyjB8jlMg/uP61/M=;
        b=FW+PEk9fHJnm9Vp1Vx2pwATmIWIriq3uR3HtR8Vm7OG9HJLybLb/qD2Ya0ZjNWZXR6
         ww1KMrJS4m0ROsr2V3JWKwcp4+BckdsacSgMig9wmeSUXxAuIuzTCaqw/WmaSDjlq6cJ
         wceaypqTMwIC0IzcZHcQKge/D1fm6blzrGjBCbdPRIVfifD5Rd7U57mBlaeNVSSfPuVD
         2CjPjMxxQUp6bWoUb5lzXAiFqq8Y6ufaWAeihfilN2iObyi45CsSmIkkj+08XbYaeFbo
         /yiploWYmBi94qVtoJtE/3dXmY5MN+j8qAr45E2/zIRnEIwAYfgsl/tvi4AxeDmu/ZdZ
         Uv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703288641; x=1703893441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9uJAXYaWWEwDD2fcwcXO74cohGnyjB8jlMg/uP61/M=;
        b=WRNosEVNgcFsrBW2IC3FgxkGdpQtYQ0l4W81lxfZlAUwNxLYSUi7Mr8QFdIaqY8/m3
         A6Xzn4CP9gVRIp5UBf0gKlqjlu5UGulT5XgwvPtfZb2013yQ0PaUGXsnYTXg7o7OSaus
         broUx43pp+RYTw4zbymw3YPV08IkumvYmmGdURyih545n+yGHKheDCNWde+8FoEnZcdm
         +oUaBTWcgKyQsgYDFLK9hLs1lyB4thTdSyUx8H3RsPYmsNuUWTGEwyb+HGOtfcmP7JyI
         UkCY67MeyIFq9iMMsK/OpB9QuMNfudpfm2YxYcYrmw2sIHmB7gO7+FsJAQ6Zw+PAd8WH
         yWWg==
X-Gm-Message-State: AOJu0YwhICgKhZmwTKQh7cV/+RMnhGZ4HckCnedHJvoeTA+LDNv+f5+M
	U1eUg4g0CyNihpGB/fnf3txSUS/KI/ezRQ==
X-Google-Smtp-Source: AGHT+IEBcMAdxLDV76HXmc3OCUvAfcCQtbzCX5BinmvoHbmUgdEY1mZjWmlPxQP4eyZbz6cYaXOUmw==
X-Received: by 2002:a05:6808:1247:b0:3ba:e56:4778 with SMTP id o7-20020a056808124700b003ba0e564778mr2514960oiv.100.1703288641539;
        Fri, 22 Dec 2023 15:44:01 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:b835:c8f0:af87:712f:cf12])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b006d98222b74esm2326427pfi.46.2023.12.22.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:44:01 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: dan@danm.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bagasdotme@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
Date: Fri, 22 Dec 2023 16:42:27 -0700
Message-ID: <20231222234237.44823-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221231115.12402-1-dan@danm.net>
References: <20231221231115.12402-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 4:12 PM Dan Moulding <dan@danm.net> wrote:
>
> I started running v6.7-rc5 on a desktop and began having problems
> where Chromium would frequently fail to load pages and give an
> "ERR_NETWORK_CHANGED" message instead. I also noticed instability in
> avahi-daemon (it would stop resolving local names and/or consume 100%
> CPU). Eventually I discovered that what is happening is that new
> temporary IPv6 addresses for a ULA address are being generated once
> every second, with very short preferred lifetimes (and I had an
> interface with thousands of such temporary addresses). I also found
> that it seems to be triggered when one of the devices on the network
> sends a router advertisement with a prefix that has a preferred
> lifetime of 0 (presumably it's sending that because it wants to
> deprecate that prefix).
>
> I bisected it to commit 629df6701c8a ("net: ipv6/addrconf: clamp
> preferred_lft to the minimum required"). Upon reviewing that change, I
> see that it has changed when generation of temporary addresses will be
> allowed. I believe that change might have inadvertently caused the
> kernel to violate RFC 4941 and might need to be reverted.
>
> In particular RFC 4941 specifies that the preferred lifetime of a
> temporary address must not be greater than the preferred lifetime of
> the public address it is derived from. However, this change allows a
> temporary address to be generated with a preferred lifetime greater
> than the public address' preferred lifetime.
>
> From RFC 4941:
>
>     4.  When creating a temporary address, the lifetime values MUST be
>         derived from the corresponding prefix as follows:
>
>         *  Its Valid Lifetime is the lower of the Valid Lifetime of the
>            public address or TEMP_VALID_LIFETIME.
>
>         *  Its Preferred Lifetime is the lower of the Preferred Lifetime
>            of the public address or TEMP_PREFERRED_LIFETIME -
>            DESYNC_FACTOR.
>
> Previously temporary addresses would not be generated for an interface
> if the administratively configured preferred lifetime on that
> interface was too short. This change tries to avoid that, and allow
> generating temporary addresses even on interfaces with very short
> configured lifetimes, by simply increasing the preferred lifetime of
> the generated address. However, doing so runs afoul of the above
> requirement. It allows the preferred lifetime of the temporary address
> to be increased to a value that is larger than the public address'
> preferred lifetime. For example, in my case where the router
> advertisement causes the public address' preferred lifetime to be set
> to 0, the current code allows a temporary address to be generated with
> a preferred lifetime of (regen_advance + age + 1), which is obviously
> greater than 0. It also, in my case, leads to new temporary addresses
> with very short lifetimes being generated, about once every second,
> leading to the application-level issues I described above.

Sorry for the unintended consequences, and thank you for the detailed
explanation. Does this patch fix the problem for you?

-Alex


Alex Henrie (1):
  net: ipv6/addrconf: clamp prefered_lft to the public address preferred
    lifetime

 net/ipv6/addrconf.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.43.0


