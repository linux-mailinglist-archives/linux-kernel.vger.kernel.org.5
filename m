Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D857A784069
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjHVMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjHVMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99012CD9;
        Tue, 22 Aug 2023 05:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABD765530;
        Tue, 22 Aug 2023 12:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1277AC433C7;
        Tue, 22 Aug 2023 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692706200;
        bh=oIroAJWGpAoaXxQqj5B47vOkVLFc3Qej63Npk++iLT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayKbqyQ8w1V9qrLcqkiY6b6ldUXauWFOQ4vYytTyxaeZ0SGPUbBcg3dn150Rg8Llz
         45OSSC8ZBqa5T8ZUbGXDqKAAeu/V4+9+Q1mWJMgWmT9joofIDgZFbJqNQTrx2OL47p
         qz6qJZ80vfxctHuz4FeW3KLTorowBcJMnql5JoKw=
Date:   Tue, 22 Aug 2023 14:09:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        pmalani@chromium.org, bleung@chromium.org
Subject: Re: [PATCH 0/4]  Displayport Alternate Mode 2.1 Support
Message-ID: <2023082231-expose-animating-bbd6@gregkh>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:07:31PM -0700, Utkarsh Patel wrote:
> This series enabels cable identification flow required for Displayport
> Alternate Mode 2.1 support.
> 
> In this series [PATCH 3/4] uses cros_typec_get_cable_vdo API from,
> https://patchwork.kernel.org/project/linux-usb/list/?series=766752
> 
> Utkarsh Patel (4):
>   usb: typec: Add Displayport Alternate Mode 2.1 Support
>   platform/chrome: cros_ec: Add Displayport Alternatemode 2.1 feature
>     flag
>   platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1
>     Support
>   usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1
> 
>  drivers/platform/chrome/cros_ec_typec.c       | 30 +++++++++++++++++++
>  drivers/platform/chrome/cros_ec_typec.h       |  1 +
>  drivers/usb/typec/altmodes/displayport.c      |  5 +++-
>  drivers/usb/typec/mux/intel_pmc_mux.c         | 24 +++++++++++++++
>  drivers/usb/typec/ucsi/displayport.c          |  2 +-
>  drivers/usb/typec/ucsi/ucsi_ccg.c             |  4 +--
>  .../linux/platform_data/cros_ec_commands.h    |  5 ++++
>  include/linux/usb/typec_dp.h                  | 28 ++++++++++++++---
>  8 files changed, 91 insertions(+), 8 deletions(-)
> 
> -- 
> 2.25.1
> 

What tree are you expecting to see this patch series go through?  Please
be explicit when you resend the new version so we know who is
responsible to take it (or not.)

thanks,

greg k-h
