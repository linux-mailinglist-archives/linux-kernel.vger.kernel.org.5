Return-Path: <linux-kernel+bounces-53080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00584A071
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15C3B20C25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9044C69;
	Mon,  5 Feb 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP5NruZQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA8446BC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153609; cv=none; b=lgMo/WiyLapRy8ZjVLrV8XlMJ785LCm1pHVdeNSJPXuL4WrAYSgDrIGuFsTnmxsi6J4f31nbqqn4m6GaRw91GIyknLRiHCRAmpVkMJDe2yCfFZ333jFbM6XhOov1bc7qvL2mD/+5VJDP8njBG9TyWLcCBaNW1ceZxOOIdfjheQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153609; c=relaxed/simple;
	bh=aOjNSOvtp0ujIQMTbaE4YDaVYoKK/aZ/wS4JYuV5p9E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG7jCBiEKNesKlXn88e1uhgJ4rRzI+O85H8DFKppY7RoXXvFNRpwe8V8judTTBSWyWv9R5tloksnFHgnG7YWWpy6A8mNe0w0XAJaXwPo8SllKWgQJlPu5KnBOFY/8Eb5Q6yV8GDGz/nstVzquH1fGB7pfSg8BYvfC/tu/MsM9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP5NruZQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5113303e664so4898078e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153605; x=1707758405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEMbhpQ2LvQj1QxG5F6R2P3PMHhRfGI0cJ0mIvjw5pc=;
        b=XP5NruZQr0NFcXd78RxBhrGhrZCl9U4Fe1tKU/sk5qp+0F6NaXRifgYBYDD2cVl/hY
         WjWeBbn0S902fJrmVexSoU4ChhNMs+OGU0gC3zUCow3cYpaD1+14F4q0OaL2ai9Sa+xm
         AXACV5xbkYFOV2N/L1FwVIel5/tvb9gqcOQnvP2fbtwPy6PywNPDtO+pCIYxkuOZwttt
         GI0TCuPts/5CvM3aok1eB481Amvz0V6jyO1qf/w6fUt7EzUnjzG2JPgwdJsHW1ltuZ0U
         0u8u6sM1nAU2A2j42yqCs7N7kh7FRSajLXYnMNekL2kY/eNvnlFWTMlIfZ1GlQohdDd9
         87SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153605; x=1707758405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEMbhpQ2LvQj1QxG5F6R2P3PMHhRfGI0cJ0mIvjw5pc=;
        b=gGg32PiI50ZO97wNZdRDmyTutPIlg0/N+3S2xfI26BYJIvecHEWI9U7sf182ZdMy/f
         MP+Lt3MrV/7LWV3krFNQX4hyfTdv6iAgE1AT9uLQmtLk/R/VqvvsHMnLBSQd/BoskOVa
         UTPfios88DoqbMf89RtKS88iLFiZsSMSdCCCdlA9mR/eYvr1s9cjVIr22rX7lUyWESaa
         XzMGuRzM9YdVQl/Zy1S63CnDO4Ij/NkMupx7cvD1hTChi2QYIpN9dzQjtXqtxDtzoe5W
         AoU3bMlnPwoJ7oDjM5hlttyGDVEgBOIa9IXL+xzwpwDl7iN68jQe0HjMg3TbHNdp4Hk6
         DGAQ==
X-Gm-Message-State: AOJu0Yzwa9jg8aDLYrRou3JsZ8cYPrYoaJbLdlxJzdR89zbb9N36V8ED
	ifHkWp0rFf9Yr4HEiqxISGRdqsrsE+2g0nx4P05dI4IGjAEbiaDt
X-Google-Smtp-Source: AGHT+IF/U3pklMyQlVuLPVYg7jAgrN+UBJwYZh37iO/M8/Q+IjGj3RKv8n4H/GvGEwdkTpNLtW2Ggg==
X-Received: by 2002:ac2:4423:0:b0:511:3460:925c with SMTP id w3-20020ac24423000000b005113460925cmr162635lfl.65.1707153605175;
        Mon, 05 Feb 2024 09:20:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlXmFdAampbMQxuoSf9NU3tuqxvlQLt0Ru1NKVuY/VUfO1BHf0bMy9/hknBhSmAYWuMHmTctGkA4L9V8wJ6UfeyvFSHhawPxyKu2031a855vAkpO7uPvngkiWnVZobwzWlH30MWIPOqCwsTD6az0kzv25spR0c5emxzNozawKtB4Ok/uGkMwY3ocV+a+6PSPbWL9iCluJcDJAg1ufYGalRmLF+HdCeN0q63GE5JboLe8ltiQCqJaFPSSHgu4TNbtgWbrqbWS+LSlZZEYtAJlBcGM7r1BDXVsXGDblbfrlTDKe+steHuW4=
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id d26-20020ac24c9a000000b0051156fcce6esm11874lfl.238.2024.02.05.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 5 Feb 2024 18:20:02 +0100
To: Christoph Hellwig <hch@infradead.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Add a scan area of VA only once
Message-ID: <ZcEYwp-I-R3NLhT_@pc636>
References: <20240202190628.47806-1-urezki@gmail.com>
 <ZcCDCQdja-rjtIZ3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcCDCQdja-rjtIZ3@infradead.org>

On Sun, Feb 04, 2024 at 10:41:13PM -0800, Christoph Hellwig wrote:
> > +		 * Only scan the relevant parts containing pointers to other objects
> 
> Please avoid the overly long line.
> 
> The rest looks fine.
> 
> > +		 * to avoid false negatives.
>
Thanks!

--
Uladzislau Rezki

