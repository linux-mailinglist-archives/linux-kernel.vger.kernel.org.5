Return-Path: <linux-kernel+bounces-31394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDC832DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A23283CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13855C29;
	Fri, 19 Jan 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZcputRn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983A54FB9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684292; cv=none; b=DDCeJkbcZ+6bxATEiUMlHt83QmROMwt31geWVeCcp1ZY23yK3QZcV1r+vlF8ilKBZgxFul0zvuNPOigvMnrMlnJdgv9eH27aMCuumK4dIErzlNtO5CBDpBeEkutQGwYzbcoscJhfuD3IxWzTJefxTE1zI1SqgrhgunRX06cOlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684292; c=relaxed/simple;
	bh=2/p506ZvO5GsIXwzDe+zqGUr6ySQqKjLLVfiaEt2pL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laMkxM69KdjC5VBcI6HUjY0t+MDXh5hCqUy+CCaSA7R62Ko1r2dmEdJcKBDzYQ7rCU2RvfRbXr+TblzAsFUMRDYjMwX9UZ9JUVvlJQpctrXR0h4DSdAEgLZZ5iQSgCcKnDHFOZO8kvfR3+xNU/8X3HtcrcgN2qQGEJSi+PvOQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZcputRn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d427518d52so8269325ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705684290; x=1706289090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP3xgW37E4s9QsJwv9VFLnSNrhK1MDLNOYdnQNaP7rI=;
        b=HZcputRnIOIIxhtpfjcFSN4V37glVlQjzPJhG2dkeJWK9KOK+8IGl4hWXp+syuRAuV
         3hAJ8Th+SQd3H1mHaf9sKM+74SvQKIIhpE2XwzmjRyzPVcLyTdGG9kGoSW39AaTJK1qM
         GqGTzNGXLd4HjmCmD5mtmzghYQRWnE0zJSTsiNpX+/I8g+TW+ikp0BDZEMnY8sbQlTzg
         MMKSQvH0FsoGurJKIS5cAvbcTmy9O4Omz/zthHCLGhFO2Yk54NU72iZRIIyAvDyBOh72
         qMreok4ieebQnvHm+FKJqg3vAgoeSQNpkz//e72WHooOE+ZdqfXnlKiv+kar4JlkML6d
         JJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705684290; x=1706289090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP3xgW37E4s9QsJwv9VFLnSNrhK1MDLNOYdnQNaP7rI=;
        b=MlosBhxo8RL0js0rcTzwJjBTE0HKnPBK8lx/kJSKtMO+3k8hmg3s78fk2279GaJKyX
         TUVr+9RYTh+vV/k0oHwDf9eQU1gmDyGjbKJ2i2Q8+UI/dk3boNiT+qhDtaDUh1+NXF2B
         gH9XBL1Wz3cq1jHOIrLVrdeBooOsjbbNNakoLDkMV2p15kP2FH5YlBoikfdJqT6O3lDs
         NcbtXC7j1I0uHWcQGIxB9lPmU3AaKqxiBPoD8mPZIt9AVIdX6fswfs2Yhznxiv0kcdxL
         HER1/+COhB6GBUeQ0PhhezBTEkSdSniSbqLYKBbyZhhYAxrHGM8PntR64cFi9Qjg3hKz
         tq/w==
X-Gm-Message-State: AOJu0YzASrAtfe5fWdrCOszYriSDu8U2P6gPuq2CFEoj1Kyz5csvYtq/
	ocWL0dS5Fyf3O4zCk9P0l5Y+LDmZMelJq+DNxiWnrbX3k6aJMkfFulgpQKCEcA==
X-Google-Smtp-Source: AGHT+IFGmoiv70FPHh58Z0FTxGqfyd+JtLAeEaWOLTUh5eTnZB2+fVnR/zBt1LSHBVJ2TW1fpBpu0A==
X-Received: by 2002:a17:902:e5c6:b0:1d7:2a07:7841 with SMTP id u6-20020a170902e5c600b001d72a077841mr105478plf.27.1705684290394;
        Fri, 19 Jan 2024 09:11:30 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm3290969plb.148.2024.01.19.09.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:11:30 -0800 (PST)
Date: Fri, 19 Jan 2024 17:11:26 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/28] binder: fix async space check for 0-sized
 buffers
Message-ID: <ZaqtPrVhmfvDYzCU@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-5-cmllamas@google.com>
 <Zal8uGqP2lLZz_oz@google.com>
 <2024011948-sulfate-tartly-7f97@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011948-sulfate-tartly-7f97@gregkh>

On Fri, Jan 19, 2024 at 06:48:53AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 07:32:08PM +0000, Carlos Llamas wrote:
> > On Fri, Dec 01, 2023 at 05:21:33PM +0000, Carlos Llamas wrote:
> > > Move the padding of 0-sized buffers to an earlier stage to account for
> > > this round up during the alloc->free_async_space check.
> > > 
> > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > 
> > Sorry, I forgot to Cc: stable@vger.kernel.org.
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Oops, here is the complete info:

Commit ID: 3091c21d3e9322428691ce0b7a0cfa9c0b239eeb
Subject:   "binder: fix async space check for 0-sized buffers"
Reason:    Fixes an incorrect calculation of available space.
Versions:  v4.19+

Thanks,
--
Carlos Llamas

