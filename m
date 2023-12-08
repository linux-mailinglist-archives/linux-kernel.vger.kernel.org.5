Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1269809BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjLHF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:29:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417E1716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:29:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB1C433C8;
        Fri,  8 Dec 2023 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702013372;
        bh=UsILT93r2k6n3TCqbrECLHZ5VzzDB9sDuQ3fq/CaaLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQ4nidSrLr3sx5zj4XZhOy/B9Pg9OjuoSqb2SQ3q4Wo7ScYmCdVeIKa4cXOXZvZ0Z
         yNis7aVc2K7fVoihnX04GXN7iiFPkpNb5jsgHecW1vrBa/DQfuBaYDTYD/cWB3fVj+
         1OpltY3UkFEtus7g52w0YdYMd3s3SdbxqkVb1nWY=
Date:   Fri, 8 Dec 2023 06:29:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Aron Silverton <aron.silverton@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023120832-vegan-trustable-f89a@gregkh>
References: <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
 <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
 <ZXIWzBxR3S39Snn3@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXIWzBxR3S39Snn3@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 11:02:36AM -0800, Saeed Mahameed wrote:
> I would like to add that debugfs is usually used to expose the driver
> software states, as it evolves and changes with the driver code, but as I
> explained in the other email, it's clearly not a good solution to expose
> arbitrary objects of complex devices, that require interactive and
> selective debug interfaces tailored to the user use-case.

Why not?  Remember, the only rule in debugfs is "there are no rules!"

Well, there is one practical one, "do not rely on debugfs for any
functioning system properties", i.e. "if access to debugfs is not
present, or something in debugfs breaks, the kernel should continue to
work just fine with no change in operations".  But that's an overall
system-level rule, not a rule for what you can put into debugfs.

Have fun!

greg k-h
