Return-Path: <linux-kernel+bounces-13397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D3820492
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBBA1C20E2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB72749E;
	Sat, 30 Dec 2023 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQAoPmrR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA815881F;
	Sat, 30 Dec 2023 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so1758017a12.0;
        Sat, 30 Dec 2023 03:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703935689; x=1704540489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85O6LiWePPiFIF6JQGS3gBNdkvVwV11/X/ToIcvymM4=;
        b=mQAoPmrREDvW+GE7hGXkVZr/LX7Jv15pjCmx9ijXqs0CFOsmtmCZlBYX7MFLPTMtKw
         mOTwzLHYHGYwtXKqc4M/68NL2ROSIekRpCM7WdcsSM4nVE479n9PK1P5523SU4siBP6l
         oCfThr56k/oQkDNXjpXIBsn4DRpXKPSroSLWBRQ1i68oqG0BPUgYBZtkxS6bv44nTYC7
         ctGSz69l8DjjsvcfFDbOJbjzoZJRy3OqGuTCpkB84fQc0+dZ7DCMjXdhOZT2Q2UrmB3D
         qSjHbiXAvaRITgFUgeGxcyzVTWAyu8oULnHhoD29FCOczL8gqdMeOJpG5nKdSNHW6aqf
         FIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703935689; x=1704540489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85O6LiWePPiFIF6JQGS3gBNdkvVwV11/X/ToIcvymM4=;
        b=FgR+ewDFBwU4rC0SjwI8YHc1IohrzyVl8BVbSyREAyAX9oMZWcyE1EdZaaV320wzIx
         +5AD2Hubn1Fn5d6bwLOvJEDkLxIOyQIzwU+qzgWXOTNVKDAnYQLUKbn/KVhikRPXD6DG
         m26geBaax/8nvaw3TMcvB7Fi9HJIM1Tgv2vpBsNyFsuXLYq8VpPHBQGXWJ4nIF8+YOCy
         mcEpn1pTt6N+kpAhi1FEid/jx2ebLGeaBkFB2kONtdHTeq/7YMYJOTnwKDV7nUl+2AKi
         2ThABCoQCkAMWFaVNZvFuOXsNuDTXkZF4J+8vYou0OB5G5/ytvFm+mCITIrPf/C1AbH7
         8TlQ==
X-Gm-Message-State: AOJu0Yz9ggKgYCcykR2Z9iNjFMSe17Y11whyDTjI+f9wIhoL0y9zzPEs
	zNaLYtZH4tZVlBtXWOP5UsM=
X-Google-Smtp-Source: AGHT+IFi3jZefLQyBuY/C97S1WM5Q23ySnKKxkJYKJ45z2CeKWyZhnS607UPaBUb4CW+T8cmtvGXBw==
X-Received: by 2002:a50:9f8c:0:b0:554:3afd:492c with SMTP id c12-20020a509f8c000000b005543afd492cmr7890236edf.17.1703935688964;
        Sat, 30 Dec 2023 03:28:08 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c7d4000000b0055537e76e94sm5218374eds.57.2023.12.30.03.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:28:08 -0800 (PST)
Date: Sat, 30 Dec 2023 13:28:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
Message-ID: <20231230112806.o5ia43mu4mo64lea@skbuf>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
 <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
 <20231229152519.2jxrwaeltp4pxlms@skbuf>
 <CAMty3ZAOM5+EMw9sLVOq-=CH_sP=1TLAGEMF9LYOZ4aFbNUtsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMty3ZAOM5+EMw9sLVOq-=CH_sP=1TLAGEMF9LYOZ4aFbNUtsg@mail.gmail.com>

On Sat, Dec 30, 2023 at 01:48:38AM +0530, Jagan Teki wrote:
> On Fri, Dec 29, 2023 at 8:55 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > Why all these combinations? You don't know which switch port is which?
> 
> This is where I get confused in the first place. I didn't find proper
> information on binding about how the physical pin-out is to be
> configured in DT ports or maybe I didn't understand properly.
> 
> As per schematics.
> Pin MII0_RXD0-D3/TXD0-D3 is connected to PROC_MII0_RXD0-D3/TXD0-D3
> this would be fec0.
> Pin MII1_RXD0-D3/TXD0-D3 is connected to PHY_MII1_RXD0-D3/TXD0-D3 this
> would be ethphy0.
> Pin MII2_RXD0-D3/TXD0-D3 is connected to PHY_MII2_RXD0-D3/TXD0-D3 this
> would be ethphy1.
> Pin MII3_RXD0-D3/TXD0-D3 is grounded
> Pin MII4_RXD0-D3/TXD0-D3 is grounded
> 
> So, I did use the above 3 combinations and assumed fec0 is always a
> port4 based on existing DTS in the tree. Please let me know which
> configuration is proper as per schematic connections.

With this switch, any port can be a CPU port. The CPU port selection
from existing, unrelated upstream boards has no influence upon yours.

The pin naming in "MII0_RXD/TXD" follows the same numbering scheme as
"port@0" etc. The SJA1105PQRS.pdf datasheet should tell you as much.
So your CPU port should be the "port@0" node and not "port@4". The
switch "port@3" and "port@4" sound like they should be the ones with
status = "disabled".

> > If you are truly using MII, then you should remove the RGMII delay
> > properties, and since you are using a 6.1 kernel - hence after kernel
> > commit 5d645df99ac6 ("net: dsa: sja1105: determine PHY/MAC role from PHY
> > interface type") - you should be using phy-mode = "rev-mii" to put this
> > port in MII PHY ("RevMII") mode - to interoperate with the FEC in MII
> > MAC mode.
> 
> Okay, I will remove RGMII delay. is phy-mode = "rev-mii" applicable to
> all ports or only for fec port4?

Use phy-mode = "rev-mii" for the switch port going to the FEC, and
phy-mode = "mii" for the switch ports going to MII PHYs (and for the FEC
itself).

> > You can also use the RX counters to determine which switch port is which
> > (but the phy-handle of each port to each PHY needs to be correct).
> 
> RX counters in ethtool you mean?

Yes.

