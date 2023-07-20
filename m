Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE775B173
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGTOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGTOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921D010FC;
        Thu, 20 Jul 2023 07:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E434161AFA;
        Thu, 20 Jul 2023 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2D0C433C8;
        Thu, 20 Jul 2023 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864298;
        bh=GmljuuaoAQMQSKe9upLbTo8ps7Tp7aaUoWS5ofnJR5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwTDCHJtU2GbmV0rpapDlUP+VZ5nnG3SF1b/xMeux3B7o24gxyFHFXd3f54f4GM09
         xZInLOQ8rOngf+rHw0jwTwMgBQZ6sKqiiCi4heIuRb5DjhZkJTDhelwNLND6nOINdB
         jEK3UE0c9kN4eZmOFHDEMVOEh9ouxty+ehj/FxNaSbJVV1exWYRs6+ttbotYxHPN/s
         1iqNxz8kcreV+C6bOn0HxqmneA/mByfGyj9A4SwEJhEWk9KHY44CWlO4vt6iKVjcMc
         dmQaJzDDImn5UIpBT1kH18vvb8eFHQwKdKFKWwhD9HrhkIiO4P4gz/xA9jC7j9b9xU
         wMnxyqL8Vg/uA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMUtu-0008D0-2g;
        Thu, 20 Jul 2023 16:45:06 +0200
Date:   Thu, 20 Jul 2023 16:45:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: simple: sort entries
Message-ID: <ZLlIcl_JzUoqk9hK@hovoldconsulting.com>
References: <20230720080049.14032-1-johan@kernel.org>
 <2023072016-answering-easing-ad6b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072016-answering-easing-ad6b@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:23:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 20, 2023 at 10:00:49AM +0200, Johan Hovold wrote:
> > Sort the defines and device-id entries alphabetically in order to make
> > it more obvious where new entries should be added.

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the ack. Note that I updated the commit message slightly:

	USB: serial: simple: sort driver entries

	Sort the driver symbols alphabetically in order to make it more obvious
	where new driver entries should be added.

when applying.

Johan
