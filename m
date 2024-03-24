Return-Path: <linux-kernel+bounces-112797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB1887E42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9376FB20C73
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA51B941;
	Sun, 24 Mar 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJLbo3WI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641101B7E1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304085; cv=none; b=QqRtLQYjti3TKFE+TJ74Sop9DpvhKrb2IMO18TeZchrW4Jm2F91CNYc0yFbAOprjbf/YWVeIHtgLCFH6SW4yYnoXt9SoTSXzobmU4NPbGSNGSrLQgTdYJxD1NEeKLn7Zssz/x6RpmI3b3JVpv/DcB9dMvW2IDW+5XZAY5+iy4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304085; c=relaxed/simple;
	bh=evkO277w186ii8bfJYyUnIoPuE/Koo/3dScjBu47PiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoBCshZbZ/JFntYYIwBzbqlxiISPiAJYdVC1Esjx+pix/yx9jMgorUPbpQcialqVEaX5rIjdSTBv+n4q0X46UTeGNlXB8lflDHl59/Cdrh6Ay1xZ4PDBn5I55KJ2mYcFSkQKKmtNWX5ATI3DikqMv01w8eUsZgRasBzljbQLlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJLbo3WI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c01c2e124so964152a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711304081; x=1711908881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtxbUcaQcEBq0klFGzfroz61cBFn0r/9x2LrvOXiFaI=;
        b=WJLbo3WIYdG1uYJgzdbhA2YEwcBosZ5/QGHD2j+/GlHAJvg49RIt5pBvg6lxtZ3BO7
         zxpA2gQwQSap/Ud18aA+NFvWVLVCTh16teYMPXBZREmOW+XYah6dfdnoywesaFni942z
         qYMfYjNj71OkSm3JXLxLGn5tl7H72ltvTlZGYh3NSA3R/3otpScf6OW/hWFl095SFeh2
         q06gsK/qpZp8wf/8nbS5mOi6/YqsueNPsdpUtmVkYeUOEbDf/gfkpDW7SqLVOUWUC8WJ
         2GvRSpDf911//VZ1abggFLvs4byLlQBHIIsLelQmhcwjwtexJtL8mMrfx1BQTQ3+e7uG
         JbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711304081; x=1711908881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtxbUcaQcEBq0klFGzfroz61cBFn0r/9x2LrvOXiFaI=;
        b=J7WzJdj3/msThHvrIXe2OoiYCDFQGRRe0Pn2cDhxzlpKj/7JC7XHdWv/quQiEQbVlh
         Ev80U2rfqz9lpeyN0jIiUse/9eEVezgJxn17yG1qc6YdlOjqc8SXtbnnYObowqce4w+V
         9FXW4xmrmIRCaUvKkTKuKxTlWeVMB71zsXT+N1XKppbWrTfjwWtoZlsnzpkEycCN9fun
         vhgJT/JZeu1SfmwJY9gImsngg7UesQXkYVwdg4oBp1cKGJBiJPw91inwrhr3/8OFq0fG
         G3paYgSEn/7S2Oifx/7AFemNQZoEs78fel65gUcfy3gHkEA+MKMGBYFiZ2TYrdWkciOe
         m/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU0KKBLZgQRTK8BzGd6hZThS2LRe64cFHXA6ZvMz0gkToU1Clh8j6RDo+JsI6DuP5Xj57duhYG0oVuiKyKmST+Qaipy7TDeDnjc4c1x
X-Gm-Message-State: AOJu0YyYqogsf0xpB+HvZpKr+Sk7ryJDa//Oub2FshiQnz3HrQ2xu8Af
	em0mf2+79drZnuyTLo8rDOal4IsCp5Q1fatOLv0gkc+XB90l29wW
X-Google-Smtp-Source: AGHT+IGcvsZlhAY7NbB2kQs2ucDxRyZ6VgoZ54YFAMmUofPXUBRrAyY3X0z16xg7EJvotGvDZ5aRYQ==
X-Received: by 2002:a50:cd08:0:b0:565:bb25:bb7a with SMTP id z8-20020a50cd08000000b00565bb25bb7amr3689351edi.24.1711304081296;
        Sun, 24 Mar 2024 11:14:41 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7dc08000000b0056c06d5dce1sm1096305edu.81.2024.03.24.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:14:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 19:14:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	David.Laight@aculab.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Message-ID: <ZgBtjpv+epdpSVw9@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com>
 <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
 <Zf+mjy49dG5ly9ka@gmail.com>
 <CAMzpN2go9mmyWRb9vsg7O1aAtSKrW=HqcZYmddkq7eZQQHuM1Q@mail.gmail.com>
 <ZgAGEcmrWZyDrO50@gmail.com>
 <CAMzpN2j1B99FSXVQ=S5a3G+XQf2Cq5rtx=fR77VHW8RDn7WKAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2j1B99FSXVQ=S5a3G+XQf2Cq5rtx=fR77VHW8RDn7WKAQ@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> > > But, "make oldconfig" will still silently disable stack protector if 
> > > the compiler doesn't support the new options.  It does put the 
> > > comment into the .config file though, so that may be enough.
> >
> > So I was thinking more along the lines of emitting an actual warning to 
> > the build log, every time the compiler check is executed and fails to 
> > detect [certain] essential or good-to-have compiler features.
> >
> > A bit like the red '[ OFF ]' build lines during the perf build:
> >
> > Auto-detecting system features:
> >
> > ...                                   dwarf: [ on  ]
> > ...                      dwarf_getlocations: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libbfd: [ on  ]
> > ...                          libbfd-buildid: [ on  ]
> > ...                                  libcap: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ on  ]
> > ...                      libdw-dwarf-unwind: [ on  ]
> > ...                             libcapstone: [ OFF ]  <========
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> >
> > ... or something like that.
> >
> > Thanks,
> >
> >         Ingo
> 
> That list comes from the perf tool itself
> (tools/perf/builtin-version.c), not the kernel config or build system.

Yeah, I know, I wrote the initial version. ;-)

( See upstream commits b6aa9979416e~1..4cc9117a35b2 )

> Something like that could be added to the main kernel build.  But it 
> should be a separate patch series as it will likely need a lot of design 
> iteration.

Doesn't have to be complicated really, but obviously not a requirement for 
this series.

Thanks,

	Ingo

