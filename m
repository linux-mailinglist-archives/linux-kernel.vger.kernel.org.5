Return-Path: <linux-kernel+bounces-103043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148087BA54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D981F22D26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95DE6CDBA;
	Thu, 14 Mar 2024 09:25:04 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89BEEC4;
	Thu, 14 Mar 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408304; cv=none; b=gRReJPXINC2eYet//AmQFQv43ZEYEKP0SxGHojOA3JWgia56csNybm59VwB0OuCzFYCw36B91C3lZpETJWM1GI83OvzKqk1MR6aY6iCx7vX2JeaIKc1Cnns4q8Gtm3JItGHnfk4GvVOw1TYTgAGR4xNOQSySRhdgbvg36hH9lAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408304; c=relaxed/simple;
	bh=IDFJQkzpmC7c2WA6l0wWiWP6Efo/2y2jmb9sZhGD9FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpk06rnSyFWDKjlpx+2etm0QSIVuTt2efKw/F7qfnTBRq+JUxwrDr2eswFXlSxxoTB8SkyoShne9MizyRc7SBU4JwlhRKf2uJou6HptDOhyz1IGUQZr3zyxAVMq2noVil+DAGSQpnyBNar37hZBlLVIMCW9BwE4zD2NE9Ksy5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so783990a12.0;
        Thu, 14 Mar 2024 02:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408301; x=1711013101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2AMCKa8xjuFJ/+y6Cct9NYQEH6LHnnZ4GOl/QZE6sI=;
        b=nLyDdvkLjm2jYaXRQRFhv83vqyrpbBB+/7bWPl+Py5iNTtr21XTNLBJr9a3wHEb/68
         Wn8Zp+4L/EvYqZ26aLVf/aEHGzLfRsOCepm5QSGv2hj8eMwXh99RpsqOov55VrXxZN1+
         sTLTtvrHtoIj9JEWOjDIldsMBj3JjKqqqyfyKZBvZ8jpDXXVDeLoQW4R0Vi8hD7Y6wEM
         PGARgFfCC+Wu/5ab43GNDThXhEMDCMPvwW+dGEkVqSronQlnFCgmF2FsiZ+6fFdqF0tO
         q85JYjWtOASs9g4+1nZCH7T6+pmL8zbumz+Vudhhi0YqatOX85pU6GTTMdEOiaYu9zH9
         4Ilg==
X-Forwarded-Encrypted: i=1; AJvYcCVm+1c0otEsHDQNeXNCQpOlQXmZtT2H1CGselGQn0j3xtDsEntxY6GNsZPszGnzJynYIKjE5+iKom1FCbAeupZ+OiziGd4jx9j1+1c8GMbxZfDW68Ze0rYB22wElhTLee8pytP4
X-Gm-Message-State: AOJu0YylJ3mq3doikXwbBxz+b0DrNHg797aOl9nYWyIMhGe4u81+AMzR
	NTRm85tY47vtsFREhhxIFB+t/pEPxH4nH0KcP60ayFQvj1AvzL63tfYQ1XYG
X-Google-Smtp-Source: AGHT+IEV2+DZzFGZ2aBVjsYtF46Z5Pf8Bzv2uM+4A3+8sU8bu/aI8ncLBomTP3kDjPXWSerq/6lTaQ==
X-Received: by 2002:a05:6402:4494:b0:568:3362:cccf with SMTP id er20-20020a056402449400b005683362cccfmr808747edb.7.1710408300966;
        Thu, 14 Mar 2024 02:25:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7d358000000b0056729e902f7sm521951edr.56.2024.03.14.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:25:00 -0700 (PDT)
Date: Thu, 14 Mar 2024 02:24:58 -0700
From: Breno Leitao <leitao@debian.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, dsahern@kernel.org,
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
Message-ID: <ZfLCakKfDmC/JNPV@gmail.com>
References: <20240308112746.2290505-1-leitao@debian.org>
 <ZfJtzhKJV4yo3LRF@zx2c4.com>
 <CAHmME9prrtWu8jkj20WKvTZV6mjQE2Vt_mFWGOuy9St1FOrEOg@mail.gmail.com>
 <CAHmME9oPPtJXd8DsA+xXvbdN7T0PbAM5kYpQj32KZXv9bKP1ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9oPPtJXd8DsA+xXvbdN7T0PbAM5kYpQj32KZXv9bKP1ng@mail.gmail.com>

On Wed, Mar 13, 2024 at 09:35:43PM -0600, Jason A. Donenfeld wrote:
> On Wed, Mar 13, 2024 at 9:27 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Mar 13, 2024 at 9:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > I applied this series to the wireguard tree. Thanks for the patches.
> >
> > Actually, sorry, nevermind. 1/2 is fine, but 2/2 results in `ip -stats
> > link ...` returning all zeros.
> 
> Ahh, okay, required some more commits from 6.8. Okay, seems to be
> working. I'll let this cook a bit and then push it up in a while.

Right, it requires the following commit, which is already in net-next
and 6.9 by now.

3e2f544dd8a33b2f6 ("net: get stats64 if device if driver is configured")

Thanks Jason!

