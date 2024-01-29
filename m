Return-Path: <linux-kernel+bounces-42893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A3840836
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9745BB20D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B365BD4;
	Mon, 29 Jan 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFfAtbwK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C765BAC;
	Mon, 29 Jan 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538346; cv=none; b=LYzIqJ3F50yWfBkRVhmb+IEVXs70Bfh3fldGavP3QfmVY/F8O8RCFlTomATqvPzS1QzRa9bl/11xBFP+T6YxF+vWgz0p0MvspqxkFmp1tqBWJ2sIl6uz2EZUrDCM+GpNc5raYYhDq8UHmlMGWXEA24yqR6qkMnkgOxr+Ht8F2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538346; c=relaxed/simple;
	bh=2R5ZIz9MxN6mq027Z2VzR7qaUO8PkjvN4PVvvhlsqWA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7t4yIWOYK2R+ahiJtm0jvq1HnhOLHL2iYuQN+iITzAwEdisOeL+CsnQk3WGAGlBST9v1kybfapms47vS245biXgooY5pwZiVYIYauAay7xRlkYe5gPyp13SOFnXucviyVB/NJG81cbaHyp9JsnhHPOAvshcIQ6B4khVXLsJYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFfAtbwK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so311461066b.2;
        Mon, 29 Jan 2024 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706538342; x=1707143142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3DLBk7FCeyrBOfLE6KeW9MOgN/w/f8n8lVjswz0xVsM=;
        b=KFfAtbwK008/rHRzHyJ4AiTUk+bnbWVFIC832BBzeXoNYxADSJnODuJPvlxesSynp4
         sLzrfY9FQw4x6xY3PY/Vp/GkuL6ApetHpcwgoVvfnRoihFNWEC+oI8Gn4xPA54K3esRV
         gou4iHSBa/RGp0C4XA4Rd9iNZevXIVY8FTuRurH0rCn+JLMTnOUmNsVW1TwQlalxODJs
         GhookhzZ0Zk1h6N7JbSanwAk187+rakHsH984fJ3HJ6xohmfea8xWBKnMUNWNPliYRLQ
         tiGZ62Ele2ED7nznf6+teLZUdfmrAVv+GjIojH5UFbZldcXOVcXeQNoOJXF9L/xvgfQM
         qvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538342; x=1707143142;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DLBk7FCeyrBOfLE6KeW9MOgN/w/f8n8lVjswz0xVsM=;
        b=PHF+sMK6Ux1IYRYm9LCemQ4uSOC5+I3DCzPc3NZOtDzT00hMQFWIXcV7Or/+10noz3
         2OY8JgdVrqyx+zouG5EUpKo7t1pCOch0k6LZp4VqkTngWIJZkVNeQPvLZ32EOjkiGmHE
         z193NOAUPJdx/+KQEINEGhqPrZXdncvtXVlGpW1Ra371BrfRgqxrExhjeLmWmzQoz89a
         DncNUuKaGIV9SfvhrI5r6/c9lT29EHJwtCknobEP2kaWluzx9iNJ/PVIxQqMARvVLo8A
         v6Ys8WYZuOZoQFtYyTEtbNNF/nbd9ifR4mHX4gHZGlOT+4of9YG513RYKpSJ5MYYTqkc
         O/qw==
X-Gm-Message-State: AOJu0YyF9gR9FXeMdmX7/92RX9xuiDqlQc24QVRXDXxduL9rV9yP2IIS
	ChV2+rerZfBucc3AbX0QLtwMNR01v2eqVCljMvsiYlM6dq0fu3Cn
X-Google-Smtp-Source: AGHT+IFRwkJdiSF5ChNztpfbK11gjETPTUnOmElJ+2PEZMTKRJwDUEfQ8xriP3+XimdipYgu0N9qng==
X-Received: by 2002:a17:906:150c:b0:a35:3152:c46b with SMTP id b12-20020a170906150c00b00a353152c46bmr4150853ejd.60.1706538342340;
        Mon, 29 Jan 2024 06:25:42 -0800 (PST)
Received: from Ansuel-xps. ([78.208.142.203])
        by smtp.gmail.com with ESMTPSA id ot7-20020a170906ccc700b00a3172cc2a0fsm3949392ejb.136.2024.01.29.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:25:41 -0800 (PST)
Message-ID: <65b7b565.170a0220.2666a.0d2b@mx.google.com>
X-Google-Original-Message-ID: <Zbe1RQLCUG71MHGk@Ansuel-xps.>
Date: Mon, 29 Jan 2024 15:25:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
 <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
 <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>
 <65b3ecd7.050a0220.9e26c.0d9e@mx.google.com>
 <cdd0e481-2738-465b-9ef8-b7ab79981fbe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd0e481-2738-465b-9ef8-b7ab79981fbe@quicinc.com>

On Mon, Jan 29, 2024 at 09:59:03PM +0800, Jie Luo wrote:
> 
> 
> On 1/27/2024 1:33 AM, Christian Marangi wrote:
> > On Fri, Jan 26, 2024 at 07:20:03PM +0200, Dmitry Baryshkov wrote:
> > > On Fri, 26 Jan 2024 at 18:03, Jie Luo <quic_luoj@quicinc.com> wrote:
> > > > 
> > > > 
> > > > 
> > > > On 1/26/2024 1:18 AM, Andrew Lunn wrote:
> > > > > > Hi Christian,
> > > > > > Just a gentle reminder.
> > > > > > 
> > > > > > The MDIO frequency config is already added by the following patch series.
> > > > > > https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> > > > > 
> > > > > I admit this version was posted first. However, its embedded in a
> > > > > patch series which is not making much progress, and i doubt will make
> > > > > progress any time soon.
> > > > > 
> > > > > If you really want your version to be used, please split it out into a
> > > > > standalone patch series adding just MDIO clock-frequency support, with
> > > > > its binding, and nothing else.
> > > > > 
> > > > >       Andrew
> > > > 
> > > > Hi Andrew,
> > > > We will rework the patch series to include only MDIO frequency related
> > > > function and frequency dt binding, and post the updated patch series
> > > > on th/Tuesdae Mondayy of next week. We will work with Christian to
> > > > ensure he can re-use this patch as well.
> > > 
> > > Can you do the other way around: rebase your patches on top of Chritian's work?
> 
> Hi Dmitry,
> Sure, we can take this approach if fine by Andrew as well.
> 
> > > 
> > 
> > Would be ideal, also I have to send v2 that handle the 802.3 suggested
> > MDC rate (ready I just need to send after this has been handled).
> > 
> > Also I can see some problem with Lui patch where thse divior
> > value is not reapplied after MDIO reset effectively reverting to the
> > default value.
> 
> Hi Christian,
> In my version, the divisor is programmed in every MDIO operation and hence I
> did not add the code to revert to configured value in reset function. But
> sure. we can program it once during the probe/reset and avoid doing it
> during read/write ops.
> 
> In addition, the MDIO divisor 1, 2 and 4 are not supported by the MDIO
> hardware block, maybe we can remove these macros to avoid confusion, or add
> a comment mentioning that these are not supported.
>

Hi, thanks for confirming it! In v2 I already changed the logic to start
looping from divisor 8 and added comments in DT and driver about not
assuring correct funcionality with those divisor.

> > 
> > If it's a credits problem I can totally change the from or add
> > Co-devloped, I just need the feature since the thing is broken from a
> > looong time on ipq40xx and ipq807x.
> > 

-- 
	Ansuel

