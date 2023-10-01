Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9007B474C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjJAMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:18:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098F94
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:17:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso17432537a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696162675; x=1696767475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAzLS2dOI2yGk1V4Wl9xWr4J2ifkSYT5oCM0Ek9ZlC8=;
        b=Lta9eVgqJGx64bM+OYsoMD6qdOeD4XBsArp4+SGAHt96s8gek1zmsg3CatajP6K7Yv
         WeSasDVG3A0LMCKFjBcad2RMYn2US6iYyJMl//flCybX4p5pdD5yb4lUnQB9HD2zTcne
         kvL0I3VPCaXFgMT5GpzhYGF7CgaSAPCZtQkmlLIGj9QFHuoPJlGowi+Fgnxl0PprqfHg
         luUIBRwIfIdHunzhcOw7+KHKjYj/QhD5a+JQe20D44e2WZENMHti4O2UV+Q2MpOQHFzv
         uqfvRdGxaj+C/aGIbMbZaNTrAxcMG0Qwihpkcw4QTERYoDFWgCgRaYLepyjbsGgUTgT0
         OyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696162675; x=1696767475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAzLS2dOI2yGk1V4Wl9xWr4J2ifkSYT5oCM0Ek9ZlC8=;
        b=HhDx3WXp+s7tWkeyrZZfqDPImffPfX4YhIOLg8VwMb/te3HaKMnArIsY37HyceTkL5
         Df3ofNl0GARCZkynOH6W4kpOLnfkmNNlLQPTnyKduCtJAsxdm7dbTanB3JcJQiR+XbgR
         HRZMSUfNgGwUZBky4D+HJEdoqGL902klatOnkuNrCC46bN+hrXHSJkf1F7oe9t581M1N
         jdE+hCSrOtllTLikxdPljJH8ncJpdfPbGxVyAskRoYngXl32GtQ0w0xd1xzx9E/mOjuh
         wr5umrBz6VPsG9D/sX2e+gA7+h+uphl82fV48YitFHZFFAQw3eNIjpt8BpYrNF1rtASb
         eZtQ==
X-Gm-Message-State: AOJu0Yx7XYgNn//o+0Wv08015HIjtO2ZsSkHYqDoddEd9+A2hkYNaGLN
        efdTlmfdXp8erRVvzhL0uuI=
X-Google-Smtp-Source: AGHT+IGlUbJ6x50iaYdhuEWNUrelSREHnjmxrrJK6ohea0fCwZ2JyB9hGW++3kFanro7izPMNQqTvg==
X-Received: by 2002:a17:907:2cd5:b0:9ae:68dc:d571 with SMTP id hg21-20020a1709072cd500b009ae68dcd571mr7867155ejc.46.1696162674925;
        Sun, 01 Oct 2023 05:17:54 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090685c800b009ad7fc17b2asm15458667ejy.224.2023.10.01.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 05:17:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 14:17:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRljbqRbaj+eoUU6@gmail.com>
References: <20230926040526.957240-1-aik@amd.com>
 <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
 <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
 <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Sun, Oct 01, 2023 at 08:40:30PM +1100, Alexey Kardashevskiy wrote:
> > Ingo says different, who wins? :)
> 
> I do: a function gives you type checking - a macro doesn't.

That's false, because this specific macro don't force any types, it
only passes types through as-is to type-checked functions, so both
the macro and the function variant does similar quality of type
checking ...

But I'm fine with both approaches, I suggested a macro because the
existing rdtsc definitions used macros already - but I have no
strong feelings which particular color this shed gets painted ...

Thanks,

	Ingo
