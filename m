Return-Path: <linux-kernel+bounces-121898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05D88EF22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3814229D4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44211509BB;
	Wed, 27 Mar 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2KXsP2c"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419E3DAC11;
	Wed, 27 Mar 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567553; cv=none; b=ZMua5a9OmUg8coC+8jX2y9yfAWHNmpUeVmH30/6JIFxU5XPgIFNBstPsi2QRH/pt7jQGrD/sGH0ayJkMQyAYvOlI4fI6aDNBNYCBYz56ezyIp6PPEWviXwEdwwDdabBinJsrTWGMgqymhbF5SozCbOJMC5QCpX8wkH4kDGqM43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567553; c=relaxed/simple;
	bh=RhmkBT+4YVOUr4GcMcbTeWJo8+I/K5JHSwJk9TQtgQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UufBfXhX41yCVAohutrxV7xKyPUOnbsqARO7BKSAEqCDnbjgS+2rFZdpgue0QjFmcdXtFYuPFzQzTdravu0pBfka/y0Cwqq/DOMPeraHo6t4fxwz+ka3kIky4Y18tUwr0CG3xntmrx4o4KTlJ8gv+yMpOk3XDkhIZtp+DIop+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2KXsP2c; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0d8403257so1858775ad.1;
        Wed, 27 Mar 2024 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711567551; x=1712172351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl8eNBms0Ypy8dIOTW/avUScjvW0EWf64cS1n0rycF0=;
        b=E2KXsP2cLuKpAY78fAAKOgultZY0Ny+4XgrzihW/4aIKx72VCnVhNQwLZsBY7Rziur
         D+jWMPJ4GM/bv9Xzc1W7GJ6AISZ+c1Nc6FUFpi1DgGKwMworL5g/MMUbqEy5eAPE5p7p
         lp+lUYLfBAbFscMzsikwErWySCWMyig1Q/gRa6EJiMLbMqFRpU2/XWTL5H7sLi2U2b2g
         T/yUbVVXfJYnaUfPzlbM6/uRqe1YDCxyWUr9JDisW6cAY0wt4mP747N8/HdqFpYJ8uGJ
         smu8HPinatI4x0eNLgjrZj5BOHq+3zTd77B1qPQKcqgq4VScd//O0KY1bl7h26D2ApM1
         PDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711567551; x=1712172351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl8eNBms0Ypy8dIOTW/avUScjvW0EWf64cS1n0rycF0=;
        b=bTG0CymtQSUzOxMdRyaRVn95diwpRPQ37qVkNMaQvkZDe2wl7Zq+7htaOOIEBKcdRt
         0hWOb/mqF1VWiIODeCfl3ExpBedYUzU0S0/gG5nTzFF74ZeSZ69oCarqoXrhtfZX57xR
         +1sCPDnmvS3qYnGzy8PpeQt/LOG7uXM3mV9ChCZOKvG9mZ/F89Z4/lOyVn96t7sKqvJK
         D0Sn7XlUoQIHVQrgV2Rtj7eghpGxVGANgcDEsd7/CK/qNYXAdOza7Y2f1ZQ7syX5/DuJ
         TPfO+jOzo4ikRv3Grc6p+vL0mdHD7kt55FXcVEOaQrx8EQNcriqaaIn0AJxbPC5GsPTe
         ns8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7GbJKMDwwvnT2NxNdmV9msbnZoFjRCBHtgEMl3LeINKLHeSq6455hOAp60wv5xUJnynVDuQaP61rZQf49HNsFpPccFoJIOLMDIQ==
X-Gm-Message-State: AOJu0Yxvx3WSi7d0Jg3+qw0Qztf//OqeMknZFB/IvHM94X/MOrHocCa0
	ScM/JewZ49oLG984FKRjxkykrzs0ITZP0W+etjGmPkKtnXXLNkrm
X-Google-Smtp-Source: AGHT+IGYfiRrgVXsMUV2nu22JT7tG9NAHWBYfdLcLavIx0jYc2nP+M24nKWYxWtgXqkyzo14EU+XKQ==
X-Received: by 2002:a17:903:238b:b0:1de:f840:fb22 with SMTP id v11-20020a170903238b00b001def840fb22mr793660plh.12.1711567550737;
        Wed, 27 Mar 2024 12:25:50 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902b70700b001defa2d8e22sm9395699pls.233.2024.03.27.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:25:50 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:25:48 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v1] mm: remove "prot" parameter from move_pte()
Message-ID: <ZgRyvDb_nfC6o3uX@fedora>
References: <20240327143301.741807-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327143301.741807-1-david@redhat.com>

On Wed, Mar 27, 2024 at 03:33:01PM +0100, David Hildenbrand wrote:
> The "prot" parameter is unused, and using it instead of what's stored in
> that particular PTE would very likely be wrong. Let's simply remove it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Its interesting looking at how long this has been unused for.
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>


