Return-Path: <linux-kernel+bounces-142548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DD8A2D09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B20F1F229F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF42535DC;
	Fri, 12 Apr 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgymZ2Ri"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FEC4437D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919875; cv=none; b=V3b6qXnuDj0h+cK0ZGsI4sY2Tk70k3zP3WZHDD0NPJWtVFBRZHsUNQ9rJORJizbYgiQVfItSjPSFg7MQXFnv4/EGdAtq63CkbPGuoSxPquD0jz1YOQNp/Go0/jPzk4vNRkkdYa/bABdBSxG1yxepgV6n7l6Fgycm6fdRuKacxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919875; c=relaxed/simple;
	bh=TF4tHmla/V5c93hJgap7S/F1U0/oLtGyAYyYrYfGL3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox3YRfgQraD1PfxrNKagkMAsGOuCeDfO+aaexXLq2WHjIg0w7/L2TvnXqKt5pQ2mHz/VcAokoEUa297Rr9ZMtq/chF9S9e4iW9kxRjLDM+eECpRUVQFNxgG6AIdhHcdvKVQY18yVNbK0i62iGJhz/xqfbHpTYIPu4hED38J/RxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgymZ2Ri; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51d05c50b2so90881066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712919872; x=1713524672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZWeBFh7QACCuutiiPpJmVZ9uLRO6+K6nohTcAyDGFE=;
        b=xgymZ2RibWWjuF5F0Hb7/SAOrQ4wsRPjgBJWfgSNYoJwu+pL3THuZlZOyEpq0qVcSs
         1O39T/MxCU/e8nPLWzqRT0FnGRqegayRq+GYhF7gkPZgIINhrj0q4K5SkeXRla9PhPj8
         JBIBneUc7es+fWWkIc4c7TDgjOZJlvBfU2gquo2c1v2Bl06e2QZZwxLDgAQyy+bpItEA
         +flQxmrtVO0blWqVrEewp3mCKLQaK94AxWQS0oz7tyY+Rp2j7M+HtHgspaMl+kWz1oW/
         WIzXLY+3sPcrY5cWM4npjSaswhKdKmG8sOBQYspmbDsW4JHfmEVvbZXGUCLPf/0sp1+Y
         2OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919872; x=1713524672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZWeBFh7QACCuutiiPpJmVZ9uLRO6+K6nohTcAyDGFE=;
        b=kwyJWoMbBbY/PGRI2+Sc1huMcjY5mJ3sCDJX+hJw+NLrNIkyHwt84RPyWoddJluAbb
         bcmuQ4j1SLx0TAzVwqUFMSoVh5HGXCNKsddDGM/93Ad6ARydA7gFypxsBzu82NQVAVZa
         hPWVmepMhXX0j/b2ejf6pMMBCatZdn6ll/PJGMKSFojifKtG48HNl0UJg204BFqVI4wQ
         aADHrHwjFJivY6IvtikI3EWeQfUAay1Ph9IWTfvoKKATHsg0b94WGd1GK7fNOkgO77BH
         Xqrv42VWUAJPKZ+0SwTfG0rE6kOukt8vi69TgSHTb6EKdgJQlKboD/xXnXXqNeOL/oYU
         D+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWm23EZbN9ZYHPxm/hX2Dr04vpMBmGDOAx67hfLV6SveKoeADKmkSS1+Z2hZIZyHJ5ldN3SNGJ3ws1BJytDuiAewZ2q5HnoCQGoOu7U
X-Gm-Message-State: AOJu0YyImozuyGMNuB4ih04NXVULXc33Zwde8AbJA4pEBnQMxaaJKsTF
	aqXyrZAM/6aZPrHDNbfReeusorrKHyys0NXrFUloIEoRo6Aa+UsaSPsUsZAW+X2WXWsGp9xmXin
	d
