Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09C07BC68B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjJGJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343714AbjJGJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:50:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6783;
        Sat,  7 Oct 2023 02:50:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69703C433C7;
        Sat,  7 Oct 2023 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696672235;
        bh=whvU6Sqfypv+HebCnEiJDrr9PjxsrimH+/8NP6pHjAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KG/ThXZKClPaggzGmZrszivzFcO1EJJkJ+ay/p4OIJLC/FROE2qMLtvbtctNpKOF0
         rzKWEAsL4mN3+rMEJ0vuVcMd2vIwEWCgAqVfA0SnMXGvaFbVjQq7G3BrfGTjQ/etO9
         ho+IoxrcIjjoyzjkf9BLjVuCaShXGWbL2IJ38w4E=
Date:   Sat, 7 Oct 2023 11:50:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     stable@vger.kernel.org, sjitindarsingh@gmail.com,
        linux-kernel@vger.kernel.org, jslaby@suse.com,
        George Kennedy <george.kennedy@oracle.com>,
        stable <stable@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH stable 4.14.y] vc_screen: reload load of struct vc_data
 pointer in vcs_write() to avoid UAF
Message-ID: <2023100727-blooming-monogamy-9ff1@gregkh>
References: <20230922215502.678169-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922215502.678169-1-surajjs@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:55:02PM -0700, Suraj Jitindar Singh wrote:
> From: George Kennedy <george.kennedy@oracle.com>
> 
> commit 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357 upstream.

Now queued up, thanks.

greg k-h
