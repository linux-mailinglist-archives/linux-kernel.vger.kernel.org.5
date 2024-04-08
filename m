Return-Path: <linux-kernel+bounces-135647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69589C938
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61706B248AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5161422DB;
	Mon,  8 Apr 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQqlr/Lx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53471422B1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591995; cv=none; b=gSnNkEHrx/FGO21xcs3w4HmdrmaIdEtVivGGx5wRqxYmMh1cbIG1Gm4FSBwqUcbdvT0DvEk64coFYNhHeNU+55ljrN3e8mehXp/ccp3BG4x/eWEJW5cjxnQ5/JvcwHptNRMr0rvA91Lmv8v2XbeFN06Kvha4nkwmKaKn7UvdN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591995; c=relaxed/simple;
	bh=1ALZeQ6emF91G37m/wlyKAyFfBFwnq0TBNN/pk9ANcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHC6sj19sm6PoMuo73UoG/eLfGvD60/SeXM9fHNTexcAPWubtjYWz1InJylIPPHTgI+RqkTpsc34X5UQwWUgKFjutL2VGc+19s7tYI7WRB4/6PkgrdZIglqeZuYp4GzkQ302qOWdPRKL1Gt6obWj4FTrGRpX/dPKq/pAhRI3ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kQqlr/Lx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e448d6f9cso957300a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712591992; x=1713196792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raUyqIRYyeiBVQ6DR8xzWRLnj/pHWt3aufTBBhCkwQM=;
        b=kQqlr/LxSPHNih2DoeX2RQeRE8skjGjozGHLlaJBB8J0cIIr9Azrz9PLY6UV+kSvWr
         xbRYWfxrJfz3oljne+A2AK4FqTp3v/IfJT9jIXC6y1IbR2V7GwqcQbjnwcWrZrWXdF29
         jquesBVvJ8lAEL+HbOUqF9TgcZMeiclU/Feb3g2XSNV5KAalH63olqJsrD5fP2L3TJqP
         qkhB7rckZJeprgd2UP39mg34DegsqHeCZByiBgIQ41e885I2Chccb16HGhNkSO0u2DNR
         MzJH+C/1mxSHOEhKl7NHOrxlVW9W6pPugdRfQHYn9jsaWARsO2QGRkEFBxqCX2MOrpLC
         EUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591992; x=1713196792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raUyqIRYyeiBVQ6DR8xzWRLnj/pHWt3aufTBBhCkwQM=;
        b=lm/oglZpxLUZI7No+tKGzFawOMS5qSjId/632fVZGtVcvjWSSU7fibxWbiYIvRuKPB
         xRa2es/rA70VbdASBhnoxHYv2gfHvfqJZv+kRRGd0jdmJRtYP5NTGRu0wirWjhZ7YZ1y
         rGZZQPFi+CDIcb3FhXKW+/y2GqnNQ1hzm7HbTyd7plbPDG/Rhb+uQyQUwPwnGrM50Cwe
         0PWQHdP+RmgIrx2yoH3U/QWVKUOTu74ofsHkfpygi4pNE6jGtuAvH1LUfMyEzjAQIqyA
         uBbAgPTPNqpOxWnG1iIfKFAxKDgM8Wb6O3brIR3jS+lnJrIS5s2gtq9Pb3hSFEEEjdDj
         ApNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7PFtpXrmXzVdMhafl14eKkj59GDcsxhQ6vEeE9HiDUPNo/0q5zqTrSRcQdfQ2fUnYUzodMbPtnEx1GMVsbnJ1lGGVRTmvO33NXfp2
X-Gm-Message-State: AOJu0YyCLU3ErMzU8XZXDYZWjVQM/RfW2SaVwWTm7nLRtdlAZlvIQfvk
	dwtAijp1KLgL0Ik1Sk8DlDC2iHwd2+Kmf5UOkMAMEBoqbSqe//BNW+BWOJfpR6M=
X-Google-Smtp-Source: AGHT+IE2w3mrHIQlivIgobOhQSg9hPNKdfAYMLDOg837QQvNJbsLP/SJ2CQSYGAnPSJH/6GBnsNr+g==
X-Received: by 2002:a17:906:6b97:b0:a51:e2a0:98ef with SMTP id l23-20020a1709066b9700b00a51e2a098efmr658666ejr.52.1712591991922;
        Mon, 08 Apr 2024 08:59:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kn6-20020a170906aa4600b00a4e238e46edsm4611628ejb.223.2024.04.08.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:59:51 -0700 (PDT)
Date: Mon, 8 Apr 2024 18:59:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Micay <danielmicay@gmail.com>, linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/11] staging: replace weird strncpy() with memcpy()
Message-ID: <948ab982-cb4d-46d4-a3c4-cc1c6369eb92@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-4-arnd@kernel.org>
 <695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain>
 <d8ee72ec-c16f-443a-b9c1-555dcbc69182@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ee72ec-c16f-443a-b9c1-555dcbc69182@app.fastmail.com>

On Mon, Apr 08, 2024 at 04:45:55PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 28, 2024, at 17:35, Dan Carpenter wrote:
> > On Thu, Mar 28, 2024 at 03:04:47PM +0100, Arnd Bergmann wrote:
> >> This partially reverts an earlier bugfix that replaced the original
> >> incorrect memcpy() with a less bad strncpy(), but it now also avoids
> >> the original overflow.
> >> 
> >> Fixes: 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
> >
> > I don't see a problem with this commit.  The "sendbytes - 8" prevents
> > a write overflow to buf, and the strncpy() prevents read overflow from
> > inquiry_string.
> 
> I agree the commit did not introduce a runtime bug, but it did
> introduce a warning about the string being truncated.
> 
> >> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
> >> index 08bd768ad34d..a73b0959f5a9 100644
> >> --- a/drivers/staging/rts5208/rtsx_scsi.c
> >> +++ b/drivers/staging/rts5208/rtsx_scsi.c
> >> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
> >>  
> >>  	if (sendbytes > 8) {
> >>  		memcpy(buf, inquiry_buf, 8);
> >> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
> >> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);
> >
> > I think your math is off.  The string is 29 characters + NUL.  So it
> > should be "min(sendbytes, 38) - 8".  You're chopping off the space and
> > the NUL terminator.
> >
> > This only affects pro_formatter_flag code...
> 
> The extra two bytes were clearly a mistake in the original version
> at the time it got added to drivers/staging. Note how the code
> immediately below it would overwrite the space and NUL byte again:
> 
>         if (pro_formatter_flag) {
>                 if (sendbytes > 36)
>                         memcpy(buf + 36, formatter_inquiry_str, sendbytes - 36);
>         }
> 

Ah.  Okay.  Fair enough.

I do think this code is really suspect...  What is the point of allowing
sendbytes < 36?  But that's not related to your patch.

regards,
dan carpenter


