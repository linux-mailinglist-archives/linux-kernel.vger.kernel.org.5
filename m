Return-Path: <linux-kernel+bounces-138841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3789FB00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC501F2B4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582AD16D9D6;
	Wed, 10 Apr 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXUuGRA/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0316D4FC;
	Wed, 10 Apr 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761492; cv=none; b=LVJ8lRdh5HQJzu0n6hU4Q/M3ccFY0ThOtHO9J5tw0BmGiCeEY8oGN5qWfh9mAu5SmeUQlu2QzUZVx45z7Ykd/v24xY3wcTNAo2MpKrbe+pYFMMArzIUhSeWDCXsWJg7zorH0xrS7nn0Vu56kKoMRJCZDqbcVYgxbZV9ZgZ1xXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761492; c=relaxed/simple;
	bh=606InkRvK/dlHpYD43cGJij0ajX9okU8yUZJCc6teXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwEjBX9Ry0h79q8fn/Ti1bPgn4HWrZzG7mSdRI/IqeOJB4Cw6TSyRBL9x2VS0JXGFjnJzh3CIocJMTa+OFW8OmlhdneYyVT64vcukn/6A+SqkrUTt/J5o/CPw1XRylGILU3MlEA8Nqx3iYFo8bAIGGuewtOxZlfuGEfPlpAlxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXUuGRA/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecf3943040so4833626b3a.0;
        Wed, 10 Apr 2024 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761490; x=1713366290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFpL+4mlA3tx5oFHifIbD95lvoxumVXpRzVu2uSfsSs=;
        b=lXUuGRA/EHwG/qL1xHBhLqCKgoeMPiVllXRxaY0pWzhSf1BpXMOw4Npfr3Vz/lq5Rg
         bNijKcrN82QEq2kfqWdQF15YXGKpoE1SesYJdsgrOnsSLbBWCmkXNQxXP/4bSlPT377O
         g4GdFSJ49y3v8IoirksrSpv8J+sJNI2vhUU8GPU/k5JM0qvv8sd2v9jx+PONcg+2ln/S
         7TxRlhZ29OXyXjct1NJxrzUNnyVljGFvMBwGBis7Q6Att+FzyZFZ1jm+b1K9vA5cw0pi
         Pv7xy8oeogosQ0hH9weYyqBOvAE4Z6Nx5M0w0uGRGFsAucXw7l8kaUBUbr5aep1Bp/1/
         pKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761490; x=1713366290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFpL+4mlA3tx5oFHifIbD95lvoxumVXpRzVu2uSfsSs=;
        b=GbSHA7AXBygm1bI7htCiTVOMPe7bDuW2+k3ChJfKScleNaVaty6J83p7KlwJ9gbjuO
         b+KfNjEOfBzcBqQuStfnoZMPk7OvVUjpXhCQ8xvRupEAoJsuZfNJ3LWRMaRqyGI9GUqA
         KkmDHJErckaKMdcdGeslbwklIubGlizYFkZlvTlHIFxb6e2MCDSxoF4s7/Xrgm5Vpbkz
         NLVse3GtJmSo4Bo+Hv3/7ORvuaUm/uI01JurQU5fAnLx1AFwV+f4G7yPmP4l2KeD/SiX
         jAWtMsviSNdv0fO4ab8TYpwfyHMGzyhScI1x1OmZut9OEjV2EopODDDdzzsn2cFLhDdC
         XG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7Wq+8b4yfnhHGSGO//w2nGep4/m4cB+JvYCe2EtYY/OXbI+tia/Paq1Vb7f0NUE2zjnkQklLDBBXtROsFX87sFffzyKubmLwnNH+6+sMVhYwnMZG2iuxW1dWC7PiKdYllu+ILIbp2869u3pxZC0Mk6CPE68oCL1SZzoAtw8BnaJixMtP0wqtMQQU=
X-Gm-Message-State: AOJu0YwJt+Tn16E6I3L7Y62g8ngkehY9G4ctm8/iucOUzBTUb4DRjbSB
	d1NNPqRGG83lsrZLead9a5ME+tt2JNXWMPAWYNbmxJ4CBULwAVbM
X-Google-Smtp-Source: AGHT+IFgprUO/jWxcLfYBYXKoWcGjoBPYkdmZChAbWrjLuVEUoTSapZCimoluIMwv3QiUah2F3Y6Gw==
X-Received: by 2002:a05:6a20:2584:b0:1a9:5136:13ba with SMTP id k4-20020a056a20258400b001a9513613bamr3072919pzd.14.1712761490560;
        Wed, 10 Apr 2024 08:04:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 77-20020a630050000000b005f3c5cf33b5sm9936799pga.37.2024.04.10.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:04:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 08:04:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Radu Sabau <radu.sabau@analog.com>,
	linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair file entry in ADP1050 HARDWARE
 MONITOR DRIVER
Message-ID: <3c601c2d-94d5-419c-bf9f-988596365335@roeck-us.net>
References: <20240402134203.8297-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402134203.8297-1-lukas.bulwahn@gmail.com>

On Tue, Apr 02, 2024 at 03:42:03PM +0200, Lukas Bulwahn wrote:
> Commit 4e1008d8aae5 ("dt-bindings: hwmon: pmbus: adp1050: add bindings")
> adds the ADP1050 HARDWARE MONITOR DRIVER section, but slips in a typo in
> its file entry.
> 
> Fortunately, ./scripts/get_maintainer.pl --self-test=patterns complains
> about this broken reference.
> 
> Remove the typo in ADP1050 HARDWARE MONITOR DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied.

Thanks,
Guenter

