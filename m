Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DBE7CDE78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbjJROK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjJROKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:10:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8DC199C;
        Wed, 18 Oct 2023 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qXfslROHv2RBlLwH7KP5e2yJtkHRVnTM00Qi2Twh7o0=; b=g90nYBlXt4Ne6GhLWnxmo5rxD7
        vdTzz2S8sO88AHIphUWdOlyQH71D0TEF65YxKl6vldzgIWlg/Mv237+qvll0PuobqihzoHDnGjBhw
        6E0snfC5AqkB5+nTn32fk4iNZq7a55stjOAGnZ3wE6lRJGutoUmD0oCM7tBy6KPejlM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qt7Ez-002acE-N8; Wed, 18 Oct 2023 16:09:41 +0200
Date:   Wed, 18 Oct 2023 16:09:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Message-ID: <b5202fbb-566e-4dd1-99e9-f07061231a98@lunn.ch>
References: <92a18413-fa28-4420-88f8-e7dedaa8c45e@lunn.ch>
 <20231018140628.4149-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018140628.4149-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:06:28PM +0200, Ante Knezic wrote:
> On Wed, 18 Oct 2023 15:52:27 +0200, Andrew Lunn wrote:
> 
> > It looks like this is the only use of dev->rmii_clk_internal? So does
> > it actually need to be a member of ksz_device? 
> 
> Yes, I guess you are right, sorry about that, it probably won't be used later
> on and should be removed from ksz_device.
> I will repost if the rest of the patch is ok?

The rest looks O.K. to me.

    Andrew

---
pw-bot: cr
