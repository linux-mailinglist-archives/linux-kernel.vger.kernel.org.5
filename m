Return-Path: <linux-kernel+bounces-10353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F781D33D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E11F23079
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135E98F5B;
	Sat, 23 Dec 2023 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePhiTCGy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F578BF2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78106c385a1so190104485a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703322458; x=1703927258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3qBDWKNLuMDa0UhHV+jKTkyBtD8xXFnzgQzoDr0mNw=;
        b=ePhiTCGyCgJA2KZqL6qrFtJRDbQYXqSS3Xk0SMoS4nBXoM+aLnYqTDY3znAgiBKyyL
         OShaDgQnoY+lLkffxKnkP6yDBXIR7+E+ddlT2ti4O2CQkzrrRK1QM7cDbn/7DV96ZnGS
         CeWiGFXDf+v7zqu1sMZduxyAXDM6CRRPX50lJLxfEk+KJL4LG5eBapC2r/dCuxrHmyQW
         jxMU4vWsVfaXF7HQ+wBVxYGOioLY68pfEnSwi3mrK61w/BsjwO4E1VI/fJ7Xr0ng4/92
         Vk39dJL5v+gPruZb8fpgCcmHsbjeV/PHP12nCeQSQ+QWlC8cOuoAiFFFvYwbpzDrgtXI
         DhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703322458; x=1703927258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3qBDWKNLuMDa0UhHV+jKTkyBtD8xXFnzgQzoDr0mNw=;
        b=QbdkwBzeVJUV3t7WsdeOlVwyyWtppDVu49GEHL8pvHODCcHqq9K48Go/27K0DibbmY
         rd3rF+tmUeTpeK7dgiXEHMMJyiUDeYc98wxRpfIhSbdoc8CuArWe0z3+oHZSR++sxVpM
         S1T1yc+qh+WWS8xkVllMO+eAVTmt/v4oklFzVIWgKESbh+mDVUxBUo6InxJFY60x2zZe
         LgooN0iJBYbqN0SMd3KRLPKHThTCLfgrRNNOHnKOcKwO/k6hEfA3z6gLGRDOjFcYNJK4
         ruTHU1rN1jypKVivW0nocCu+oBUIpb+zMuEBF1nEFMsNBPwLAfu9e7jW5hJdtU0kKyHX
         sndQ==
X-Gm-Message-State: AOJu0YxVWhxQiczMXFX43vq/6rQ7ybGzyImsH3VMikjjpd20uPcqyzqG
	GhMit1Ecc4QQGEqKTp8/WIo0F1/EAFajlGYGGAY=
X-Google-Smtp-Source: AGHT+IFpKHcsVXp1iQKzHj2CLL3CH2XTNSqfKhuGPY7GXxHq4a0KEu/iLc9AWbWEBv8IFRBSL5xdaMCUTOPHPQhOzUc=
X-Received: by 2002:a37:ad02:0:b0:77e:fba3:9d24 with SMTP id
 f2-20020a37ad02000000b0077efba39d24mr3020303qkm.136.1703322457686; Sat, 23
 Dec 2023 01:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116173849.210205-1-kdipendra88@gmail.com>
 <3ff3e05a-8377-4b38-84ae-be24b6cae6a4@intel.com> <CAEKBCKNsw60QM=Ay6CH2Kuh-L8YdjVB5yScjG9pTZUXcBrsf5w@mail.gmail.com>
 <CAEKBCKP9WqurMp4M0Xfm3Jn_5roMGce+G6D3X2bNFuOPe5u07A@mail.gmail.com> <CAEKBCKN02uSXH2hz7EV3PsgzNXbyT8N9wyyTvUAE79UJPo6mSA@mail.gmail.com>
In-Reply-To: <CAEKBCKN02uSXH2hz7EV3PsgzNXbyT8N9wyyTvUAE79UJPo6mSA@mail.gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 23 Dec 2023 14:52:26 +0545
Message-ID: <CAEKBCKMcdvgXrUnp-a+kKh1WsJ-1Weq3eaoH_ysS4-i9UJyrhw@mail.gmail.com>
Subject: Re: [PATCH] x86: Fixes warning: cast removes address space '__user'
 of expression in uaccess_64.h
To: Dave Hansen <dave.hansen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, mjguzik@gmail.com, 
	ira.weiny@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, 18 Nov 2023 at 01:32, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> I am sorry for the formatting of the text as it was due to changing to text
> from html and also I wrote "why spare did not find the difference between
> 'long' and 'unsigned long' in this particular case." instead of "why Sparse
> found the difference between 'long' and 'unsigned long' in this
> particular case."
>
> Thank you for your consideration.
>
> On Sat, 18 Nov 2023 at 01:16, Dipendra Khadka <kdipendra88@gmail.com> wrote:
> >
> > Hi,
> >
> > I am not sure why spare did not find the difference between 'long' and
> > 'unsigned long'
> > in this particular case. I saw that in else case,there is use of
> > unsigned long and sparse
> > does not report a warning .Hence I thought casting to unsigned long
> > will solve the problem.
> > Also, there are not any other warnings thrown by spare in the uaccess_64.h file.
> >
> > I think casting x  to  'void __user *'before checking whether it is
> > greater than or equal to zero
> > in valid_user_address() will be more sensible and fix the warning either.
> >
> > Is this ok for you? Or have to cast to 'unsigned long' or other
> > changes or no need to do anything?

I thought it would be a good time to ask again whether I need patching
or not for this warning?

Thanks

> >
> >
> >
> > On Sat, 18 Nov 2023 at 00:00, Dipendra Khadka <kdipendra88@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I am not sure why spare did not find the difference between 'long' and 'unsigned long'
> > > in this particular case. I saw that in else case,there is use of unsigned long and sparse
> > > does not report a warning .Hence I thought casting to unsigned long will solve the problem.
> > > Also, there are not any other warnings thrown by spare in the uaccess_64.h file.
> > >
> > > I think casting x  to  'void __user *'before checking whether it is greater than or equal to zero
> > > in valid_user_address() will be more sensible and fix the warning either.
> > >
> > > Is this ok for you? Or have to cast to 'unsigned long' or no need to do anything?
> > >
> > >
> > > On Fri, 17 Nov 2023 at 21:04, Dave Hansen <dave.hansen@intel.com> wrote:
> > >>
> > >> On 11/16/23 09:38, Dipendra Khadka wrote:
> > >> > Sparse has identified a warning as follows:
> > >> >
> > >> > ./arch/x86/include/asm/uaccess_64.h:88:24: warning: cast removes address space '__user' of expression.
> > >> >
> > >> > Since the valid_user_address(x) macro implicitly casts the argument
> > >> > to long and compares the converted value of x to zero, casting ptr
> > >> > to unsigned long has no functional impact and does not trigger a
> > >> > Sparse warning either.
> > >>
> > >> Why does sparse complain about a cast to 'long' but not 'unsigned long'?
> > >>  Both remove the '__user' address space from the expression.  Were there
> > >> just so many __user pointers being cast to 'unsigned long' that there's
> > >> an exception in sparse for 'void __user *' => 'unsigned long'?
> > >>
> > >> Either way, if we're going to fix it it seems like it would be better to
> > >> valid_user_address() actually handle, well, __user addresses rather than
> > >> expecting callers to do it.
--
#Dipendra Khadka

