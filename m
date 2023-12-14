Return-Path: <linux-kernel+bounces-205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084B813D70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272D0283AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928366AD4;
	Thu, 14 Dec 2023 22:43:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC46AB83;
	Thu, 14 Dec 2023 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-591553d3835so64900eaf.3;
        Thu, 14 Dec 2023 14:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593788; x=1703198588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25NXwF3j3CDWMwNZ1yXSftsyQ/VmIgJUcDUuu2o2sQc=;
        b=Kfl5cxcs0b8Za6Mt+4zUvGRc5C+23gNjxPv3ckvF9a8WcezHiigu49JaQlUCiZ8Pml
         lYILq6bBIbuHnn5d40SE1VLWEMzpXzjNlO4g3xyu+pXb0ujQNf26WtSu06rhgTOLLDfr
         ljSwpe6nevxmauSah79BmqsHNAiC7zPjYnKimhYusko31u7OmBA/UMMSWwmdEixtE2DR
         XrKhSsNX1OV0ZNDuvwcKUoRc+t4dwMDPYW+6D+IBFnXAYwwAw4ZqCKY7jNvdXsVoVjwc
         9IHCpKxyGizn3dT9eCj0ISFQ/+Buk3g9ic32ccCjvDu82/XlRfbtdw3dTvYlYUzL/4gI
         3unw==
X-Gm-Message-State: AOJu0YwVX48m1FFJTItElS0SONDh/VTPTmBAl9vSHKAg2Fobty5EweLe
	wqQUE6AbllNCXKTUVKaw6ju9FMj4Ow==
X-Google-Smtp-Source: AGHT+IEOpcXDaJc/6auAFxNvwtlBTN+TSmelxUX2AwVBrxCJYeQ+EL/Dz8nHpPpAbpv7PDMRevEGfA==
X-Received: by 2002:a4a:98ea:0:b0:590:f5fc:df58 with SMTP id b39-20020a4a98ea000000b00590f5fcdf58mr5115698ooj.17.1702593787772;
        Thu, 14 Dec 2023 14:43:07 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w23-20020a4a7657000000b0058a0809ea25sm3714382ooe.21.2023.12.14.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:43:07 -0800 (PST)
Received: (nullmailer pid 1066090 invoked by uid 1000);
	Thu, 14 Dec 2023 22:43:04 -0000
Date: Thu, 14 Dec 2023 16:43:04 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>, Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1
 isoc-in transfer issue
Message-ID: <20231214224304.GA1062298-robh@kernel.org>
References: <20231213063543.12435-1-chunfeng.yun@mediatek.com>
 <c1bc144d-07d6-422c-8294-42be47f83e59@linaro.org>
 <5327b2fd-94c6-46fe-b987-52cfff042033@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5327b2fd-94c6-46fe-b987-52cfff042033@collabora.com>

On Wed, Dec 13, 2023 at 12:17:17PM +0100, AngeloGioacchino Del Regno wrote:
> Il 13/12/23 09:05, Krzysztof Kozlowski ha scritto:
> > On 13/12/2023 07:35, Chunfeng Yun wrote:
> > > For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
> > > still send out unexpected ACK after receiving a short packet in burst
> > > transfer, this will cause an exception on connected device, specially for
> > > a 4k camera.
> > > Add a quirk property "mediatek,rxfifo-depth" to work around this hardware
> > > issue;
> > > The side-effect is that may cause performance drop about 10%, including
> > > bulk transfer.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >   .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > index e9644e333d78..b8ed68574ba4 100644
> > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > @@ -124,6 +124,16 @@ properties:
> > >         defined in the xHCI spec on MTK's controller.
> > >       default: 5000
> > > +  mediatek,rxfifo-depth:
> > > +    description:
> > 
> > The property description and driver patch suggest you configure the
> > depth of FIFO, so this should be not bool, but some uint32. And then,
> > use generic "fifo-depth" property to set desired depth.
> 
> Did you mean "rx-fifo-depth" instead, as used in net?
> This FIFO depth parameter is for RX only.

Or rx-fifo-size. There's so many to choose from.

Rob

