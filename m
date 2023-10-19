Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519907CFDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjJSPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJSPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:24:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B10124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:24:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A48C433C7;
        Thu, 19 Oct 2023 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729092;
        bh=Gs9uiuwgSdvAPbCatk5I/qMXRw9+2OVPvru9R4ouJIU=;
        h=Date:From:To:Cc:Subject:From;
        b=XjvlvFbQjLJAHl/2vyxmv8WzXMfPuS71UwTgUXGH10B9rFHjQmyBfsLJ6Wk+YGeJ6
         4OYhMwqR3z2jw1eIzd9EGl0wm9SxXD8wzO4+OyIUPBBOoKKMoj6PEg6ERUbwHYnN1h
         F3F3Kn6eFERshJyAV6kpoD0Za4/pUOrfjvN+oxEU2UnojuVNHF/+JXjYBmNi0zxdHP
         EloHZ9lwD3XBESAKzdl3bLv66T1hPWpgyaEBoZY6iTDm1Yq7zG1M2xyZkFN7IWhSkJ
         3/Vas9FCzVzWsliHqnD9WfEAC+Z2IbYAMJeFBnzXFMMhsS4oX05Uv39SHo0kdOeUC4
         HF1zbRIsObANw==
Date:   Thu, 19 Oct 2023 08:24:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <20231019082451.785aa123@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The ConnectX HW family supported by the mlx5 drivers uses an architecture
> where a FW component executes "mailbox RPCs" issued by the driver to make
> changes to the device. This results in a complex debugging environment
> where the FW component has information and complex low level state that
> needs to be accessed to userspace for debugging purposes.

You're being very dishonest towards Greg by not telling him that this
is a networking device, and the networking maintainers explicitly nacked
this backdoor. Nacked it, because you can't answer basic questions like
"what are the use cases" with more than "custom config and debug".

Whether Greg wants to take this into the "misc" pile is entirely up 
to him, but you gotta give him more context.
