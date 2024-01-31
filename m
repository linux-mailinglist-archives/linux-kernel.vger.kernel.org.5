Return-Path: <linux-kernel+bounces-45677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFE8433E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38CA1C27F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91C7470;
	Wed, 31 Jan 2024 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT+KBo0G"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C1566B;
	Wed, 31 Jan 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668122; cv=none; b=IRBiNr9YUcx9+R/EpUMrXaAb+9eqhsfdLZ/Jv7fE2IXkwwSCImcGNrJvyisSlWQRz5oviQk+aDCvUkmqmUHSWrFx1HKgsnhU1tOnBxCmt3HpN/ubYZwBopBo4ZoNwKO46JJeOIHiTQ/wWWHgsynbTQ+UmtLGk3i3HCQSPCPo0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668122; c=relaxed/simple;
	bh=n6OVbPXMiuN3Xw32rE6Lv1b8IPhNR6i3ARKs9E3EOo0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkfxh7vxPjOGXLsCV9o/PPsPjhC/yV3TOutQRTgHhizfWlck4LzCDWh36lO/JSR7CQajIXLBA1GUEXnImIbVdLtZ1DzrH4pfG9b5wpinmVJqL54ZcQkC9EBOmPtVcfpDfX6RhzwuZe3YvKwGtW8aRq/j1HSsahqYPOjom2LXkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT+KBo0G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so209994f8f.0;
        Tue, 30 Jan 2024 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706668119; x=1707272919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2jLTYVSeYvQnWVKXFzBhZVC+OXb8WPieh64UeYpW5+4=;
        b=TT+KBo0GdPDVDyFHdTh+Eo5LzDk4P8K9Li8jOALpWN7eXp2qrJ6NWVScX9+30nnQlN
         K7O85EBVYAda8zVGu6zpM7pAyGwnqOzXcCZ2Q8DZu9MJqYpWnZ7b8/6xtEg/k7A+5uWI
         AzZsNAdF1Zudmgp3ayAtjMca/emoeB6b1VYqQ4AQyd+BWEvcC7IBUsbkIka+kPMdJqhL
         4D9kizVKu00dRYhJ799aqsrxiNI0gJpDdTWqw/7LJrxM57trgSt/NDE1TSwnkAmX8rXh
         5RAAKUoe67KNBz2yFH5mdYkNXI0AqpR7CHhOthgMJpIsqpbiw38sHf10UzVSzse9Qsf/
         9Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668119; x=1707272919;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jLTYVSeYvQnWVKXFzBhZVC+OXb8WPieh64UeYpW5+4=;
        b=jbnjfLdzGR0QSHxgNN7Hkx29vTPohOQww5qewfqocRLVFHVMB9nqVPYPW59cdVqmQS
         rDIQrUnerl7LxFK6XSIHJAwDbTDo3JJzGyr9h4MxUThodqSMUbcOPKaoQEukfZp+aGc/
         4lvebybSV3fdRZ0DOvhorO6vakDjkPFivGWwNENtXMBAoJhDcICNQUcxoQ48NMBsxzDB
         E3T7MEpy1GavEn8sXtbDmrCQK0xGWa3xjtPrqPXZsCWWL/ye2/TtmHEjKQozTvVUyJES
         qIy/XJEnJ0p7W13KK1yXru0vf5W030L0Yv4xti8SVccoL449lr2QSAjgqGMs5kQs9Sn4
         imzg==
X-Gm-Message-State: AOJu0Ywe28TfKI6laE7i9he1ErcOEPgLIj2EXWJ/HJTK7HDTGlFlZQgE
	EcqIid68ZSWV9brNpfZF3g/vkgECaUlaRh3qZtBPSC6xypniJEOC
X-Google-Smtp-Source: AGHT+IFFbw4X4rm7rTmp0mavrk3j/tNSg8iTjVba0Rn2JSBpR5IPAwOams/1ppQI4SW9Waf1Lr8PYA==
X-Received: by 2002:a5d:4a12:0:b0:33a:f3fc:a7e3 with SMTP id m18-20020a5d4a12000000b0033af3fca7e3mr204208wrq.25.1706668118925;
        Tue, 30 Jan 2024 18:28:38 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bu25-20020a056000079900b0033ae4f2edb0sm9747157wrb.37.2024.01.30.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:28:38 -0800 (PST)
Message-ID: <65b9b056.050a0220.2fde8.9be5@mx.google.com>
X-Google-Original-Message-ID: <ZbmwUjbYpzFshDiK@Ansuel-xps.>
Date: Wed, 31 Jan 2024 03:28:34 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [net-next PATCH v2 3/3] arm64: dts: qcom: ipq8074: add
 clock-frequency to MDIO node
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-4-ansuelsmth@gmail.com>
 <b1ff77bc-0833-493a-b099-884c727f0341@lunn.ch>
 <65b84983.050a0220.e1700.35fd@mx.google.com>
 <20240130174041.74341188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130174041.74341188@kernel.org>

On Tue, Jan 30, 2024 at 05:40:41PM -0800, Jakub Kicinski wrote:
> On Tue, 30 Jan 2024 01:57:36 +0100 Christian Marangi wrote:
> > > If we merge this via netdev, is a merge conflict likely? Any other
> > > changes expected in this area, given the changes which might happen to
> > > GCC soon, etc?
> > > 
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Honestly I don't expect much to change here in the mdio node.
> > 
> > If it's a problem I can submit in a separate patch in linux-msm.
> 
> The arch maintainers usually prefer to take the DTS patches,
> so if there isn't anything special here we should probably
> default to that.

Thanks for the suggestion I sent v3 with the DTS patch dropped and I
sent that patch separately.

-- 
	Ansuel

