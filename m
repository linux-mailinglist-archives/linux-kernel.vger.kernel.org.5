Return-Path: <linux-kernel+bounces-152172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4A8ABA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35211C20B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460601426E;
	Sat, 20 Apr 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7/14+jc"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BC125C7;
	Sat, 20 Apr 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601269; cv=none; b=HM8yN+muEehho2FOMc6oG2HFl9RjzVruMiO0pnnInN/kUQ7IsfYwJlB5DqOsqvsrW05VKv2QDS9qkG0OCiTCyC89QTll+rRMQ9CFd9DOIb6wH0SrE0vXN2qsjcJ4AZusz0PNHggZ2Q9sDxsxVDEDop4btnDH36jfasjOZ7gf3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601269; c=relaxed/simple;
	bh=CM/+cAjyrx/umPb70TdQ6o0MIWdOkChhMn69jSOSbtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbcHnV1O36t3A4sv3X8wHf2Ut/KAT0eD+Hi90JHAo1Rd8/CESYBD8Un+FeapSvEzmJbatd8eahkUHHlN2aa4Fn3AvKvb6pCb/WgHRkjS+YHRRbZpx46pGVExa2PxdVIDvh62iI/dTwBD8pJCdXBycTid8IXqyGqdd5jPshyM1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7/14+jc; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c70ef25e19so1318837b6e.3;
        Sat, 20 Apr 2024 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713601267; x=1714206067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC8MGZH1e7UDE4rfEJ3W5P3/vWA2hHezrcq6mh7lqLA=;
        b=G7/14+jcmtiVoLWTzOnEmPrVfT5fHQOcjZ+Cyp5NjQR00+T2DEdJi44+YTHuSFOuyA
         hJXFqrWkJ+iNVOWZAWYcrxYf3ZjOYNPf2y6ExqSNsG7B4juzMZ2V3rkyhz3vjaHN1IWZ
         Acx++SeBbnKRORMR+yZQRWnr/+Se/ZdQWmeicS9O+b74dQRoLGWcqas334PruZ9DZpjD
         WoWMHFFfA+p97LDXkefMPbjK8DVIyghzM5glckh2hGBb0vH3b1JubWuR63HPa48CBt1M
         9/lZE5gz3grDcbMHPCPOqxmcRjE7sMelhOMFe8DdK65Fnv1dT/pUXdYMWTzwTkNvuPOl
         uxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713601267; x=1714206067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC8MGZH1e7UDE4rfEJ3W5P3/vWA2hHezrcq6mh7lqLA=;
        b=wvbhzoZhBQBXeDAXWrv2oqbFZs6Cms8bJOU4nC2QneXS8l7I5aARxNG58x9gwRl9pN
         CJ5napsLHHCkJ3dSnP963sHnwjkOpyvtevmZwyK2/LI65qTgAnqHUfh12/Ubh2DdfoQN
         w237ysHG4RuDBPwWd9KcwXO6VONImfKcmSr2Smad2+McgHE4iv3ExKX1K4P/q7aZcO8D
         wTzeUgQMVjsDtPN6eXiojoGg8YGUgQjxrJ7+tle5hGfOwTWE36Pa8Kh/SQf4djyjEMR0
         SiKAqaxQMaIhn5OZbpof14PPhI++TpnFbMAsMhgRIxDFrUxAw6WJB81i527G6iSnXVy5
         0ehg==
X-Forwarded-Encrypted: i=1; AJvYcCXSCZTidi2tsRocJeUWj5qYfDzTKALGgSsKfX5R8QaZIQyQTAm3nQqzLUO+doq1e6cG/hU6+BakAq3Ntna8RTEWFy8RLE6x+UurvJm8
X-Gm-Message-State: AOJu0Yw80BTF6UX0yitpd2IC8+p94Zk4vFlh51EZyKeJs+4Xqz1YD+4F
	nNnJzfOCRQWDwlv2xZkpNfmjjjqlBKCT0DEXYHsTnMhnh+6oR9cU
X-Google-Smtp-Source: AGHT+IFCLWgrDQCTwzW6CervKDzR+V3n2iXrThMK3ZraLyVfDsExAQwHxZXlAYaf6AUPRB2arYfdlw==
X-Received: by 2002:a05:6808:1c8:b0:3c7:44d5:3f34 with SMTP id x8-20020a05680801c800b003c744d53f34mr4607654oic.37.1713601267168;
        Sat, 20 Apr 2024 01:21:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm4597506pfb.140.2024.04.20.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 01:21:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: kuba@kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v3] net: hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Date: Sat, 20 Apr 2024 17:21:02 +0900
Message-Id: <20240420082102.63841-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419200453.13301f29@kernel.org>
References: <20240419200453.13301f29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After looking at this email and testing everything, I have confirmed 
that both patches are running without any problems in my environment,
and the patchwork test outputs an unknown error in the patch 
in ap_get().

But the patch for sp_get() is confirmed to have no problem,
can you tell me more about the problem?

Thanks.

