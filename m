Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB587F8BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjKYOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjKYOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:48:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235861BD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:48:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDEFC433C7;
        Sat, 25 Nov 2023 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700923729;
        bh=tS+XD1FVGDo2P6LA3feC8M3YjSB4G+skn0rfq45uNdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5mRcIDQ6F27z7/oqY8Xb1ZybREwiZ5PAqpxWzHIf/EXMsVjqqSCMZ+dnRtrswOGd
         2tr+gHbd6GirIGI6Hxb7VIaiXEYX9rv+6qtX6rTGECG6Ws8SsLrvuJKaQ2cgWriEuQ
         c86kEduv8S8KIKER09womRbefHoPWj0Xo1W7+jFk=
Date:   Sat, 25 Nov 2023 14:48:46 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 3/6] debugfs: add API to allow debugfs operations
 cancellation
Message-ID: <2023112537-anyhow-bottle-f499@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.8c5d739c69e7.If54cd017d5734024e7bee5e4a237e17244050480@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.8c5d739c69e7.If54cd017d5734024e7bee5e4a237e17244050480@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:25:26PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In some cases there might be longer-running hardware accesses
> in debugfs files, or attempts to acquire locks, and we want
> to still be able to quickly remove the files.
> 
> Introduce a cancellations API to use inside the debugfs handler
> functions to be able to cancel such operations on a per-file
> basis.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
