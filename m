Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82D7D8F33
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjJ0HHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7B116;
        Fri, 27 Oct 2023 00:07:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BD8C433C7;
        Fri, 27 Oct 2023 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698390461;
        bh=wJS+QNrJXp1MsR3/ZUU86Cl8sI9OcARWlPbkBdr/bKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cKRZ/dqG1UPyK7jGIKlc7d4qyLaGMVNalQpqY5YHNuJmLJssUWMCh6+DxStZzOCx
         ycijrCqRKHCwG3bBlKXxj6ROCUqVDwp9sptIHEiJoXAY5OMP9E1PBCQQoH3nnqTxU/
         IxMV/TmCRUpp4AVho4hqjROmuArhRVLTI/EHMcDk=
Date:   Fri, 27 Oct 2023 09:07:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Witold Baryluk <witold.baryluk@gmail.com>, arnd@kernel.org,
        Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregory.greenman@intel.com, ilw@linux.intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com,
        stf_xl@wp.pl
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
Message-ID: <2023102709-purse-repressed-d8b9@gregkh>
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
 <87o7gld8l4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7gld8l4.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41:27PM +0300, Kalle Valo wrote:
> For example, I see lots of dead code under '#ifdef NOT_YET' and '#if 0',
> removing those is a good a start. Also converting the ugly debug_level
> procfs file to something more modern would be nice, maybe using just
> dev_dbg() throught the driver is a good option? Or maybe use a module
> parameter instead?

Ick, no new module parameters, this isn't the 1990's, please just use
the netdev debug lines instead :)

thanks,

greg k-h
