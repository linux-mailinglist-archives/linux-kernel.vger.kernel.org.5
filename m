Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13E377755A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjHJKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjHJKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686323584
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E935665709
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BFC433C8;
        Thu, 10 Aug 2023 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691661808;
        bh=h3BA3I10oH7VW8/1K474QAx0VUkyw0uaaD0W0BPjf+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQuvaB982mwEO7JuDiSs+xIJamzFCo+k9o5sT80t2RT33S8xb6TdKuzeYXv9JiZkj
         KKnAWfjUKUtFZveI9RrBSzdu69lEH2TOY/SXQzFffAHtAzhTV75CV8vaG13doAsaIP
         V4X7jEYlglKETikr1QGpZ799l9hfEew87tejhLeLBpEOr2T0okDSBW9cmRzkG4AQ1p
         /kQJYqYWA91uGUilavbHwngUkuhx84EqdNUg3J5z5Ftl4+IPjD6BGw8tVqybABwTOZ
         DZCcDVhjYEOjHy50Kdhd4HvJrGKc0EV4iGIcze/wLc5yVC7SheVWJndU8xL51eR/dL
         CcvM/35+xMb8Q==
Date:   Thu, 10 Aug 2023 12:03:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v3 1/1] net: stmmac: xgmac: RX queue routing
 configuration
Message-ID: <ZNS16rhrXq+JUR85@vergenet.net>
References: <20230809020238.1136732-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809020238.1136732-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:02:38AM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Clean unused defines
> 
> Changes in v2:
>   - Convert the shift ops to FIELD_PREP

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>
