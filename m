Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3929D7F79AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjKXQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:48:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0E18E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:48:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12046C433C8;
        Fri, 24 Nov 2023 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700844519;
        bh=aOSyWxsPCSARKTHyqNLlusRc2HF7ChrOhJn8s86UXsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8y+L/N74Nut5tJxqr8hMdvI0Nj4LKerxwOPf666UaRxC7XLfeNBwhQIA4muf0/sy
         vL1K57nDKxZDNup4Zhzw4Glcm6i5ZB0GkPMsIDIf4lMP5joqsZcpmE7doL8svoNL1i
         l6R733FuEeSrG5wDOAErGNTF0YufnEZ3U2jFlVQ/6dbVxsdzt0g3JOLgAeN/soTJ0P
         VRxuGcN8uoulmVTJE9a16feowMBrT81YnpsUcu2Lo8YuY+mPADkurjx2YCxOzLUdoP
         HM98Eh5aOdFqMEWg6eYpQrEdxha2pCypYuF1BVXBfD84TWY5SM9uYyHl4K4uUQ06Yb
         KEihAys3IRodw==
Date:   Fri, 24 Nov 2023 16:48:34 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124164834.GT50352@kernel.org>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:52:43PM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> Sync lib/test_firmware.c file accordingly.
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - Add the newly introduced error code to test_firmware.c

I verified that the error obvserved in v2 when compiling the above
file with clang-16 has been resolved.

Link: https://lore.kernel.org/all/20231121173022.3cb2fcad@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>

...
