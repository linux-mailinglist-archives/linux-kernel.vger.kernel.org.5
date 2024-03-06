Return-Path: <linux-kernel+bounces-93641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785378732B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3429D285D04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DFE5E068;
	Wed,  6 Mar 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6prxrGX"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F595DF14
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717947; cv=none; b=mY4hy9mZbxlvfUg4ZyZ1Nv3g93gypR+eXR28aXnEecVS63EZOtxOXhSWxY1/4dUMn5UklPASycbvLQzE3flhJKD/RhGT+l7ZE0CeRE6gOuqtVC1Jk2aE/9AjTuJyIfcCAevE/RYWGIJS4yyvuQwoWLuYVWkJKBGqRnqs4++1GcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717947; c=relaxed/simple;
	bh=tZqOWl/U+Elbnt1R7UGa8ygGo0JWMb8haTOc9kpg6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1U+3+McA7DArl3uGUfQpiyBFEtaJJKIScGYIPCK3lvfKxCPgnBzmquxkFg+sU+47G/eyUHEvBsDaVH9QWp2SpdInciR2FDz1WB86IpvdgJ+lH9yIW/W9z8GpZsiV69bEFRs27hUby2Q87vY4c7zjT3lzMNLWcJYrUf53YRWQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6prxrGX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so5782954a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709717945; x=1710322745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B9/QgTMyt6fHk74mMOMoiAquWcsGjb450gZKkLexk1U=;
        b=L6prxrGXTA52RVYVPuhlpSGRlK7POfhoePJeok+mqUHFwsHncqxj5XtbELkyfy7RJP
         ZDvVz50pKFpzHk0V2jea7EJdQiacSjRRgH8ypAggOndXlDHamMY2oYTie+cBlLfhdPhb
         Xwv0Im/OXk2p8Y4UQHsepXuwWMMBOgdKre6cu8QpowzdjtD9R7x37IDHJ4iQttgXNWHW
         MwWS6h7/5lLa1+gpFEBAbRqoA3xBAHU3OE4osAuut7jtBH2kKZ/kccKquBDI2ZabX7uV
         2f5rsf83Av5HCGVVW4jmFYSyUh+vNHWTuhNYE02Y29jrpZ1+DMT25jT4NcOxz7QIEvZc
         c9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717945; x=1710322745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9/QgTMyt6fHk74mMOMoiAquWcsGjb450gZKkLexk1U=;
        b=PUGnZL7rUidq41ac00tnHQaZKNhKr9aCO6+ded0K9tgwFO/NU/CkcasyeYY+jDVmJ/
         NIZl55lkMbVRUL5g27WT7ODmYT4OGVVMArQwSe+sKwOVM/slnDMax78yTewJn28eenlW
         USpk7ueSfj7G8u/PE+K7LHfqfIwsN3zSLRXgUVHGjIkDUu5tfN2bfIQPAqJk8NxgpX2f
         tb836rldHOR8rOYK657XXas2GWSKLBq/pfY4J274+8oQtUbqrFbte41j5H58zUUj5xQE
         k7yJyhRjMtrq3tQkenQ6/EVN8DftrWWOTN0JJPtnqc/RTRGdvNbW6oH36MHYq19tCRMT
         6xJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcYBcpjYyXGLvnzE9VWnCUIwlh4TMJJnH6sh09e9FELZxk5TbcaMh32osfj2mrvN7EGNwl6nyDiC0WlWhXHuAxzeOgiJCXNlKPgORK
X-Gm-Message-State: AOJu0YxsKKl9m4r041DO+gbmNpODSqR61Yy9S7jgp9BGcWnUTtrcV6W4
	C3/PLPMOluoDT5hkqTB2XqT5/3Dt7T43MuRmurHbgM8NQ4hfDXMCaNmKGA8ITw==
X-Google-Smtp-Source: AGHT+IHbO1CHuqg+60eRdVkKVCxleqZt9OqbjKUuy5Fd7mfWIapm625mEDrgXo2J1vMHZLAWyc1MHQ==
X-Received: by 2002:a17:90a:688c:b0:29a:bdbe:5859 with SMTP id a12-20020a17090a688c00b0029abdbe5859mr10903212pjd.7.1709717944519;
        Wed, 06 Mar 2024 01:39:04 -0800 (PST)
Received: from thinkpad ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id oj13-20020a17090b4d8d00b0029b13f233f6sm10337019pjb.11.2024.03.06.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:39:04 -0800 (PST)
Date: Wed, 6 Mar 2024 15:08:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240306093857.GC4129@thinkpad>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad>
 <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad>
 <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
 <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>

On Wed, Mar 06, 2024 at 10:12:31AM +0100, Johan Hovold wrote:
> On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> > On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > > > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
> 
> > > > > Just received confirmation from Qcom that L0s is not supported for any of the
> > > > > PCIe instances in sc8280xp (and its derivatives). Please move the property to
> > > > > SoC dtsi.
> 
> > > > Ok, thanks for confirming. But then the devicetree property is not the
> > > > right way to handle this, and we should disable L0s based on the
> > > > compatible string instead.
> 
> > > Hmm. I checked further and got the info that there is no change in the IP, but
> > > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > > there will be AERs when L0s is enabled on any controller instance. And there
> > > will be no updated PHY sequence in the future also for this chipset.
> > 
> > Why? If it is a bug in the PHY driver, it should be fixed there
> > instead of adding workarounds.
> 
> ASPM L0s is currently broken on these platforms and, as far as I
> understand, both under Windows and Linux. Since Qualcomm hasn't been
> able to come up with the necessary PHY init sequences for these
> platforms yet, I doubt they will suddenly appear in the near future.
> 
> So we need to disable L0s for now. If an updated PHY init sequence later
> appears, we can always enable it again.
> 

It could be the same case for all 'non-mobile' chipsets (automotive, compute,
modem). So instead of using the compatible, please add a flag and set that for
all non-mobile SoCs. Like the ones starting with SAxxx, SCxxx, SDxxx.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