X-Google-Smtp-Source: AGHT+IH4VUAKHBWqRNJzHGdIvq8PGL5V48yPws8cK6i36baicRTB+rSLgHyFIHK+0WrfBeufEQueFw==
X-Received: by 2002:a17:906:11ce:b0:a51:bca7:3a96 with SMTP id o14-20020a17090611ce00b00a51bca73a96mr1624173eja.72.1712919871946;
        Fri, 12 Apr 2024 04:04:31 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b00a51eed4f0d7sm1684736ejc.130.2024.04.12.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:04:31 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:04:29 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	David Collins <quic_collinsd@quicinc.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
Message-ID: <ZhkVPXCDySXRWWJj@linaro.org>
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
 <20240407-spmi-multi-master-support-v9-1-fa151c1391f3@linaro.org>
 <fkwugrnak3fhkg5ig47kmy3edm45ut4dprkabntnwemjt3w2mb@7cak5zxwzw4p>
 <ZhOJB8o9cRr7oQU8@linaro.org>
 <920d797f-0e1a-458a-9924-1f299a8752d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920d797f-0e1a-458a-9924-1f299a8752d3@linaro.org>

On 24-04-08 08:30:56, Krzysztof Kozlowski wrote:
> On 08/04/2024 08:04, Abel Vesa wrote:
> > On 24-04-07 19:07:03, Bjorn Andersson wrote:
> >> On Sun, Apr 07, 2024 at 07:23:21PM +0300, Abel Vesa wrote:
> >>> Add dedicated schema for X1E80100 PMIC ARB (v7) as it allows multiple
> >>> buses by declaring them as child nodes.
> >>>
> >>
> >> But is this really a "dedicated schema for X1E80100"? Isn't it "the
> >> schema for all multi-bus controllers"?
> >>
> >> I.e. isn't this a "dedicated schema for all platforms starting with
> >> SM8450"?
> > 
> > Suggestion was from Krzysztof to add platform specific comaptible (and
> > therefore schema). Since the first platform that will support in
> > upstream proper multi bus is the x1e80100, the schema needs to bear the
> > same name as the compatible. When support for multi bus will be added to
> > the other platforms (including the SM8450), they will use the fallback
> > compatible of the x1e80100 and will be documented in this newly added
> > schema. We did the same thing with some PHYs drivers, IIRC.
> > 
> >>
> >> Can you please use the commit message to document the actual reason why
> >> you choose to create a dedicated schema for this? Is it simply to avoid
> >> having to schema with either pmics or multiple buses as children?
> > 
> > I can re-send the patchset with such a phrase in commit message.
> > 
> > One of the early versions of this patchset was actually submitting a
> > generic compatible for multi bus, but I remember that there was a
> > request for following the platform dedicated approach.
> > 
> > Krzysztof, can you please provide here the argument for why that is
> > preferred?
> 
> I could not find such suggestions from my side in the archives, except:
> https://lore.kernel.org/all/dd86117e-0196-499b-b8b3-efe4013cbc07@linaro.org/
> 
> where I want SoC specific compatibles to be used, not versions.
> 
> Now about this binding, it is not a schema for all platforms starting
> with sm8450, but only for x1e. I do not understand why this would be a
> problem?
> 

I agree, I don't think there is a problem with that. At some point,
all platforms starting with sm8450 will be added and then we can even
make the sm8450 compatible as the fallback comaptible.

> If you ask why this is not a schema for all platforms, then because:
> 1. maybe no one tested other SoCs?
> 2. maybe no one cares?
> 3. maybe other boards need some quirks, so this would be applicable but
> not fully?
> 
> I don't know... since when do we add "generic schemas"?
> 

The focus of this patchset is support on X Elite which implicitly needs
multi bus support. Again, we can do the other ones later on. I don't
think we should extend the focus of this patchset more that it already
is.

> However maybe the question is different: why other devices are not
> described here, while they should? Then probably Abel can answer what he
> wants and what he does not want to describe. There is no requirement to
> model all possible hardware in a binding, but instead describe one
> hardware, so x1e, fully.
> 

I'll switch the older platforms as well in a separate patchset, I promise.
But let's not delay this any longer.

> Best regards,
> Krzysztof
> 

