Return-Path: <linux-kernel+bounces-23810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD882B203
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2991C24181
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF764D10E;
	Thu, 11 Jan 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kszKQUJg"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553E4CE09
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so4582428b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704987815; x=1705592615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emlCTYFoJ7HTQ2zXqmk/2tpC5aAMyfsd8X53K7e0g/Q=;
        b=kszKQUJgnT75KyoKkYIzgLlr/fSEAnCWEyV8ociIm50uGsifW+ujJj2lzdnpS4V2e5
         TpSLduHwaf61tiI9e6TNm8n8SDzuu/RPEY00tW3HDx6GBac1m+bW0v7iOr41LCv6O1K5
         WuIOacooRx/Fc7fujBmRG8HMb8q72AOhh62YBv11g+u8MJ75VOCgTeqfhD8saHFmUBKy
         AZbcARMlegIENZH6Be82PUTqqVNehl/pIWrb9GBz0MHaqKEe2JE+IiZZgX3mQqLjj/6M
         g2KuhRvbHujoQmNwygKjj5hI6B6XD6Ms6lvqFAkpKWC4ND/yAwas1R/Z6ul+BOXs3iOE
         f06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987815; x=1705592615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emlCTYFoJ7HTQ2zXqmk/2tpC5aAMyfsd8X53K7e0g/Q=;
        b=XsmUdgoZYKuxo+s66ND66r2isYlf4DrzXm6gkFGMclvvwLYY0CmUVXuBHPWSpikRWF
         v2w8k4nb9SAAhEhKNXw23od/6DJir/ResHN3cJ/Yw5ioaodYWOQlg3sFHLiUNfeTRVZB
         21EVZV8zsx/bkJYefn6bQIzSupb5MTbAw2gzDSexX2tVEca5DMqx3FeDuU89wfDhnhDz
         rAYRE4mzSE4m4lBtrA5cKSfjFN5BvU17rTQmGCX9Yzg3isKNkl7KiNMU5qht96pZonaS
         lTI9d7MM6sTbJn3QbpTBgMsjIgWwPlw5SNF9NAiueeMlr/1S9nw9Zk1zXyG876CY0C6x
         9WOg==
X-Gm-Message-State: AOJu0Ywmj8kSFX8XZMf9RmesrYFtEEon1JwnMPiwGellpMgwV56bbXu7
	oqCOX6xF41tqbHergTpgQW5xX+W3uA95
X-Google-Smtp-Source: AGHT+IFvJaH4YK0hj1wr5WEnyTQLfJ5o58oJEO/otJH4ybFOLkeh5Ao1CGLtIVFFwC3v7Yp457eJow==
X-Received: by 2002:a05:6a20:1595:b0:19a:5eb0:4389 with SMTP id h21-20020a056a20159500b0019a5eb04389mr27554pzj.31.1704987815222;
        Thu, 11 Jan 2024 07:43:35 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id n8-20020aa78a48000000b006da5e1638b6sm1360917pfa.19.2024.01.11.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:43:34 -0800 (PST)
Date: Thu, 11 Jan 2024 21:13:26 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZaAMnh8lae_Cxvtm@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
 <20230710170608.GA346178@rocinante>
 <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
 <ZK7m0hjQg7H5rANZ@google.com>
 <ZLENgbMe4YVOINRQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLENgbMe4YVOINRQ@hovoldconsulting.com>

On Fri, Jul 14, 2023 at 10:55:29AM +0200, Johan Hovold wrote:
> On Wed, Jul 12, 2023 at 11:15:54PM +0530, Ajay Agarwal wrote:
> > On Tue, Jul 11, 2023 at 08:52:23AM +0200, Johan Hovold wrote:
> 
> > > All mainline drivers already start the link before that
> > > wait-for-link-up, so the commit in question makes very little sense.
> > > That's why I prefer reverting it, so as to not pollute the git logs
> > > (e.g. for git blame) with misleading justifications.
> 
> > I am developing a PCIe driver which will not have the start_link
> > callback defined. Instead, the link will be coming up much later based
> > on some other trigger. So my driver will not attempt the LTSSM training
> > on probe. So even if the probe is made asynchronous, it will still end
> > up wasting 1 second of time.
> 
> Yeah, I had the suspicion that this was really motivated by some
> out-of-tree driver, which as I'm sure you know, is not a concern for
> mainline.
> 
> Vendor drivers do all sorts of crazy stuff and we don't carry code in
> mainline for the sole benefit of such drivers that have not been
> upstreamed (and likely never will be).
> 
> So again, I think this patch should just be reverted.
> 
> If you want to get something like this in, you can send a follow-on
> patch describing your actual motivation and use case. But as it appears
> to boil down to "I need this for my out-of-tree driver", I suspect such
> a patch would still be rejected.
> 
> Johan

Johan, Mani,
I submitted https://lore.kernel.org/all/20240111152517.1881382-1-ajayagarwal@google.com/
which does not return an error value if the dw_pcie_wait_for_link fails
in probe. Can you please check and provide your comments?

Thanks
Ajay

