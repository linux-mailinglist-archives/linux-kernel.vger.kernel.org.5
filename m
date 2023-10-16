Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB87CABAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJPOig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjJPOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:38:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD4AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:38:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C304C433C7;
        Mon, 16 Oct 2023 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697467113;
        bh=VJyGFGnCxOE3R7mSYDW1dreNDxE6icdciGwJArzqru0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPwwozyKXU3+Hek7w+hL/wMHLC69oGdgnT4RaZAYHySek3BfOL6T1u+gJEF7tNx+i
         ldxu+vUTLv72vfzBARGCndFnTe/z8OPQSiTB7FEk9OjHWs5CBF3wJ6V0SV7i+18XG7
         0YrIuIKzdxqn5VVh/pvqoXZAPnixnnt1n1Sf4O3P7blNIlp3t2MThfrlnb5tCl6Qip
         pS3LYF4QkmcGSQHEL53+wUn18u1ve+YHdzzgvld25evxc9uWeousWnGtwQetjObGb1
         RRcBVuRtJAFD2MCPWisjkAZNyMN413zoTz8xF0/D/HfPBX+WHlZ50GP63Q/UoirGT5
         g5nuRDztZf8tQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsOjk-0005WX-0k;
        Mon, 16 Oct 2023 16:38:28 +0200
Date:   Mon, 16 Oct 2023 16:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gnss: tell what GNSS means
Message-ID: <ZS1K5AoZnS-3H-c3@hovoldconsulting.com>
References: <20230925054346.18065-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925054346.18065-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 10:43:46PM -0700, Randy Dunlap wrote:
> Tell users what GNSS means in the Kconfig prompt.
 
>  menuconfig GNSS
> -	tristate "GNSS receiver support"
> +	tristate "GNSS (Global Navigation Satellite System) receiver support"

No, I don't like the way this clutters menuconfig. The above would make
this one of the longest entries and for very little gain.

We don't spell out NVMe or SPI either and I think the help text below
is clear enough as anyone not yet familiar with the concept of "GNSS
receivers" is sure to at least have heard of "GPS receivers" (which we
also don't spell out).

>  	help
>  	  Say Y here if you have a GNSS receiver (e.g. a GPS receiver).

Johan
