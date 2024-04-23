Return-Path: <linux-kernel+bounces-155088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D78AE52D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E440D1F240B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716F134420;
	Tue, 23 Apr 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JSjVhsqY"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C484A57
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872645; cv=none; b=DDBpYmx0yKEpAHIVIybQnYxp9kvh6lsZZcNO6DU38NTwH4GZvONeC6+wT55/BGPgjw/kk25QBsDk7GsUUQbaqA5dDfEtUtAuGP93RAZiIS5izPPmBCGJhj7YcUMIwDorpkQ6u1ieJLYsSMa+3b/AGdihFQvp7n00CWHp7SCkl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872645; c=relaxed/simple;
	bh=6/0LlvrN1gpGDZp5aJmUVeP9sPWMqO/MFef6cX7kpcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg8tliq6+N1yleCFFswUZotl6RtnKuelaOjHBAvros+zCA/mc80M2elL1qPtRvA3V65Hr0Ry7gY+45MIN2/flGRhqcZc0CrceIBNyGXDiBjBtXmewQ1YmUBP4qL0vm7wEJsVzo0p9hi1anWL+xAL1BW03eeBTZUGiBC/YAyVP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JSjVhsqY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617e6c873f3so60332267b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713872642; x=1714477442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1sKCCl7ebl0MIJR/f/QkAnKKTThmqv/7gFM9mRIM98=;
        b=JSjVhsqYE+B3o+nKJl2VyqLDdobvhVT0cpe6eAD+nKPEurS1Rfk8FdYebTWlsGc6zA
         0DKXF5wv5LwA0JaOo+60p7JRZv/0AcYfXLU4FbBGUxC9wgWiL/CuJMff4AfQiuLr0umm
         wSC0/uhqQ3w2aML/PMzX8S+e/dWf9IH4RJWZugPlzI7DkmTmDcVxKZ2/QRAl3Ohj5GPh
         9lhaNIjLHn5uul2LQBtYcPF5E2ExQFsZkg0Zl8Qfy4e7eE0rw6B1MjeRVlL3SfPvvD4p
         iimEBcnQJYI0PR6wnA1Tl1DeiQOi7Oj+HesvxY3ukL70qzSeEBwXIy+WEx2qcY5eg4yk
         8xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872642; x=1714477442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1sKCCl7ebl0MIJR/f/QkAnKKTThmqv/7gFM9mRIM98=;
        b=LtaTxnt1DnB79wM54lss+o0eP8eJxyG8AaDSjoFbhZu5+SJfHnSVZ9wpl8o3sLs8ll
         XqQ0+6pQMm9OE05yPFaxL3Ace0Kfe5p4CjWIe2/8xabh/i9rqPwPfbzOUljeLRdQHNVg
         UlY1wZZCNmXckg8A6lKpH/ptsnZduOqlr9C8HvxMnbaGRadQzntMqvMfEjATtefoXgaI
         TizMQvWQcjaj+oCCsuSfm4fLEDAqyhoqBvDO98UK0LLdkeltY4Xn57UJMqowIWdfPTnL
         Ci//tt5/tOvaJg5ZYJmiMf8xNqqZQzYq3eEMlkZ8zUHqJEFfSGpErvXd+DF+Sh2XSFY3
         RDKg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZYWx/d96HqWu6ZRkxNbwd7Wvb63JuhVO8KnkrDFT0N1H2ou9LCrAlBAtqkxrh76RcGUxj3r5zzI/H+I8VvC/twaIrRA8MqxLoUYX
X-Gm-Message-State: AOJu0Yw2GsGhQSJhKoLXcGZUDhZgulh6yt2Y0XBluL2LQ0fqtylrtxL3
	PE+0Z80nHADQHrzK9yXYBlLS7pIL6Sy0V/K1wjxoZXwxHJApngiHKd98YeDtiW7383SDKbUX8XY
	9
X-Google-Smtp-Source: AGHT+IHAGRMnMfKun6Sso1s6etTs8eqdIEQLJM8wBLdLQfSB2Mmcqbr2Dnq3AU99ObhConlm2aqaYw==
X-Received: by 2002:a05:690c:3341:b0:614:8185:2946 with SMTP id fk1-20020a05690c334100b0061481852946mr13628124ywb.42.1713872642685;
        Tue, 23 Apr 2024 04:44:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c3-20020ac85183000000b00436e193f408sm5094927qtn.28.2024.04.23.04.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:44:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzEZ7-0038Id-Jp;
	Tue, 23 Apr 2024 08:44:01 -0300
Date: Tue, 23 Apr 2024 08:44:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 4/6] RDMA/mana_ib: enable RoCE on port 1
Message-ID: <20240423114401.GD231144@ziepe.ca>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
 <1712738551-22075-5-git-send-email-kotaranov@linux.microsoft.com>
 <20240422193728.GA44715@dev-arch.thelio-3990X>
 <PAXPR83MB0557DE1F99908341801A11A6B4112@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0557DE1F99908341801A11A6B4112@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Tue, Apr 23, 2024 at 07:15:41AM +0000, Konstantin Taranov wrote:
> > I could not really find a consistent return code for when
> > netdev_master_upper_dev_get_rcu() fails. -ENODEV?
> 
> Thanks for catching this! Yes, I think ret = -ENODEV; is appropriate fix.
> Should I send a patch to rdma-next? Or what should I do now to fix
> this?

Send a patch

Jason

