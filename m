Return-Path: <linux-kernel+bounces-102240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DF87AFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86192288648
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EF7B3EC;
	Wed, 13 Mar 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbtyHUv8"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741C61675;
	Wed, 13 Mar 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349971; cv=none; b=X5gHK8ltQ407C0ZofXkBu7zI6LMHscdOKT6QrscL4m91ypL1Cxm2/FBK+DuS0HNmNn9phS8aQwpTS9CTfGl+nQPAIESpVwN5bGth+O+6YvqayQwncMDI909aQsFL1BxNh+2MLfQ5SB+YtJq/s7cgpgczdh6il0dabdPTFO47nAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349971; c=relaxed/simple;
	bh=CGtEhdwmrm5/UaNMYSgG9Qpd3QrEM1t+g+OOYfaXvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9GfHK8GXRgEcC8NF0SwPgI1o92q3y3L+1w2/xqTmJFj+5+4FglMeZQ7L4niWDPzs1gAjGhQM2xUAt9S5MJkZrsAjWYlObbp0Tfm52LBlXYcA3ZYPJ2qtoVTWI/lGc9+7CIJ0t1PT+AQnBtbDiU2JdUP558znDXOpOOQD+6mKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbtyHUv8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690b24973beso9275786d6.0;
        Wed, 13 Mar 2024 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710349969; x=1710954769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpBNctat7CfTRjsNkuYxZn5BwpmaKOl12v6NjpLVXV8=;
        b=nbtyHUv8TnlFMLgrLtte3OsZlPTV3TYxHGeHT/wVEpvCVcC3WyoVoPzHtmahZn55BO
         e1ZTbAioyRqfWTD5Ktc9Up/fsSnVBEHACIn8VDrPdjfKcZAl26Gw0cgAnzXeFfvN9dNR
         tCvkE2k+Bn11w6dOezSoLV3ftXRwleTSi+O0ynnz51vr5V47e72KcQ8SjWmqdpn15iEz
         ynye5Pj4OHVQWa3mhuHbG/lO3V5xCQfoA8zDANPeJx969tIXBwRWN4C+unEfbhvRqeFy
         4VjzZc95BEtnsyTOG4SrdVi0PHmMjWd0Je6MSLFDOS1LDsZDi93BmiapxCxaibf3VBOD
         awHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349969; x=1710954769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpBNctat7CfTRjsNkuYxZn5BwpmaKOl12v6NjpLVXV8=;
        b=dm3WmFNKOmREnLwvy8mjTg8LnCh8sanN0aRucxBMlN8ABCkGU4YiuHw2krZewfIGzt
         7Ny+3myv1D3BcQI2bzZ9ZqYMpnaigsYh+QAs4GNJ458hXl1Y6yOt1Z/MUA9G6LY3El1r
         iWyMsqRnV695D8lu4pNwv5EDLueSRb6SbKUb7FIzADHezjnvLl7d6iSGmCjWGtPt+nYH
         T9eMlVe3Pp4LTcsHAfy3PXMMLUgkt+vH2DM+MkHZEnAr6/Tb1UaeaN30tWWVV8687EY7
         /iR740zFd6PpAZtFAFM5kYx4fuld0u7W6nJLmZx2nzFH1QAhfm85RPccVPXodzSVKbCc
         2qHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3SPwCihT54BsxAHYosCc8ZYbs14WI+GxZZ+Ms2Fnx17NyNSk8nfTRH53e0Md18b2aaiF28ujI2S3nzOEyDo+sga9+obUqlfRhs9x1A710q+bQwRBkoBILnr3zz5QOaAeDtzAyTNXx7Mudb28=
X-Gm-Message-State: AOJu0YyEDFZGE5pqfiuAc9TKG0sRZ6UismHWB52vlVlJJLypvzNtTUcr
	2gDghiJqD7mEeZUtFmAxx1A4PbpIvqK8N2vhkLtCSkNFTzccJpBX
X-Google-Smtp-Source: AGHT+IEKYoX53WR1XBO/FpN7W909KsrVm9qTaiMAgbvqLtMsJn2thhDcEE1Qvu13gSqv1a4SMQLHuw==
X-Received: by 2002:a0c:9a08:0:b0:690:b85a:7030 with SMTP id p8-20020a0c9a08000000b00690b85a7030mr775770qvd.1.1710349969112;
        Wed, 13 Mar 2024 10:12:49 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id o8-20020a056214180800b0068ff79d8d97sm4924415qvw.41.2024.03.13.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:12:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 415971200068;
	Wed, 13 Mar 2024 13:12:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Mar 2024 13:12:48 -0400
X-ME-Sender: <xms:j97xZcP4ekLZyuLFSffkH5mn6zOy-lMw5vkeftLqxOI8bBoiFs1Jqg>
    <xme:j97xZS85lX99rgqK2mI5hUzIGDfrTWD5pLI2NGL9iF40dEhcGKjzarbc28owB5mHl
    nPWJei8HViDiYUiJA>
X-ME-Received: <xmr:j97xZTTrndTlfp5rMW8GGxwoC3VE4s-IRWk8b3ViUIPlK_Gil49yZFPf82wybQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:j97xZUtJYZkQ-GFuo4LzmKvZ5CpZtYydPBKGHU_m_EV8URBbpMoWZQ>
    <xmx:j97xZUdbrY1ldRBl5U6CR59aX4pAzrIc_6BJw-oO9URuT2kmHVsoJw>
    <xmx:j97xZY1DLEuSDMDPWysVxZbSN1ODcDbqG20LYQLSpaUm9iadWOLtdQ>
    <xmx:j97xZY8CI8UxkqllJygc347AvjXvjW6wLvRy-dQAgZyU8qZwufeGbw>
    <xmx:kN7xZY1TPimN4QStyILpFjF9cFtMM5mfeRTyWlwPYDwOg7DonwaiqTsrnZs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 13:12:47 -0400 (EDT)
Date: Wed, 13 Mar 2024 10:12:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, gary@garyguo.net,
	linux-kernel@vger.kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v3 2/2] rust: sync: add `Arc::into_unique_or_drop`
Message-ID: <ZfHejEkGKPPHPx05@boqun-archlinux>
References: <ZfCQuh-JrplKtbco@boqun-archlinux>
 <20240313095059.844387-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313095059.844387-1-aliceryhl@google.com>

On Wed, Mar 13, 2024 at 09:50:59AM +0000, Alice Ryhl wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> > The code looks good, and FWIW, I added the Examples section for the
> > function since I at least need something to run when queuing it to
> > rust-dev branch ;-) And I think it's overall good to have examples for
> > every `pub` function. If there is a next version (which is unlikely),
> > feel free to fold it. I can also send it alone once Miguel put your
> > patches into the rust-next branch.
> 
> Thanks! If you have reviewed it, could I have your Reviewed-by tag?
> 

Done.

> > From 7d26d1177a2788ba96c607fd9dc45baf469fb439 Mon Sep 17 00:00:00 2001
> > From: Boqun Feng <boqun.feng@gmail.com>
> > Date: Tue, 12 Mar 2024 10:03:39 -0700
> > Subject: [PATCH] kernel: sync: Add "Examples" section for
> >  Arc::into_unique_or_drop()
> > 
> > These examples provide better documentation and can serve as unit tests
> > as well, so add them.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 

Thanks! I will add it.

Regards,
Boqun

> Alice

