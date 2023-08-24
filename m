Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5B787034
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjHXN1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjHXN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDC19A4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B05664BF2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDBBC433C7;
        Thu, 24 Aug 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692883618;
        bh=ZsW3prl8w4T4P2bsAVNCnXSIvm0wiRqqLXGDRkAWsQw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NWgu4UQ0OixhAYi9nTrfuYg+8ntCaTHvz/06SAdPExjouDYmyD7PR+j61sBpwiuXV
         iIDdlMSfAGUfiaLBB9aWDeHPG6+Nl6FFpcHatfED80RohGzc5oib/R4ZIjqR8OpylA
         m9uP8DA44ongAZvRWekBb0WSO6Znu9IO+LI1bmDrh8WgAiFtEVAC5sLe4+y6v5LtEu
         iBog2g8bLk1kHqsG4sYgPbttFIMgghmMNwDrmCvV4W4yxJrRUFl0Ee37hvVeZE9KkI
         DvhSSd4THuNK7prHtNTgQexGK1DRogGt2sG1RsLOyhgbIranYaCUYOh/6NRkh/gfaC
         Ng0GQrSRrCfZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230824091615.191379-2-radu-nicolae.pirea@oss.nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com> <20230824091615.191379-2-radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [RFC net-next v2 1/5] net: macsec: documentation for macsec_context and macsec_ops
From:   Antoine Tenart <atenart@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
To:     Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>,
        andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Date:   Thu, 24 Aug 2023 15:26:54 +0200
Message-ID: <169288361453.5781.18200652512492828409@kwain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Quoting Radu Pirea (NXP OSS) (2023-08-24 11:16:11)
> =20
>  /**
>   * struct macsec_context - MACsec context for hardware offloading
> + * @netdev: pointer to the netdev if the SecY is offloaded to a MAC
> + * @phydev: pointer to the phydev if the SecY is offloaded to a PHY
> + * @offload: MACsec offload status

As this selects were the offload happens and how the two previous
pointers can be accessed, might be nice to be a bit more explicit in the
comments.

> + * @secy: pointer to a MACsec SecY
> + * @rx_sc: pointer to a RX SC
> + * @assoc_num: association number of the target SA
> + * @key: key of the target SA
> + * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
> + * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
> + * @tx_sc_stats: pointer to TX SC stats structure
> + * @tx_sa_stats: pointer to TX SA stats structure
> + * @rx_sc_stats: pointer to TX SC stats structure

s/TX/RX/

Thanks,
Antoine
