Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859F7E1FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjKFLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjKFLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:24:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85609CC;
        Mon,  6 Nov 2023 03:24:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE90C433C7;
        Mon,  6 Nov 2023 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699269895;
        bh=cd8YyuUAyfvtnQe9MLUMItmo03bLdF8bJjKWJ1adwUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PReufXG5fG3dKYS+IucbNpTQO342nNm+GWA1FJrVcxZugXmIwYy6wlEQpdCtTmxPm
         qUpOT4Zw+mjjmyH5BGt1iVXAupCRJp/5ujPeIyc3qBr8mYRMy3QxYBzUkjQwuDNtUL
         koxUem2WN8f2E9lISUTVKCaS/HWJ1mAtu0DRrly4=
Date:   Mon, 6 Nov 2023 12:24:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     stable@vger.kernel.org, jslaby@suse.com, george.kennedy@oracle.com,
        linux-kernel@vger.kernel.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH stable 4.14.y] vc_screen: move load of struct vc_data
 pointer in vcs_read() to avoid UAF
Message-ID: <2023110642-salsa-crawfish-1d1e@gregkh>
References: <20231101002421.1674851-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101002421.1674851-1-surajjs@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:24:21PM -0700, Suraj Jitindar Singh wrote:
> From: George Kennedy <george.kennedy@oracle.com>
> 
> commit 226fae124b2dac217ea5436060d623ff3385bc34 upstream.

Now queued up, thanks.

greg k-h
