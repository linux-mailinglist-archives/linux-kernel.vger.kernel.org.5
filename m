Return-Path: <linux-kernel+bounces-25061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B129182C711
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F4B2837F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947117735;
	Fri, 12 Jan 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc8Z7/ao"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5617726
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3fde109f2so10975ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705097814; x=1705702614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lry9qLsx6UZvlRxob1780MirJjVFaR6R1yAoW5+x8Hk=;
        b=dc8Z7/aomT9QRgG04selIE/s6ThMYsbvvNBGU5Rd4gt8HPEsYDKoldeJKLgGgrCPkU
         0FCgKDB5Pp5//RhUH7qRDraAXdr66WyaAXr11Ow2eqwWk5Q0YJECKkz8GDj7LYtOcECy
         DasoPAgX5yyklpg0F/Tpqtv5t9TVNz7SZIQ1PeZPaf10VBlJus0Y+klAya8uH1CrLk3Q
         Y2/5YRQnRUWFX6uN93ljhRLdqIbL2pZSQWLyKX1TpIR6EBMH9ZcTz33fiJ8b4a/QPOyd
         GBr9FAXISl3EoNmRcJWOrgh386pRz3hP3yUdAppjQuChiwgk9oei4NzMY+pGUJgc+DLb
         gvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097814; x=1705702614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lry9qLsx6UZvlRxob1780MirJjVFaR6R1yAoW5+x8Hk=;
        b=HeX+kC2736/Cn2h1bqMeWX5QX77TLLnbESPpEwF1ZD6bXGf9e9GNTkE49bA08VzHcd
         e8W8mUlkTQB9m27mRNhnJGgMQ2M1MwbVyXVbqKNr2/mC05OrVPCGsF9tzhqaZslEaqkP
         ShxBK5t6l9M+JUemCL88ycoE5OCdOlmBt8mqrKAoM/hDpqVT5iTTHlpSqggEq8R3Znve
         KbkApbmXEsgcVruoBTC13rV/ytVSXZLygAPPDSyviI2TXRKk7J2cGvXiuhhCWQLvP7DK
         oKiW7Jwcu+KAH0qb7kP9NKXEVcvKU/Kcw6wx2STBCUZTGgorDkQIWh5z7V85WC/fKvY0
         3c1Q==
X-Gm-Message-State: AOJu0Yx+w9WmIT2Rlny3FxrgEDuDM3n2sYalDl+qo6DCm9NfMwF9E28Z
	9GQM6XofatUcdHWGffjIj6x9KWeIxrqc
X-Google-Smtp-Source: AGHT+IHZxFmKAb81aZbOG13seu8/SecJ0oTiSTHCDMzD2aW6mfK8h3njEoIKTzRV2XruCxfBbfLtyQ==
X-Received: by 2002:a17:902:f544:b0:1d5:4c40:bf01 with SMTP id h4-20020a170902f54400b001d54c40bf01mr22623plf.17.1705097813656;
        Fri, 12 Jan 2024 14:16:53 -0800 (PST)
Received: from google.com (78.250.82.34.bc.googleusercontent.com. [34.82.250.78])
        by smtp.gmail.com with ESMTPSA id b13-20020a65668d000000b005cdf0b46fecsm3218397pgw.81.2024.01.12.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 14:16:52 -0800 (PST)
Date: Fri, 12 Jan 2024 14:16:49 -0800
From: William McVicker <willmcvicker@google.com>
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] checkpatch: allow build files to reference other
 build files
Message-ID: <ZaG6UcGSrxduqtFH@google.com>
References: <20240112183420.1777576-1-willmcvicker@google.com>
 <3513adb04d17156242c92121a7aec4515c39bcf5.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3513adb04d17156242c92121a7aec4515c39bcf5.camel@perches.com>

On 01/12/2024, Joe Perches wrote:
> On Fri, 2024-01-12 at 10:34 -0800, Will McVicker wrote:
> > Add an exception to the EMBEDDED_FILENAME warning for build files. This
> > fixes the below warnings where the Kconfig and Makefile files reference
> > other similarly named build files.
> > 
> >   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the
> >   filename in the file
> >   #24: FILE: Kconfig:34:
> >   +source "drivers/willmcvicker/Kconfig"
> > 
> >   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the
> >   filename in the file
> >   #36: FILE: Makefile:667:
> >   +	} > Makefile
> 
> No need to wrap here I think.

You're right. I'll update in v2.

> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3785,7 +3785,9 @@ sub process {
> >  		}
> >  
> >  # check for embedded filenames
> > -		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
> > +		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/ &&
> > +			$realfile !~ /Kconfig.*/ &&
> > +			$realfile !~ /Makefile.*/) {
> 
> Align to open parenthesis please.
> It's not useful to have .* before the /

I was following other references in this file, but looks like you're right that
it's not needed. Your recommendation passed the tests I have. So I'll update
the regex in v2.

Thanks,
Will

> 
> So perhaps better to be
> 
> 		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/ &&
> 		    $realfile !~ /(?:Kconfig|Makefile)/) {
> 	
> >  			WARN("EMBEDDED_FILENAME",
> >  			     "It's generally not useful to have the filename in the file\n" . $herecurr);
> >  		}
> 

