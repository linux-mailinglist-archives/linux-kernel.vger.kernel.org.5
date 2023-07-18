Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB760757D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGRN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjGRN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F025D1;
        Tue, 18 Jul 2023 06:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F102761584;
        Tue, 18 Jul 2023 13:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1461C433C8;
        Tue, 18 Jul 2023 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689686973;
        bh=6iTjVARF9WmVKMhxOcPS9qZIC1LR6nJSeaSCWdPXC4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QITOC1h3eFOnv1ebHrmktrNSZuNoKjXl88x44EkSlWqmOVY0Be0pwWe7ibFyZka9J
         zRLK+VYwQIjc7w92ClrzExG35ZS3H9GL+mcrccbVtVNb0BZTtXuWvImvIfqUPzB7Hs
         jx5ZlxnOHnALrNHrYv8ONDO9w+YzlYkCziBdNhOQ=
Date:   Tue, 18 Jul 2023 15:29:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH v4 2/2] usb: typec: intel_pmc_mux: Configure Active and
 Retimer Cable type
Message-ID: <2023071800-roaming-automated-5404@gregkh>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718024703.1013367-3-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:47:03PM -0700, Utkarsh Patel wrote:
> Cable type such as active and retimer received as a part of Thunderbolt3
> or Thunderbolt4 cable discover mode VDO needs to be configured in the
> thunderbolt alternate mode.
> 
> Configuring the register bits for this cable type is changed with Intel
> Meteor Lake platform. BIT2 for Retimer/Redriver cable and BIT22 for
> Active/Passive cable.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
> Changes in v4:
>  - No changes.
> 
> Changes in v3:
>  - No changes.
> 
> Changes in v2:
>  - No changes.
> ---
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 28 +++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)

Why the 2 --- lines?

And why are you not cc:ing all the proper people (i.e. the person that
can actually apply this...)?

confused,

greg k-h
