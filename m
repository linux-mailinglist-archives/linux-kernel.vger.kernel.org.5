Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA44753BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjGNNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:16:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAAF30DE;
        Fri, 14 Jul 2023 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kY9kWgPRsbUG2PwMOsb8zyln8FszRPF2CwtQS5KEw50=; b=ZBNqoO4508QGdlm4xwIwriY4I+
        yBv9AnZXqMeuoerpvlqk7FfUni3J/C21vKpvgbytPD8aIKyqFa5kL9kpf7SV0hzEy8H7e886FAbS5
        +R53T+aPb+b4zOhLrkM5y6cqWUQ6ZZvaSI5EWcYho+r2LYbm1wMRJ75+AbPr2EHpYZUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKIey-001M4n-DH; Fri, 14 Jul 2023 15:16:36 +0200
Date:   Fri, 14 Jul 2023 15:16:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] net: phy: at803x: enable qca8081 slave seed
 conditionally
Message-ID: <d2ea830d-6444-47d6-8a0d-48098f1b954e@lunn.ch>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-4-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714063136.21368-4-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:31:33PM +0800, Luo Jie wrote:
> qca8081 is the single port PHY, the slave prefer mode is used
> by default.
> 
> if the phy master perfer mode is configured, the slave seed
> configuration should not be enabled, since the slave seed
> enablement ignores the master/slave perfer configuration,
> which is not expected.
> 
> disable slave seed if the master mode is preferred.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
