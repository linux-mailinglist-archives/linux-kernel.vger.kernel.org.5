Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D32784180
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjHVNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHVNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D04CC6;
        Tue, 22 Aug 2023 06:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7306963972;
        Tue, 22 Aug 2023 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323E6C433C8;
        Tue, 22 Aug 2023 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709481;
        bh=ub/bcX26vqv0SnRwA1OEt2iuTCjmwdGk2R/p505yXBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKOsintoj3EMdxyaWS3nbeMYnPM9ait5IenzIaBMygu/XgKuThIFoMk6IvZgTO58j
         ETf/HjwhmLTaJr/QLUMonuU0wWrXIOdV5ujDY1/Du7bvyMLEFJJ0Taj4etdBEvr5aH
         d4eJICXAFtYwsUZq+oThKE4iP1hXngSkEaw2JA4U=
Date:   Tue, 22 Aug 2023 15:04:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Message-ID: <2023082253-heftiness-arena-ed06@gregkh>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
 <20230817093231.2317-8-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817093231.2317-8-daniel.starke@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:32:30AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add counters for the number of data bytes received/transmitted per DLCI in
> for preparation for an upcoming patch which will expose these values to the
> user.

As you don't do anything with this data here, let's just wait until you
actually do as it's not part of this patch series.

So when your resend, please drop this.

thanks,

greg k-h
