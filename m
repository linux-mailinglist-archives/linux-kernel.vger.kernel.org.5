Return-Path: <linux-kernel+bounces-100703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668C879C30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACAC1F24B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70314263B;
	Tue, 12 Mar 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fjLzEIe6"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6B7E761
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271050; cv=none; b=VH5wdhHJaa+h9rEHYJLlmI2r8sYfWigM4rD+7rzTSvzAjy1sn2n7F9W6pCucZly8KESrlzLbnx9eAJ6tl83GAghIAp+ORfniecdshbE9+zWwUKRUhystT4q5U6QtSlHPc7ukmphpP5/IBGllGrqCeNN1dtmkEvFEyQO1S3YvHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271050; c=relaxed/simple;
	bh=cenzjZ+RIAMctKhDW0VVdrYPL4dSxNe5xXKryhs3GRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMKEg4/WuWbt9UYZ/8GRPA46tzhXx1JMpPaxLw63Qq2P2YBabJ5/qD37J5rNLj2rExn/Uz3txbniPOrMIY963CDpd0SHL4pvhgeWhhhfk/Jtb2ALrTM40bfB7y+nXkpFB3NygiEffKER9/I46+PRWh/QGYCPTMVxCluIo/juLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fjLzEIe6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7882d713f6fso294215385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710271045; x=1710875845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3E+KvORFMKvDm1+B07pZtngBNS1kRcXmmHOQGV6v/ns=;
        b=fjLzEIe6a3423cbFNnJ+RttrSZrn3pMtzjOq0xP40kAampWJfe8mOV7zZe4oYrnzGm
         hojO2jTTzO1eSNHnIM3opDNuK5sBhps97o8sMugVM0E2itbbq7yrcJPCcKUUPSpPN7cW
         dEY+yCT4zNPvBZGO4XLw0QT5PP4Hfi6atF8EcLqHDgfby5t3++HUXGuunc/AvZw6tk6X
         wIAjINCfGbzfZS4KFxvaMPgXI+Ow4RWV6R2AucDBnGTWFUMr9Ssjac2PShe3nH3OGBaP
         hfloe3RMWIVpc/C0PIC5JRbCE6dBGQw9kHhz6IrEhC+3VYihNEV6lW1sD6V8xhfiaLpy
         j8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710271045; x=1710875845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E+KvORFMKvDm1+B07pZtngBNS1kRcXmmHOQGV6v/ns=;
        b=frtEOsavHvSu1EYraoS9NXWm6hS5UcGX+wUyOwFGDN1og2iCNyk4eJP1ounK842E4g
         BjcdHIO2PCnKkS7fwYclgkpv85VY4xjXBdLkb61h7him1KiF5wGlGM5oaIUvVgQhZtLk
         WrpETrcQtj8lvLERd/g1v11BCJLDJtIQyzaf39EebvnGcPCN47JgrNfDLS0gP4V3Kcep
         i9+IPr1LVAN1G/cRp2I4Bq1/HLugQe0Ar6Kf3GNqrDng4mFDeccRYpdBUsgoLhJlJKdV
         ctpi8SGiFQYb6Nnol9/ULgR0ExbLQGl9duJHzfso4OJLuayhZvAtOQsNZleByrkGldsZ
         Tjng==
X-Forwarded-Encrypted: i=1; AJvYcCWTQNFJ1fTmsd6uox5Qz10NWhDSBggqxi9VQw6GKQv4A/XXYKgdBIUxa2SbW4kvpa+izq9tQO22RVOwrNtnILAzMQgFZruAIvlSv63b
X-Gm-Message-State: AOJu0Yz4/tryMGxXp3ZRHoc8hInjlrgmgD+HNOlAijr1o/ePqSV7YIDV
	aLANuT7PvG3SkloPGqgAeg1TAQWmC1FJL5nQSeKOm0jCwedl61fSWjyBUT4gB3u5dzZBAJWZcCf
	9
X-Google-Smtp-Source: AGHT+IENwreDIWA7OOCMBwF+IoqLwS54xXW8Y4tliviDGJXugYUc3z/69YEWyHnVBSzsnrdNhej3sQ==
X-Received: by 2002:a05:620a:2906:b0:789:4844:a229 with SMTP id m6-20020a05620a290600b007894844a229mr2679493qkp.8.1710271044743;
        Tue, 12 Mar 2024 12:17:24 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id vw23-20020a05620a565700b0078830d4ef5bsm3935321qkn.107.2024.03.12.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:17:24 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:17:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: remove unnecessary check in zswap_find_zpool()
Message-ID: <20240312191723.GA65481@cmpxchg.org>
References: <20240311235210.2937484-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311235210.2937484-1-yosryahmed@google.com>

On Mon, Mar 11, 2024 at 11:52:10PM +0000, Yosry Ahmed wrote:
> zswap_find_zpool() checks if ZSWAP_NR_ZPOOLS > 1, which is always true.
> This is a remnant from a patch version that had ZSWAP_NR_ZPOOLS as a
> config option and never made it upstream. Remove the unnecessary check.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

