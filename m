Return-Path: <linux-kernel+bounces-8197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D878481B387
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF071F24CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044951039;
	Thu, 21 Dec 2023 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfFITGSM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34D750254;
	Thu, 21 Dec 2023 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc259392a6so6382721fa.2;
        Thu, 21 Dec 2023 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154442; x=1703759242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMiezRdT/XDNzzla55Phv/V63MuuA+97DCN5FLo6xvg=;
        b=nfFITGSMtR/nLdHdxZCgTckLhL9UUvi9J3kr/FvARoHH+ceBmoNY5YO5dNanBl7D0c
         lLrehBQRE0wQpfyn1utO2uxVrY2gyladM4ug3t/cUMrMTFw84HmtjWWfIuL0JUmaBRZo
         suzbUc4NR2/id+3tEkjeqNeZ9M04X2vko5wbrYGeyUO8RGrLXFVfbCiGwRCeDiEU2kp/
         APBKU8WMJVofmuuq5SG4wLei0beXQdC8kw3xblQqYym5ENfRmuJCbY+C5vow1/TaMp/e
         NCCHjq8siJcpZEozzbZ7mF7XogGxTmotkA2XogfPBS/Mc7X/Yi2SsTjydIPAG0DBwTUn
         QqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154442; x=1703759242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMiezRdT/XDNzzla55Phv/V63MuuA+97DCN5FLo6xvg=;
        b=OfUToHj2arEn4T1s8X9FsJnEcwQfek2zGhhWrzZXQkvj+Q84gDpqGiNgfErN9IG1tC
         NKvkKfsKdNjl7qWqi2Foivw1w5d2WaiK5TYsFDkwNkBfKBjWIeB/d/pe0xr/3gvV98DJ
         1dMqYcy1bxaTN+GyxpjnES9Y2VkZwyGSZd+nz+1P3jjRnc+DgnDhMOGvjT4Yjf5MRlQ2
         C8Nd+XyTyTGe6BFckENt7jskIjohpzdDwwaWEnhC/WqbfSvd8GQZz7rEGxof0euN7kAf
         Pjnmzqpv65v++LujywRy0car8f2+j5jfU4dIdMwvODiI05YwAAUGwg/aeqajDIkcSVer
         8P7w==
X-Gm-Message-State: AOJu0YxcyW4UdE5SAx7Pq744R7DK17eolHeC7Szmh3BblCzQLtzEJXeR
	WvlOviTHEHNarVa+X6dsQI0=
X-Google-Smtp-Source: AGHT+IHF1tEZetxJfAuXOZbfPbAucVTh2Q24xdjOFkU14oGT2ixt4fSb442EOZVrgIr2b6MJ/SDvZA==
X-Received: by 2002:a2e:b602:0:b0:2cc:7457:d2f8 with SMTP id r2-20020a2eb602000000b002cc7457d2f8mr3231787ljn.59.1703154441493;
        Thu, 21 Dec 2023 02:27:21 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id l19-20020a2ea813000000b002cc31b0d27csm220615ljq.101.2023.12.21.02.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:27:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 Dec 2023 11:27:18 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 7/7] rcu: Add CONFIG_RCU_SR_NORMAL_DEBUG_GP
Message-ID: <ZYQTBtlRMxxM4_DA@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-8-urezki@gmail.com>
 <81e233e8-ea1e-4d59-992e-826b3c96ce01@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e233e8-ea1e-4d59-992e-826b3c96ce01@paulmck-laptop>

> On Tue, Nov 28, 2023 at 09:00:33AM +0100, Uladzislau Rezki (Sony) wrote:
> > This option enables additional debugging for detecting a grace
> > period incompletion for synchronize_rcu() users. If a GP is not
> > fully passed for any user, the warning message is emitted.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Much better, thank you, as this avoids the possibility of false positives
> in production.  But to avoid potential bisection issues, could you please
> fold this into the first patch?
> 
Makes sense. I will fold it into the first one!

--
Uladzislau Rezki

