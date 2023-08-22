Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7769C784555
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbjHVPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHVPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:21:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813DCC6;
        Tue, 22 Aug 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aBMzTbbcj3sZ+U9NM/TH4LSpDQpyP3QM6n+GGY62x2w=; b=Sdyo1Qr5O3IR7Y/knFXS+bzfMZ
        KHOD1huzeFmDC45Qy5OlQxoCJ5SHe61aBmL8XsfYVbZ8jr+58bNcBp05KRIb6AT/upGm9tZpj83sq
        T75hq69Gwk4DFenkhn7ZfU20O12nC4GPc5t4TqkQ1udBqQqZtN/rb29d3K4qPDOOzwI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYTCa-004nEp-F0; Tue, 22 Aug 2023 17:21:52 +0200
Date:   Tue, 22 Aug 2023 17:21:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <d3461e26-2cd1-43c7-a1d0-22363258f23c@lunn.ch>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com>
 <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
 <CAJhJPsUpmR0R8AhGMvFbBHXvcYcUsDmjw5_yb=NnFSdzjSf5dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsUpmR0R8AhGMvFbBHXvcYcUsDmjw5_yb=NnFSdzjSf5dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry! The RGMII mode does work for LS1B.

and the question then is: How does it work?

    Andrew
