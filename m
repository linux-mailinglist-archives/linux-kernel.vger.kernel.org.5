Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C07CC015
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjJQKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjJQKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:03:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6CF7;
        Tue, 17 Oct 2023 03:03:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bdf5829000so576083566b.0;
        Tue, 17 Oct 2023 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537011; x=1698141811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTgb65Fpyt9Rg03VxFdA++ksbT9LLQtyEzJ7ObjtlZM=;
        b=lmoN4hCLVv0/tXKeBrTJYwRlfAgGhtGk2oSWDV3gSxY42jrTnce4asERmsnlN8x8S7
         N4doF0yfVBrQQbYTtzh7RcvSsJet/oalfj7wSE0P7nvUkPLVuvd4FHr+s9V3Q2ouvpXn
         eOXC3mQ7BMw65BHtq1J0N2ox00vTK6yv6T+577wzXvPdoz7IXdFc7hKdaM9zF+jmMfoN
         97ZjbB1NrpMv5HetYE3FTw1AcT2HPGDzwdW/+yYUspJS11zgjfEjkE25A2/WgZFmoa7T
         S7dzn8VE9WW0ScHFZJphLOWJO6aYS2rZZ87aRi8BLm+8//pDyY0MkcdQk//jqYjFmW97
         CXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537011; x=1698141811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTgb65Fpyt9Rg03VxFdA++ksbT9LLQtyEzJ7ObjtlZM=;
        b=Kq0epw6GlOkTVu4MUMaM4NyI9/Bx4blknlAvA4NWwocm1LoyWNMWEEpbQGvUmcTWBp
         S4uIklciGJGizjdS9F8pPUjv3fJv87slG2CcGYRC0x94YLhMzZiYrSwv80kTqSC4x1/u
         fe+SSv4vLeancC0pYW+1NTe7YE+Cow788LzYwLfy3PDgcvhYeZCFF4Mc26vHdfAJ7y7A
         OTDowM4jigUP9crHNDvpTTwBKvTpMIh5GRZBZp04XmtJsNQ9dYOHGsJWwoMpegpRZ/01
         2VWQBx+GMXNNq/ULI2Iq+e4f5o5fEWsezSQFNilKkoyBCmH6eU2cir4uJ00iGcPU5Vxr
         Il9g==
X-Gm-Message-State: AOJu0YxGoTwx0XVRFv0DLKR0AVocy1iO2C/gkPV/z3YvlYk4KYEg5iHm
        OHw8j3/QPMHBAoAeo6iEn1s=
X-Google-Smtp-Source: AGHT+IHQUGjRVUWPVc5mpl2WQuY13s2RSyBWHkvsVca2HV4uweZh2gdmY/WWlUw6xlNRqYo617ccDQ==
X-Received: by 2002:a17:907:3181:b0:9a1:cb2c:b55c with SMTP id xe1-20020a170907318100b009a1cb2cb55cmr1092951ejb.35.1697537010583;
        Tue, 17 Oct 2023 03:03:30 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id sd8-20020a170906ce2800b009b8a4f9f20esm938801ejb.102.2023.10.17.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:03:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:03:28 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v4 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231017100328.qmwi2dnqay7syoki@skbuf>
References: <20231016164742.264613-1-florian.fainelli@broadcom.com>
 <20231016164742.264613-1-florian.fainelli@broadcom.com>
 <20231016164742.264613-2-florian.fainelli@broadcom.com>
 <20231016164742.264613-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016164742.264613-2-florian.fainelli@broadcom.com>
 <20231016164742.264613-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:47:41AM -0700, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Note that you left the following unconverted:

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d117e9b1a465..d27c6b70a2f6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1113,7 +1113,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	u32 val;
 
 	/* When a new MTU is set, DSA always set the CPU port's MTU to the
-	 * largest MTU of the slave ports. Because the switch only has a global
+	 * largest MTU of the user ports. Because the switch only has a global
 	 * RX length register, only allowing CPU port here is enough.
 	 */
 	if (!dsa_is_cpu_port(ds, port))
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index be2491de173d..42b1acaca33a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2486,7 +2486,7 @@ static int mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
 	else
 		member = MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_TAGGED;
 
-	/* net/dsa/slave.c will call dsa_port_vlan_add() for the affected port
+	/* net/dsa/user.c will call dsa_port_vlan_add() for the affected port
 	 * and then the CPU port. Do not warn for duplicates for the CPU port.
 	 */
 	warn = !dsa_is_cpu_port(ds, port) && !dsa_is_dsa_port(ds, port);
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index d203e4a84441..9243eff8918d 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -761,7 +761,7 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	int ret;
 
 	/* We have only have a general MTU setting.
-	 * DSA always set the CPU port's MTU to the largest MTU of the slave
+	 * DSA always set the CPU port's MTU to the largest MTU of the user
 	 * ports.
 	 * Setting MTU just for the CPU port is sufficient to correctly set a
 	 * value for every port.
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index d171c18dd354..0875e4fc9f57 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1144,7 +1144,7 @@ static int rtl8365mb_port_change_mtu(struct dsa_switch *ds, int port,
 	int frame_size;
 
 	/* When a new MTU is set, DSA always sets the CPU port's MTU to the
-	 * largest MTU of the slave ports. Because the switch only has a global
+	 * largest MTU of the user ports. Because the switch only has a global
 	 * RX length register, only allowing CPU port here is enough.
 	 */
 	if (!dsa_is_cpu_port(ds, port))
