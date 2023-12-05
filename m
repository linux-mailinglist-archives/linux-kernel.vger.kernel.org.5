Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10D804504
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjLECee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjLECed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:34:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE18127
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:34:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47CC433C8;
        Tue,  5 Dec 2023 02:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701743679;
        bh=liax+sIHnmEKfEfVW+s4DmqLUntZruIqSMcTRWSs0Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/w5kHwP00LQYOnC9+5b7PG1sxSHiFKwsRB1yDsd5YpDaHD+tSl0X7jbWde2cdt4L
         xyzfu0VP8pQO9lGfB36ETlCv1oD21KUHIKTVAq7ykuYLNXWUVeTt3CjFi3M0dIu3bE
         Uv6oZJvVMMkEG9gllT8ApZkUrAyVwSu42Y+khv8Q=
Date:   Tue, 5 Dec 2023 11:34:36 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: usb: r8152: Fix lost config across
 deauthorize+authorize
Message-ID: <2023120521-fervor-subscript-20b1@gregkh>
References: <20231201183113.343256-1-dianders@chromium.org>
 <20231204182727.1a52ae59@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204182727.1a52ae59@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:27:27PM -0800, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 10:29:49 -0800 Douglas Anderson wrote:
> > Since these three patches straddle the USB subsystem and the
> > networking subsystem then maintainers will (obviously) need to work
> > out a way for them to land. I don't have any strong suggestions here
> > so I'm happy to let the maintainers propose what they think will work
> > best.
> 
> No strong preference here, on a quick read it seems more like a USB
> change than networking change, tho, so I'll defer to Greg unless told
> otherwise.

I took these in my tree already, sorry for not saying anything here.

thanks,

greg k-h
