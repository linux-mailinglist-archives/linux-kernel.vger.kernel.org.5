Return-Path: <linux-kernel+bounces-101867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947887AC48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04466285426
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E260BA2;
	Wed, 13 Mar 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0AvnPKj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160360881;
	Wed, 13 Mar 2024 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347985; cv=none; b=RTEuWWDI+VJVD80zWPG9HBVyeq6xZnB79AUgvqksWovFc4g8t/oJEi/iV/Q3ObpST5Q2kmPFYdTIUvVgE6cYXIvQuB/+RChh+zEMEZD2xw343s0GsHjRNrQ4cJI0Y0MSPoXa6R4YEDtI6qojDhDPz7mw6ixeezOcy/vdQ1rGX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347985; c=relaxed/simple;
	bh=gBpHjSZpjDFXvuiIbpzC535LhD6ix8zxBIgTnu8tYLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O8FFTlGziLxYHOB1iNvGlWNOCfKmzq7PBbWWnmABioNB8upf0J1rs+jvT4+XtwUkgrMXe8rPzRtEy1PVdh5aZ0K4/J6FWb0uQwO0+y1C2e0K2l1/coOuIK4Nkato1MjwPZnW33nN0rBlqG3Ppjn2qupt1gvkj9Y3KU7Xt3xlJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0AvnPKj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413ee4d4f64so424385e9.1;
        Wed, 13 Mar 2024 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710347981; x=1710952781; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8F8neoasSZhR6V/DsTj5KFDld/PtQqmCaaEQYiHmneQ=;
        b=l0AvnPKjQc5mLgsFwHjE8ova6jNYS54eKKnATUsfWE1mzW7eTgZPFCmqPV+R5RcZ9M
         WK9+mU4pI4C8Ka0eN0SDuxzYq3utrZAD0T5gYTuz1MJp1snAbEZVUECgGtlkbzyTfHRj
         VjnYrA+Jbfnw0GiicgNwftsKF2phTcU3IcyFfbEYQZAKicrE2coTOJOOUz7JAtIVoTJz
         ynwOrutnYX98Xnnw2G+2sjtoJtSznG9pO3eNVcMAemKVps3S7r5HTjrIPzLgBtxjKmhq
         Q5y6ucAJM0evEfiZgxs1hwMJoUtL9ETWNDU9GVQ3IjCb0jdv+fgKHHWDAHgV3JjvrfgU
         nwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347981; x=1710952781;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F8neoasSZhR6V/DsTj5KFDld/PtQqmCaaEQYiHmneQ=;
        b=M0JWsI0TQWW9OEVdB/Q7dnKzA7NVX9D1VlPMakVdAA1wGjudtCzCjy2hpPX8eKqo+c
         Nv194+ONNkpC5UISRZVhh7HkAZie3+Mxtrk3oUc1KFXRMvFyst47EhUV0hEa1JuUEC49
         XSZRUGWK+TaQmMfkw5stnK5JgXGXhwpQs+KuViaiswHIx4sklQA7sw5dOREG+8b1DB87
         EtanW0PbQG8b4Wa5CAppjl3CsAUYab4gCTXIfGq0F1EfAHe7Yme8c0i7IQq3l2oUYILx
         4L31/GVDnqruXH6JPicKrsyKx/UZwN6e6xSsV3pj7WW9ebxN+TBZ15ijwjuWzZmjN+15
         iBag==
X-Forwarded-Encrypted: i=1; AJvYcCU4n+4sI/XOCsHt82SYHBSus09aTGe2tC9dUAHktCvg5TUXffxVrurlyYk+bqjUL8wqKAmtXbumtjRokrCa/NpeNsXmsN3LAlSNvN2p
X-Gm-Message-State: AOJu0YxczSK9Nea1tztMBYwt8aeOnJKNYErI5StF7bnAlBD1CXjpuaY6
	9mUEu+VR4QeFJIDgXATWCV6ISGlAciBcHisfgCYs8cywE6sc8Io4OpOeCcYD
X-Google-Smtp-Source: AGHT+IE2uHk9GewV6px4YV+5kfONQ7dP8tNoZOCWOZPepd0bNIcgWH6EoE3nvjiS2DHqsfnZSXvCYQ==
X-Received: by 2002:a05:600c:548f:b0:412:d149:254c with SMTP id iv15-20020a05600c548f00b00412d149254cmr392744wmb.17.1710347981195;
        Wed, 13 Mar 2024 09:39:41 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00413320f795fsm2805025wmb.35.2024.03.13.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:39:40 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:39:39 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.9
Message-ID: <ZfHWyzu2sVF6kno6@antec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 7f1e2fc493480086fbb375f4f6d33cb93fc069d6:

  openrisc: Use asm-generic's version of fix_to_virt() & virt_to_fix() (2024-03-10 08:55:46 +0000)

----------------------------------------------------------------
OpenRISC updates for 6.9

Just a few cleanups and updates that were sent in:

 - Replace asm/fixmap.h with asm-generic version
 - Fix to move memblock setup up before it's used during init

----------------------------------------------------------------
Dawei Li (1):
      openrisc: Use asm-generic's version of fix_to_virt() & virt_to_fix()

Oreoluwa Babatunde (1):
      openrisc: Call setup_memory() earlier in the init sequence

 arch/openrisc/include/asm/fixmap.h | 31 +------------------------------
 arch/openrisc/kernel/setup.c       |  6 +++---
 2 files changed, 4 insertions(+), 33 deletions(-)

