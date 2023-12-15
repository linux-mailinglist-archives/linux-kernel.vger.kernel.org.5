Return-Path: <linux-kernel+bounces-1132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1F814AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F1C285AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96114358AE;
	Fri, 15 Dec 2023 14:49:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6831734;
	Fri, 15 Dec 2023 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da45aa5549so548834a34.0;
        Fri, 15 Dec 2023 06:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651755; x=1703256555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTcdU8JgUNSEfxeT9Xh4yUJhv++1bY3Z7SLC7fDL6mU=;
        b=XRtSamtylUouKMRcV5JKLz702YPtdBAdgH8Vp2ehMud32l6VnevJ5pKXYOoNNA0l7L
         FDwCMSENJ18EP55Iwowuoos6GDv/FDEQBZgDiZrbsJfMenoQ/WUVuo4J8W6TRG4ehHJl
         N1DwsCRf6BiD/BpV9cH5xFvQEUEyoaL+xXV37JlD1d1LkncaX6oxanodTYOYhM6PJgIe
         3Yr/iUnC4aRD3f5fG0gUPRS0ZOO2GSc+SUEm+whLLL9SkXfoO0PjQROYAsBEpRsa+TSs
         m4OzPTmmTqK5aoCaUn7lKvqFI7RNTjaghIe1l9EGsAIovbm48Jlw7LQ1T5KQuMFLvI5k
         Xo6g==
X-Gm-Message-State: AOJu0YyndQM3uqRI0BlHKNx7W66k/rP+oUQcEyoHSlYAZY5gmhanhjQz
	3CVzDrgKIUqCNTRsG9a/Qg==
X-Google-Smtp-Source: AGHT+IFYl+saY+Skc5Ug+LewydgV1ECe1agDOExPez3oAwH4Ly9DtXGJzK9hqq07oPCPo7UfUrcG+g==
X-Received: by 2002:a05:6830:3486:b0:6d8:74e2:c097 with SMTP id c6-20020a056830348600b006d874e2c097mr14209575otu.73.1702651755009;
        Fri, 15 Dec 2023 06:49:15 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d7990000000b006d9d8abcdeesm3687410otm.40.2023.12.15.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:49:14 -0800 (PST)
Received: (nullmailer pid 3787422 invoked by uid 1000);
	Fri, 15 Dec 2023 14:49:13 -0000
Date: Fri, 15 Dec 2023 08:49:13 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [net-next PATCH v3 3/4] dt-bindings: net: Document QCA808x PHYs
Message-ID: <170265175286.3787360.12287688657217382801.robh@kernel.org>
References: <20231213111322.6152-1-ansuelsmth@gmail.com>
 <20231213111322.6152-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213111322.6152-3-ansuelsmth@gmail.com>


On Wed, 13 Dec 2023 12:13:21 +0100, Christian Marangi wrote:
> Add Documentation for QCA808x PHYs for the additional LED configuration
> for this PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> For Rob, I used enum instead of const as I assume more PHY will
> come in the future for the qca808x family. Currently only qca8081
> has seen around.
> 
> Changes v3:
> - Use compatible instead of select
> - Out of RFC
> Changes v2:
> - Fix License warning from checkpatch
> - Drop redundant Description phrase
> - Improve commit tile
> - Drop special property (generalized)
> 
>  .../devicetree/bindings/net/qca,qca808x.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


