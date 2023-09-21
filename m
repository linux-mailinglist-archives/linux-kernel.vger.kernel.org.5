Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524087A9E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjIUTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIUTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:53:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256CF10250C;
        Thu, 21 Sep 2023 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=y/4WeEF6bN1yrtbIGksz8Co0XtSt537OFniIJItRBBI=; b=HCsMc/KJYehWkA0EELVwxmv8nP
        YmnIs0f3MLpD3Vo6XnE0jEplVdB5aOiYfkVoQ0qkyliMh/l62SO0UwjUMgZiP99EEhqQoxolOv2Pt
        GFg6Dz5QObtx5A9AbcRLdcGqQ2pFGlkdDBYFG76YoSEtCC0EUhXpisPvn/waj6jX0/9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjPD0-0077lE-4D; Thu, 21 Sep 2023 21:19:30 +0200
Date:   Thu, 21 Sep 2023 21:19:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <61e316c5-e504-4ad1-93a3-f2df5a16b654@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
 <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
 <4c1d0d38-c459-4722-bead-7660d85f4925@lunn.ch>
 <e037b12b-e592-f451-102e-61401c7ea5d0@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e037b12b-e592-f451-102e-61401c7ea5d0@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, as "struct oa_tc6" and its members are not or going to be accessed 
> in the MAC driver, I will consider this as an opaque structure and 
> declare it as void *opaque_oa_tc6 in the MAC driver private structure 
> "struct lan865x_priv" and will pass to the APIs exported from oa_tc6.c lib.
> 
> Is my understanding correct?

Yes.

If the structure is going to be truly opaque, i suggest having it in
the C file, not the H file.

	Andrew
