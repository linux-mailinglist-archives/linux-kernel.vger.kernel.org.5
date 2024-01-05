Return-Path: <linux-kernel+bounces-18408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CA825CF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804981C23280
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B3360AE;
	Fri,  5 Jan 2024 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh94wv/f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE136096;
	Fri,  5 Jan 2024 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810d8759e7so209885a.0;
        Fri, 05 Jan 2024 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704495736; x=1705100536; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQyFGK18sBCI6dlds62qZM1cJoYfjwJznu/a2Ec9awA=;
        b=mh94wv/fX1rtF3KIaCOw6KLdhQhB9F+vwZel/IudYalxFSsbImDO1/secBleaDjM92
         zeIPsZL151vua6jPPhBkjgGgzEy6m/6SbpvzbVc3CHMtughUTHEmc5QgfYcg17B03d4T
         XteWEksmGNUboQNlShekDgN2R+up0mpM251VrrGs5InLPmiB2p89KS5T9TBefQTkzR7s
         esG4Tp4MM7qprxunB76nh1WYBQf2jVeP3Kzna1W/jCasj4vQ0RUamTZw2ipOJmkME1el
         u0YKybInZRcdrEeHdUw7RrDHrRY/F+Jx5KFOWP6rCT1EF8IHt1eCZYxI1Kk/OVF4IHmJ
         Nndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704495736; x=1705100536;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQyFGK18sBCI6dlds62qZM1cJoYfjwJznu/a2Ec9awA=;
        b=NIST+mgNPq5U1xHiH494OxaFUQDj/LZKY4anqwjzNdB0BCz/Eu8TVBxzivFt3FdmzS
         PRS3hfXP6zZCwQJt/m+DVkITpuc07fYBFXlIRkV25sxbqXXH9u2sOFcKFk+NJ2jUVBuT
         w+zE3d6RuISgUtk+xtallfPeORT1nKsdevnrabVNhHcFZkBUF0z9yckIKNgPw4OH+zAC
         F1cpMKHmypuhpEc4+H83GbQ74+B4t/IJwkBbc/SaATnVUwDUEHHt/3sDBLgC8X5xjuud
         HhroMnm9ZpCBMNeEPU0E70v+3OiPXGBZy1EI6DpwxuzvuYmndNxDy+GfM3d9QE4PEDlx
         tX6A==
X-Gm-Message-State: AOJu0YxE6PZHg1Kb7lfegQFhlp1JD60WUBHM3Ntnl96s99hBj14VK3hb
	nFQMz4WcpS7Z7RMhtSkvbG1VZnYvP+g54A==
X-Google-Smtp-Source: AGHT+IFVgDckdegLP44yi38RKX0R8iNrnT7y6/H/HAaf0pwJrBcIANZdCupdnUJbeQT85EDnjtRtyg==
X-Received: by 2002:a05:620a:45a3:b0:783:b9d:ec51 with SMTP id bp35-20020a05620a45a300b007830b9dec51mr235776qkb.4.1704495736290;
        Fri, 05 Jan 2024 15:02:16 -0800 (PST)
Received: from davidm-laptop (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id oo24-20020a05620a531800b0078156dd57a3sm934705qkn.15.2024.01.05.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:02:15 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pm tree
In-Reply-To: <20240105081937.25076977@canb.auug.org.au> (Stephen Rothwell's
	message of "Fri, 5 Jan 2024 08:19:37 +1100")
References: <20240105081937.25076977@canb.auug.org.au>
Date: Fri, 05 Jan 2024 19:02:12 -0400
Message-ID: <87y1d32xl7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Stephen/Rafael,

Should I send another patch, or can someone add my sign-off?

I didn't realise I was supposed to add the tag, but I certainly do
sign-off on e2605d4039a4.

Sorry about that,
Dave

