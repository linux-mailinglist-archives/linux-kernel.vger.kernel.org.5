Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5727E6D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKIP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:29:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF87187
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:29:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A33FC433C8;
        Thu,  9 Nov 2023 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699543769;
        bh=Dvpc/hn3aIEBQWMzrsNL9Hlmh05ncAoe/xihc89NxGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZrg+5XM1Czv03HdNl+1iAgvYyPpK6QWXn9Ao+PHwv2vXYIdZg6bxvyEn0BOZnxv9
         kZyJQ54pJhcPKwqtAycmfW66gvQB64BSUu801eRuEe01A/hDGSaXgSCE3yhl/3LeuI
         GfK0HoyKUIHR+M7w7hyVY8+I+VIJgV9V2hP/+MsqJFlJOY9q0Jhubht3VzuA2puQbk
         KB5BEhmcHnD5/AEPg6EPSz8dmVbk298Fo1bmBXjbvQOEklFYuizIacV5jOOiW1coRe
         4k0h4z6CqT7JFmE+488TEoPRpP+xs7rq0GrxI9IPgA6DxsFD2mC+Uh+tMnEuMHCNut
         rVHO5m6OGQtRQ==
Date:   Thu, 9 Nov 2023 07:29:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put
 to error path
Message-ID: <20231109072927.6695042a@kernel.org>
In-Reply-To: <502a27b6-e555-42d2-bb0f-964a58f81dbe@siemens.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
        <20231107183256.2d19981b@kernel.org>
        <502a27b6-e555-42d2-bb0f-964a58f81dbe@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 12:08:21 +0100 Jan Kiszka wrote:
> > Is there a reason you're not CCing authors of these changes?
> > Please make sure you run get_maintainer on the patch, and CC
> > folks appropriately.  
> 
> I was only interacting (directly) with Danish in the past years on this
> driver, and he also upstreamed it. So I assumed "ownership" moved on.
> Adding both, Roger with updated email (where get_maintainer does not help).

You'll need to repost the patch, it's been dropped from patchwork.

Roger, if your old address doesn't work any more please add an entry
to .mailmap.
