Return-Path: <linux-kernel+bounces-119847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D188CDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2302AB231F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A644213D272;
	Tue, 26 Mar 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA3G8AJq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC013D265
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483039; cv=none; b=AJMR+kslmzEQynzWoCig5oKWrHz0udgfFEgQb2mwM1WSbgXgjfetNMpSa6nt6bl0sqiLaCvX5HB1GV2RFOq8gHVx0Zf1IZ/kTSu9LufnbY1dNDRDOV3QI/e4xTcSPeyC1gRz/OYK6qfpRrODnRrT8GdVbHJRH6yJrHnGiQxDy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483039; c=relaxed/simple;
	bh=2H+94qUfoDYhhZONEATXwrtmuXduQiExbMEmAQ6bX3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho3+Z78IOx1xFzmcFKPomAdXprbV8GVpqlrufSvPMMwxVtV4PWa+Q2zpxJv3eALoMWDzIFkfDF8S8jYdvoQnyKowFsZ9UyCw05d/OCI5f/SOTKk5G0wyfifTaOZe7PV7Ud9h5FurbXDjWlJda6RmV0EoU7k4wl2IzmeQxri3R7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xA3G8AJq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a467d8efe78so719866066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711483036; x=1712087836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMZemv+treJRJZKcndzvb56dHiZdwvWPeQfGgJVwwG0=;
        b=xA3G8AJq7vHx44Pq3fe5DhK6XN9N6wMyDC0N3fZze5T88C9qxp+xxhoneP68/iL/yj
         VWUSmhxxuq5CT0cidP4h3nQWiYlZ2Oh3BHptgmqWZ1wAZk42aHQJctKRdC4FBh/89CzF
         ZK48PW67qllN1fWMW0uem6wNo+eAoyqFSnYtA6uswb9TvkhO3jKGt35lRFT2eq9d9pGy
         RY7SAGl+AL6dOOJMvcY+1gesmt2qLTD5UiTV5k52c7nW7BYmo8vrmHth2t5mPEMxB/qo
         YEykDzlO9loWo6gklYer3Wi8AiwbUNnUNs8u1UmFK5afcei9lZQMxze830/HaBCBhS9h
         ty7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483036; x=1712087836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMZemv+treJRJZKcndzvb56dHiZdwvWPeQfGgJVwwG0=;
        b=ls+CMhiy5JuXavWVuAb6DAsL5j+0YjNntIE01YzLRS3bSrWnw3fyQcuuTAXmkxC36r
         mUWAu469sJsu7+lLNMQD1FNUhycpptcncLuhIB8RBhupNcxsAgu43MKa6oOCloGEvwrU
         5L3CjeWxRKF3TQT4ZolU/95uPxG2YYkuXx/Y29lmgjjMz79v03e8jpM7uSaMpOPjA6IU
         9PYGIzJqRtw3b279uR9/H28tJ2J8lfcxG9IXkLUZQylCu0T3tp1oi8Mipl3mNTQHyFik
         r9ZbdC3LfjdfOAR00Ho6zrTetqSMOvqJaom5xcwsyeocu9I7eBXsVpZx+mL2DYH/fnpy
         LTaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7uqJJYTEP8kgB4w6n+FpxGvm0/gTxNsfi03M3t+WzLLpO61IvmySdBxqUnsChovUlIJQi9vJ3dEc9KiMaLpbYCz3Vzqkd1SGX17nc
X-Gm-Message-State: AOJu0YwP5pqcrEcPpzNR+5L15AxfJGDWYfmSN7xc6NeeARp5NdRFe7Je
	CDoGnw4BdG1OVQASZt6fymeGv0Aaox7vzkMAoLA8wTmJa7rBUnVIs2+Mdtr3ZZQ=
X-Google-Smtp-Source: AGHT+IGV8Lxx+KB8zTQRgaBH6RRCSCr9jlkk5+m4uBMdcvsOQYxK7zl7jHLINOfQjQLorKVjX4b3oA==
X-Received: by 2002:a17:907:970f:b0:a47:4293:947f with SMTP id jg15-20020a170907970f00b00a474293947fmr9602283ejc.8.1711483036185;
        Tue, 26 Mar 2024 12:57:16 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090633d100b00a4df82aa6a7sm758313eja.219.2024.03.26.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:57:15 -0700 (PDT)
Date: Tue, 26 Mar 2024 21:57:14 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/5] spmi: pmic-arb: Add support for multiple
 buses
Message-ID: <ZgMomo9Uw19Ll10N@linaro.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
 <20240326193203.GA3252922-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326193203.GA3252922-robh@kernel.org>

On 24-03-26 14:32:03, Rob Herring wrote:
> On Tue, Mar 26, 2024 at 06:28:15PM +0200, Abel Vesa wrote:
> > This RFC prepares for and adds support for 2 buses, which is supported
> > in HW starting with version 7. Until now, none of the currently
> > supported platforms in upstream have used the second bus. The X1E80100
> > platform, on the other hand, needs the second bus for the USB2.0 to work
> > as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
> > all found on the second bus.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v6:
> > - Changed the compatible to platform specific (X1E80100) along with the
> >   schema. Fixed the spmi buses unit addresses and added the empty ranges
> >   property. Added missing properties to the spmi buses and the
> >   "unevaluatedProperties: false".
> > - Deprecated the "qcom,bus-id" in the legacy schema.
> > - Changed the driver to check for legacy compatible first
> > - Link to v5: https://lore.kernel.org/r/20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org
> 
> Where are Krzysztof's Reviewed-by tags?

Urgh, did "b4 send --resend" which only sent the v5 as it was before the
Reviewed-by tags have been picked up.

My bad.

I'll send a v6 with the tags appended.

> 
> Rob

