Return-Path: <linux-kernel+bounces-101375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A487A643
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EC01C21045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300E3E491;
	Wed, 13 Mar 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMg2o1dH"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3923D548;
	Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327514; cv=none; b=Ikbad56SqCUZdH9ZG0d6R4fJtajkEztfPUUDsjLqTeh+iBTdetnSPvHTwwh245MCYxYUpys8sb20Kx8EumhSj5SqmibmXDYr115n9lXHD1D6KKY71crgTDRbDVG8radbYJFaDIVeqKrmIyJjA0QVQuVCPP+lNr99qYVzaxRAGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327514; c=relaxed/simple;
	bh=Atdyd4iRcOIB6SximA+lOzbaGWSLdUjyiRBUswIGW18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tb7k+gWYlBa3LbRPRVTAxggxthjc9RW9hpygYnckP6AHd8GjAnWEznJ5lizIndKFLvhnTdlYqtjNKBUVAPc+/REELEijMUqa/xV0cl9KPuj6SXo/f2Jh3/f2VokWquo+2a+Aj1kEmCskXwQASMV4UlbPt16waIk9DfDQLvby4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMg2o1dH; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a19de33898so493188eaf.0;
        Wed, 13 Mar 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710327512; x=1710932312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rE4lzNuJ8QYXgQLqej+lU+X5DW/HUYj7GofK0E/I2I=;
        b=lMg2o1dHXRvYMCYlP5RJhi1N4VrwiO0n1N5eFRKXbVwRXsvHJRqKq2uji7IE7VKlnb
         r2qRrnwnIU6nSufdBmfjTvyGc8YLXUWaCiN4FPegJHo4zaAawOSf+mdFYFY3oTwieob0
         ixesIu4B2o1UivF03myTLWOAk3BmJc35DMSh72bj5dPelzNStcR733JhAPVuRgYRihcv
         YCOWaO4dXH+iOuQdM6zviO1qwesnWvuklL0rICh79tnH6ivPrM4/6DLfLDBCrOrSfmYZ
         yGsR4013c6qi4xOKNqkqD9vzuAMppwV6xZcfrXlTKZ2vxG2dmKCKXrAAJsSZNLow0qiy
         imXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327512; x=1710932312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rE4lzNuJ8QYXgQLqej+lU+X5DW/HUYj7GofK0E/I2I=;
        b=bVi25yDVbFvTS2sc1KtP1eQL1GoAt4qne8aggSrO1t4VZPa55Nc8RnmWB333n8Bdg5
         c2/BPsVdCW+TvVSpq6xsNgxUA9IXO+nWqE1SUrTH159UYe2oZIC/POBo7Rt3YbOvsPr6
         27CEEuEVZyPKdKIzdxKKG9/7JYOQvJd51Z4yl3FwrlDW3t3vnulU1Gtokv6cVua6sP+e
         XQMoSV3EzkOdXYefntTsbALsX1jNPKXuIS1eSHqe2LRaKllAnXcDYajUgw7Pjm6Ebg03
         DsRBVAvysH8Y39/3phKkiN0/c7Mwmcswr249ww4x7HWMoHQOZ2b4GHG7lyZMXO4T39Jn
         vvZg==
X-Forwarded-Encrypted: i=1; AJvYcCVY4i0LJc8fS3XzPolIn0Y/hPegz3RQhyt4/HlOeMsfuIxtovyLBgDmWl7zxptZnyODOMg161r/idtR/q2ci42Ug2Xoq9qT6J+5Zh2qFNhMZSF4zIMwnjTC9PcA/5tCm05Lmak0Cm/xH2E=
X-Gm-Message-State: AOJu0Yz5UEKFm6fsnpdAggw5Lr8Oj1Xthd3qKjAm34aQ1qpP+t4Vc2jm
	zLQhDy9fN9jLBtMSWJ6yF3WE66bwiJ7fUizfI27QiQFkZuMxBhjL
X-Google-Smtp-Source: AGHT+IGd+sB9zJ9kHVMgMm/DrhiN5KWMeYMgh43NYWG3ZMMfZTh4G7PFD0ZEvbTwceT0Y/5SZTpa1g==
X-Received: by 2002:a05:6870:3050:b0:222:d78:14ce with SMTP id u16-20020a056870305000b002220d7814cemr6220699oau.48.1710327511794;
        Wed, 13 Mar 2024 03:58:31 -0700 (PDT)
Received: from carrot.. (i223-217-148-4.s42.a014.ap.plala.or.jp. [223.217.148.4])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006e6ab7cb10esm2338844pfa.186.2024.03.13.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:58:31 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nilfs2: fix kernel bug at submit_bh_wbc()
Date: Wed, 13 Mar 2024 19:58:25 +0900
Message-Id: <20240313105827.5296-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002df264056a35b16b@google.com>
References: <0000000000002df264056a35b16b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

please apply this series as a bug fix.

This resolves a kernel BUG reported by syzbot.  Since there are two
flaws involved, I've made each one a separate patch.

The first patch alone resolves the syzbot-reported bug, but I think
both fixes should be sent to stable, so I've tagged them as such.

This series does not conflict with the currently queued conversion
to kmap_local series, etc and can be applied independently.

Thanks,
Ryusuke Konishi


Ryusuke Konishi (2):
  nilfs2: fix failure to detect DAT corruption in btree and direct
    mappings
  nilfs2: prevent kernel bug at submit_bh_wbc()

 fs/nilfs2/btree.c  | 9 +++++++--
 fs/nilfs2/direct.c | 9 +++++++--
 fs/nilfs2/inode.c  | 2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.34.1


