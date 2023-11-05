Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D467E161C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjKETgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKETgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:36:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAF597;
        Sun,  5 Nov 2023 11:36:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AA1C433C8;
        Sun,  5 Nov 2023 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699212963;
        bh=iBuwmBDODWXmPW8qYjUrjw4+pvhW0NeswLxnxHH8LsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MySeR0pHRpVdhnUHtvv66gVrQe4ttTg2s5Saf9h2OW69iwsqiYz53eeI1LSBnodJO
         bykTy9rmUy9vM2zMYCKHI4QLHLKuxMcNVR5lEpU0fGQj6nF41Ni2eK9s79J+Mxe/gl
         orZ5te116AuRDjxbovPDsFWjfuEaa1k8mbECUGNRifhpdbwJXDvoYt+52Llci0G6N3
         h3H8aaZYK6L1OLQtsRFPiPgYRaccxrECK24egJDILnPX5TFFnan0wkksh4KiA3cuWc
         tUoEE+9UuSViedoeYVcDEPkbbIA4x4uP+Cps7Q4IZZSGhCMafQqlhH4p/vMgFtk3gR
         ScRCvbC9OHIhA==
Date:   Sun, 5 Nov 2023 11:36:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: smb cifs: Linux 6.7 pre rc-1 kernel dump in smb2_get_aead_req
Message-ID: <20231105193601.GB91123@sol.localdomain>
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 11:05:30AM -0700, Steve French wrote:
> maybe related to this recent crypto patch?
> 
> https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=783fa2c94f4150fe1b7f7d88b3baf6d98f82b41b
> 
> On Sun, Nov 5, 2023, 10:32 Damian Tometzki <damian@riscv-rocks.de> wrote:
> > [   83.530503] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W
> >     6.6.0 #61
> > [   83.530508] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W
> > (1.62 ) 07/12/2023

The above suggests that this warning occurred on 6.6, not on 6.7 pre rc1.

- Eric
