Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2727BE7EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377939AbjJIR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377922AbjJIR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:28:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F805E6;
        Mon,  9 Oct 2023 10:28:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9B5C433C7;
        Mon,  9 Oct 2023 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696872521;
        bh=tBsebNI+DlCdruldq1wvSjRa0++KU5LKq8R9zyL1D7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq1mHUmjt34pBDMiDhKtSUMt2ln06E6kI7QtooyYZ6vgSRVNW4O74xeoYdoEvFziU
         cRKF65/DYt/4wpsOXmXlTeIkwAxYsjAi8JrNig0IfcDpn/yHReAFFwhrD8WdnmiX2/
         2nxn00APZabf0OAIP2jLD6nfMtlzoz0ZZi3gUM84=
Date:   Mon, 9 Oct 2023 19:28:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/7] drivers/tty/serial_core: add local variable for
 newly allocated attribute_group**
Message-ID: <2023100931-safeness-resolved-cb20@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-5-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-5-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:38PM +0200, Max Kellermann wrote:
> This allows the compiler to keep the pointer in a register and
> prepares for making the struct field "const".

You know what I'm going to say...
