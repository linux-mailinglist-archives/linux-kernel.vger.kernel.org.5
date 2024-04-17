Return-Path: <linux-kernel+bounces-149019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489898A8A88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0455E285402
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E461172BBF;
	Wed, 17 Apr 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f023c7/e"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F2172BBA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376447; cv=none; b=DLn8MwNLlT1O6WTCEiF7lS7s34Z2p2aYUU3fkkb00a2t9yuNohlps4ufHJ31MJTFTHMIz52bE8JMZNE35jjcenG23eV4668AMZxStpL3drvra3sW245YoKH0UlYAYGAqKd2GpkRGzJ6CY0rPug0TXZZBoyZAJBrI49H+ZCi5xjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376447; c=relaxed/simple;
	bh=yjwUiz5i63lqvu/Wsaqfo+VaTFRpc3RdpiuqVgDvGbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUX2txdyv0YnwEAj/vEnBy38AGvBBsxNI1eEsvRH8K/G+HyiI+fdxknbNZw2C/pa8eZ3OI8KTdsR/QNycz9HwXLq6opR7HCIT1wUSkCE/qWIWm5lqnRdFKG7LAjL69px72xaBpKss9RkPx23e31MnTpxcS+Y4Y4yKLGa2zKsGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f023c7/e; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5194a4da476so1201269e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713376444; x=1713981244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vGOqA/tsDaN2kiyXsK38pfoG/Y32VAi9NcQwb/Ixe0=;
        b=f023c7/e81BDu5QxRFzt736kkzxtGUamghqnTMEyH7f6oQE1kGQSZx75xU6Itb94bi
         HI/Asxl+lG9d3VXDFNgpzPeMrQ5kr0vSUv4iJ2yFzAkiD5eO2ah/VovAHwrIVhy1NOlL
         fIIqoaaLgP9JY1PQQT/oTj5+Se/azPRdoUYLytlAdJ1srvyJHfYbs2XFpYo9CqUfXYYc
         BuIUgmnzIL+1awy/pKSHoR7R47S+xisTPiFLyg7juDGLNGDLAjstk8OatYEvXR0RoANN
         daE9INIbbi72s9b1RysrbT7c91gkMat02lnPn/dpU9VcaBL0zf/AlbmccW4CNrronDI4
         M2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376444; x=1713981244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vGOqA/tsDaN2kiyXsK38pfoG/Y32VAi9NcQwb/Ixe0=;
        b=J3+YgHVcuum/wJZ/UzJTF1lmMTdx7TAtxcZwDGXYp4VPVkQxia1PfndZH7Zpr1+0dZ
         LMGrrS/4AASB3ccwcu7RP2tW8GwLkbOe4LILS+elc0wutx+Are5kes+3SwcyFof7bPVg
         cPQYsVVePqf48qRP29WjiyhQR2RFGH8i5r3c1DDuqz56QT3ZE9lXwekxnGkNoUSwDhh3
         yxP+F6JeNuXRiyGroxjpudGXuUhuGMAdv4nVwapmg/yOmL3/X5dqEl/MLRvnxtNCoQi3
         fW62fLSMbe1mtuRoCmt/GLLsYAWlKGYly6Mc/ogAHwjmzl/+sfE9CWNQwfQmSCMAZmfq
         UmtA==
X-Forwarded-Encrypted: i=1; AJvYcCWe4C7kCBkWRp+HUKg3oaJ7NGN4hWGGfHwU2zdg6rija2dz7BmFrCK9B8WFpkTp/WVDyNAu4Hl6YMh3w1ePxkrjO1PGO6pB8SQFk/Fw
X-Gm-Message-State: AOJu0Yz9/WPvKKp4nSFL7xGagBa2ha/hkWryvm57b1tKdfRceWxcmtMs
	F37RBHLhp/3xTrjNgARPZam740DLhRxI604u6/cRCIj1Ss7e8HyL+jdBKm/Jhg0=
X-Google-Smtp-Source: AGHT+IEI8lhzEp655MQMbBlCd/gzQ7PV4wz3eZ9YqXSWEsCmkU+0eps106BovIPdS+UK5hgmBPPJBQ==
X-Received: by 2002:a19:f616:0:b0:518:d6ea:9f5d with SMTP id x22-20020a19f616000000b00518d6ea9f5dmr4860lfe.42.1713376443915;
        Wed, 17 Apr 2024 10:54:03 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709063f8800b00a5239720044sm7098788ejj.8.2024.04.17.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:54:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:54:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <f59e4b8f-ee5b-4608-940a-2e2b6a43e8b8@moroto.mountain>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiALuYlshLmwLhvu@ryzen>

On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> @@ -761,6 +755,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>         if (ret)
>                 return ret;
>  
> +       msi_capable = epc_features->msi_capable;
>         if (msi_capable) {

Or just:  if (epc_features->msi_capable) {

;)

>                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
>                                       epf->msi_interrupts);

regards,
dan carpenter


