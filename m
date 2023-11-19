Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883CB7F03C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 01:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKSAWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKSAWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 19:22:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A2A192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 16:22:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2133BC433C8;
        Sun, 19 Nov 2023 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700353335;
        bh=njhZ+VEXY43nM/ztzb1ihZasqdd6Cd8C+mifV4uY/i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogU1lkuBP7h3e4Pzq67ZPDXlPApu6eBJFWXVCwbtfba0b6iRlchETP6JbVXt2Kg84
         WZk1ID/f0CPrv4pqA0cFpbM6CD2vfLwYyXNFHF0caNHVbUBFKA2xzPmG2C8foB+24A
         RPnMARKe0y7cL6DzwBSiqWCXhErVcnGHSFb7MUCG2zk7jFXAaVKLPiltp08JGmHpB7
         B1QVwwqNMEfvL5Vx6tdlZQIHR7TqrYaHPZziEtgbJn1C4GiUkiCf3X8GZj/N2bRWcK
         fic+xmWgPANV0O9gwxO5dLDpwlMzmyNWqsoLqQXjk2UjsuYY810GFeH9mrD/awKNP6
         ZSP1DPLEUqe7A==
Date:   Sat, 18 Nov 2023 16:22:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] net: phy: at803x: add the function
 phydev_id_is_qca808x
Message-ID: <20231118162214.7093d46c@kernel.org>
In-Reply-To: <20231118062754.2453-5-quic_luoj@quicinc.com>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
        <20231118062754.2453-5-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 14:27:52 +0800 Luo Jie wrote:
> +static inline bool phydev_id_is_qca808x(struct phy_device *phydev)

Please drop the "inline" keyword. The compiler will decide what's best.
