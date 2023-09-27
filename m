Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3D7AFE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjI0IZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjI0IZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFE10E5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:16:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CBAC433C7;
        Wed, 27 Sep 2023 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695802595;
        bh=uEUSTFph3mLlkwgv5DTW0f7XPtXB/8XECV8Mj5d6RsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qc+7HZR2ZLzxGFOzsHW5R4Ho/73z4LdNVH8v/WUgIKRedlohyoknuoL51Zt4pb81U
         HcljwTT/8vHaecRxbSyTnMICqPl0mY0FIFzCpAGTtCEX/zmH7O/4k1YbPI8abaxlI/
         /Otr1Mv8WCGPiaTKZGqbR2EOTfJi+Yrpu1P0w4dg=
Date:   Wed, 27 Sep 2023 10:16:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v5] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
Message-ID: <2023092701-facelift-projector-d1d4@gregkh>
References: <20230927073027.27952-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927073027.27952-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:00:27PM +0530, Krishna Kurapati wrote:
> In the event gadget_connect call (which invokes pullup) fails,
> propagate the error to udc bind operation which in turn sends the
> error to configfs. The userspace can then retry enumeration if
> it chooses to.

Will this break userspace that is not expecting error codes to be
returned?  What userspace code will now be modified to handle this?
Where is that work happening?

thanks,

greg k-h
