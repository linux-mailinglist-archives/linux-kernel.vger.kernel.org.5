Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D480F550
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377100AbjLLSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC379B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:16:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F8C433C7;
        Tue, 12 Dec 2023 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702404966;
        bh=55v2YEAEajqeqknulyuWsJXXATDMpGT7WsJUIr0GI/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKwKGBqs/hXYX/mV4mPQ1ZwkgUJrnnfWNcTPTyuiWBMJ/leiYEQSgENKdG3sfmvuE
         bSxth5b7ltOcRFcXTlP8+X9n+jOnsalASL5N2T8+CKUnwMTofd6ykO/MA3iEjkEH1I
         vyEo/J55wTxQRcgS8Z26G14QuLjkeJL/++nkTRr5TV82egehIoXsWMvKeHxZW1Xyid
         HlrXsxTNt0sQBUanT+A3LL7p35sHXf4ZvAD3mpjk4w5JT0X9ECdORpdYkQ6uqWc+hj
         S+MdnAXBQoDEF/jxjxTWyYFWDxeb6TrrrvUcE3mDsEqhmpugczKoOVcl1o+k1jfZrz
         hwp9ZTajSJYBA==
Date:   Tue, 12 Dec 2023 10:16:05 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>,
        Jiri Pirko <jiri@resnulli.us>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header
 split ringparam
Message-ID: <20231212101605.766fbbcc@kernel.org>
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 15:27:50 +0100 Alexander Lobakin wrote:
> Currently, the header split feature (putting headers in one smaller
> buffer and then the data in a separate bigger one) is always enabled
> in idpf when supported.
> One may want to not have fragmented frames per each packet, for example,
> to avoid XDP frags. To better optimize setups for particular workloads,
> add ability to switch the header split state on and off via Ethtool's
> ringparams, as well as to query the current status.
> There's currently only GET in the Ethtool Netlink interface for now,
> so add SET first. I suspect idpf is not the only one supporting this.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
