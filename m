Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA97CFE04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbjJSPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346315AbjJSPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:36:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D8124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:36:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEC3C433C8;
        Thu, 19 Oct 2023 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697729767;
        bh=MDH0593z5jBKtRznEEG57ISvSJ+OQMYzUp3pHBYru0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yDhrCSLBa25X6++UErtsExqW3w4Z/b6+7PxN4OKBIgujnUn09B/xDscLBzHXrpfYX
         jDI8K6mIAwSAwFCwNNynkXqisatsX+HbkAlWZe6btEIPjlt1j/3Fs3ICLNbiqfjo+n
         tHrs8jUBg/Y45tDde6dNyA8nACpukEH/jyPOH1K4=
Date:   Thu, 19 Oct 2023 17:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <2023101923-tried-provable-72e7@gregkh>
References: <20231019082451.785aa123@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019082451.785aa123@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:24:51AM -0700, Jakub Kicinski wrote:
> > The ConnectX HW family supported by the mlx5 drivers uses an architecture
> > where a FW component executes "mailbox RPCs" issued by the driver to make
> > changes to the device. This results in a complex debugging environment
> > where the FW component has information and complex low level state that
> > needs to be accessed to userspace for debugging purposes.
> 
> You're being very dishonest towards Greg by not telling him that this
> is a networking device, and the networking maintainers explicitly nacked
> this backdoor. Nacked it, because you can't answer basic questions like
> "what are the use cases" with more than "custom config and debug".
> 
> Whether Greg wants to take this into the "misc" pile is entirely up 
> to him, but you gotta give him more context.

Well, in this case, no way in hell will I be taking this.  If this is a
networking device, it needs to go through the normal networking driver
review process, thanks for the heads up.

greg k-h
