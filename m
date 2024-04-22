Return-Path: <linux-kernel+bounces-153535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6A8ACF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D565B2241D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA71514C9;
	Mon, 22 Apr 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9iRwFZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331E136988;
	Mon, 22 Apr 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795892; cv=none; b=pDOaQXyvMQ61NF7JHsqTJEBSEC12pdmQiSi58REh0jBWu6VEnh1BlzkTIkAfJZn/r/uZY8cUC8x91YBTiC5n4rzwPXZGsKRlUEITmar6kewVKpNwEkh8vvPZLEXaP6JI7i3I+DF8JiCGsaxpgQzDfb9vo6spjZoyg6oE6WWjxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795892; c=relaxed/simple;
	bh=UixV5EidYwsxFua1xIDYV6JAjWIOm875jhs6D2+QN/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAfjdDpaX1649SiRedq8Ho5zcZ43YPmQHWnsEW5MA/kZMQM5GbQxENGWLJaolMHouNGa30/iT1pw/aW6knCgX/gXME0pKnlYaFvFrAHBKV4C91Q6b7SCNnzn/DoIGyvvGgOH3c6v7VbVzsuYKRCk/JBGuibh9Cs0UQQ3mYuaND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9iRwFZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB09C113CC;
	Mon, 22 Apr 2024 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713795891;
	bh=UixV5EidYwsxFua1xIDYV6JAjWIOm875jhs6D2+QN/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9iRwFZc4nm5fJqxtHjuvWOp6mjRA8LzvnLCX1H5Kv+Qys2M5FqKiFeGJBRuIWJBS
	 JPAr1jWogxMWhbaJhjVRyXWysKBnVc2PQYw9tW9hqh98DfKqEcEH8FWqvabhGp2FZ5
	 /M4PtM6QNLFmw9wjM3qV+yCuVjLHejweLDgrA3++au6lThe/KEFSRGi226PQxOyElm
	 G8j1FH8MEy0zpK9l9HfXilWaGxLEpnuX/Pwj5dMvpEO5rJpy0ccwwHnqQvf0WW/oAV
	 qL08LZxijyPSQ+fLwJIUSai2pzR0CoX+eYEz+e/WT4Vi1HgtR9tM0B9YdwWHXYZgev
	 yVZpdDmrNACsA==
Date: Mon, 22 Apr 2024 09:24:49 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: dsp: support imx8ulp dsp clocks
Message-ID: <20240422142449.GA1186917-robh@kernel.org>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-2-laurentiumihalcea111@gmail.com>
 <ZiGLxBa8CMsaRSTc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiGLxBa8CMsaRSTc@lizhi-Precision-Tower-5810>

On Thu, Apr 18, 2024 at 05:08:20PM -0400, Frank Li wrote:
> On Thu, Apr 18, 2024 at 11:37:18PM +0300, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > 
> > i.MX8ULP DSP node needs a MU clock, but doesn't need
> > a debug clock. Change "clocks" and "clock-names" properties
> > to allow for this case.
> > 
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 51 ++++++++++++++-----
> >  1 file changed, 39 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index 9af40da5688e..4a39d57b1cc6 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -30,22 +30,12 @@ properties:
> >      maxItems: 1
> >  
> >    clocks:
> > -    items:
> > -      - description: ipg clock
> > -      - description: ocram clock
> > -      - description: core clock
> > -      - description: debug interface clock
> > -      - description: message unit clock
> >      minItems: 3
> > +    maxItems: 5
> >  
> >    clock-names:
> > -    items:
> > -      - const: ipg
> > -      - const: ocram
> > -      - const: core
> > -      - const: debug
> > -      - const: mu
> >      minItems: 3
> > +    maxItems: 5
> >  
> >    power-domains:
> >      description:
> > @@ -93,6 +83,43 @@ required:
> >    - memory-region
> >  
> >  allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8ulp-hifi4
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: ipg clock
> > +            - description: ocram clock
> > +            - description: core clock
> > +            - description: message unit clock
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: ocram
> > +            - const: core
> > +            - const: mu
> > +    else:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: ipg clock
> > +            - description: ocram clock
> > +            - description: core clock
> > +            - description: debug interface clock
> > +            - description: message unit clock
> > +          minItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: ocram
> > +            - const: core
> > +            - const: debug
> > +            - const: mu
> > +          minItems: 3
> 
> According to your descript, look like only clk "debug" is difference.
> 
> How about
> 
>   clocks:                                                               
>     items:                                                              
>       - description: ipg clock                                          
>       - description: ocram clock                                        
>       - description: core clock                                         
>       - description: message unit clock                                 
>       - description: debug interface clock
> 
>    clock-names:                                                          
>       items:                                                              
>         - const: ipg                                                      
>         - const: ocram                                                    
>         - const: core
> 	- const: mu                                                     
>         - const: debug                                                    

You can't change the existing order, so this does not work.

Rob

