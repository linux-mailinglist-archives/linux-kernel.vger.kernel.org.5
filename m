Return-Path: <linux-kernel+bounces-38059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB98D83BA72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2321C2274B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138D11714;
	Thu, 25 Jan 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dubbi2WT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA2111B9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706166682; cv=none; b=IlmlvMex3j2dHYhNqFvofnBpksf/9k6UMFVdA5RhsE/XWjbMy9GKpbpODdg4xFL9EpDDyG4H9yhCggMxQW4J2g9pZU8CeKn9fpnYB6nhWf2X1OaABfQ9klzsNBAeMgi6ZdzOr5F0RgYB5MVa8vuq9Ky1sds8ZlNDRpgkpsF1BgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706166682; c=relaxed/simple;
	bh=MhAs+/K3M604HAjcuWid4qbqKRwjhFImnSW6mmUqhiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZxVlv60C9Ceu/Ac7G9TQ6STvWPLLyeJ+cbmMcjXmzQ/Zue9KiaDoI4yWgAejRG7I5GOXN4xVSvy4aRLAtqHHHyTTbZBBB3d4irDkQJUOq1NQebhBGOz4QJzIoQWQgkCM6TNSjSD8wCXV8Qubg3COcx2NLk1nffWhDM3CwV8f7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dubbi2WT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so5775432f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706166679; x=1706771479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q095Tqht/ByQgVt9OFJUihREhqCL8/jRPpLy+TI/xdo=;
        b=Dubbi2WT9w0KCYkMJwfP4MqALdQftg+xoUOBp/2OxGz5gfGXCoUAmtTGK9rRklDiiG
         0nzCIS6GwQpouH3HdK4DUfsM8dvv3Td9IKxAwr+xoMIgX4JseuBbnpwAgr4MzuumXZ6b
         izr//RMb4LUfpP6ldhY2SWbc0Kod/RJd0sYJURlUpef/dzGK87C44chANrkKx/MS67UT
         YAlI//78fvhiWH33/+ckoI4WWAeq2UO/ih5nSX5JHZrpRdOfNlialzf6WoPOXPV3++mv
         MDiN4icdlFKCVWK3IgGUpFP0Wm/oj2/DqiStbP7xll2J78RaROukECWST7AdApp3qtw4
         bqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706166679; x=1706771479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q095Tqht/ByQgVt9OFJUihREhqCL8/jRPpLy+TI/xdo=;
        b=e/B+dM/LEuerqkRiNdL2LxhiFebNz4ctnZEL7zv62iR31qT/MO97gxJSxkfjv8jzM/
         +DZSluVdNz4hyfpeV21BURy8ArQLeZ4OKzztgK/nFsP4TcW2frvXWiK3nRUjv1WeHrbx
         R/1bLlOK7txxs6pg+1jUsip/yVKgzn/lK5tEXFiTPwutOWl6WL8WCHmqvf3jYk9v1FaK
         m2cc1d4LhAvL6L1Yw7tfRIddb/jGaDX9g3XIqYLYfZxao6xbWigOu/8XpSsnxDoQah2b
         XPO9Lf9SygNc+WrCqAu4P+yyWz8pTmfsMY+UoUtTJgo71rlm9wOlu20nqlFcUcyJ3pnV
         YSJA==
X-Gm-Message-State: AOJu0YwzvMIn9EE2m0EDmIwlpMFlpOVvTagWPVTzE+byB0fTbHDaJaEe
	kS8VbQQFjm6n6MhP2iDYDQu1HFZGCXs5+FqlKB2tpcwBxXpnEQ36stu2WzewAQY=
X-Google-Smtp-Source: AGHT+IFoHAcK2sNljG+Q6UAboV/a3hSw72/CssXM6ogBMo8LWhKvCrsXyvXXcBjZeiSp7XJapLCnLw==
X-Received: by 2002:adf:f6cf:0:b0:337:bebc:3f4a with SMTP id y15-20020adff6cf000000b00337bebc3f4amr250660wrp.81.1706166679352;
        Wed, 24 Jan 2024 23:11:19 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e21-20020adfa455000000b003392295997dsm14778368wra.25.2024.01.24.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:11:18 -0800 (PST)
Date: Thu, 25 Jan 2024 10:11:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, mail@karthek.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix a problem of memory leak in
 hidraw_release()
Message-ID: <76300deb-f532-4d74-a97a-4cd321ae8f41@moroto.mountain>
References: <20240125063225.2796234-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125063225.2796234-1-suhui@nfschina.com>

On Thu, Jan 25, 2024 at 02:32:26PM +0800, Su Hui wrote:
> 'struct hidraw_list' is a circular queue whose head can be smaller than
> tail. Using 'list->tail != list->head' to release all memory that should
> be released.
> 
> Fixes: a5623a203cff ("HID: hidraw: fix memory leak in hidraw_release()")
> Signed-off-by: Su Hui <suhui@nfschina.com>

This is very clever.  How did you find that?  Was it through static
analysis or just review?  Perhaps using syzkaller?

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

I imagine we could write a checker heuristic to identify ->tail and
->head struct members and then complain if they were ever used in a <
or > comparison.

regards,
dan carpenter



