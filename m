Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B87702F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHDO00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjHDO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81436171D;
        Fri,  4 Aug 2023 07:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175386204D;
        Fri,  4 Aug 2023 14:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31044C433C8;
        Fri,  4 Aug 2023 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691159181;
        bh=ZuCmH0k6/djBi+5rUqKIg1jnPw9N3pQinGS7AqjW0aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOzVEkHrxVl+UTmbnpDo+z4P9pUGcUyovjzk50RGoNhtAtLlPbVTW5H9sMgYuHByF
         jExMMaNRmUudlG3888PQo1vgZIC1asJwVLK5zKd1vlj1OEUwkf1RvaTrEsn3r7b4X+
         BqGdkCiSb8LrAYF3a7XDnt1l0PATR+At0cHF9z2I=
Date:   Fri, 4 Aug 2023 16:26:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] of: Move of_device_{add,register,unregister} to
 platform.c
Message-ID: <2023080414-gander-paycheck-08d7@gregkh>
References: <20230717143718.1715773-1-robh@kernel.org>
 <20230717143718.1715773-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717143718.1715773-2-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:37:17AM -0600, Rob Herring wrote:
> The declarations for of_device_{add,register,unregister} were moved into
> of_platform.h, so the implementations should be moved to platform.c as
> well.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
