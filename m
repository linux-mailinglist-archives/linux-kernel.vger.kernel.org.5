Return-Path: <linux-kernel+bounces-154938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB958AE348
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E79A1C218F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591A81AAA;
	Tue, 23 Apr 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InsUFqXZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257657D40D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870138; cv=none; b=XoTvowXBAV87crQqXXwWWJVoqnxWsMY61sKOb9GTISftZ5HrL/CEzcwhAaO31UYArEumwcaq95l601adEesdR0PvZSmzP4VXnM9EtvWAvpHPnJOspZXWSdkmt7CobPuD3dFob9zQHwhNxVwYzQL18oC2qX0IfPUtS7BIw+p7KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870138; c=relaxed/simple;
	bh=uAd09pwfQmKaIV784pkw+4n33QRbRFZEsdNQaLALRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPr1UJApZ259SAcKcavUV1NJGDbOf3bkb2lJo5BEuo0vrlXTy8alm9D8rwD9hbUmTeVRjQeX47mp3nqN3zObwxdTi6Pqhg9JCwp0VNuGNM+9V62oxdHv1PpChYkiI2bMnlqOIx4Wh0B4oFmbtyUuDuhptbVUSZo7BvgEXSPCbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InsUFqXZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a5b68ed0aso13681815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713870135; x=1714474935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fN276X0o384Z8j3FLIwukjM5hYTBdG6Y0uEQv0QW3E=;
        b=InsUFqXZjyYOx+AWGlpDVU5TTcEc3wOzMthzm1rbnsW49CbOvqgm3t6cHDrBMcB+PM
         SuFQ5DKfyFOwUtr1s5LDXGfFSPZ7/lrUC0HY0OEFhFNsBOkbzYKyfqflByOuxbILLqyy
         WIawyTMcZK3T+3xpcyrZwBz8APn0AWazNZ1IIYmtbj1QQEpjwXb3d+lLsqnCK28IY72s
         yNMfYtpOTYxMxCDV4Abt8VeAJzHahAeY3UfcE+DcNxFtAEomYeoKWLd+NIQxOeeaj1ul
         vlCz1mK6N77WxwYB4O8zCp4ba9c/I6UdD5P5L7CbkMnW//hU9yIdqYVl7Xs9fWHYZF97
         iLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870135; x=1714474935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fN276X0o384Z8j3FLIwukjM5hYTBdG6Y0uEQv0QW3E=;
        b=QS6H6ll0CTlS5NJyOKv360ADLR1yLec9wM99mn/VLnZdPevGbexV9ljpTEToN0gptT
         wdcNl6EpVBGdnjr+tnWF5Af56+KbFKRnqSRkzE/+yEP8Lbgp7WuJVSUnNF61m52p4Tjv
         vqQL5YSbHw+s6gltepFYVh2FCpbFeCJsatezf4K126WmrCvY4vFsj1LWMWsfUiLS+F5W
         aHqGFXIOIWhlaXe89mEFTHrOvgwMUJF5EsQbkwdrAMvJ7fUtdmJVcQdqwbDO83MyKDzB
         PLtoHygHyu261zohDzH3qF6iR/RiIFWI5d06mup0NFrge1HHBAaK/sTW4xTJTiH1qroN
         f6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW99o2mexiXq4rbjf+C8urcYFlj9rAisNz6a6xecxK+MwtAd7Ng9+8vvj9Nn+HXp0VwFVCuAcd7ufrb+mwHs+mQAvgepqtcsVH3eppR
X-Gm-Message-State: AOJu0Yz6mYvUWTVHO7thdNtmebVC1Ll6CaMDFpk4fJ+JYqdJgmkgenjy
	o1V0HNGu86ZZh4OFBTKSAciFBMYnngiRo7G5U/hmkxP2oxv2T9foL+Elu3zPEUQ=
X-Google-Smtp-Source: AGHT+IGyoLxxNXB84SOaZLmPPJ4OsAAGIKmqG6QrGynLfiOOuEkZmyKzKN/zvnjVFVfYKuS9pq1zag==
X-Received: by 2002:a05:600c:1da3:b0:41a:3407:78f7 with SMTP id p35-20020a05600c1da300b0041a340778f7mr4435656wms.7.1713870135321;
        Tue, 23 Apr 2024 04:02:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm9220735wmq.17.2024.04.23.04.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:02:14 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:02:12 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] kdb: Simplify management of tmpbuffer in
 kdb_read()
Message-ID: <20240423110212.GC1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <20240422-kgdb_read_refactor-v2-7-ed51f7d145fe@linaro.org>
 <CAD=FV=XqSmD4WGyBp7Cv1i8X9yjk2gH1y2j_5qzkxtDL+GKv3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XqSmD4WGyBp7Cv1i8X9yjk2gH1y2j_5qzkxtDL+GKv3g@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:52:52PM -0700, Doug Anderson wrote:
> On Mon, Apr 22, 2024 at 9:38 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 94a638a9d52fa..640208675c9a8 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -310,21 +309,16 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >         case 9: /* Tab */
> >                 if (tab < 2)
> >                         ++tab;
> > -               p_tmp = buffer;
> > -               while (*p_tmp == ' ')
> > -                       p_tmp++;
> > -               if (p_tmp > cp)
> > -                       break;
> > -               memcpy(tmpbuffer, p_tmp, cp-p_tmp);
> > -               *(tmpbuffer + (cp-p_tmp)) = '\0';
> > -               p_tmp = strrchr(tmpbuffer, ' ');
> > -               if (p_tmp)
> > -                       ++p_tmp;
> > -               else
> > -                       p_tmp = tmpbuffer;
> > -               len = strlen(p_tmp);
> > -               buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
> > -               count = kallsyms_symbol_complete(p_tmp, buf_size);
> > +
> > +               tmp = *cp;
> > +               *cp = '\0';
> > +               p_tmp = strrchr(buffer, ' ');
> > +               p_tmp = (p_tmp ? p_tmp + 1 : buffer);
> > +               strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
>
> You're now using strscpy() here. Is that actually important, or are
> you just following good practices and being extra paranoid? If it's
> actually important, this probably also needs to be CCed to stable,
> right? The old code just assumed that it  could copy the whole buffer
> into tmpbuffer. I assume that was OK, but it wasn't documented in the
> function comments that there was a maximum size that buffer could
> be...

This is pretty much it.

I used strscpy() because the function does not document any upper limit
on the length of the supplied buffer. Thus using strscpy() means we are
resilient in the face of future refactoring.

I chose not to Cc: stable@... since it's only a theoretic overflow.
With the code as it currently is kdb_read() should never be passed a
buffer long enough to cause problems.


Daniel.

