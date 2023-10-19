Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687977CFD21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjJSOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjJSOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:42:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A702D6D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:42:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9CC433C7;
        Thu, 19 Oct 2023 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697726560;
        bh=gn8f0lL/c50dlaUtn0M4/uha7RqskTVC3QDEAjTmYtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBlfZeKj0ZEARoRcytYVE9gadpv1rPmLE4txHPWtP9AhEtGgruo0+zmCV9WyYb5rx
         aGKg4aTjS9RZ0zwcXf5M7bg3mqIYWghj8IFs+EJDeue4WC3f6KOt2GvEoEHd9KoEoH
         VvTRx7k4I0ia0xKM0AT8SJRqnNwl+9hq0Wgg+cmHBKIl8T40hEpctksfYBaRTLWGk+
         TFcF/OdSWwoEYTlkoEr2nBEuFusUDej8Md4dTv5srofzCu44i2Z5FpJ7qoQGB51ZI6
         A4dhEf5v0VbdKSRfOuNMbGC4CElFB1uKeqj/Nl0RnQ0qp/9YPN1OKQYy8l0LOK5D5o
         HUo6JV7tWuvHg==
Date:   Thu, 19 Oct 2023 07:42:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <20231019074237.7ef255d7@kernel.org>
In-Reply-To: <ZTE884nkvAxKy2G3@d3>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
        <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
        <20231017181543.70a75b82@kernel.org>
        <ZTE884nkvAxKy2G3@d3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 10:28:03 -0400 Benjamin Poirier wrote:
> > Humpf. Unrelated to the set, when did qlge grow devlink support?!
> > 
> > Coiby, do you still use this HW?
> > 
> > It looks like the driver was moved to staging on account of being
> > old and unused, and expecting that we'll delete it. Clearly that's
> > not the case if people are adding devlink support, so should we
> > move it back?  
> 
> AFAIK this was done by Coiby as an exercise in kernel programming.
> Improving the debugging dump facilities was one of the tasks in the TODO
> file.
> 
> I moved the driver to staging because it had many problems and it had
> been abandoned by the vendor. There might be some qlge users left but is
> that reason enough to move the driver back to drivers/net/
> if there is no one who is interested in doing more than checkpatch
> fixes on the driver?

Staging is usually an area for code entering the kernel, not leaving.
We should either suffer with it under drivers/net/ or delete it,
as you say, nobody is working on significant improvements so having 
the driver in staging is serving no purpose.

How about we delete it completely, and if someone complains bring 
it back under drivers/net ?
