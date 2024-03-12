Return-Path: <linux-kernel+bounces-99986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75DA879046
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC0CB2168F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814A77F20;
	Tue, 12 Mar 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgVrCpjh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278877F08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234259; cv=none; b=NkUbhr6XA5TMvvUAXeB4hBvc1j0OTCDbDXkw9+4R9ahekSY/zgl8ZX80tXIB44Uk1d56Eo670iOGiKLTT69YxwFeldtNlMoEpniooeg4VGiGO8MVcLO6z813lzIj63qlj7s5dtwK4hb5H05g/Sb/xhdCB2ae3ZaFJ4KdvU8/qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234259; c=relaxed/simple;
	bh=8cPRkKDwhOjOinN7/KvqFlSp2n3BNkd495iOvtqXRig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeuPj0m+HUEvTpM7qsfamJIFMP9rJAy9soKC4RCC/0SA7IxpxV9yiiPUFlYfHizTasaOFxtQbosrcdADoMPuAJYXeXe035QagNS/VTnoM+9mqRMlDEdLN9K7qqXX7uXOy96sG/1/GCoHQ5d89WSx84rFZZ+Qca2CPRX2nnpDBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgVrCpjh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51381021af1so5056162e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234256; x=1710839056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O7zxAyQF3D3E9D7zRfWoSnQN6R55rWso5I91Sy8Nv0=;
        b=dgVrCpjhKWUJFflAcwAdpjeTnlaM8VZjwpCN4XmXKGQwPHyGfkYMHyem4XrSf1zkZT
         hQpuURjyy6eYpLfsb1OckVzGSuBubA51REqJX00J+Nj6KaLcKoVQp09pNbsU5VsKmc+G
         VYQzynra7RnGTTXGbJR11AdwqR6qtWJ61nfCX9BlefWlM+VgwTbbjs+hN2DmTHdGiM2V
         uOt4++qJJNN5qbPRHiPT+KWeIYSXEpHO92nrPz0rOagHeZ2bqwcnTh5446ZqfMfG3VJt
         gfVjbTgzcIVkamWXrQcZeU/yTbE41xTEiTvjXXzwSahdQk7dvE5i/PAnqqCFCu2+yWAi
         X3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234256; x=1710839056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O7zxAyQF3D3E9D7zRfWoSnQN6R55rWso5I91Sy8Nv0=;
        b=lj3IxLnkmApJplv9guQCCUWYNEbrmpmtGhOlSxjnSBiB3r3oJpW42Ln+C1vF/KadGM
         EAs8DYct5myxXqi/ixbVmAs0/U4qwx9pR3NcE/ia+w7Ze4WqR99EqMexK6wqp1cqEw+Q
         nf2turTz9D/EAy1+QWMLx7/dmRYa90gw4gQS2x9jtRmNckmEDrLoSvusD6IiRhb112WK
         qoO9/cCQg2ky2LDK3tqkIcp/s5g2KseFpWlV1gtRpQ4fTva86R1rJaqw0rST1iVA5iE7
         RSwndyS1kyt4KqyGJwzSaRtBC3akiVm21Je3DrUB2cw/WBhysl89Z+gNmx1CQPyxCv8C
         zCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWwwk5gQjHqDOusqQSl5mhui/YjCvmRP7l9Xj52DI2B+zmZyBf9XVSTZyIh+jCnQtbjXlfDdleePt0q4v9RzYtNdv0mdGdMupE7zeaT
X-Gm-Message-State: AOJu0YwD2/YuxvH/6C47ZGwmNDnfwoNy9Msr06pUdQXbBDM/GdiWWbdA
	8wUIbknzHUGQjO/2ZJKPhGj4sDKmw6L6DOsVax2jBY08Voo+r7HjoT5E69E4Wp8=
X-Google-Smtp-Source: AGHT+IF7jRGKUWcc9+xc1C8LaTDLuV1gfOIdPpXZDA45JouV+odf1Ft319wMfzCFJft299C7xXkSPQ==
X-Received: by 2002:a05:6512:238e:b0:513:a738:20f1 with SMTP id c14-20020a056512238e00b00513a73820f1mr5437293lfv.25.1710234255222;
        Tue, 12 Mar 2024 02:04:15 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe782000000b0033e7715bafasm8516787wrm.59.2024.03.12.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:04:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 10:04:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/sev for v6.9-rc1
Message-ID: <ZfAajHpcEULEmi/8@gmail.com>
References: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
 <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > diff --cc arch/x86/include/asm/coco.h
> > index 76c310b19b11,21940ef8d290..42871bb262d0
> > --- a/arch/x86/include/asm/coco.h
> > +++ b/arch/x86/include/asm/coco.h
> > @@@ -10,9 -11,15 +11,15 @@@ enum cc_vendor
> >         CC_VENDOR_INTEL,
> >   };
> >
> >  -extern enum cc_vendor cc_vendor;
> > + extern u64 cc_mask;
> > +
> >   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> >  +extern enum cc_vendor cc_vendor;
> 
> I put the 'cc_mask' declaration inside the #ifdef too.
> 
> Because those two variables are defined together, and without
> CONFIG_ARCH_HAS_CC_PLATFORM the whole coco/ subdirectory that defines
> them won't even be built, as far as I can tell.
> 
> And I don't see any _use_ of 'cc_mask' anywhere outside of that one
> 'cc_set_mask()' inline function and the coco/core.c file. So declaring
> it only when it's all enabled seems to be the right thing.
> 
> Let's hope my artistic merge resolution doesn't end up coming back to bite me.

So it does come back in a fashion, because the tip:x86/boot tree has an 
internal merge of x86/sev, where it dutifully followed the original pattern 
of:

   1c811d403afd x86/sev: Fix position dependent variable references in startup code

.. instead of merging it smartly like you did. :-/

And because I think it would suck to force you to do the same smart merge 
conflict resolution *twice*, I did it myself in x86/boot and documented the 
background:

  commit 2e2bc42c8381d2c0e9604b59e49264821da29368 (origin/x86/boot, x86/boot)
  Merge: 428080c9b19b 855684c7d938
  Author: Ingo Molnar <mingo@kernel.org>
  Date:   Tue Mar 12 09:49:52 2024 +0100

    Merge branch 'linus' into x86/boot, to resolve conflict
    
    There's a new conflict with Linus's upstream tree, because
    in the following merge conflict resolution in <asm/coco.h>:
    
      38b334fc767e Merge tag 'x86_sev_for_v6.9_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
    
    Linus has resolved the conflicting placement of 'cc_mask' better
    than the original commit:
    
      1c811d403afd x86/sev: Fix position dependent variable references in startup code
    
    ... which was also done by an internal merge resolution:
    
      2e5fc4786b7a Merge branch 'x86/sev' into x86/boot, to resolve conflicts and to pick up dependent tree
    
    But Linus is right in 38b334fc767e, the 'cc_mask' declaration is sufficient
    within the #ifdef CONFIG_ARCH_HAS_CC_PLATFORM block.
    
    So instead of forcing Linus to do the same resolution again, merge in Linus's
    tree and follow his conflict resolution.
    
     Conflicts:
            arch/x86/include/asm/coco.h
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

You'll get the x86/boot pull request later today. If that extra merge 
commit is too much, please merge FETCH_HEAD~1 instead to discard my merge 
commit.

Thanks,

	Ingo

