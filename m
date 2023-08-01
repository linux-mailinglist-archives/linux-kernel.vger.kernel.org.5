Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA876B5B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjHANXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjHANXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09594198B;
        Tue,  1 Aug 2023 06:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884BB61592;
        Tue,  1 Aug 2023 13:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6884CC433C7;
        Tue,  1 Aug 2023 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690896229;
        bh=5q/CMepqEmFV80SLOi54Dgdhh+HQuHJoSqdQhC4cuYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6HzGR7itk/BVX7PNS6dpsRIXsD4RuE8WPspCdvfLqWQM2aXPdujXuO+ApDOuzBGw
         M5CGNVonoCQlYO8m50FnewczAY9BU6dpL/WF+wY6iFiklSXzh4jW8OL+2kr1dYcUVg
         Ey26dMf+5tkTd2OFkqCJSiOkXTW1XHFETP85BsR8=
Date:   Tue, 1 Aug 2023 15:23:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: vt: Remove some repetitive initialization
Message-ID: <2023080103-yearling-backfire-4875@gregkh>
References: <20230801115724.1428952-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115724.1428952-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:57:24PM +0800, oushixiong wrote:
> 
> Members vc_col???vc_rows and vc_size_row of the struct vc_data have been

Odd ??? characters?

> initialized in visual_init(), so it no longer to initialized them again
> in vc_init().
> 
> v1->v2:
> 	- Fix the comment.

This needs to be below the --- line, right?

> 
> Signed-off-by: oushixiong <oushixiong@kylinos.cn>
> ---
>  drivers/tty/vt/vt.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

thanks.

greg k-h
