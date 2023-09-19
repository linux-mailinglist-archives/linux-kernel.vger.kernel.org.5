Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF27A5CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjISIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjISIea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:34:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0E11C;
        Tue, 19 Sep 2023 01:34:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD7EC433BB;
        Tue, 19 Sep 2023 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695112462;
        bh=v6C3Kv6sJefn6hl+Ywp4TwA5HQWieFzbjla5S20Jk3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMj9st1OEM7HmnN+05vosvwSmvE79S0TbOnXgaZRa1txEZLAh8GLVYJzBNhtRRFIM
         +o8hj0iuB4zgs2Fcy83+2fC824AlB0xVGy6HD2yHvhHdaGOD8j9BXYpiDfT8Cp7e/w
         JtepQ/HfLFWvv4DZzT5NT19hYrnqCL9H2jAWz9VY=
Date:   Tue, 19 Sep 2023 10:29:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091922-unplug-flask-f2e5@gregkh>
References: <2023091954-algebra-hastiness-3bb8@gregkh>
 <20230919080207.3654671-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919080207.3654671-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:02:08PM +0800, Edward AD wrote:
> When the call to gsm_register_devices() fails, we need to reclaim the memory
> requested in gsm_dlci_alloc().
> 
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>

Please use your company name/email address, and then just set a manual
"From:" line as the first line in the changelog as the documentation
asks.  That's how developers work around their broken corporate email
systems (but really, you should go and poke your IT group to fix it.)

thanks,

greg k-h
