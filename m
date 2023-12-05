Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7471E8044DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbjLEC3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346494AbjLEC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:29:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF578D5B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:27:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F6C433C7;
        Tue,  5 Dec 2023 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743250;
        bh=ZwC3qSAZfYKEV4lmUPujpx9iFrtL2THK5cK6G6Kv+18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LUviNjSM3lDsbgdG0110/E4gueBM0mni3upUVnXg6VDKol6i+x92wx4p4RJauOJty
         +pLQ9GMXxXwYjjBp/m6pCHKy6EfYc/HUP5Ds9q1rIL/n7HI367HLQGfQbgFNqxBQd3
         leoMciv2/0RQvv6xRDLz+z9EmK3s2RJDKp3dTkefC0L2sbZBNsZRqsQ9/pNuAAmqK8
         e31ApknJcB4JQ9jJSOKVle5lYO78V+zzRmh8wQoSAIZL30r4mgZKyAJ4VScjrxeC34
         7mmYA91rQ7/H4iQI+gImhaONP7OR5dTOU6Cxw0wihFnpZoBydY+xZwB4CyhBoQO3wo
         4M8G/xA6MujGg==
Date:   Mon, 4 Dec 2023 18:27:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: usb: r8152: Fix lost config across
 deauthorize+authorize
Message-ID: <20231204182727.1a52ae59@kernel.org>
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Dec 2023 10:29:49 -0800 Douglas Anderson wrote:
> Since these three patches straddle the USB subsystem and the
> networking subsystem then maintainers will (obviously) need to work
> out a way for them to land. I don't have any strong suggestions here
> so I'm happy to let the maintainers propose what they think will work
> best.

No strong preference here, on a quick read it seems more like a USB
change than networking change, tho, so I'll defer to Greg unless told
otherwise.
-- 
pw-bot: not-applicable
