Return-Path: <linux-kernel+bounces-88200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C999486DE82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6860D1F25ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1C6A8BB;
	Fri,  1 Mar 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZqdM5MY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9A69312;
	Fri,  1 Mar 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286189; cv=none; b=r8mAUn7u1jYtUekML08w4KufVyzIhucJIB3/QCupAhGcl9ROUPguCXvi1ZMJTIahH1BOkj8+jU+UNdTjMRjEIFwRSLjeSDwv6vhwhKff6HjazIjKQ2cjxnhqfMChYFGEnYzHh3iOafNiZytZGAcf45hs2kyAn9zxkZWPRb8L4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286189; c=relaxed/simple;
	bh=Q/pSwiu5bnF00mc889Wu5nUt1owdaEavDfTTeHGOU/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVqHYQ+dDkXeSBoi5i+JzKcSFpvEYcpYfTWvc/lnjFxlfLj31mLOXDEiSaCL7CQfDj4anFOGB2KjmVK8CyytQPRHA6RLWwsDAYmaJlBi3W3O5jQ1bw6wl0b7H6ztzWzolAemtPOuuJRI/M4FvFP7aZtAJsofU5YIc5xg7WYRql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZqdM5MY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e55731af5cso1506387b3a.0;
        Fri, 01 Mar 2024 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709286187; x=1709890987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/pSwiu5bnF00mc889Wu5nUt1owdaEavDfTTeHGOU/4=;
        b=bZqdM5MYaWgjcnUGupt95iffnplovf47Nbpksuwo0UbF6GdpsMKB+w73oyzpzT5v6S
         VkGp2z51uc8PZhtEDh/UoXY06Tb4rW4L7LdtqKSoffi2T3zTc6jv5SrSjNHwkuE3ulq3
         Ckj4AK+zjXT7mtVb1+XwOEB1hMTyxsLwltZRSI/QrCrxyLEZM3Sju9vG27OttlQ2dLuu
         TfHdZERASRv/DCHu4RgnHXjuW8Yoj090a3GFxvopdTOzRESCDhKWfRRNr6NlmGSGkdlW
         jRwKWFdct+aZY9NnLw45vZJ9ckZVUzW4zwS/ltmKvGz3lV1fDH8hXf9N4/0CIMRlGgcm
         UIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286187; x=1709890987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/pSwiu5bnF00mc889Wu5nUt1owdaEavDfTTeHGOU/4=;
        b=JDmqixikFExNfU/G9GDSpJGS7jMDoLdP7Z853KLiQUOtZWcrZxUVna0VKYR0MI9pN8
         RgWRhlw9RV6t8LfeReLHbeZ+Z3aY6bu8pnM65vXwe5+rOBbMtDWmfQN7u3n4bWNnUrsQ
         Opvd6HXVOgoHv9argpeN9p8+Rqt6RiH2CavQlDar9y1W+RVtu1xkfimP8qJvpsQP19ju
         LtwaB0ftc4U+6D2TXZxrv3csxxBxtzRIh82DdV0twc6yJ0nQt3JL5BAw6OSTAeTtidni
         DyW9bVEQiq1bbGHZQ4Z06uWiqBJzXY7PvqlSPOP4Y1ItM6KzQHQhySoZPeavJh+hT25/
         QqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbVwAYcCnbvughrAre+ETsvBAcpBauDcN+S0MNRL9W4qrenW2NSXUH8Gs2rOYJ/I8RBVSpXYdRZiCt4Pv9EW4XGMKEqZstOdgc5jDVDhSuRWzh5twQn56WCkhQ28gj5tU4rB2hici6PQ==
X-Gm-Message-State: AOJu0YwHsU9EdtWvWkFOtuC0N3tM0tfOluqy94G7/CxrZv7RWj5DRtH3
	Iqj5eTFn4G5Yiuf+3hdUovQPDg8TzWJbkvDnWPksiO3sy8tYW5QaXmJPzcXcQLGD0kSbSM3nYMp
	0kjIg3wJp5p3rFDP83Gi/NcN1etunCsvGUtE=
X-Google-Smtp-Source: AGHT+IGbCad8v2Ljwyl4WWC/62pOxFrAt3peGaca8gfisX3q1k+RCJf/Ms8P/Oq3ilqvjavEzQMoiJCNFeUgwyknNsQ=
X-Received: by 2002:a05:6a20:9187:b0:19e:b925:f191 with SMTP id
 v7-20020a056a20918700b0019eb925f191mr1061070pzd.10.1709286187448; Fri, 01 Mar
 2024 01:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301153807.796a3a28@canb.auug.org.au>
In-Reply-To: <20240301153807.796a3a28@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Mar 2024 10:42:55 +0100
Message-ID: <CANiq72mgE-3xYGabX9h3DgqCEbHjMvynpjbA=na9NUh8cxJVdA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the arm64 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:38=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

The resolution looks good -- thanks!

Cheers,
Miguel

