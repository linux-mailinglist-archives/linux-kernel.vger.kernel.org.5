Return-Path: <linux-kernel+bounces-146527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854D8A6697
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D59B1C20F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450484A5C;
	Tue, 16 Apr 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIYvxdUE"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB31F19A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257992; cv=none; b=mziQ44e7i0FYah/1uZv5YV4nADvhzpOx+VzxFZF/pSHaqNDTnKvuC+TTpF83bpOeMHGKlcaArygOQEBznIV4OeQZhQtitpWjRSgKy6u2vn61IkZWExEBguIcBZMqGA3c85EWntunvs/1mvyJ42sGrz5vMb0h1ko2SK5iBC8heAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257992; c=relaxed/simple;
	bh=PKx1DWM9HBQ2TquNxdM03KajoVGyjXDkA/Jg6/nj/6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+Wc8irwBcsVi+Mzddl8pIlD5uvDQE6zhMN9AqtKAHjhJoqyxf8nIEcnMOQk087A06Ls7YL3/ffPuZNNvYV/anZjHxumbfX0luST4ZhNFKAzdXZPvUVOuoxS87DdD0OmXQgrVrTz/4DAVQfPAovImIWl+ZlTOwdREYYiq6H1tEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIYvxdUE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51a7d4466bso469801766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713257989; x=1713862789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNMdc9j3H3MgThdxW8z4dMJyAU9QqhokoKvc+V7z6ho=;
        b=tIYvxdUEFGNrYDf4HL0RGOL0nL6+VMN7ZHqIjp1J81Hbi65UYvfme+k+COhWxQkLG9
         v8ZW0lHv1QaEHTEQeP9bFWy56f6Hj2XNZy4AgiF7ueyDncIeJlaofpW7sRKqey80Beo/
         f1W/LIHC7R8shkeE1eP6rvJLxf0C4y2XIHkm6s5f7+DjJU/5iaxrWYdLWWGZbZ92+qO7
         ctZ+stzTxqgUbN8kCFkyHDWCAtTV6KTW8zDdgyRzQh3xoyXmgdJ+j3KiuafuG6PpTSRy
         1gXfvqXhG4pIMaIRb9FAQbPyocn1TK49xOFIfAegdBpwW8JqUonpjJzBt4qm1AIAeLhY
         LyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257989; x=1713862789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNMdc9j3H3MgThdxW8z4dMJyAU9QqhokoKvc+V7z6ho=;
        b=vjBeLbI6jc5+iVuYiWSX3eStvnz7zogF10eUDZygAbIb4/zzDxVcuV3mKcrpb8Dbml
         +A5qtvT3YpIws6RBFpBT1wUUKKPgwYf/f5GPQJ8SiCCLgSRrP1ZmTRP3mdu1zgGdlAlP
         4dQoGhIQpAd06B3RHCnBuySKf0FIyykVHYNIH1dVbA2ind57hYhbkkMsWFG7mqQIEq7k
         Z5mbWnjJVLHvyZS5bQxVeATZndOGgMvIXgJjRLBCp5gNdq8xQIUHV6jAk3mwunPwv0Vb
         c349zin2eI15d5+/ZlzzMYeFdkRWwvpErwTOmZJI4dQ0GjmzsFCrOH6/v1TilUGFOJFl
         OwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi5QLAYgzgKFJHokbjDSCPAnRhXaCMc+EuNtvBQmY+ZmvTCp11ug56FTOp8qwmHdtAll/essM7bJjFV0UTgjTWih2asv9mxSmcKjLa
X-Gm-Message-State: AOJu0YwN2khhE7OShLVLEJ5OnVokrAI3+j437/zMUvGCWDJtSIylVxn+
	GnFXacfAPd9IQSgPRNcngSPJLdgBUqElvtmJL788jJfYdnWrvPcmeQTfjCfDMDk=
X-Google-Smtp-Source: AGHT+IE5hrTESVqMWnWzqk4RK1lMAqDSLSeII7ES9isRsHuP19AaLAFRxOcYI7GPCs5uQxoyE2W7eQ==
X-Received: by 2002:a17:906:6a09:b0:a52:2c4f:7831 with SMTP id qw9-20020a1709066a0900b00a522c4f7831mr10436193ejc.4.1713257988846;
        Tue, 16 Apr 2024 01:59:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090670c800b00a52244ab819sm6352929ejk.170.2024.04.16.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:59:48 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:59:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Prasad Pandit <pj.pandit@yahoo.in>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: error if file terminates without a new-line
Message-ID: <edf23b1b-303a-46eb-b455-8c766c84ddf1@moroto.mountain>
References: <20240330033858.3272184-1-ppandit@redhat.com>
 <1568855168.5949322.1713251087824@mail.yahoo.com>
 <2024041627-overgrown-ripping-2348@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024041627-overgrown-ripping-2348@gregkh>

On Tue, Apr 16, 2024 at 10:48:27AM +0200, Greg KH wrote:
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 9c4c4a61bc83..df34c0709410 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2795,6 +2795,13 @@ sub process {
> >             $is_patch = 1;
> >         }
> > 
> > +# check if patch terminates file without a new line (\n)
> > +        if ($line =~ /^\\ No newline at end of file$/
> > +            and $rawlines[$linenr - 2] =~ /^\+.*$/) {
> > +            ERROR("NOEOL_FILE",
> > +                  "patch terminates file without a new line (\\n).");
> > +        }
> 
> Why is this a problem?  files without a new line should not cause
> problems with a compiler, right?  You don't have a justification for why
> this change needs to be checked for anywhere.
> 

I gave him such a good reason too...  It breaks `cat file.c`.  Plus, it
looks weird in `git log -p` because it has a "No newline at the end of
file" comment.

regards,
dan carpenter

diff --git a/test.c b/test.c
new file mode 100644
index 000000000000..d808cac2d962
--- /dev/null
+++ b/test.c
@@ -0,0 +1,12 @@
+#include <stdio.h>
+#include <stdbool.h>
+#include "check_debug.h"
+
+void kfree(int *p);
+
+int *p;
+int main(void)
+{
+       kfree(p);
+       *p = 1;
+}
\ No newline at end of file

commit f4a997924122d0094675c897a220371f0a129d90





