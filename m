Return-Path: <linux-kernel+bounces-70840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96949859D13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1799B221F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661920B28;
	Mon, 19 Feb 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8SpurX1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6520B0C;
	Mon, 19 Feb 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328173; cv=none; b=r0ySvCIbxuTnO5hn8GSGt2aoCXTYdRhEB1LG5f5u75tKA82p1TVRTSoT5ZXnFNO5B47EP4C+ydXIp5sq+LCeqWztrhvBKljrtwg5TDRIKSxhvBojzS8rAM88UsDyhOANNvPnoGsXLb/yiKmWhZlcJf0mUP8tQTIBxeM4Wl4Jqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328173; c=relaxed/simple;
	bh=wIzkxKsImbJ/HmssMD5tyTof/KWUePGTl995Gj1hfuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPHhpj32rujCbFhraW6g47z4nOMMpo+um3rIS0k5emO/Dt2oUqRTNAewePSw0qz3z9Z5DiyFuZLnJm2XrJbpVPt+PowWASYV4ULaHgesX122FngwAIgMqCeBb8/YIKZ9mcjavtbfKoiLE0/1I4Ph8VwLgBtvmUL2NHNRkIPepwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8SpurX1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dba94f9201so22470175ad.0;
        Sun, 18 Feb 2024 23:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708328171; x=1708932971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4N1yqqNc4soYKuEhrWS71Ru+gC8kE1SCU4AAgr0rrDg=;
        b=I8SpurX1kmT+30vzWd0G6AY7kJ5hCHYuashKKN5oHCLaWy+lPGqpvB8PYPicP9W3hZ
         mj/lPb7tEaUDVuLx1HfP7jKYEcqSasC0iWxne24LPe1c5MRdPSeXuNwlBItbvqp3XMyR
         BOiwIllqJmqR5wG+cGgDKLbySnrCkxwOOqHOELDxvw14hEl+eZRXPiE7cadxAXMynCxN
         ThS4iayewibDqZGSBpbjh5xONO1Pg7mN2AT1rZH68I/1omoOSUYXqKVJ8U4D4za4RVAx
         BvZBfn1gq6NNZn7Txve7Ar7JCy/4Uq/Ia8xyIsw4oAGM7G/yk6yjWBvtZqbNAWwqO6Nx
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328171; x=1708932971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N1yqqNc4soYKuEhrWS71Ru+gC8kE1SCU4AAgr0rrDg=;
        b=FR/hcMxoKOSyUm/wUQne0U9ljb9i8qy91HzqDxYci5Osgj6/hjsFDGIW/nkhH8Uk6x
         6PXtFDuUAYYlOOEeoVobI99ebRZpk1iP/b9ArHIMZcAzdkBW/rSuZywysSvw8f48GN/G
         uWqw9GB2x1+U5x7kMdN4iSL0qFO6ycINzvlMQuIwGgc+VcTpMj2v9w9DxNLlNSeiVq2N
         0QQWkRQTs6bO3PF1DFtdJCKXOf1lwE/X+GTirIuf9pX2cDHQDkdpXbXaIBEgxa1onlTL
         VHgVl4NLbufRU2HThawUN6FErRBasZ5tNW9TNHqics4ZBycVgTd/bJbwmo98iNYigTNK
         K4AA==
X-Forwarded-Encrypted: i=1; AJvYcCWHDW1qtW/YNdaI7Ip9i0wYPcAy4utgYypVlUSR4djtrFGBYjEVWEZ1G1rXBlpfYzZYeB8uCL1te9tj3tCjIc/PtzwM4FuxbjHkSuAvwL8=
X-Gm-Message-State: AOJu0YyKOrcact7pfD080LDGAM15bkU2MnE0+UwRan/APsDiHldDENSL
	qgrpYyKLQgWO4R4rg4RpgR+42U+P+/OxG4hYkx3JZp03rmxvLZkn
X-Google-Smtp-Source: AGHT+IHs8GXSK9XI2HyilcSBZzWK4O1deawwav7eDTKuX6MVUVVvKxLRBOq7IvRlT8MN1YHHVAiSFA==
X-Received: by 2002:a17:902:d4ce:b0:1db:ecf1:3b71 with SMTP id o14-20020a170902d4ce00b001dbecf13b71mr3546621plg.53.1708328170947;
        Sun, 18 Feb 2024 23:36:10 -0800 (PST)
Received: from gmail.com ([192.184.167.79])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170902fa4e00b001db8145a1a2sm3717861plb.274.2024.02.18.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:36:10 -0800 (PST)
Date: Sun, 18 Feb 2024 23:36:08 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <ZdME6NUCBuy3yq7L@gmail.com>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdL7_-2VCJqjn634@gmail.com>
 <mtelhhn3z7qfo35odeb37doe3pqagesju46awcjnsyhq4xdk7t@ufoyklpskiyf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mtelhhn3z7qfo35odeb37doe3pqagesju46awcjnsyhq4xdk7t@ufoyklpskiyf>

On Monday 02/19 at 02:03 -0500, Kent Overstreet wrote:
> On Sun, Feb 18, 2024 at 10:58:07PM -0800, Calvin Owens wrote:
> > On Monday 02/19 at 07:21 +0100, Arnd Bergmann wrote:
> > > On Mon, Feb 19, 2024, at 05:09, Calvin Owens wrote:
> > > > 32-bit arm builds uniquely emit a lot of spam like this:
> > > >
> > > >     fs/bcachefs/backpointers.c: In function ‘extent_matches_bp’:
> > > >     fs/bcachefs/backpointers.c:15:13: note: parameter passing for 
> > > > argument of type ‘struct bch_backpointer’ changed in GCC 9.1
> > > >
> > > > Apply the arm64 change from commit ebcc5928c5d9 ("arm64: Silence gcc
> > > > warnings about arch ABI drift") to silence them. It seems like Dave's
> > > > original rationale applies here too.
> > > >
> > > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > > > ---
> > >
> > > I think these should be addressed in bcachefs instead.
> > 
> > That seems reasonable to me. For clarity, I just happened to notice this
> > while doing allyesconfig cross builds for something entirely unrelated.
> > 
> > I'll take it up with them. It's not a big problem from my POV, the notes
> > don't cause -Werror builds to fail or anything like that.
> 
> Considering we're not dynamic linking it's a non issue for us.

[ dropping arm people/lists ]

Would you mind taking this then?

Thanks,
Calvin

---8<---
From: Calvin Owens <jcalvinowens@gmail.com>
Subject: [PATCH] bcachefs: Silence gcc warnings about arm arch ABI drift

32-bit arm builds emit a lot of spam like this:

    fs/bcachefs/backpointers.c: In function ‘extent_matches_bp’:
    fs/bcachefs/backpointers.c:15:13: note: parameter passing for argument of type ‘struct bch_backpointer’ changed in GCC 9.1

Apply the change from commit ebcc5928c5d9 ("arm64: Silence gcc warnings
about arch ABI drift") to fs/bcachefs/ to silence them.

Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
---
 fs/bcachefs/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 1a05cecda7cc..3433959d4f35 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -90,3 +90,6 @@ bcachefs-y		:=	\
 	xattr.o
 
 obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
+
+# Silence "note: xyz changed in GCC X.X" messages
+subdir-ccflags-y += $(call cc-disable-warning, psabi)
-- 
2.43.0


