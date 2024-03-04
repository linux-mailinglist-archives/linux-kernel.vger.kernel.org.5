Return-Path: <linux-kernel+bounces-90762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3587049C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794411C21345
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5446426;
	Mon,  4 Mar 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDnGKJt3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E43FB02;
	Mon,  4 Mar 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564201; cv=none; b=IUE1ZHIs2+KfEpi1Dr0589KKdjyhQisceWqxvlv3Cajc8eoCqIHihjnk5GuZbtyxxdEAqDcONjikd6f/IX+/njVV1RHevnM6bY8e1syue4rDV7jHHBDJzXnBbN3bM35y1MnGHjDgR3HR7D/X1slUrFXwOXTs7HdQkfYZRXKB6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564201; c=relaxed/simple;
	bh=N/D0uIgUoOHQbPkMuf10uhOf+id1XoY9SIa7oMOVSmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flmm2xBEHfLl8fc+xPgWfoZgVWOQVjgIWPBl4jtS2oISAUGp2pvET0LJjOAKhfNKQSHUcM6aVlfYapLLlYdLy8tpNbYzYY2ddUvSJuAf2sY9wnYDWAZ5pbDQY/BUMOA9erf9dqMJFrnaW/9LyC5PYlFo5zKmIsTDWoMOqpBpgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDnGKJt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7440C433F1;
	Mon,  4 Mar 2024 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564201;
	bh=N/D0uIgUoOHQbPkMuf10uhOf+id1XoY9SIa7oMOVSmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDnGKJt3xItxvEa0PiLVh12+82cJgVgXwveOA+wnpP/PEZKamKXXshOplx+gs3WlF
	 DXTCsYzfyYWjb2Rgope+1O1VMf8p0uYrekDXoxXQhJyhKG7yYtNTgUySEJYbLfTkW3
	 IOiMLdJuo/L02ua0vafERU8mNq8Q/gc4gxWld7cPQclmiqSKGQyxQdfo/ysJGgAI9N
	 qICBP06ZaYxf+YPshrIBxy9dOeFW/y8bWgoXlQhMtkRygtEJai6R4/N9MvUL0HJfdk
	 qfGrJm3LiazTIiov9vb/UiJaZ8AIXGFhuYXE2marQamhb7tcN87bxSoYETAk1hsbAM
	 jjlWOv3U5cEdQ==
Date: Mon, 4 Mar 2024 08:56:38 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <20240304145638.GA198680-robh@kernel.org>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-2-d4d5935fd3aa@nxp.com>
 <3460ecc8-d7d7-4d1c-ad0c-b32efc3b9049@linaro.org>
 <ZeFTqM8o/eozl+MS@lizhi-Precision-Tower-5810>
 <a1861d70-80e2-4f42-b99a-f2b8c8efe042@linaro.org>
 <ZeH2v9WJsX9sLvXb@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeH2v9WJsX9sLvXb@lizhi-Precision-Tower-5810>

On Fri, Mar 01, 2024 at 10:39:43AM -0500, Frank Li wrote:
> On Fri, Mar 01, 2024 at 07:30:45AM +0100, Krzysztof Kozlowski wrote:
> > On 01/03/2024 05:03, Frank Li wrote:
> > > On Thu, Feb 29, 2024 at 10:44:42AM +0100, Krzysztof Kozlowski wrote:
> > >> On 28/02/2024 20:14, Frank Li wrote:
> > >>> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > >>> have 1 interrupt.
> > >>>
> > >>> Increase max interrupt number to 2 and add restriction for platforms except
> > >>> i.MX8QXP and i.MX8QM.
> > >>>
> > >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > >>> ---
> > >>>  .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
> > >>>  1 file changed, 19 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > >>> index 82430f1d5e5a2..785f7997eea82 100644
> > >>> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > >>> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > >>> @@ -31,7 +31,8 @@ properties:
> > >>>      maxItems: 1
> > >>>  
> > >>>    interrupts:
> > >>> -    maxItems: 1
> > >>> +    minItems: 1
> > >>> +    maxItems: 2
> > >>>  
> > >>>    dmas:
> > >>>      items:
> > >>> @@ -100,6 +101,23 @@ required:
> > >>>  
> > >>>  additionalProperties: false
> > >>>  
> > >>> +allOf:
> > >>> +  - if:
> > >>> +      properties:
> > >>> +        compatible:
> > >>> +          enum:
> > >>> +            - fsl,imx35-spdif
> > >>> +            - fsl,vf610-spdif
> > >>> +            - fsl,imx6sx-spdif
> > >>> +            - fsl,imx8mq-spdif
> > >>> +            - fsl,imx8mm-spdif
> > >>> +            - fsl,imx8mn-spdif
> > >>> +            - fsl,imx8ulp-spdif
> > >>> +    then:
> > >>> +      properties:
> > >>> +        interrupts:
> > >>> +          maxItems: 1
> > >>
> > >> else:
> > >> minItems: 2
> > > 
> > > I think needn't 'else' here. Top have set to maxItems is 2. 
> > 
> > So explain why one item is correct here.
> 
> Top interrupt: maxItems: 2. That's means all compatible string (include
> imx8qxp, and imx8qm) required interrrupt number less than 2.

You said: "fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts"

That means they have *exactly* 2 interrupts, not <= 2 interrupts. The 
top level says you have 1 or 2. Somewhere you have to say it's always 2 
interrupts which is what Krzysztof provided.

Or you need to explain why the 2nd interrupt is optional for 
fsl,imx8qxp-spdif and fsl,imx8qm-spdif.

Actually, I'd reverse the if/then to have shorter list:

if:
  properties:
    compatible:
      enum:
        - fsl,imx8qm-spdif
        - fsl,imx8qxp-spdif
then:
  properties:
    interrupts:
      minItems: 2
else:
  properties:
    interrupts:
      maxItems: 1


Rob

