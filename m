Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197747A621A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjISMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjISMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:08:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E1CF7;
        Tue, 19 Sep 2023 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yPXw5msWBa7gpoTMlarfa1JynmH72wdGK8K5th/5R3U=; b=bt8IMNCWIoMPhCUaKCSuJa5xCE
        55Y7MUY7M0PFq4nl56NsGy1MY3WvNRyRRFvOTpV/Y1zvxoaOH7ktZavRUWTm7EFNAfenm3UVi2iPr
        c5l5zGC3lWP5PCZ3GrlLVYC+BvylVqrSjQqfSDngq2d73+IlXbZQeb8qXlax9s95NQ64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiZWS-006uCd-Ap; Tue, 19 Sep 2023 14:08:08 +0200
Date:   Tue, 19 Sep 2023 14:08:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
        pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] r8152: remove queuing rx packets in
 driver
Message-ID: <369f3139-4e63-4327-8745-2d72d7dfea8f@lunn.ch>
References: <20230919031351.7334-429-nic_swsd@realtek.com>
 <20230919031351.7334-430-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919031351.7334-430-nic_swsd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	return work_done;
> +	if (work_done > budget)
> +		return budget;
> +	else
> +		return work_done;
>  }

I don't know NAPI too well. Are there implications of not telling it
the truth?

    Andrew
