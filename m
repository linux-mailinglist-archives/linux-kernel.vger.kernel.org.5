Return-Path: <linux-kernel+bounces-45152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BD842C39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014B4282CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE577994C;
	Tue, 30 Jan 2024 18:58:43 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B637993D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641122; cv=none; b=kRPXOKbexg8CpCAYhzxvUcnJZmTRGkkaWcp4gyn3Rf6xCzwur3X6CkLrPX2UUG019TK94PE5TM2gEFUhmRQm2cJbgDp9CVbEPf0f23yvt90CI11spXofh2+SPlqaTOBl1Bx90Md9IAohvTglX6ol1S4UouwHKDrE0+uPceQn/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641122; c=relaxed/simple;
	bh=feOlOVjVoDFlYhJijI29hyyTBq3VHkJbnIkbQHkWo+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOIOpdav2sWj0GSXYVFZ5pkx7608QHEGirS3+Hfv00p830jk2jHZGbDA9bhU+5G03xAjl0egP1eIFKFuXsJZTX+PrSN9mkxipMEyuC2NTuGZj7Ft/6I4sh70Tnda5Lh8acG+aPE7B49K5jt9oHDJaaWFyxmbnXsD+tIAWUNQWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680b1335af6so1008266d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641120; x=1707245920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQQdl1Z7hWzrJNQVbHBRvsLI1/jbn0qd6qXGr4XoIGk=;
        b=Maw7q42p+L6eYhX1t7W13S8ijRbr1eaR5tju3Uq8I6XQXpzmP0JDyQTQdUphsPYbJd
         yFbk3y3HbN/4I60obNgtiluphtcAgXcypdEqdVhXCOr6xIM/bZJcrnsW3S2s3OtQHgfP
         vN4taaTXjESJHNMfX9ytLjRpabxpWt7n8amVNXlHPGQAA9gGaTGPJcg9YQMCtB3Qxf//
         kFbCQzEZabSDetGL1XTM93tj/0eHCPS1Wlg3v/FzHoobF9XxhXxt0VEw4YCSlAkO8qQn
         w1bkZtnQTPozT5swT/OSFLwvT6kY+1XZAwOquKVDgEE684Aj8Luv/itTG9Y6R4RvhpIg
         TUHg==
X-Gm-Message-State: AOJu0YyyiIU8HxstTxHXaH9dtdNWZXHgv33dE1R36LzCuzWxBgrjnz5/
	q0SpHQzFS5i0njQpIW/vxuTJ83ha/u25SKTcCjjVku2pOpPzXLsdoSQm2q4ZPA==
X-Google-Smtp-Source: AGHT+IFAvIv3XblWdgdQ8RQaDq6JHCKiCsKus1Crsy6Zo4z9JO1wUINYuy/SufWB3UTtR+pOQa194Q==
X-Received: by 2002:ad4:4353:0:b0:68c:4b59:d4ee with SMTP id q19-20020ad44353000000b0068c4b59d4eemr1868859qvs.21.1706641120069;
        Tue, 30 Jan 2024 10:58:40 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id or32-20020a05621446a000b0068189e9d3a3sm4322738qvb.112.2024.01.30.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:58:39 -0800 (PST)
Date: Tue, 30 Jan 2024 13:58:38 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 47/82] dm verity: Refactor intentional wrap-around test
Message-ID: <ZblG3sBtxv68aRyH@redhat.com>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-47-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-47-keescook@chromium.org>

On Mon, Jan 22 2024 at  7:27P -0500,
Kees Cook <keescook@chromium.org> wrote:

> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: dm-devel@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Please change subject to:
"dm: Refactor intentional wrap-around test in a few targets"

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

