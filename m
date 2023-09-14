Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157979FBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjINGal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjINGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:30:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B680E7;
        Wed, 13 Sep 2023 23:30:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c65820134so479408f8f.1;
        Wed, 13 Sep 2023 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694673034; x=1695277834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqrbsszNPWGJmRm+hq+F8aeQwjVZEj8yw2XLI124orQ=;
        b=PH6lh+0TiA38KVKdfqiL9NuWucs0+Fv+cl2ujYsewf6lpiFCPTEk5kcsWiVLnKN1r1
         EZRIrzZ/J4Ibn7c9vgQKIYLuhiWy7Eh+b+vIbwwV5S3Ka+QksD1dJ2MJlvWY7lr8AWlD
         cINkCGum4egXJ1J6ckJnGBPymEAQ6yvsOJnlZNoAgd0P6a1qmDl2QkCeOHMNSJO2JKXX
         9PNZ6kTQVxwOuiD+6/48qFCV/R+85+YT6zmZ7trbqEnVz+KCpBtnG0ZJxVY5LWtMJgwx
         mrvJ8lA4Ge5QzQkO5REfBIA6OCVKAWHlu8maT8QOR0cAqQgtSl5vAb2c+Y8ev/hllC56
         0Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673034; x=1695277834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqrbsszNPWGJmRm+hq+F8aeQwjVZEj8yw2XLI124orQ=;
        b=ecA8o1g/dDpFZjm4Nz2t2ujQwchndSzn+5P0co4XPg6n3ra98vYDVS9mz6iPGjobFo
         /MkhFo+1EtWjy5xDTAx+pbMq+JAee/qetEODV6VzvFXwGFyFfElkfv54wjtwmInf/Vta
         adKyawGDHo0j0bRAwCsoc38Cm/4mxfPHN7L6EMofCDPwcqft3NzdDkyKsYQWOsN8ipzr
         lw1sYQs9Q4p+wYp07AGtmzltsXbAz/DFCyynQHQTTyl7KXi80bds/EYSpR0C6T2DJ24u
         mfMmmRsomNqGdWX8vEmb110MTuukOJRVtZmQsmmx/dKBjepql07IpZzvkyAXQ8tJ/WuT
         Mt4g==
X-Gm-Message-State: AOJu0Yxb3gtIafRA175wAijmCFiA29OP7es0O0d/gp+kEztYqegE3flG
        bFSTAzwjdy08v8rZQ/ZkMEM=
X-Google-Smtp-Source: AGHT+IFloPuoVMqwYqNAhjxlxIGlUZ3r6nTexrsPHeVVWQubS4P5bMZvZAOmmO2qUmDhVXXzpFq6fw==
X-Received: by 2002:a5d:65c6:0:b0:31f:b0ba:f2ce with SMTP id e6-20020a5d65c6000000b0031fb0baf2cemr4008727wrw.9.1694673033297;
        Wed, 13 Sep 2023 23:30:33 -0700 (PDT)
Received: from gmail.com (1F2EF048.nat.pool.telekom.hu. [31.46.240.72])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4c84000000b003197c7d08ddsm818496wrs.71.2023.09.13.23.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:30:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 14 Sep 2023 08:30:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Message-ID: <ZQKohp0plVd4S5St@gmail.com>
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
 <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
 <ZPiH/ds9oeimXDdb@gmail.com>
 <953f2e40-7b0e-27b5-b017-a1ac2175bb47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953f2e40-7b0e-27b5-b017-a1ac2175bb47@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> >> Which IMHO is much more readable then what has landed now. But since 
> >> v2 has already landed I guess the best thing is just to stick with 
> >> what we have upstream now...
> > 
> > Well, how about we do a delta patch with all the changes you suggested? 
> > I'm all for readability.
> 
> So I started doing this and notices that all the string manipulation + 
> parsing done here is really just a DYI implementation of 
> sysfs_match_string().
> 
> So I have prepared a patch to switch to sysfs_match_string(), which 
> completely removes the need to make a copy of the val string.
> 
> I'll submit the patch right after this email.

Thank you - that looks a far more thorough cleanup indeed.

	Ingo
