Return-Path: <linux-kernel+bounces-135255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848689BDDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010371F21CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F1F651AB;
	Mon,  8 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVbFZf6B"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0264CCE;
	Mon,  8 Apr 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574851; cv=none; b=nn6kwuYBr0H5JrSF/aaM18SwSQOl1NZaD5IMQ7XaMnNmiEjOduy0ITM7cgwcdiG7cc+iRkU7OhiAheApah9Nq5m6kiKaUOkzZufnrB/VkU4lH7kV6wfykZg6328qF2T3m930MPEqJONzAmwmH9lxm0zhOGH+Gk+iQ6BY89t5MBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574851; c=relaxed/simple;
	bh=zRax7m6YaaxkpU8NWFO0guN+tAyfSrEAgeU9k9/lpCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCPbma6e4VrB6m451u7ZHE1XUDty+UnCZgvFQQmNmlHNFMWu8P84tkCVf9HzC50B4XsWyMMr2eaMQQbG3HRvHsMfhuYrB/tH9SAFLj/SbDafAnZq3YRxoD26Uz1jWuGM4JCKiHoK5kfDl3Ny/aWxz82As1fo/ng9muUWwynvycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVbFZf6B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0e89faf47so10965535ad.1;
        Mon, 08 Apr 2024 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712574849; x=1713179649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fXnqY/hiuIzNOaaXqBgq2NQBkWNEl8jGRoP9ENRrDio=;
        b=NVbFZf6B5XYbBf2SYyMDozR/3v7pCBSsnLNkBse25JRxo77qYTKRzyWmlgSFl9Ojrf
         eZoaLEgx4KpcuQR3Az0x4gtZP7ZzQOBI2FdZwTl6zZ/t53S9oqTJUl412fgW8n/0emsf
         yoZofk0vBA56HyWv1l53Nvb8tFKoi+pGnftaPzJt0Id7q7/r23hJSh43Nc9EWiCvA3zl
         HcPY5103e4hEhjvNJVU5R/DfhP5Sn4AyUQFj+Hbn8C6XA+zFaVq6/7krnSn13KOCmoKs
         cognDDVTgyc2iIx/v5XhaRMi2W9KcdNiZRHa8GnUQSd1WDK17s5K0Z/7i//ifIPyBrzW
         +wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574849; x=1713179649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXnqY/hiuIzNOaaXqBgq2NQBkWNEl8jGRoP9ENRrDio=;
        b=mXVWbvKTtNzvDMOucv2NM9gUhb1cWhcBPHJ5EJyq0XvSXkuX0OpCpjnVqk/SD0qEaV
         Dxknl4EWrOpGQf21GqpQzNgvPmmBi+a3MI2HaKHUy9eXw3mcZIKUZDsWL/XyQ1nb+sAY
         oVhsvvM5f2CmOq72JzANeHvHnJn3z4nARq50t3d/mVC5NzEFqK7JEjTkPD1a7Zty1MZ1
         R1eWMEvpMYPauhFP/vciOu5XXYyMeZNPzSXC+VYyKFZE3W4uk54+/LtlvLy7QnWYbAKz
         xfC83zMn+GDPLKe/ZQ36beAkY0y+jEC+sEqUweDvyYfW1cE2HR1wxlXUSrWtok9AAaBX
         w4SA==
X-Forwarded-Encrypted: i=1; AJvYcCXsmvJubuiPVbuHS/4TxIY37WUK0Y7N3I3QgQVscmWKwCMJ2ayfGLNa+GDK2udcl86DxWYlmNJ1BfLcZHikyx02GEAitGo9sDJ1Pcf7k9qhdAyOWD9+O0LYfN7PqqXZ17eJwtZU
X-Gm-Message-State: AOJu0Yx7WtLb+dteqEGCcZ9h7//X6LLe7rtCqOpBWMhl4Jc208TJ9cW+
	M1cO0D7L302QRyc340nOKVVQ3p4oNhlHdOYytUL6a+LbxY4LLEKh
X-Google-Smtp-Source: AGHT+IH+xMcVjhrAfZdMRUUOacUFXNyLoJMz6JNERAY1hW08XRtfGnHXhCDa6A1nFCgE/jjg0ajKkg==
X-Received: by 2002:a17:902:ce87:b0:1db:ce31:96b1 with SMTP id f7-20020a170902ce8700b001dbce3196b1mr10607491plg.6.1712574849390;
        Mon, 08 Apr 2024 04:14:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001e45572a253sm1047027plg.14.2024.04.08.04.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:14:08 -0700 (PDT)
Date: Mon, 8 Apr 2024 19:14:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jserv@ccns.ncku.edu.tw,
	cake@lists.bufferbloat.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sched: cake: Optimize number of calls to
 cake_heapify()
Message-ID: <ZhPRfYt0BLh9UELN@visitorckw-System-Product-Name>
References: <20240406235532.613696-1-visitorckw@gmail.com>
 <87frvxgnmr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frvxgnmr.fsf@toke.dk>

On Sun, Apr 07, 2024 at 06:10:04PM +0200, Toke Høiland-Jørgensen wrote:
> Kuan-Wei Chiu <visitorckw@gmail.com> writes:
> 
> > Improve the max-heap construction process by reducing unnecessary
> > heapify operations. Specifically, adjust the starting condition from
> > n / 2 to n / 2 - 1 in the loop that iterates over all non-leaf
> > elements.
> 
> Please add an explanation for why this change is correct, and why it is
> beneficial. "Improve" and "unnecessary" is way too implicit.
> 
> pw-bot: cr

For correctness:
To build a heap, we need to perform heapify operations on all non-leaf
nodes, so we need to find the index of the first non-leaf node. In a
heap, the index of node i, the left child's index is 2 * i + 1, and the
right child's index is 2 * i + 2. The left and right children of node
CAKE_MAX_TINS * CAKE_QUEUES / 2 are at indexes CAKE_MAX_TINS *
CAKE_QUEUES + 1 and CAKE_MAX_TINS * CAKE_QUEUES + 2, respectively. Both
children's indexes are beyond the range of the heap, indicating that
CAKE_MAX_TINS * CAKE_QUEUES / 2 is a leaf node. The left child of node
CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1 is at index CAKE_MAX_TINS *
CAKE_QUEUES - 1, and the right child is at index CAKE_MAX_TINS *
CAKE_QUEUES. Therefore, we know the left child exists, but the right
child does not. Since it's not a leaf node, the loop should start from
it.

For benefit:
We can reduce 2 function calls (one for cake_heapify() and another for
cake_heap_get_backlog()) and decrease 5 branch condition evaluations
(one for iterating through all non-leaf nodes, one inside the while
loop of cake_heapify(), and three more inside the while loop with if
conditions). The only added operation is an extra subtraction.

If you're satisfied with the explanation above, I can attempt to
rewrite the commit message and send the v2 patch.

Thanks,
Kuan-Wei

