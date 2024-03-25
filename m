Return-Path: <linux-kernel+bounces-117381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0688AAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD9340CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51256B98;
	Mon, 25 Mar 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7cvx1+R"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423085677A;
	Mon, 25 Mar 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380932; cv=none; b=f6h6iBjLvKy9VjD1bJVh5HCtzlII7Ncfs9wm1wOXsepo6jb31+kMGENzqvs7DD3jNZPQjlfVTPqTUbbqsIcBXGiwJipdIB/iXAux4ZFP8fnDbknmACHbpb3kYsEPSmQ5Rx0ZWAnv9AyGL4AD1/Hdc6rYiKapMffg+QxFOfINCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380932; c=relaxed/simple;
	bh=MaD9/SmJ2gwBbfzRyshBjEL8kp+oAgi6WZStd/nITTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp5kH65uwDEiY57snuny3NLLiCDkClRH2t3kokqZab9N7WdggWhnJ2PpGK/EbLXh8cn9ll5JJMIo3uNvbVFumjbUOTbEGIGUzXNN1nyIW8fGEVn5ndILBkonEc3M6zDSl86EKfmx6+9TXgT4eOnC2ELnSqVGtDtqiRFJdPws904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7cvx1+R; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4817189c8so2700875eaf.1;
        Mon, 25 Mar 2024 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380929; x=1711985729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5gjqpqHL6b3QiYfa4GEp8Way2nwhE496MGE+gkfK6k=;
        b=F7cvx1+RSV8EOwJjI639gSHBtYx3+BULTDwz603Hs4LNkO/GitlfRTg6x31GJ0gx88
         s0oeh8uHKQohsWXy7jO+Rj7NrkeeoYy2+NMJTBHWsqcoyrCjU1zoyGWyajLlysYlMf5D
         AmYw1MBkwQoHFSZbOqNeggnN1uFbzUGK7yXiK88cUDyFdd5KMa1q5xwlYHhqDQ2pK9GJ
         swt+Rt3RVzCl4YzsLJuVg07WKoZStYZ3xs+iVwI0A+qYCs4H8JIXaTvMhYHnwDrjeRSB
         t4cBSNFlWOVGB7CTgzJz7ab3Xo9m9y068heOrf1kTA/bhsM/6jHj/n7bRMAeq7eIve+h
         11VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380929; x=1711985729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5gjqpqHL6b3QiYfa4GEp8Way2nwhE496MGE+gkfK6k=;
        b=WvDVl1sxNF9l1qk7UJTVbPCxoKi12AHKWlKSUrZpinNzPWuk9Bjv5cU0fM91tt6BT+
         2BRCq8S4d30Z+LAWG+yT2M3UICMCv/AtYxAEr2fRH0oGypDM0x+FTuK3wHCH9no8UeFg
         VD00B42er9rECKeL1NiyXc6kQMXUk2eACxYis+DKqObPUVlwOrVRtR7Pk/RpV55CmrtX
         ZbkQQokQ7qo186vz5lakeCzxrjg6bF8yTJvZLz3lpmtCsQVynGISXJGRn8JGLkIRpqch
         9vsrgNbfKM4Xpg4cyVaLzq7DiEAUo9lpvzATnJdtiBnUxJQNT7kFuiT1P5d1IbkM2dMk
         YMVw==
X-Forwarded-Encrypted: i=1; AJvYcCVmspg29cT7u0W+/zMsauGl835C2aPzkKy+sSaQ1N0ijAcnRyD0lYfeDOq14xTw54AbXVm7YAs6Umadu/9SUvDxA9BQ+j6DcJHFBP+FyzEgiaNjgAIb0CLd6U11b4+YV6b5dgM6dhM=
X-Gm-Message-State: AOJu0Yy8cdswK8M3A8uqrHsX6gsST+9mD9gYhq0Vxw4Ea7+iwinwC73X
	xYle/c9YIBKwcS3r6l517n2Yw89OU92ob6oIjYWoosvOqD1QdAvcgxn/voYR
X-Google-Smtp-Source: AGHT+IHiJ2wXU9yqlX2P3hAeHZ63N300m60Nt+wjAHA9SK87kZ7s4CUMO9vVZHQHJNqyPFse83iNVw==
X-Received: by 2002:a05:6359:4ca5:b0:17f:5f96:4ab4 with SMTP id kk37-20020a0563594ca500b0017f5f964ab4mr8916514rwc.16.1711380929288;
        Mon, 25 Mar 2024 08:35:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u19-20020a63d353000000b005dc88b232a5sm5989948pgi.26.2024.03.25.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:35:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 08:35:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
Message-ID: <1804882b-79bd-408b-862f-bd96e0ba9a46@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>

On Mon, Mar 25, 2024 at 08:39:39AM +0100, John Paul Adrian Glaubitz wrote:
> Hi Guenter,
> 
> On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> > This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
> > 
> > Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
> > data") causes bad checksum calculations on unaligned data. Reverting
> > it fixes the problem.
> > 
> >     # Subtest: checksum
> >     # module: checksum_kunit
> >     1..5
> >     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
> >     Expected ( u64)result == ( u64)expec, but
> >         ( u64)result == 53378 (0xd082)
> >         ( u64)expec == 33488 (0x82d0)
> >     # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
> >     not ok 1 test_csum_fixed_random_inputs
> >     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
> >     Expected ( u64)result == ( u64)expec, but
> >         ( u64)result == 65281 (0xff01)
> >         ( u64)expec == 65280 (0xff00)
> >     # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
> >     not ok 2 test_csum_all_carry_inputs
> >     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
> >     Expected ( u64)result == ( u64)expec, but
> >         ( u64)result == 65535 (0xffff)
> >         ( u64)expec == 65534 (0xfffe)
> >     # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
> >     not ok 3 test_csum_no_carry_inputs
> >     # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
> >     ok 4 test_ip_fast_csum
> >     # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
> >     ok 5 test_csum_ipv6_magic
> >  # checksum: pass:2 fail:3 skip:0 total:5
> >  # Totals: pass:2 fail:3 skip:0 total:5
> > not ok 22 checksum
> 
> Can you tell me how the tests are run so I can try to verify this on real hardware?
> 

Please also see
https://lore.kernel.org/lkml/0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net/t/
where I reported the problem a while ago. I didn't see a fix, so I figured
I'd submit a revert, following the logic that non-optimized code is better
than buggy code. Obviously a real fix would be preferrable, but I don't
understand sh4 assembler well enough to understand what is happening.

Thanks,
Guenter

