Return-Path: <linux-kernel+bounces-133794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E789A8C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C515B2224E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45591AACC;
	Sat,  6 Apr 2024 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc1hOVYQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6317C8B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376099; cv=none; b=Y4vO+bmIbVaZf5x2TglDJLJ8uP03Fy6vWC6R+hJSfJFVi+otOKbdYE2xWa9J/TCQgz+ewSrCkx2HcFvToSnNu9e5s06XWbnL5aRr5N8Jzl847Bx3y2zwJZCiAPupLQICczKLBensBuxWWb48LEjhL92iIhJRIaazp+WqQ9v7oH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376099; c=relaxed/simple;
	bh=iGIic5Vke/591CKh/3b9bJwpfTpW9Aa1DcmTqF5MS4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzZD3WJMS34GtCJb5zPm8YP+hmWCSfMlhh5fKs6lhn5vthCKWgVlxwT9CFjdupFRzgoI/IV2Ygc6KnPbn7ENOFz7InTE+QXq7XaPD+g+fSsYF0L/68NbuRQ8kDt2PQkIuFAsBvM8OOplOHMTVpxkzZ/DSfmdgaSw6JRSR2FOTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kc1hOVYQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0edd0340fso25292325ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712376097; x=1712980897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQjty2mOKA3aYPwrRydJz6nV5Fa5xbHN2C7CKYkz1ck=;
        b=kc1hOVYQgcXV6R2vXfIzE+c7Re72RcXcpnF0zt1frEwFUaSEvLUQRW92quGrawGpw2
         nJz6cr5R+RUr7RahnQVRM4Sz9sehvSVa7yeVzAa8Ub9UDcd1+kAHS3bD5ivn+Wu/QksM
         OfGxzW845x41v3woOP3fzrIJWIce9d0MnfjkeEUfaspOnzHTHjmW2cqCxdtJCzfjcVQS
         uQq7+5yH+8E2cKtH96KVuXAsOCl0H6pqSINfi3lySrVp2T2YV8nVtIa3Ymmvu3O8MM3G
         adKBBxxjSky+OLRTENE+ObsGVnvPie/ey0HtYJVu5UhJYO4tPSo118ocBuAbnBLdJhuh
         cgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712376097; x=1712980897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQjty2mOKA3aYPwrRydJz6nV5Fa5xbHN2C7CKYkz1ck=;
        b=drxP6MEIgtrjabHoXZIP4fciSfavvkVDzIsvKxDTjOxBhu+Fm23+DeDlM1hlLiWuiP
         4DKHwT7Imy+5r+CJ4D3WEtUKUNpez5nWXbEiwDknyHmn9Il0GqosM4XXe8N1TwgjjgGI
         Rl1Eewb21V+GxOwg4ztY0/Ph6w0l0nZt1tUEXykmpiphli2B54PPsiOj66O3QxiZwmKi
         f39JSpZx0Fj2E3tlVirJX9KWNYqprLEn6fBI8CT3mUX0NYKtAfRCbgGiQZpIdU3W3L97
         cACF79iwrN+WQKz9AXPIR2Hmr6+pfigjxlGfslbZlFNw3LTtZ04sAFmLmbxmg5kFzHun
         zkLg==
X-Forwarded-Encrypted: i=1; AJvYcCWBdby4HyrvHMMlOh94YKGcKGjYSYz1Ql+P2LPtOsLek55hTx3rRdk6SN6xd5YYYOvTK54Y3irvtyNGNWzdOwP8GbHIXCW/X4FIuIyt
X-Gm-Message-State: AOJu0Yx4/TZ17IIPlbd7mmBWk3Hh98tMMqVPVplXXNlwAnfHSTq+sIXU
	NuuSDxvHNwqe3KmebsXCol6UBCmdVVEed8vGcDJwxbNmAz5fLmgdXp9GPE+qjQ==
X-Google-Smtp-Source: AGHT+IFMgTl1ymn76+dFZqiHTXRkv7EeNZvZAC0dcIAOHMClnGKLFdsS4H4hz0A/TXOMBMvrVgvVKQ==
X-Received: by 2002:a17:903:2990:b0:1e3:e081:e7f6 with SMTP id lm16-20020a170903299000b001e3e081e7f6mr2877plb.66.1712376096519;
        Fri, 05 Apr 2024 21:01:36 -0700 (PDT)
Received: from thinkpad ([103.28.246.231])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001e0e5722788sm2483112plk.17.2024.04.05.21.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 21:01:36 -0700 (PDT)
Date: Sat, 6 Apr 2024 09:31:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <20240406040131.GC2678@thinkpad>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
 <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
 <20240405062426.GB2953@thinkpad>
 <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>

On Fri, Apr 05, 2024 at 10:31:16AM -0400, Frank Li wrote:
> On Fri, Apr 05, 2024 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Mar 19, 2024 at 12:07:15PM -0400, Frank Li wrote:
> > 
> > PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off during system suspend
> > 
> > > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > > window. This space's size is 'region_align'.
> > > 
> > > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > > can trigger a PCI message, such as PME_Turn_Off.
> > > 
> > > Add common dwc_pme_turn_off() function.
> > > 
> > > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > > exist.
> > > 
> > 
> > How about:
> > 
> > "Instead of relying on the vendor specific implementations to send the
> > PME_Turn_Off message, let's introduce a generic way of sending the message using
> > the MSG TLP.
> > 
> > This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> > at the end of the first IORESOURCE_MEM window of the host bridge. And then
> > sending the PME_Turn_Off message during system suspend with the help of iATU.
> > 
> > It should be noted that this generic implementation is optional for the glue
> > drivers and can be overridden by a custom 'pme_turn_off' callback."
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 267687ab33cbc..d5723fce7a894 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	return 0;
> > >  }
> > >  
> > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct resource_entry *win;
> > > +	struct resource *res;
> > > +
> > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > +	if (win) {
> > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > +		if (!res)
> > > +			return;
> > > +
> > > +		/* Reserve last region_align block as message TLP space */
> > > +		res->start = win->res->end - pci->region_align + 1;
> > > +		res->end = win->res->end;
> > 
> > Don't you need to adjust the host bridge window size and end address?
> 
> Needn't. request_resource will reserve it from bridge window. Like malloc,
> if you malloc to get a region of memory, which will never get by malloc
> again utill you call free.
> 

Hmm, will that modify the window->res->end address and size?

> > 
> > > +		res->name = "msg";
> > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > +
> > 
> > Shouldn't this resource be added back to the host bridge?
> 
> No, this resource will reserver for msg only for whole bridge life cycle.
> Genenally alloc resource only happen at PCI devices probe. All pci space
> will be fixed after system probe.
> 

I don't think so. This resource still belongs to the host bridge, so we should
add it back.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

