Return-Path: <linux-kernel+bounces-79519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A0486238F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633C51C21E54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185517C74;
	Sat, 24 Feb 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOXIfQJE"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603917580;
	Sat, 24 Feb 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765310; cv=none; b=i4KKku7KIEUjLrzgCrNqlmt3nzrWPJeTnZ1QLBw5Kd4vCssyfmZU/gCSRAljSrY+UhMYSDKiq5Gh4XfXVHJKqsztBJccIjzVhKD5uAiRoayLI0AtEbmZzHc+8GVEOfCXBrPg0JEhTu1WFCZgGEgxnv25VABCe7pvMcAMW5Tr02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765310; c=relaxed/simple;
	bh=IWyH0Jkz//fmI8dxhf0fckSefgngvhBY4MjWQL1hiwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNvwW0ffUCVf7oqhS2Pi2/271neWVJtHfDtaOlx3ghZj6NbJvoT27irYMkeIP43yp+rH4Xj3ifY8KGDtlRjOWLIxdSTWrRpkfN67VgqQZOPUjZyC5lxh9TGdlN+c+lzRVFJC6i2xZ8JPUM2CMIp8bMdC/EVnR1uuXO7ApKHRkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOXIfQJE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299b55f2344so1230787a91.2;
        Sat, 24 Feb 2024 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708765309; x=1709370109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZAu6HeYsVaFhEPwhQMNPxqZSfY4dGk4yAP3g8ezQ1Y=;
        b=mOXIfQJEUaTDy1ZO6omci9ClRtS3aPvb80Fi0F6Y90wiqsOC1zNWE6pwlqcxzH04gm
         Gf50VxD4t6lK94znd94lYyLrJBOQRjkg0cGckY1UKqpL8MAvoYkypori3eh4PsPGKMQc
         Q7zr7J2yyEfxFVEtlLP3UwhtAlx7VK7nITdTvZ8dNy/LOPxZZ+3kVG92FdRCLg+m+KTL
         pZamxO2d5WtUTXquvyxOut/mFvfQgXyzIm/utmJDwA8H+PZ11jmVshITP02++4Rh7fus
         6ID0fc+2Y3GSuztGoa9mcMpGMRJG5aGSJitBVL84waDnBGOroTl9s5eIpDkpcWxQbdp+
         gkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765309; x=1709370109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZAu6HeYsVaFhEPwhQMNPxqZSfY4dGk4yAP3g8ezQ1Y=;
        b=RhEPiuE46SWckynqRztpteaG4kwgFzS9Gu57C3Iulxn+9TiRTfMsNmGyS/K0JQzRCd
         yum790U5n3MYFhGe/wZLN6K3xeq5sqHWAOilKaPi2kdLUkyqfcAct5AwniuILO4npm+9
         BmA3mxygmzoLGIIhzWdDlpimpjV8fXW9fWvdkZsLKrr+HuEPr3/SCNM1Nedx47Kjtn5G
         adjQSmINn0/drFuuS9i62XC6IUcXXa1l7ozszgXClUD9Gmivo+T5xtwbmu7swAwp8vbz
         iiSryDeR76y1ankwmS/4kCZUPYOxTYr1+ibm+Z3umx3GRDPonXY8D5N7lYLVD4ZtrKmN
         HBtw==
X-Forwarded-Encrypted: i=1; AJvYcCXenFjfNQQc3BYe292UaYBrT9NjWD+Zig9rBhMMA9+tPxvSZz+EGeliX7LkoX1JDNGZtFUryx5L7QG72tzKl+d8PCrCKI+ILfXciiVPxwBEuhTAVXe6WyvbCIrMhant0tx+BOI5
X-Gm-Message-State: AOJu0Yw25O4NDoTfqi8doe1LYvciWlt01ztntPVbbnoar9KMIjP1s2WV
	1S0y8CHAwGXGE9WJ0l1ngxUMNnQ/D9UZ8TMZk8DqZWX0OOeGe3OX3xsL6PI5/wjA82xkXTKFdXR
	w1TgdscJUfeOWFlU0+MOEAdNEfhk=
X-Google-Smtp-Source: AGHT+IFR6Ij6u+v9GZaUQFLCV6I0IxwMQH003T03XeNsQS0Axg0VZbKYSQZ2MEF/nesR8WVh/biY5nuQZzt+xuTlPys=
X-Received: by 2002:a17:90a:6806:b0:299:d672:ba0d with SMTP id
 p6-20020a17090a680600b00299d672ba0dmr1547614pjj.3.1708765308564; Sat, 24 Feb
 2024 01:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de> <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
 <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de> <2024022326-wheat-heat-e4ba@gregkh>
In-Reply-To: <2024022326-wheat-heat-e4ba@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 24 Feb 2024 10:01:36 +0100
Message-ID: <CADo9pHgvjr6-=heOBuhjZqW0W2nhC1zBbaqYq9bWis9J-6SBAA@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Ronald Warsow <rwarsow@gmx.de>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How do i change to bottom instead of top posting in the gmail webinterface?
will try to make better in the future if i know how to do, i am just
trying to help out sorry

Den fre 23 feb. 2024 kl 13:59 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Wed, Feb 21, 2024 at 03:47:23PM +0100, Ronald Warsow wrote:
> > On 21.02.24 15:25, Luna Jernberg wrote:
> > > Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
> > > Processor and Arch Linux
> > >
> > > Tested-by: Luna Jernberg <droidbittin@gmail.com>
> > >
> >
> > du meine deinem Scheiss Top Posting immer !!!
> > :-(
> >
> > get the fuck out of it !
>
> Ik kan ook vloeken, maar dat is niet ok=C3=A9!
>
>

