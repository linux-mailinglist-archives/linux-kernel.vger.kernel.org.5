Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774E7DC31C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjJ3XY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjJ3XY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:24:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81FC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:24:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ECFC433C8;
        Mon, 30 Oct 2023 23:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698708296;
        bh=eSToCgNoOU36yWDh/ZxU3u2eyKj54Yk56h54zCsbdXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GpfElP365wN/ntyCouhtGgE4EnElxrLBWUnHewLm2Tv83CcOEFAJc0xTi9ZaLniWt
         Vkt1qQw9qGiC0o7CmVokbZQUO97mvo/v+GGob6fwz1xAM4mrnvO3u2r2vGY8lWxo+K
         w3ItJvBvE5hc4/uvYRnL+vpSK8U8fUCPgEl6JEkP99A4T7N14VHI1VhNL9RO0ZVK2n
         kwNi++QKoGITDgb2xRbqMA+9xSk4ihSceeAaC4qnhvAwlE7jvDfpzgSsEH1qCWt+QN
         4Sq5EcQ6yGst5DNIFGpy0zuh6vPoqMRMXTrbRm4LmYOcCnhnLSlhcp/L3b1++FtU77
         i8OEA9Y7JzDsg==
Date:   Mon, 30 Oct 2023 16:24:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Add missing NULL check in
 `tls_strp_check_queue_ok`
Message-ID: <20231030162454.628a9c66@kernel.org>
In-Reply-To: <ZUAsFeXFOJdo-VzU@urola>
References: <ZUAmyb44sy309V6H@urola>
        <20231030150512.254220a5@kernel.org>
        <ZUAsFeXFOJdo-VzU@urola>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 15:20:05 -0700 Frederik Deweerdt wrote:
> > Hm. Can you share the decoded stack trace?  
> 
> We could only have screen captures from the management console. I've
> attached the image to this email.

Is it possible to enable crash dump kernel or serial console or
netconsole on the machines to catch a fuller stack trace?
