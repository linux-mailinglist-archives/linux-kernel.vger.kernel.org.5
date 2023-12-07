Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714AB808F94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443607AbjLGSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLGSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:03:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F2170E;
        Thu,  7 Dec 2023 10:03:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1e2f34467aso120574166b.2;
        Thu, 07 Dec 2023 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972216; x=1702577016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cyd5phiUGtF3gGm1M6y6XMNxNpiGb0naeJEFalYfR2w=;
        b=Iq1LYhC0rBbVyQTC6Hg0kvYm9u8ojdK4AUeUmSgXZbod2Q/h6yr0qzEaIOuH7SJIDk
         Hr2NXVd/YUmiO5GSZqXO97gvw8+QccPW9vSp7t1q+ivhca/LQq7w+JVl/IdvOvEad/O+
         6CK7q41/Vp5hAR8ztukxW1gtCjAR6COfDAZ9WqK2FtrE4/nDMkKQ1pQbO3eqcoqxeo4K
         orJ1ZFCM3iyGCNdh1lU8fxqyH2sdTdyo1jwwOKnOSfGMwUwbrsoUT4sT4W6wrjiIbe5U
         LzsUZ2EqZWyoawYG1NdVULXjq9XeTS88TnHlaePiLcfRzD9JVqATwc5A8axRuhcxAiFj
         HVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972216; x=1702577016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyd5phiUGtF3gGm1M6y6XMNxNpiGb0naeJEFalYfR2w=;
        b=aEPEGoHVhbKS6pidu2wfs3NNPHZgSqK/yIaISha4xyJLtbxMtmsMW6oXAtKJ2HUaBf
         Kt/+Jet5fPsGkMA+H+jmZc4YD2KSOoLjuQblc0UxnKKHMBZLiBjtNGqOnfZhzVylbncS
         u/hV8ubaD+rtcq+4jysV1+FVukLB618/zTSZ+8BxkQv8zFVpywP7zPz+lXuc5bifZv5U
         R+00o9ADQmzIQD9nigM0jiQNOi5dNs5axv+575HC79cyWg9JyoCjZH5kCqgA6ur9RHef
         UfRhaCv2vH+d7QMjOD0ozC97LZYbFHMHJruOhkEsrVedsFyWi7KB+/ZzTR4fucz/ylZa
         Mbug==
X-Gm-Message-State: AOJu0Yx/oKTTUfKrejvMUpnNU1voT3okID8WaycSROJkrdpYK3RAqnOH
        06448clEG7E8nlHqM4P8C0I=
X-Google-Smtp-Source: AGHT+IEb+8/GgdfwY783D66zPQhIszkM1fWsRJgqvO0vREeyx1Z2tXbyEmShioG3fZn9KBdhMDEBMQ==
X-Received: by 2002:a17:906:fa92:b0:a19:641:66da with SMTP id lt18-20020a170906fa9200b00a19064166damr2080980ejb.7.1701972215689;
        Thu, 07 Dec 2023 10:03:35 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a1c7b20e9e6sm40275ejc.32.2023.12.07.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:03:35 -0800 (PST)
Date:   Thu, 7 Dec 2023 20:03:32 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 05/15] net: dsa: mt7530: improve code path for
 setting up port 5
Message-ID: <20231207180332.ugfp33xcdkw3elrw@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-6-arinc.unal@arinc9.com>
 <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
 <5e95a436-189f-412e-b409-89a003003292@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e95a436-189f-412e-b409-89a003003292@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:36:03AM +0300, Arınç ÜNAL wrote:
> On 18.11.2023 17:41, Russell King (Oracle) wrote:
> > > For the cases of PHY muxing or the port being disabled, call
> > > mt7530_setup_port5() from mt7530_setup(). mt7530_setup_port5() from
> > > mt753x_phylink_mac_config() won't run when port 5 is disabled or used for
> > > PHY muxing as port 5 won't be defined on the devicetree.
> > 
> > ... and this should state why this needs to happen - in other words,
> > the commit message should state why is it critical that port 5 is
> > always setup.
> 
> Actually, port 5 must not always be setup. With patch 7, I explain this
> while preventing mt7530_setup_port5() from running if port 5 is disabled.
> 
> Arınç

Then change that last paragraph. You could say something like this:

To keep the cases where port 5 isn't controlled by phylink working as
before, we need to preserve the mt7530_setup_port5() call from mt7530_setup().

I think it's a case of saying too much, which sparks too many unresolved
questions in the reader's mind, which are irrelevant for the purpose of
this specific change: eliminating the overlap between DSA's setup() time
and phylink.
