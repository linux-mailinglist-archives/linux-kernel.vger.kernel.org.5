Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869367F3B53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKVBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjKVBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:30:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400DDD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318CEC433C7;
        Wed, 22 Nov 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700616623;
        bh=qLkVBzXHR/QW5/imP3V/FC/AudAulL8dc5GkIdRhqfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p3L8BdjjfTylDPlZyTn75Ouq8WJdrrS/p+OC10QDvCVlu/ODKjLeTcV03nzppkIgi
         VMQA0a14bUeAqU6XFbXy1NrJsJ3aABmZnLu4Na+HcLOS9bkmDT47FJXScrXrMNlwnD
         zmuD7fiGuTBnp7v7iyodEsqmNdXAqdC8IsmbQVQ5SvHi6lQ2ujoiRBV4SDn9TkZQRB
         IIVGw58jUDEqluWJoa/udAezJY34dSvGn3+e2hu4K7M8xkS4eeCGx8Hnh+B3Gy0Qt8
         AMcaz0paSaev1SLJeAgg3Pmi6mgauiCFdIvwJTBWuBin+PS1ebc69OnN9BQcyrgZPy
         3/lqwSXL9P05A==
Date:   Tue, 21 Nov 2023 17:30:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231121173022.3cb2fcad@kernel.org>
In-Reply-To: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid

Any idea what this is?

lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls through to next function __cfi_test_fw_upload_cancel()

My build shows this on an incremental clang 17 build.
