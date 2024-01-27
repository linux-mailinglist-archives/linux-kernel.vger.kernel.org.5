Return-Path: <linux-kernel+bounces-41439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389C83F164
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99FC287EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758F200AD;
	Sat, 27 Jan 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3D7F0cN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAC1F93F;
	Sat, 27 Jan 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396494; cv=none; b=P7Jb4VOMNVRT5Lc/a+bjsMj63WIg+8TlA2nr7ysWDyeDRqCv5nVEaVhbTUVtmPhnNdkJyRrdPFj3RsY10BHPvs/lPF+uzhjhT3anN7qlsqWDIrp4auJiG8YXqZLXZjG43a9O0/2wpBFjfjdQ9avuCYK3Bi9Jh7m9qpvPqsLGCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396494; c=relaxed/simple;
	bh=HQMTgPB4Bhpi6XTnDbAxXcr86RjC0yJcJ4MlTGyCRJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vByzMnmkPalTqv3JQOB2QamBYo+tGWtP+tV1532BILz5KpK2mWY70BXav3dWS5aRSEmNd2bbG0eoAG4fz8b75CIwz4m3PbWAyOP5ado0kNbylgTyVPV1K5SVbdPiMqyOYWO+DFWaOtxnTXbFXXPCGU1OJ+vn+o3LMzNrQ3lDE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3D7F0cN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51028acdcf0so1739089e87.0;
        Sat, 27 Jan 2024 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706396490; x=1707001290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3PtoOCmflXE8JrM44LwtaHSMNzcJ3eR+Esxbam8yVg=;
        b=f3D7F0cN6227EU//2JzlSDOIKY/ezUigjsNgebcu4VF4MlPXvEsoxqmHSCwDaoXy7F
         8pUUUnU1//oHObBsvHBcS4aHwoFYvqEU7KDLvDcsXiRLrmOzKN2bFmCaiuzY4JwOi7d8
         17a9M9l8cPonHek/25o9d+wNfaWVT+O5z/bSJ0/NaNbGp2uQpjNM8r9oDAjwy64FKsuI
         k0LJGGumZ4SfcWtxiq+SeoIM8AZ+9fpIp4h/OoSQ5j4pyDtfeqyhz8YFofMl3Vev8XjP
         o0P7G2riYXWfI4Yqr+H9v/DjJUJkLYbi1dSxJ2TQ67Q7W+OG8THEjZX+Y2oC3Dr2oGqq
         dSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706396490; x=1707001290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3PtoOCmflXE8JrM44LwtaHSMNzcJ3eR+Esxbam8yVg=;
        b=JQsJ7j7f4YBED6KyzbbW2FFyy6QC5sA06EStPkl+fNtaDSB3nNnIXLf/7Kx534k1GL
         qKY+dR9OmZ5uZOsfCD01ideMmKK/Jkz5LkCeslcjbjRQ49gVGEMDQRd2lbxcTMB+neXN
         m7O1rAJbE9fjZhkylecTOTqNPX8SpYGECyYiZ4y84Q7o2egqQutXi+9D7UxTgYC4+aNt
         c3VQTaP5B9I16pkc8Dol/1VGo10OcTZ4qSw+00iS3EyrHrkClAJsM4mfcCRQUNHD+ljb
         3L3IWTIi1I2J2+wFiCWv7NtKvl9ZF6/HwzNqxWI7QUQZ2jroVjjwKrGLMzikETy0Jp/w
         wmcw==
X-Gm-Message-State: AOJu0YwTZ+kj+xrOVkNeQJoEfGos5QSnlriVRI0eiYAMgjg6ezF8lAc6
	J4tbnxfzFhO0XnNR4Q75/inelmchLIStgYPRAi19elw0JlTQKD2IZYetcKArjkMnbjE2IYAv2Zg
	eoN0EiLAK+RVZRUGdJyQWGL5o/5c=
X-Google-Smtp-Source: AGHT+IE+iOPuu6oBq6RfhXdXaSlN1kLy8vx7/5kCGbP8mMThNsfKdD+U3LBhdWItjkggF7qNNwFD84CJsW07upVjH9M=
X-Received: by 2002:a05:6512:20d2:b0:50e:7aaf:ec53 with SMTP id
 u18-20020a05651220d200b0050e7aafec53mr1226739lfr.12.1706396490033; Sat, 27
 Jan 2024 15:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126193143.245122-1-kovalev@altlinux.org> <2024012613-woozy-exhume-7b9d@gregkh>
 <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
In-Reply-To: <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 27 Jan 2024 17:01:18 -0600
Message-ID: <CAH2r5mv2ipr4KJfMDXwHgq9L+kGdnRd1C2svcM=PCoDjA7uALA@mail.gmail.com>
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: kovalev@altlinux.org, Greg KH <greg@kroah.com>, stable@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	keescook@chromium.org, sfrench@samba.org, corbet@lwn.net, 
	natechancellor@gmail.com, ndesaulniers@google.com, 
	"pc@manguebit.com" <pc@manguebit.com>, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 12:43=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi,
>
> Adding more people to CC.(who have looked at this issue)
>
> On 27/01/24 6:19 am, Greg KH wrote:
> > On Fri, Jan 26, 2024 at 10:31:41PM +0300, kovalev@altlinux.org wrote:
> >> After mounting a remote cifs resource, it becomes unavailable:
> >> df: /mnt/sambashare: Resource temporarily unavailable
> >>
> >> It was tested on the following Linux kernels:
> >> Linux altlinux 5.10.208-std-def-alt1
> >> Linux fedora 5.10.208-200.el8.x86_64
> >>
> >> The error appeared starting from kernel 5.10.206 after adding
> >> the commit [1] "smb: client: fix OOB in SMB2_query_info_init()",
> >> in which the buffer length increases by 1 as a result of changes:
> >> ...
> >> -      iov[0].iov_len =3D total_len - 1 + input_len;
> >> +      iov[0].iov_len =3D len;
> >> ...
> >>
>
> We can reproduce this on 5.15.148(latest 5.15.y) and Mohamed reported
> this on 6.1.y, so we need backports there as well.
>
> https://lore.kernel.org/all/09738f0f-53a2-43f1-a09d-a2bef48e1344@oracle.c=
om/
>
>
> [root@vm1 xfstests-dev]# ./check -g quick -s smb3
> TEST_DEV=3D//<SERVER_IP>/TEST is mounted but not a type cifs filesystem
> [root@vm1 xfstests-dev]# df
> df: /mnt/test: Resource temporarily unavailable
>
>
> This two patch series doesn't cleanly apply to 5.15.y.
>
> Also I am unsure, which is the better approach to go with
>
> Approach 1 - suggested by Paulo:
> https://lore.kernel.org/all/446860c571d0699ed664175262a9e84b@manguebit.co=
m/
>
> Approach 2 - this series
> Pulling in [PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with
> flex-arrays like this series did.
>
> I think approach 1 is better as the changes are minimal, but please
> correct me if that seems wrong.

Yes - Paulo's fix looks simple


--=20
Thanks,

Steve

